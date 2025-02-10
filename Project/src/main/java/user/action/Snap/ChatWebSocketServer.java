package user.action.Snap;

import user.dao.snap.ChatDao;
import user.vo.snap.ChatMessageVO;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint("/chatSocket/{userId}")
public class ChatWebSocketServer {
  // 한 userId에 대해 여러 세션을 저장: Map의 키는 userId, 값은 해당 userId로 접속한 세션들의 리스트
  private static Map<String, List<Session>> clients = new ConcurrentHashMap<>();
  private ChatDao chatDao = new ChatDao();

  @OnOpen
  public void onOpen(Session session, @PathParam("userId") String userId) {
    if (userId == null || session == null) {
      System.err.println("❌ userId 또는 session이 null입니다. 연결 실패.");
      return;
    }

    // roomId는 Query Parameter로 가져오지만 없으면 null로 둔다.
    Map<String, List<String>> params = session.getRequestParameterMap();
    String roomId = params.containsKey("roomId") ? params.get("roomId").get(0) : null;
    if (roomId == null) {
      System.out.println("⚠️ roomId가 전달되지 않았습니다. 추후 메시지에서 업데이트 될 예정입니다.");
    }

    // 해당 userId에 대한 세션 리스트를 가져오거나 새 리스트 생성 후, 현재 세션을 추가한다.
    clients.compute(userId, (key, sessionList) -> {
      if (sessionList == null) {
        sessionList = new ArrayList<>();
      }
      sessionList.add(session);
      return sessionList;
    });

    // 각 세션의 userProperties에 userId와 roomId 저장
    session.getUserProperties().put("userId", userId);
    session.getUserProperties().put("roomId", roomId);

    System.out.println(" 웹소켓 연결 성공: userId=" + userId + ", roomId=" + roomId);
  }

  @OnMessage
  public void onMessage(String message, Session session) throws IOException {
    System.out.println("웹소켓 메시지 수신: " + message);

    // JSON 파싱
    ObjectMapper objectMapper = new ObjectMapper();
    JsonNode jsonNode = objectMapper.readTree(message);

    // 메시지에서 roomId를 추출하고, 세션에 저장된 roomId와 비교하여 업데이트 (초기 연결 시 null일 수 있음)
    String messageRoomId = jsonNode.get("roomId").asText();
    Object currentRoomId = session.getUserProperties().get("roomId");
    if (currentRoomId == null || !currentRoomId.equals(messageRoomId)) {
      session.getUserProperties().put("roomId", messageRoomId);
      System.out.println("세션의 roomId 업데이트: " + messageRoomId);
    }

    String senderId = jsonNode.get("senderId").asText();
    String messageText = jsonNode.get("message").asText();
    String imageUrl = jsonNode.has("imageUrl") ? jsonNode.get("imageUrl").asText() : null;

    // DB에 메시지 저장 (ChatDao를 통한 처리)
    ChatMessageVO chatMessage = new ChatMessageVO();
    chatMessage.setRoomId(Integer.parseInt(messageRoomId));
    chatMessage.setSender_id(Integer.parseInt(senderId));
    chatMessage.setMessage(messageText);
    chatMessage.setImage_url(imageUrl);
    chatDao.sendMessage(chatMessage);

    // 동일 roomId에 있는 모든 세션(같은 계정 및 다른 계정 모두 포함)에 대해 메시지를 브로드캐스트
    for (Map.Entry<String, List<Session>> entry : clients.entrySet()) {
      List<Session> sessionList = entry.getValue();
      for (Session clientSession : sessionList) {
        Object clientRoomId = clientSession.getUserProperties().get("roomId");
        if (clientSession.isOpen() && clientRoomId != null && clientRoomId.equals(messageRoomId)) {
          clientSession.getAsyncRemote().sendText(message);
        }
      }
    }
  }

  @OnClose
  public void onClose(Session session) {
    // 세션 종료 시, 해당 userId에 속하는 세션 리스트에서 현재 세션을 제거한다.
    String userId = (String) session.getUserProperties().get("userId");
    if (userId != null) {
      clients.computeIfPresent(userId, (key, sessionList) -> {
        sessionList.remove(session);
        // 리스트가 비었다면, 맵에서 해당 키 제거
        return sessionList.isEmpty() ? null : sessionList;
      });
    }
    System.out.println("웹소켓 연결 종료");
  }
}

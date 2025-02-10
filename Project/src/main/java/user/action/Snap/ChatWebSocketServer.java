package user.action.Snap;

import user.dao.snap.ChatDao;
import user.vo.snap.ChatMessageVO;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Map;

@ServerEndpoint("/chatSocket/{userId}")
public class ChatWebSocketServer {
  // userId를 키로 세션을 저장 (필요시 session id 등으로도 관리 가능)
  private static Map<String, Session> clients = new ConcurrentHashMap<>();
  private ChatDao chatDao = new ChatDao();

  @OnOpen
  public void onOpen(Session session, @PathParam("userId") String userId) {
    if (userId == null || session == null) {
      System.err.println(" userId 또는 session이 null입니다. 연결 실패.");
      return;
    }

    // roomId는 Query Parameter로 가져오지만, 없으면 null로 둔다.
    Map<String, List<String>> params = session.getRequestParameterMap();
    String roomId = params.containsKey("roomId") ? params.get("roomId").get(0) : null;

    if (roomId == null) {
      System.out.println("⚠ roomId가 전달되지 않았습니다. 추후 메시지에서 업데이트 될 예정입니다.");
      // roomId가 없는 경우에도 연결은 유지합니다.
    }

    // 세션에 userId와 roomId(아직 null일 수 있음) 저장
    clients.put(userId, session);
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

    // 메시지에서 roomId를 가져와서, 세션에 저장된 roomId와 비교 후 업데이트 (처음 연결 시 roomId가 없었을 수 있음)
    String messageRoomId = jsonNode.get("roomId").asText();
    Object currentRoomId = session.getUserProperties().get("roomId");
    if (currentRoomId == null || !currentRoomId.equals(messageRoomId)) {
      session.getUserProperties().put("roomId", messageRoomId);
      System.out.println("세션의 roomId 업데이트: " + messageRoomId);
    }

    String senderId = jsonNode.get("senderId").asText();
    String messageText = jsonNode.get("message").asText();
    String imageUrl = jsonNode.has("imageUrl") ? jsonNode.get("imageUrl").asText() : null;

    // 메시지 저장
    ChatMessageVO chatMessage = new ChatMessageVO();
    chatMessage.setRoomId(Integer.parseInt(messageRoomId));
    chatMessage.setSender_id(Integer.parseInt(senderId));
    chatMessage.setMessage(messageText);
    chatMessage.setImage_url(imageUrl);
    chatDao.sendMessage(chatMessage);

    // 같은 방의 사용자에게만 메시지 브로드캐스트 (자기 자신 포함)
    for (Map.Entry<String, Session> clientEntry : clients.entrySet()) {
      Session clientSession = clientEntry.getValue();
      Object clientRoomId = clientSession.getUserProperties().get("roomId");
      if (clientSession.isOpen()
          && clientRoomId != null && clientRoomId.equals(messageRoomId)) {
        clientSession.getAsyncRemote().sendText(message);
      }
    }
  }

  @OnClose
  public void onClose(Session session) {
    // clients 맵에서 해당 session을 제거 (userId를 키로 관리하고 있다면 반복문으로 찾아 제거하거나 별도 관리 필요)
    clients.values().remove(session);
    System.out.println("웹소켓 연결 종료");
  }
}

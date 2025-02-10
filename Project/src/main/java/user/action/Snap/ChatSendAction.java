package user.action.Snap;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import user.action.Action;

import user.vo.snap.ChatMessageVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

public class ChatSendAction implements Action {
  private final user.dao.snap.ChatDao chatDao = new user.dao.snap.ChatDao();

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
    response.setContentType("application/json");
    JsonObject jsonResponse = new JsonObject();

    try {

      BufferedReader reader = request.getReader();
      JsonObject json = JsonParser.parseReader(reader).getAsJsonObject();


      int roomId = json.get("roomId").getAsInt();
      int senderId = json.get("senderId").getAsInt();
      String message = json.has("message") && !json.get("message").isJsonNull() ? json.get("message").getAsString() : "";
      String imageUrl = json.has("imageUrl") && !json.get("imageUrl").isJsonNull() ? json.get("imageUrl").getAsString() : null;




      ChatMessageVO vo = new ChatMessageVO();
      vo.setRoomId(roomId);
      vo.setSender_id(senderId);
      vo.setMessage(message);
      vo.setImage_url(imageUrl);

      boolean success = chatDao.sendMessage(vo);

      if (success) {
        jsonResponse.addProperty("success", true);

      } else {
        jsonResponse.addProperty("success", false);
        jsonResponse.addProperty("error", "메시지 저장 실패");

      }

    } catch (Exception e) {
      jsonResponse.addProperty("success", false);
      jsonResponse.addProperty("error", "서버 내부 오류 발생");

      e.printStackTrace();
    }

    // JSON 응답 반환
    response.getWriter().write(jsonResponse.toString());
    return null;
  }
}

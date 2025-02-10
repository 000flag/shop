package user.action.Snap;

import com.google.gson.Gson;
import user.action.Action;
import user.dao.snap.ChatDao;
import user.vo.snap.ChatMessageVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

public class ChatRoomAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    try (PrintWriter out = response.getWriter()) {
      //  요청된 채팅방 ID 가져오기
      String roomIdParam = request.getParameter("roomId");
      if (roomIdParam == null || roomIdParam.isEmpty()) {
        response.setStatus(400); // Bad Request
        out.print("{\"error\": \"roomId가 없습니다.\"}");
        return null;
      }

      int roomId = Integer.parseInt(roomIdParam);
      System.out.println(" roomId: " + roomId);


      ChatDao chatDao = new ChatDao();
      List<ChatMessageVO> messages = chatDao.getChatMessages(roomId);
      System.out.println(" 채팅 메시지 개수: " + messages.size());


      Gson gson = new Gson();
      String jsonResponse = gson.toJson(messages);
      out.print(jsonResponse);
      out.flush();

    } catch (NumberFormatException e) {
      e.printStackTrace();
      response.setStatus(400); // Bad Request
      try (PrintWriter out = response.getWriter()) {
        out.print("{\"error\": \"잘못된 roomId 값입니다.\"}");
      } catch (Exception ignored) {}
    } catch (Exception e) {
      e.printStackTrace();
      response.setStatus(500); // Internal Server Error
      try (PrintWriter out = response.getWriter()) {
        out.print("{\"error\": \"서버 내부 오류 발생\"}");
      } catch (Exception ignored) {}
    }
    return null;
  }
}

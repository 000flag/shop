package user.action.Snap;

import user.action.Action;
import user.dao.snap.ChatDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MarkAsReadAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
    int roomId = Integer.parseInt(request.getParameter("roomId"));
    int userId = (int)request.getSession().getAttribute("cus_id");

    ChatDao chatDao = new ChatDao();

    boolean success = chatDao.updateMessageReadStatus(roomId, userId); // 채팅방 메시지 읽음 처리
    response.setContentType("application/json");
    response.setCharacterEncoding("utf-8");
    response.getWriter().write("{\"success\": " + success + "}");
    response.getWriter().flush();
    response.getWriter().close();
    return null;
  }
}
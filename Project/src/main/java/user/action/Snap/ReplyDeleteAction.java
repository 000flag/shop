package user.action.Snap;

import user.action.Action;
import user.dao.snap.ReplyDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ReplyDeleteAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
    request.setCharacterEncoding("utf-8");
    response.setContentType("application/json; charset=utf-8");

    int id = Integer.parseInt(request.getParameter("comment_id"));

    ReplyDao replyDao = new ReplyDao();
    replyDao.deleteComment(id);

    response.getWriter().write("{\"success\": true}");

    return null;
  }
}

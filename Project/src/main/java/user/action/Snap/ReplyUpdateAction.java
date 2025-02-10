package user.action.Snap;

import user.action.Action;
import user.dao.snap.ReplyDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReplyUpdateAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response)  {

    try {
      request.setCharacterEncoding("UTF-8");
      response.setContentType("application/json; charset=UTF-8");

      int commentId = Integer.parseInt(request.getParameter("comment_id"));
      String content = request.getParameter("content");

      ReplyDao replyDao = new ReplyDao();
      replyDao.updateComment(commentId, content);

      response.getWriter().write("{\"success\": true}");
    } catch (Exception e) {
      e.printStackTrace();

    }
    return null;
  }
}

package user.action.Snap;

import com.google.gson.Gson;
import user.action.Action;
import user.dao.snap.ReplyDao;
import user.vo.snap.ReplyVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

public class ReplyAllAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {

    try {
      request.setCharacterEncoding("UTF-8");
      response.setContentType("application/json; charset=UTF-8");

      int boardNo = Integer.parseInt(request.getParameter("board_no"));
      System.out.println("boardNo = " + boardNo);

      ReplyDao replyDao = new ReplyDao();



      //전체댓글가져오기
      List<ReplyVO> replies = replyDao.getAllReplies(boardNo);




      Gson gson = new Gson();
      String jsonResponse = gson.toJson(replies);
      PrintWriter out = response.getWriter();
      out.print(jsonResponse);
      out.flush();
      out.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }
}

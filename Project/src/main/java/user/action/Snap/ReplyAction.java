package user.action.Snap;

import user.action.Action;
import user.dao.snap.ReplyDao;
import user.vo.snap.ReplyVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

import com.google.gson.Gson;

public class ReplyAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {

    try {
      request.setCharacterEncoding("UTF-8");
      response.setContentType("application/json; charset=UTF-8");

      int boardNo = Integer.parseInt(request.getParameter("board_no"));
      int cusNo = Integer.parseInt(request.getSession().getAttribute("cus_id").toString());
      String content = request.getParameter("content");

      ReplyDao replyDao = new ReplyDao();
      ReplyVO reply = new ReplyVO();
      reply.setBoard_no(boardNo);
      reply.setCus_no(cusNo);
      reply.setContent(content);
      if(content != null) {
        replyDao.insertReply(reply);
      }
      // 최신 댓글 가져오기
      ReplyVO latestReply = replyDao.getLatestReply(boardNo);


      System.out.println(" 가져온 최신 댓글: " + latestReply.getContent());


      Gson gson = new Gson();
      String jsonResponse = gson.toJson(latestReply);
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

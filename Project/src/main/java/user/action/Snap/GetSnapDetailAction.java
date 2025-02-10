package user.action.Snap;

import user.action.Action;
import user.dao.snap.SnapDao;
import user.vo.BoardVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import com.google.gson.Gson;

public class GetSnapDetailAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    try {
      request.setCharacterEncoding("UTF-8");
      response.setContentType("application/json; charset=UTF-8");

      int boardNo = Integer.parseInt(request.getParameter("board_no"));

      SnapDao snapDao = new SnapDao();
      BoardVO snap = snapDao.getSnapDetail(boardNo);



      // JSON 변환 및 반환
      PrintWriter out = response.getWriter();
      Gson gson = new Gson();
      String jsonResponse = gson.toJson(snap);
      out.print(jsonResponse);
      out.flush();
      out.close();

    } catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }
}

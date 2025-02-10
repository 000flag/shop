package user.action.Snap;

import com.google.gson.Gson;
import user.action.Action;
import user.dao.snap.SnapDao;
import user.vo.BoardVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public class SnapDetailAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    try {
      String idParam = request.getParameter("id");
      if (idParam == null || idParam.isEmpty()) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid or missing 'id' parameter");
        return null;
      }

      int boardNo = Integer.parseInt(idParam);

      SnapDao snapDao = new SnapDao();
      BoardVO snap = snapDao.getSnapDetail(boardNo);

      response.setContentType("application/json; charset=UTF-8");
      PrintWriter out = response.getWriter();
      Gson gson = new Gson();
      out.print(gson.toJson(snap));
      out.flush();
    } catch (Exception e) {
      e.printStackTrace();
      try {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the request.");
      } catch (Exception innerException) {
        innerException.printStackTrace();
      }
    }
    return null; // JSP 경로가 아닌 JSON 응답 반환
  }
}

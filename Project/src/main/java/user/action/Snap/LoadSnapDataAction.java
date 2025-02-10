package user.action.Snap;

import com.google.gson.Gson;
import user.action.Action;
import user.dao.snap.SnapDao;
import comm.vo.seller.BoardVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public class LoadSnapDataAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    int id = Integer.parseInt(request.getParameter("id")); // 게시물 ID 가져오기

    SnapDao dao = new SnapDao();

    BoardVO snap = dao.getSnapDetail(id); // 게시물 데이터 가져오기
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");



    try (PrintWriter out = response.getWriter()) {
      if (snap != null) {
        out.print(new Gson().toJson(snap)); // JSON으로 반환
      } else {
        out.print("{\"success\": false, \"message\": \"게시물을 찾을 수 없습니다.\"}");
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return null; // JSON 반환 후, 별도의 뷰로 이동하지 않음
  }
}

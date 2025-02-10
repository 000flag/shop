package user.action.Snap;

import org.json.JSONObject;
import user.action.Action;

import user.vo.snap.LikesVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.stream.Collectors;

public class LikeToggleAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    response.setContentType("application/json");
    try (PrintWriter out = response.getWriter()) {

      String jsonData = request.getReader().lines().collect(Collectors.joining());



      JSONObject jsonObject = new JSONObject(jsonData);
      Integer cus_id = (Integer) request.getSession().getAttribute("cus_id");
       int boardNo = jsonObject.getInt("boardNo");
      System.out.println("boardNo: " + boardNo);
      int status = jsonObject.getInt("status");

      System.out.println("status: " + status);


      user.dao.snap.LikeDao likeDao = new user.dao.snap.LikeDao();
      LikesVO vo = new LikesVO();
      vo.setBoardNo(boardNo);
      vo.setCusNo(cus_id);
      vo.setStatus(status);
      boolean success = likeDao.toggleLike(vo);


      JSONObject responseJson = new JSONObject();
      responseJson.put("success", success);
      out.print(responseJson);
      out.flush();

    } catch (Exception e) {
      e.printStackTrace();
      response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }

    return null;
  }
}

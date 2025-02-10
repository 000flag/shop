package user.action.Snap;

import com.google.gson.Gson;
import user.action.Action;
import user.dao.snap.FollowDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.Map;

public class FollowAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    try {
      String type = request.getParameter("type");
      HttpSession session = request.getSession();
      int customerId = (int) session.getAttribute("cus_id"); // 현재 로그인 사용자 ID

      // JSON 요청 처리
      BufferedReader reader = request.getReader();
      StringBuilder json = new StringBuilder();
      String line;
      while ((line = reader.readLine()) != null) {
        json.append(line);
      }

      // JSON 데이터 파싱
      Gson gson = new Gson();
      Map<String, String> requestData = gson.fromJson(json.toString(), Map.class);
      int followingId = Integer.parseInt(requestData.get("followingId"));

      // 디버깅 로그
      System.out.println("Action Type: " + type);
      System.out.println("Customer ID: " + customerId);

      System.out.println("Following ID: " + followingId);

      boolean result = false;

      if ("follow".equals(type)) {
        result = FollowDao.addFollow(customerId, followingId);
      } else if ("unfollow".equals(type)) {
        result = FollowDao.removeFollow(customerId, followingId);
      }

      // JSON 응답 반환
      response.setContentType("application/json; charset=UTF-8");
      PrintWriter out = response.getWriter();
      out.print(gson.toJson(Collections.singletonMap("success", result)));
      out.flush();

    } catch (Exception e) {
      e.printStackTrace(); // 예외 로그 출력
      try {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the request.");
      } catch (Exception innerException) {
        innerException.printStackTrace();
      }
    }
    return null;
  }

}
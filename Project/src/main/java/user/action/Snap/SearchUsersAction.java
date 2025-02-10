package user.action.Snap;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import user.action.Action;
import user.dao.snap.FollowDao;
import user.vo.snap.CustomerVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class SearchUsersAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
    response.setContentType("application/json");
    response.setCharacterEncoding("utf-8");

    String query = request.getParameter("query");
    System.out.println("검색어: " + query);

    FollowDao followDao = new FollowDao();
    List<CustomerVO> users = followDao.getFollowerSearch(query);
    System.out.println("검색된 유저 수: " + users.size());

    JsonArray usersArray = new JsonArray();

    for (CustomerVO user : users) {
      JsonObject userObject = new JsonObject();
      userObject.addProperty("nickname", user.getNickname());
      userObject.addProperty("profile_image", user.getProfile_image());
      userObject.addProperty("follower_count", user.getFollower_count());
      userObject.addProperty("id", user.getId());
      usersArray.add(userObject);
    }

    JsonObject responseJson = new JsonObject();
    responseJson.add("users", usersArray);

    try (PrintWriter out = response.getWriter()) {
      out.print(responseJson.toString());
      out.flush();
    }

    return null;
  }
}

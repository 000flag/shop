package user.action.Snap;

import user.action.Action;
import user.dao.snap.SnapDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class BoardDelteAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
    int id = Integer.parseInt(request.getParameter("id"));

    SnapDao snapDao = new SnapDao();
    snapDao.deleteBoard(id);




    return "/Controller?type=snap";
  }
}

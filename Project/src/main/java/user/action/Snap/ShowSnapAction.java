package user.action.Snap;

import user.action.Action;

import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShowSnapAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {

    return "user/snap/jsp/snap/SnapWrite.jsp";
  }
}


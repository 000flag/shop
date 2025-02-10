package user.action.Snap;

import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class delAction  implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {


    return "/user/snap/jsp/sellerManagement.jsp";
  }

}


package user.action.Snap;

import user.action.Action;
import user.dao.snap.CustomerDao;
import user.vo.snap.CustomerVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginAction  implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    CustomerVO loginResult = null;

    CustomerVO vo = new CustomerVO();
    vo.setCus_id(username);
    vo.setCus_pw(password);

    // 로그인 정보 가져오기
    loginResult = CustomerDao.login(vo);

    String nickname = loginResult.getNickname();
    int customer_id = CustomerDao.getId(nickname);


    HttpSession session = request.getSession();
    if (loginResult != null) {
      // 로그인 정보 저장
      session.setAttribute("cus_id", customer_id);
      session.setAttribute("nickname", nickname);
      session.setAttribute("isLoggedIn", true);
      session.setAttribute("customer_info", loginResult);

      return "/user/snap/jsp/index.jsp";
    } else {
      // 실패 시에만 isLoggedIn 설정
      if (username != null && password != null) {
        session.setAttribute("isLoggedIn", false);
      }

      return "/user/snap/jsp/login/login.jsp";
    }
  }
}
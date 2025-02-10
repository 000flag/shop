package admin.action;

import user.action.Action;

import admin.dao.RootDao;

import admin.vo.RootVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminLoginAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println(username);
        System.out.println(password);

        String viewpath = null;
        RootVO vo = new RootVO();
        vo.setRoot_id(username);
        vo.setRoot_pw(password);

        RootVO loginResult = RootDao.login(vo); // 로그인 정보 가져오기
//        String testname = loginResult.getName();
//        System.out.println(testname);



        if(loginResult != null){
            System.out.println(username);
            System.out.println(password);
            HttpSession session = request.getSession();
            session.setAttribute("name", loginResult.getName());
            session.setAttribute("id", loginResult.getId());
            session.setAttribute("root_id", loginResult.getRoot_id());
            System.out.println(loginResult.getRoot_id());
            request.setAttribute("isLoggedIn", true);
            request.setAttribute("root_pw", loginResult.getRoot_pw());

            viewpath="/admin/jsp/index.jsp";
        }
        else{
            viewpath="/admin/jsp/login/login.jsp";
        }
        return viewpath;
    }
}

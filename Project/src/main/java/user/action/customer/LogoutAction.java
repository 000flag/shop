package user.action.customer;

import user.action.Action;
import user.dao.customer.LogDAO;
import user.vo.customer.CustomerVO;
import user.vo.customer.LogVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

        // 로그아웃, 추가 로그
        LogVO lvo = new LogVO();
        lvo.setCus_no(cvo.getId());
        lvo.setTarget("customer 로그아웃");
        lvo.setLog_type("3");
        LogDAO.insertEtcLog(lvo);

        // 세션 종료
        session.invalidate();
        return "Controller?type=index";
    }
}

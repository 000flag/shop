package user.action.customer;

import user.action.Action;
import user.dao.customer.PointDAO;
import user.vo.customer.CustomerVO;
import user.vo.customer.PointVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class PointAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

        if (cvo == null) {
            request.setAttribute("session_expired", true);
            return "/user/customer/jsp/error/error.jsp";
        }

        // 적립 예정 금액
        String upcomingTotal = PointDAO.selectUpcomingTotal(cvo.getId());
        request.setAttribute("upcomingTotal", upcomingTotal);

        // 소멸 예정 금액
        String expireTotal = PointDAO.selectExpireTotal(cvo.getId());
        request.setAttribute("expireTotal", expireTotal);

       if (action != null) {
            switch (action) {
                case "all":
                    // 전체
                    List<PointVO> all = PointDAO.selectAll(cvo.getId());
                    request.setAttribute("all", all);
                    break;
                case "earned":
                    // 적립
                    List<PointVO> earned = PointDAO.selectEarned(cvo.getId());
                    request.setAttribute("earned", earned);
                    break;
                case "used":
                    // 사용
                    List<PointVO> used = PointDAO.selectUsed(cvo.getId());
                    request.setAttribute("used", used);
                    break;
                case "upcoming":
                    // 예정
                    List<PointVO> upcoming = PointDAO.selectUpcoming(cvo.getId());
                    request.setAttribute("upcoming", upcoming);
                    break;
            }
        }

        return "/user/customer/jsp/mypage/components/point.jsp";
    }
}

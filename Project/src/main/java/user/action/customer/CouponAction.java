package user.action.customer;

import user.action.Action;
import user.dao.customer.CouponDAO;
import user.vo.customer.CouponVO;
import user.vo.customer.CustomerVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class CouponAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

        if (cvo == null) {
            request.setAttribute("session_expired", true);
            return "/user/customer/jsp/error/error.jsp";
        }

        String viewPage = null;
        if (action != null) {
            switch (action) {
                case "select":
                    String searchValue = request.getParameter("searchValue");
                    String sort = request.getParameter("sort");

                    // 보유 쿠폰 수
                    int coupons_count = CouponDAO.selectCouponCount(cvo.getId(), cvo.getGrade_no());
                    request.setAttribute("coupon_count", coupons_count);

                    // 쿠폰 목록
                    List<CouponVO> list = CouponDAO.selectCoupon(cvo.getId(), cvo.getGrade_no(), searchValue, sort);
                    request.setAttribute("c_list", list);

                    viewPage = "/user/customer/jsp/mypage/components/coupon.jsp";
                    break;
            }
        }

        return viewPage;
    }
}

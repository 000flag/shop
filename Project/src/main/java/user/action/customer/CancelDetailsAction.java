package user.action.customer;

import user.action.Action;
import user.dao.customer.OrderDAO;
import user.dao.customer.PointDAO;
import user.vo.customer.CustomerVO;
import user.vo.customer.OrderVO;
import user.vo.customer.PointVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class CancelDetailsAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

        if (cvo == null) {
            request.setAttribute("session_expired", true);
            return "/user/customer/jsp/error/error.jsp";
        }

        String order_id = request.getParameter("order_id");
        String order_code = request.getParameter("order_code");
        String prod_no = request.getParameter("prod_no");

        // 주문 취소 상세 정보 조회
        OrderVO cancel = OrderDAO.selectDetailsByStatus(order_id, cvo.getId(), prod_no, order_code, "6");

        // 쿠폰 정보 조회 및 설정
        List<OrderVO> couponList = OrderDAO.selectOrderCoupons(order_id, cvo.getId(), order_code, prod_no);
        String couponName = null;
        double salePer = 0.0;

        if (couponList != null && !couponList.isEmpty()) {
            OrderVO coupon = couponList.get(0);
            couponName = coupon.getCoupon_name();  // 쿠폰 이름 가져오기
            salePer = (coupon.getSale_per() != null) ? Double.parseDouble(coupon.getSale_per()) : 0.0;
        }

        // 적립금 사용 금액 조회
        int pointAmount = PointDAO.selectPointAmount(cvo.getId(), order_code);

        // JSP에 전달할 값 설정
        request.setAttribute("cancel", cancel);
        request.setAttribute("coupon_name", couponName);
        request.setAttribute("sale_per", (int) salePer);  // 소수점 제거 후 전달
        request.setAttribute("point_amount", pointAmount);

        return "/user/customer/jsp/mypage/cancelDetails.jsp";
    }
}

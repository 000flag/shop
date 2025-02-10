package user.action.customer;

import user.action.Action;
import user.dao.customer.DeliveryDAO;
import user.dao.customer.OrderDAO;
import user.dao.customer.PointDAO;
import user.vo.customer.CustomerVO;
import user.vo.customer.DeliveryVO;
import user.vo.customer.OrderVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class RefundDetailsAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

        if (cvo == null) {
            request.setAttribute("session_expired", true);
            return "/user/customer/jsp/error/error.jsp";
        }

        String action = request.getParameter("action");
        String order_id = request.getParameter("order_id");
        String order_code = request.getParameter("order_code");
        String prod_no = request.getParameter("prod_no");

        String viewPath = null;
        if (action != null) {
            switch (action) {
                case "select":
                    // 주문 정보 조회
                    OrderVO refund = OrderDAO.selectDetailsByStatus(order_id, cvo.getId(), prod_no, order_code, "7");

                    // 배송 정보 조회
                    DeliveryVO delivery = DeliveryDAO.selectRetrieveInfo(order_id);

                    // 쿠폰 정보 조회 및 처리
                    List<OrderVO> couponList = OrderDAO.selectOrderCoupons(order_id, cvo.getId(), order_code, prod_no);
                    String couponName = null;
                    int salePer = 0;
                    if (couponList != null && !couponList.isEmpty()) {
                        OrderVO coupon = couponList.get(0);
                        couponName = coupon.getCoupon_name();
                        salePer = (coupon.getSale_per() != null) ? Integer.parseInt(coupon.getSale_per()) : 0;
                    }

                    // 적립금 사용 금액 조회
                    int pointAmount = PointDAO.selectPointAmount(cvo.getId(), order_code);

                    // 반송지 정보 조회
                    OrderVO sellerInfo = OrderDAO.selectSellerAddress(order_id);

                    // JSP에 전달할 값 설정
                    request.setAttribute("refund", refund);
                    request.setAttribute("delivery", delivery);
                    request.setAttribute("coupon_name", couponName);
                    request.setAttribute("sale_per", salePer);
                    request.setAttribute("point_amount", pointAmount);
                    request.setAttribute("vo", sellerInfo);

                    viewPath = "/user/customer/jsp/mypage/refundDetails.jsp";
                    break;

                case "select_reject":
                    // 주문 정보 조회
                    OrderVO refund_reject = OrderDAO.selectDetailsByStatus(order_id, cvo.getId(), prod_no, order_code, "9");

                    // 배송 정보 조회
                    DeliveryVO delivery_reject = DeliveryDAO.selectRetrieveInfo(order_id);
                    // 쿠폰 정보 조회 및 처리
                    List<OrderVO> couponList_reject = OrderDAO.selectOrderCoupons(order_id, cvo.getId(), order_code, prod_no);
                    String couponName_reject = null;
                    int salePer_reject = 0;
                    if (couponList_reject != null && !couponList_reject.isEmpty()) {
                        OrderVO coupon = couponList_reject.get(0);
                        couponName_reject = coupon.getCoupon_name();
                        salePer_reject = (coupon.getSale_per() != null) ? Integer.parseInt(coupon.getSale_per()) : 0;
                    }

                    // 적립금 사용 금액 조회
                    int pointAmount_reject = PointDAO.selectPointAmount(cvo.getId(), order_code);

                    // 반송지 정보 조회
                    OrderVO sellerInfo_reject = OrderDAO.selectSellerAddress(order_id);

                    // JSP에 전달할 값 설정
                    request.setAttribute("refund", refund_reject);
                    request.setAttribute("delivery", delivery_reject);
                    request.setAttribute("coupon_name", couponName_reject);
                    request.setAttribute("sale_per", salePer_reject);
                    request.setAttribute("point_amount", pointAmount_reject);
                    request.setAttribute("vo", sellerInfo_reject);

                    viewPath = "/user/customer/jsp/mypage/refundDetails.jsp";
                    break;

                case "select_complete":
                    // 주문 정보 조회
                    OrderVO refund_complete = OrderDAO.selectDetailsByStatus(order_id, cvo.getId(), prod_no, order_code, "11");

                    // 배송 정보 조회
                    DeliveryVO delivery_complete = DeliveryDAO.selectRetrieveInfo(order_id);
                    // 쿠폰 정보 조회 및 처리
                    List<OrderVO> couponList_complete = OrderDAO.selectOrderCoupons(order_id, cvo.getId(), order_code, prod_no);
                    String couponName_complete = null;
                    int salePer_complete = 0;
                    if (couponList_complete != null && !couponList_complete.isEmpty()) {
                        OrderVO coupon = couponList_complete.get(0);
                        couponName_complete = coupon.getCoupon_name();
                        salePer_complete = (coupon.getSale_per() != null) ? Integer.parseInt(coupon.getSale_per()) : 0;
                    }

                    // 적립금 사용 금액 조회
                    int pointAmount_complete = PointDAO.selectPointAmount(cvo.getId(), order_code);

                    // 반송지 정보 조회
                    OrderVO sellerInfo_complete = OrderDAO.selectSellerAddress(order_id);

                    // JSP에 전달할 값 설정
                    request.setAttribute("refund", refund_complete);
                    request.setAttribute("delivery", delivery_complete);
                    request.setAttribute("coupon_name", couponName_complete);
                    request.setAttribute("sale_per", salePer_complete);
                    request.setAttribute("point_amount", pointAmount_complete);
                    request.setAttribute("vo", sellerInfo_complete);

                    viewPath = "/user/customer/jsp/mypage/refundDetails.jsp";
                    break;
            }

        }
        return viewPath;
    }
}

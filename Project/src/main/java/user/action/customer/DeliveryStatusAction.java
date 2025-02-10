package user.action.customer;

import user.action.Action;
import user.dao.customer.OrderDAO;
import user.vo.customer.CustomerVO;
import user.vo.customer.OrderVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class DeliveryStatusAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

        if (cvo == null) {
            request.setAttribute("session_expired", true);
            return "/user/customer/jsp/error/error.jsp";
        }
        String order_code = request.getParameter("order_code");
        String brand = request.getParameter("brand");

        // 배송 현황 조회
        List<OrderVO> list = OrderDAO.selectDeliveryStatus(cvo.getId(), order_code, brand);

        // 배송 상태에 따른 타입 설정
        for (OrderVO order : list) {
            if (order.getExchange_request_date() != null && (order.getStatus().equals("1") || order.getStatus().equals("2") || order.getStatus().equals("3") || order.getStatus().equals("4"))) {
                // 교환 진행 중 상태
                order.setDelivery_type("EXCHANGE_IN_PROGRESS");
            } else if (order.getStatus().equals("8")) {
                // 교환 신청 상태
                order.setDelivery_type("EXCHANGE_REQUESTED");
            } else {
                // 일반 배송 상태
                order.setDelivery_type("NORMAL_DELIVERY");
            }
        }

        request.setAttribute("list", list);

        return "/user/customer/jsp/mypage/deliveryStatus.jsp";
    }
}

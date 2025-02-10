package user.action.customer;

import user.action.Action;
import user.dao.customer.DeliveryDAO;
import user.dao.customer.OrderDAO;
import user.vo.customer.CustomerVO;
import user.vo.customer.DeliveryVO;
import user.vo.customer.OrderVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ExchangeDetailsAction implements Action {
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
                    OrderVO exchange = OrderDAO.selectDetailsByStatus(order_id, cvo.getId(), prod_no, order_code, "8");
                    DeliveryVO delivery = DeliveryDAO.selectRetrieveInfo(order_id);
                    OrderVO vo = OrderDAO.selectSellerAddress(order_id);

                    request.setAttribute("exchange", exchange);
                    request.setAttribute("delivery", delivery);
                    request.setAttribute("vo", vo);
                    viewPath = "/user/customer/jsp/mypage/exchangeDetails.jsp";
                    break;

                case "select_reject":
                    OrderVO exchange_reject = OrderDAO.selectDetailsByStatus(order_id, cvo.getId(), prod_no, order_code, "10");
                    DeliveryVO delivery_reject = DeliveryDAO.selectRetrieveInfo(order_id);
                    OrderVO vo_reject = OrderDAO.selectSellerAddress(order_id);

                    request.setAttribute("exchange", exchange_reject);
                    request.setAttribute("delivery", delivery_reject);
                    request.setAttribute("vo", vo_reject);
                    viewPath = "/user/customer/jsp/mypage/exchangeDetails.jsp";
                    break;
            }
        }
        return viewPath;
    }
}

package seller.action;

import user.action.Action;
import comm.dao.OrderDAO;
import comm.dao.ProductDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CancelOrderAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String order_no = request.getParameter("order_no");
        String reason_seller = request.getParameter("reason_seller");
        String status = request.getParameter("status");
        int cnt = OrderDAO.cancelOrder(order_no,reason_seller,status);
        // JSON 응답 반환
        request.setAttribute("cnt",cnt);
        return "/seller/jsp/ajax/change_active.jsp";
    }
}

package seller.action;

import user.action.Action;
import comm.dao.OrderDAO;
import comm.dao.ProductDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ChangeStatusAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String selectedOrders = request.getParameter("selectedOrders");
        String status = request.getParameter("status");
        String seller_no=(String) session.getAttribute("seller_no");
        String[] split_tid= selectedOrders.split(",");
        String[] split_status = status.split(",");
        int cnt = OrderDAO.changeStatus(split_tid,split_status,seller_no);

        // JSON 응답 반환
        request.setAttribute("cnt",cnt);
        return "/seller/jsp/ajax/change_active.jsp";
    }
}

package seller.action;


import user.action.Action;
import comm.dao.OrderDAO;
import comm.vo.OrderVO;

import javax.servlet.http.*;

public class OrderOneAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String order_no = request.getParameter("order_no");
        System.out.println("주문번호: "+order_no);
        OrderVO vo = OrderDAO.getOrderOne(order_no);

        request.setAttribute("vo", vo);
        return "/seller/jsp/ajax/order_one.jsp";
    }
}

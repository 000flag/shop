package seller.action;
import user.action.Action;
import comm.dao.OrderDAO;
import comm.service.FactoryService;
import comm.vo.OrderVO;
import comm.vo.ProductVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class OrderListAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();

        String  seller_no = (String) session.getAttribute("seller_no");
        OrderVO[] ar = OrderDAO.getOrderList(seller_no);

        request.setAttribute("ar",ar);

        session.setAttribute("seller_no",seller_no);
        if(seller_no == null){

            return "/seller/jsp/order_list.jsp";
        }

        return "/seller/jsp/order_list.jsp";
    }
}

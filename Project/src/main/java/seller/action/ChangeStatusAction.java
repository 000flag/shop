package seller.action;

import user.action.Action;
import comm.dao.OrderDAO;
import comm.dao.ProductDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ChangeStatusAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String selectedOrders = request.getParameter("selectedOrders");
        String status = request.getParameter("status");
        String[] split_tid= selectedOrders.split(",");
        String[] split_status = status.split(",");
        for(int i=0;i<split_status.length;i++){
            System.out.println("tid: "+selectedOrders);
            System.out.println("status: "+split_status[i]);

        }
        int cnt = OrderDAO.changeStatus(split_tid,split_status);

        // JSON 응답 반환
        request.setAttribute("cnt",cnt);
        return "/seller/jsp/ajax/change_active.jsp";
    }
}

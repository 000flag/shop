package seller.action;
import user.action.Action;
import comm.dao.InventoryDAO;
import comm.dao.SellerDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CheckIdAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String seller_id = request.getParameter("seller_id");

        System.out.println("CheckIDAction: " +seller_id);
        int cnt = SellerDAO.checkId(seller_id);
        // JSON 응답 반환
        request.setAttribute("cnt",cnt);
        return "/seller/jsp/ajax/change_active.jsp";
    }
}

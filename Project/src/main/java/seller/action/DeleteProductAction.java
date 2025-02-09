package seller.action;

import user.action.Action;
import comm.dao.InventoryDAO;
import comm.dao.ProductDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteProductAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String seller_no = (String)session.getAttribute("seller_no");
        String prod_no = request.getParameter("prod_no"); // 상품 번호
        int cnt = ProductDAO.deleteProduct(prod_no,seller_no);
        int cnt2 = InventoryDAO.deleteOptions(prod_no,seller_no);
        if(cnt>0&&cnt2>0)
            request.setAttribute("cnt",cnt);
        else
            request.setAttribute("cnt",-1);

        return "/seller/jsp/ajax/change_active.jsp";
    }
}

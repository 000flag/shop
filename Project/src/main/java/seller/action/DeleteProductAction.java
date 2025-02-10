package seller.action;

import user.action.Action;
import comm.dao.InventoryDAO;
import comm.dao.ProductDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteProductAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String prod_no = request.getParameter("prod_no"); // 상품 번호
        int cnt = ProductDAO.deleteProduct(prod_no);
        int cnt2 = InventoryDAO.deleteOptions(prod_no);
        if(cnt>0&&cnt2>0)
            request.setAttribute("cnt",cnt);
        else
            request.setAttribute("cnt",-1);

        return "/seller/jsp/ajax/change_active.jsp";
    }
}

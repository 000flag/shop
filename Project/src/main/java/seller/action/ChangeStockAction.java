package seller.action;

import user.action.Action;
import comm.dao.InventoryDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
public class ChangeStockAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String prodNo = request.getParameter("prod_no"); // 상품 번호
        String stock = request.getParameter("stock");   // 입력된 재고 값

        int cnt = InventoryDAO.updateStock(prodNo,stock);
        // JSON 응답 반환
        request.setAttribute("cnt",cnt);
        return "/seller/jsp/ajax/update_stock.jsp";
    }
}

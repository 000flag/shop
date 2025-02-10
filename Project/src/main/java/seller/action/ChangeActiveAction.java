package seller.action;

import user.action.Action;
import comm.dao.ProductDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ChangeActiveAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String prod_no = request.getParameter("prod_no"); // 상품 번호
        String active = request.getParameter("active");   // 입력된 재고 값
        String seller_no = (String) session.getAttribute("seller_no");
        if(active==null){
            active = "0";
        }
        int cnt = ProductDAO.changeActive(prod_no,active,seller_no);
        // JSON 응답 반환
        request.setAttribute("cnt",cnt);
        return "/seller/jsp/ajax/change_active.jsp";
    }
}

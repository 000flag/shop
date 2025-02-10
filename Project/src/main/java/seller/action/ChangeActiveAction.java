package seller.action;

import user.action.Action;
import comm.dao.ProductDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ChangeActiveAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String prod_no = request.getParameter("prod_no"); // 상품 번호
        String active = request.getParameter("active");   // 입력된 재고 값
        if(active==null){
            active = "0";
        }
        int cnt = ProductDAO.changeActive(prod_no,active);
        // JSON 응답 반환
        request.setAttribute("cnt",cnt);
        return "/seller/jsp/ajax/change_active.jsp";
    }
}

package seller.action;

import user.action.Action;
import comm.dao.ProductDAO;
import comm.vo.ProductVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ProductListAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();

        String  seller_no=  (String) session.getAttribute("seller_no");

        ProductVO[] ar = ProductDAO.getAll(seller_no);
        if(ar!=null){
            request.setAttribute("ar",ar);
        }
        return "/seller/jsp/product_list.jsp";
    }

}

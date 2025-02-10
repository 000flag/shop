package seller.action;

import user.action.Action;
import comm.dao.ProductDAO;
import comm.vo.seller.ProductVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SearchProductAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession();

        String prod_name = request.getParameter("prod_name");
        String category = request.getParameter("category");
        String seller_no = (String) session.getAttribute("seller_no");

        ProductVO[] ar = ProductDAO.searchProduct(seller_no,category,prod_name);


        request.setAttribute("ar",ar);

        return "/seller/jsp/ajax/search_product.jsp";

    }
}

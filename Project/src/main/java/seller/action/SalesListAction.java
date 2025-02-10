package seller.action;

import user.action.Action;
import comm.dao.SalesDAO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SalesListAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String seller_no = (String) session.getAttribute("seller_no");
        // 기본적인 매출 목록 페이지 로드
        request.setAttribute("salesList", SalesDAO.getSalesList(seller_no));
        request.setAttribute("totalSalesCount", SalesDAO.getSalesCount(seller_no));

        return "/seller/jsp/sales.jsp"; // 상세 정보는 여기서 가져오지 않음
    }
}

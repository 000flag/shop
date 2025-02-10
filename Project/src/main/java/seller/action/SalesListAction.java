package seller.action;

import user.action.Action;
import comm.dao.SalesDAO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SalesListAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 기본적인 매출 목록 페이지 로드
        request.setAttribute("salesList", SalesDAO.getSalesList());
        request.setAttribute("totalSalesCount", SalesDAO.getSalesCount());

        return "/seller/jsp/sales.jsp"; // 상세 정보는 여기서 가져오지 않음
    }
}

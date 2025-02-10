package admin.action;

import admin.dao.SellerDao;
import admin.vo.SellerVO;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminSearchSeller0Action implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");
        SellerVO[] ar = SellerDao.searchSeller(searchType, searchValue);
        request.setAttribute("s0ar", ar);

        return "/admin/jsp/ajaxSeller0List.jsp";
    }
}

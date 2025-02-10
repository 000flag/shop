package admin.action;

import admin.dao.SellerDao;
import admin.vo.SellerVO;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminSearchSeller2Action implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");
        SellerVO[] ar = SellerDao.searchSeller(searchType, searchValue);
        request.setAttribute("s2ar", ar);
        return "/admin/jsp/ajaxSeller2List.jsp";
    }
}
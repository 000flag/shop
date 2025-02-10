package admin.action;

import admin.dao.CouponDao;
import admin.dao.MajorCategoryDao;
import admin.vo.CouponVO;
import admin.vo.MajorCategoryVO;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminSearchCouponAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");

        CouponVO[] ar = CouponDao.searchCoupon(searchType, searchValue);
        request.setAttribute("car", ar);
        return "/admin/jsp/ajaxCouponList.jsp";
    }
}

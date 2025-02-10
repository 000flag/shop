package admin.action;

import admin.dao.MiddleCategoryDao;
import admin.vo.MiddleCategoryVO;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminSearchMiddleCategoryAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");

        MiddleCategoryVO[] ar = MiddleCategoryDao.searchMiddleCategory(searchType,searchValue);
        request.setAttribute("dar", ar);
        return "/admin/jsp/ajaxMiddleCategoryList.jsp";
    }
}

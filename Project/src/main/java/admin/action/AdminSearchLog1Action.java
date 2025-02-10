package admin.action;

import admin.dao.LogDao;
import admin.vo.LogVO;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AdminSearchLog1Action implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");



        LogVO[] ar = LogDao.searchLog(searchType, searchValue);
        request.setAttribute("log1ar", ar);
        return "/admin/jsp/ajaxLog1List.jsp";

    }
}

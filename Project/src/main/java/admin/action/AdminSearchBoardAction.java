package admin.action;

import admin.dao.MajorCategoryDao;
import admin.vo.BoardVO;
import admin.vo.MajorCategoryVO;
import admin.dao.BoardDao;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;

public class AdminSearchBoardAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");

        BoardVO[] ar = BoardDao.searchBoard(searchType, searchValue);
        request.setAttribute("bar", ar);
        return "/admin/jsp/ajaxBoardList.jsp";
    }
}

package admin.action;

import admin.dao.CustomerDao;
import admin.vo.CustomerVO;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminSearchCustomer1Action implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");


        CustomerVO[] ar = CustomerDao.searchCustomer(searchType, searchValue);
        request.setAttribute("cus1ar", ar);
        return "/admin/jsp/ajaxCustomer1List.jsp";
    }
}

package admin.action;

import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminIndexAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        return "/admin/jsp/index.jsp";
    }
}
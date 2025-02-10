package admin.action;

import admin.dao.CustomerDao;
import admin.dao.LogDao;
import admin.vo.CustomerVO;
import admin.vo.LogVO;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class AdminLogAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        LogDao ldao = new LogDao();

        List<LogVO> list = ldao.allLog();

        request.setAttribute("logList", list);




        return "/admin/jsp/logsee.jsp";
    }
}

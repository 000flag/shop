package admin.action;

import admin.dao.BoardDao;
import admin.dao.CouponDao;
import admin.vo.BoardVO;
import admin.vo.CouponVO;
import org.json.JSONObject;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class AdminAddBoardAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String cus_no = request.getParameter("cus_no");
        String prod_no = request.getParameter("prod_no");
        String bname = request.getParameter("bname");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String gender = request.getParameter("gender");
        String season = request.getParameter("season");
        String style = request.getParameter("style");
        String write_date = request.getParameter("write_date");


        BoardDao bdao = new BoardDao();
        BoardVO bvo = new BoardVO();

        bvo.setCus_no(cus_no);
        bvo.setProd_no(prod_no);
        bvo.setBname(bname);
        bvo.setTitle(title);
        bvo.setContent(content);

        bvo.setGender(gender);
        bvo.setSeason(season);
        bvo.setStyle(style);
        bvo.setWrite_date(write_date);

        boolean result = bdao.addBoard(bvo);


        String id = request.getParameter("boardId");
        JSONObject json = new JSONObject();
        json.put("success", result);
        json.put("id", id);


        System.out.println("JSON Response: " + json.toString());


        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
        out.close();

        return null;

    }

}
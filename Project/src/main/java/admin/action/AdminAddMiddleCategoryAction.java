package admin.action;

import admin.dao.MajorCategoryDao;
import admin.dao.MiddleCategoryDao;
import admin.vo.MajorCategoryVO;
import admin.vo.MiddleCategoryVO;
import org.json.JSONObject;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class AdminAddMiddleCategoryAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String major_no = request.getParameter("majorCategoryId");
        String name = request.getParameter("middleCategoryName");
        String typeStr = request.getParameter("middleCategoryType");
        int type = 1;
        try {
            type = Integer.parseInt(typeStr); // 정수 변환
        } catch (NumberFormatException e) {
            throw new IOException("Invalid type value: must be an integer", e);
        }




        MiddleCategoryDao mddao = new MiddleCategoryDao();
        MiddleCategoryVO mdvo = new MiddleCategoryVO();
        mdvo.setMajor_no(major_no);
        mdvo.setName(name);
        mdvo.setType(type);

        boolean result = mddao.addMiddleCategory(mdvo);
        int id = mddao.getId(name);
      System.out.println("id"+id);

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

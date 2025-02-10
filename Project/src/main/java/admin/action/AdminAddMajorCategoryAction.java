package admin.action;

import admin.dao.MajorCategoryDao;
import admin.vo.MajorCategoryVO;
import org.json.JSONObject;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AdminAddMajorCategoryAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
    // JSON 응답 설정
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");


    String name = request.getParameter("name");
    String ename = request.getParameter("ename");


    MajorCategoryDao mcdao = new MajorCategoryDao();
    MajorCategoryVO mcvo = new MajorCategoryVO();
    mcvo.setName(name);
    mcvo.setEname(ename);



    boolean result = mcdao.addMajorCategory(mcvo);

    MajorCategoryVO vo = mcdao.getMajorCategoryId(mcvo);
    int cnt =Integer.parseInt(vo.getId());

    JSONObject json = new JSONObject();
    json.put("success", result);
    json.put("result", cnt);

    System.out.println("JSON Response: " + json.toString());


    response.getWriter().write(json.toString());
    response.getWriter().flush();
    response.getWriter().close();

    return null;
  }
}

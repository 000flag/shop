package admin.action;

import admin.dao.MajorCategoryDao;
import admin.vo.MajorCategoryVO;
import org.json.JSONObject;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class AdminAddCategoryAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    // 폼에서 전달된 파라미터를 받아오기
    try {
      String name = request.getParameter("name");
      System.out.println("name"+name);
      String ename=request.getParameter("ename");
      System.out.println("ename"+ename);
      MajorCategoryDao mcdao= new MajorCategoryDao();
      MajorCategoryVO mcvo=new MajorCategoryVO();
      mcvo.setName(name);
      mcvo.setEname(ename);
      boolean chk =mcdao.addMajorCategory(mcvo);
      HttpSession session = request.getSession();

      response.setContentType("application/json");
      response.setCharacterEncoding("UTF-8");
      PrintWriter out = response.getWriter();





      return null;
    } catch (Exception e) {
      throw new RuntimeException(e);
    }


  }

}
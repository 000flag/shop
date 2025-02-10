package admin.action;

import admin.dao.BoardDao;
import admin.vo.LogVO;
import user.action.Action;
import org.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class AdminDeleteBoardAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {

    try {
      //json으로 받은모습
      String content = request.getParameter("content");
      int id = Integer.parseInt(request.getParameter("id"));
      String cus_no = request.getParameter("cus_no");

      BoardDao boardDao = new BoardDao();

      // 게시판 삭제 (id_del 0 → 1)
      boolean chk = boardDao.deleteBoard(id);

      HttpSession session = request.getSession();
      String rootIdStr = (String) session.getAttribute("id"); // 먼저 String으로 가져옴
      int rootId = Integer.parseInt(rootIdStr); // int로 변환

      // 로그 저장
      LogVO log = new LogVO();
      log.setCus_no(cus_no);
      log.setRoot_no(rootId);
      log.setTarget("게시글삭제");
      log.setLog_type("0");
      log.setPrev("고객:"+cus_no+" 게시판번호:"+id);
      log.setCurrent(content);

      int data = boardDao.logininsert(log);

      //json형태로 response에다가 분기점 값을 체크 해주고
      response.setContentType("application/json");
      response.setCharacterEncoding("UTF-8");
      PrintWriter out = response.getWriter();

      JSONObject jsonResponse = new JSONObject();
      //값을 보내준다(json형태로 )
      jsonResponse.put("status", chk ? "success" : "fail");
      jsonResponse.put("deletedId", id);
      jsonResponse.put("message", chk ? "삭제 성공" : "삭제 실패");

      out.print(jsonResponse.toString());
      out.flush();
      out.close();

    } catch (Exception e) {
      e.printStackTrace();
    }

    return null;
  }
}

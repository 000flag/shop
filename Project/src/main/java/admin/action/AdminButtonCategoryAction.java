package admin.action;

import admin.dao.MajorCategoryDao;
import admin.dao.MiddleCategoryDao;
import admin.dao.SellerDao;
import admin.vo.LogVO;
import admin.vo.MajorCategoryVO;
import user.action.Action;
import org.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class AdminButtonCategoryAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        try {
            //json으로 받은모습
            String content = request.getParameter("content");
            int id = Integer.parseInt(request.getParameter("id"));
            //
            String action = request.getParameter("action");
            System.out.println("content: "+content);
            System.out.println("id: "+id);

            if(action.equals("major")) {
                MajorCategoryDao mcDao = new MajorCategoryDao();

                // 대분류 삭제 (is_del 0 → 1)
                boolean chk = mcDao.deleteMajorCategory(id);

                HttpSession session = request.getSession();
                String rootIdStr = (String) session.getAttribute("id"); // 먼저 String으로 가져옴
                int rootId = Integer.parseInt(rootIdStr); // int로 변환


                // 로그 저장
                LogVO log = new LogVO();

//
                log.setRoot_no(rootId);
                log.setTarget("대분류추가제거");
                log.setLog_type("0");
                log.setPrev("대분류번호:" + id);
                log.setCurrent(content);


                int data = MajorCategoryDao.logininsert(log);

                //json형태로 response에다가 분기점 값을 체크 해주고
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();

                JSONObject jsonResponse = new JSONObject();
                //값을 보내준다(json형태로 )
                jsonResponse.put("status", chk ? "success" : "fail");
                jsonResponse.put("deleteMajorCategoryId", id);
                jsonResponse.put("message", chk ? "거절 성공" : "거절 실패");

                out.print(jsonResponse.toString());
                out.flush();
                out.close();
            }

            else if (action.equals("middle")) {
                MiddleCategoryDao mdDao = new MiddleCategoryDao();

                // 중분류 삭제 (is_del 0 -> 1)
                boolean chk = mdDao.deleteMiddleCategory(id);

                HttpSession session = request.getSession();
                String rootIdStr = (String) session.getAttribute("id"); // 먼저 String으로 가져옴
                int rootId = Integer.parseInt(rootIdStr); // int로 변환


                // 로그 저장
                LogVO log = new LogVO();

//
                log.setRoot_no(rootId);
                log.setTarget("중분류추가제거");
                log.setLog_type("0");
                log.setPrev("중분류번호:" + id);
                log.setCurrent(content);


                int data = MiddleCategoryDao.logininsert(log);

                //json형태로 response에다가 분기점 값을 체크 해주고
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();

                JSONObject jsonResponse = new JSONObject();
                //값을 보내준다(json형태로 )
                jsonResponse.put("status", chk ? "success" : "fail");
                jsonResponse.put("deleteMiddleCategoryId", id);
                jsonResponse.put("message", chk ? "거절 성공" : "거절 실패");

                out.print(jsonResponse.toString());
                out.flush();
                out.close();
            }


        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}

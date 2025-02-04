package admin.action;

import admin.dao.MajorCategoryDao;
import admin.dao.SellerDao;
import admin.vo.LogVO;
import org.json.JSONObject;
import user.action.Action;

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
            String action = request.getParameter("major");
            System.out.println("content: "+content);
            System.out.println("id: "+id);

            if(action.equals("major")) {
                MajorCategoryDao mcDao = new MajorCategoryDao();

                // 게시판 삭제 (active 1 → 2)
                boolean chk = MajorCategoryDao.deleteMajorCategory(id);

                HttpSession session = request.getSession();
                String rootIdStr = (String) session.getAttribute("id"); // 먼저 String으로 가져옴
                int rootId = Integer.parseInt(rootIdStr); // int로 변환


                // 로그 저장
                LogVO log = new LogVO();

//
                log.setRoot_no(rootId);
                log.setTarget("주카테고리추가삭제");
                log.setLog_type("0");
                log.setPrev("주카테고리번호:" + id);
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
//            else if (action.equals("admit")) {
//                MajorCategoryDao mcDao = new MajorCategoryDao();
//
//                // 게시판 삭제 (active 1 → 2)
//                boolean chk = mcDao.deleteMajorCategory(id);
//
//                HttpSession session = request.getSession();
//                String rootIdStr = (String) session.getAttribute("id"); // 먼저 String으로 가져옴
//                int rootId = Integer.parseInt(rootIdStr); // int로 변환
//
//
//                // 로그 저장
//                LogVO log = new LogVO();
//
////
//                log.setRoot_no(rootId);
//                log.setTarget("판매자승인거절");
//                log.setLog_type("0");
//                log.setPrev("판매자대기번호:" + id);
//                log.setCurrent(content);
//
//
//                int data = SellerDao.logininsert(log);
//
//                //json형태로 response에다가 분기점 값을 체크 해주고
//                response.setContentType("application/json");
//                response.setCharacterEncoding("UTF-8");
//                PrintWriter out = response.getWriter();
//
//                JSONObject jsonResponse = new JSONObject();
//                //값을 보내준다(json형태로 )
//                jsonResponse.put("status", chk ? "success" : "fail");
//                jsonResponse.put("admitSellerId", id);
//                jsonResponse.put("message", chk ? "승인 성공" : "승인 실패");
//
//                out.print(jsonResponse.toString());
//                out.flush();
//                out.close();
//            }


        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    }
}

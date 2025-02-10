package admin.action;

import admin.dao.CustomerDao;
import admin.dao.SellerDao;
import admin.vo.LogVO;
import org.json.JSONObject;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class AdminButtonCustomerAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try{
            String content = request.getParameter("content");
            int id = Integer.parseInt(request.getParameter("id"));
            //
            String action = request.getParameter("action");
            System.out.println("content: "+content);
            System.out.println("id: "+id);
            if(action.equals("stop")){
                CustomerDao cDao = new CustomerDao();

                // 구매자 정지 (is_del 0 → 2)
                boolean chk = cDao.stopCustomer(id);

                HttpSession session = request.getSession();
                String rootIdStr = (String) session.getAttribute("id"); // 먼저 String으로 가져옴
                int rootId = Integer.parseInt(rootIdStr); // int로 변환


                // 로그 저장
                LogVO log = new LogVO();

//
                log.setRoot_no(rootId);
                log.setTarget("구매자정지");
                log.setLog_type("0");
                log.setPrev("구매자번호:" + id);
                log.setCurrent(content);


                int data = CustomerDao.logininsert(log);

                //json형태로 response에다가 분기점 값을 체크 해주고
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();

                JSONObject jsonResponse = new JSONObject();
                //값을 보내준다(json형태로 )
                jsonResponse.put("status", chk ? "success" : "fail");
                jsonResponse.put("stopCustomerId", id);
                jsonResponse.put("message", chk ? "거절 성공" : "거절 실패");

                out.print(jsonResponse.toString());
                out.flush();
                out.close();

            }
            else if(action.equals("admit")){
                CustomerDao cDao = new CustomerDao();

                // 구매자 복귀 (is_del 2 → 0)
                boolean chk = cDao.admitCustomer(id);

                HttpSession session = request.getSession();
                String rootIdStr = (String) session.getAttribute("id"); // 먼저 String으로 가져옴
                int rootId = Integer.parseInt(rootIdStr); // int로 변환


                // 로그 저장
                LogVO log = new LogVO();

//
                log.setRoot_no(rootId);
                log.setTarget("구매자복귀");
                log.setLog_type("0");
                log.setPrev("구매자번호:" + id);
                log.setCurrent(content);


                int data = CustomerDao.logininsert(log);

                //json형태로 response에다가 분기점 값을 체크 해주고
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();

                JSONObject jsonResponse = new JSONObject();
                //값을 보내준다(json형태로 )
                jsonResponse.put("status", chk ? "success" : "fail");
                jsonResponse.put("admitCustomerId", id);
                jsonResponse.put("message", chk ? "거절 성공" : "거절 실패");

                out.print(jsonResponse.toString());
                out.flush();
                out.close();

            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }
}

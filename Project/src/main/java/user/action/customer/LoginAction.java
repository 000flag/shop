package user.action.customer;

import org.json.JSONObject;
import org.mindrot.jbcrypt.BCrypt;
import user.action.Action;
import user.dao.customer.CartDAO;
import user.dao.customer.CustomerDAO;
import user.dao.customer.LogDAO;
import user.dao.customer.ProductDAO;
import user.dao.snap.CustomerDao;
import user.vo.customer.CustomerVO;
import user.vo.customer.LogVO;
import user.vo.customer.MajorCategoryVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.List;

public class LoginAction  implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();

        String action = request.getParameter("action");

        String viewPath = null;
        if (action != null) {
            switch (action) {
                case "find":
                    viewPath = "/user/customer/jsp/login/findCustomer.jsp";
                    break;
                case "search_customer":
                    String cus_id = request.getParameter("cus_id");

                    // 회원 찾기
                    int cnt = CustomerDAO.selectCusId(cus_id);

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    try (PrintWriter out = response.getWriter()) {
                        // JSON 객체 생성
                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("success", true);
                        jsonResponse.put("is_exists", cnt > 0);

                        // JSON 응답 전송
                        out.print(jsonResponse.toString());
                        out.flush();
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        session.setAttribute("find_cus_id", cus_id);
                    }

                    return null;
                case "reset":
                    viewPath = "/user/customer/jsp/login/resetPassword.jsp";
                    break;
                case "update_customer":
                    CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

                    if (cvo == null) {
                        request.setAttribute("session_expired", true);
                        return "/user/customer/jsp/error/error.jsp";
                    }
                    
                    // 비밀번호 변경
                    cus_id = (String) session.getAttribute("find_cus_id");
                    String cus_pw = request.getParameter("cus_pw");

                    cnt = CustomerDAO.updateCustomerPw(cus_id, BCrypt.hashpw(cus_pw, BCrypt.gensalt()));
                    
                    if (cnt > 0) {
                        // 비밀번호 변경, 추가 로그
                        LogVO lvo = new LogVO();
                        StringBuffer sb = new StringBuffer();
                        lvo.setCus_no(cvo.getId());
                        lvo.setTarget("customer 수정");
                        sb.append("비밀번호 변경");
                        lvo.setCurrent(sb.toString());
                        LogDAO.updateLog(lvo);
                    }

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    try (PrintWriter out = response.getWriter()) {
                        // JSON 객체 생성
                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("success", cnt > 0 ? true : false);

                        // JSON 응답 전송
                        out.print(jsonResponse.toString());
                        out.flush();
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        // 세션 제거
                        session.removeAttribute("find_cus_id");
                    }
                    
                    return null;
            }
        } else {
            String username = request.getParameter("username");

            // 구매자 조회
            CustomerVO loginResult = CustomerDAO.selectCustomerByCusId(username);

            if (loginResult == null) {
                // 로그인 실패
                session.setAttribute("isLoggedIn", false);
                return "/user/customer/jsp/login/login.jsp";
            }

            try {
                String password = request.getParameter("password");

                // 비밀번호 검증
                if (BCrypt.checkpw(password, loginResult.getCus_pw())) {

                  String nickname = loginResult.getNickname();
                  int customer_id = CustomerDao.getId(nickname);



                  // 로그인 정보 저장
                   session.setAttribute("cus_id", customer_id);
                   session.setAttribute("nickname", nickname);
                    session.setAttribute("isLoggedIn", true);
                    session.setAttribute("customer_info", loginResult);

                    // 장바구니 수
                    int cart_count = CartDAO.selectCartCount(loginResult.getId());
                    session.setAttribute("cart_count", cart_count);

                    // 카테고리
                    List<MajorCategoryVO> categories = ProductDAO.selectCategory();

                    if (categories != null && !categories.isEmpty()) {
                        request.setAttribute("categories", categories);
                    }

                    // 로그인, 추가 로그
                    LogVO lvo = new LogVO();
                    lvo.setCus_no(loginResult.getId());
                    lvo.setTarget("customer 로그인");
                    LogDAO.insertEtcLog(lvo);

                    viewPath = "/user/customer/jsp/index.jsp";
                } else {
                    // 실패 시에만 isLoggedIn 설정
                    if (username != null && password != null) {
                        session.setAttribute("isLoggedIn", false);
                    }

                    viewPath = "/user/customer/jsp/login/login.jsp";
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return viewPath;
    }
}

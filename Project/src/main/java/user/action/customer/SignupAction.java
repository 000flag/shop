package user.action.customer;

import org.json.JSONObject;
import org.mindrot.jbcrypt.BCrypt;
import user.action.Action;
import user.dao.customer.CustomerDAO;
import user.dao.customer.DeliveryDAO;
import user.dao.customer.LogDAO;
import user.vo.customer.CustomerVO;
import user.vo.customer.LogVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

public class SignupAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String action = request.getParameter("action");

        String viewPath = null;
        if (action != null) {
            switch (action) {
                case "select_exists":
                    String cusId = request.getParameter("cus_id");

                    int cnt = CustomerDAO.selectCusId(cusId);

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    try (PrintWriter out = response.getWriter()) {
                        out.print("{");
                        out.print("\"success\": true,");
                        if (cnt > 0) {
                            out.print("\"response\":" + true);
                        } else {
                            out.print("\"response\":" + false);
                        }
                        out.print("}");
                        out.flush();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    return null;
                case "insert":
                    try {
                        cusId = request.getParameter("cus_id");

                        // 아이디 존재 여부 확인
                        cnt = CustomerDAO.selectCusId(cusId);

                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");

                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("success", true);

                        if (cnt > 0) {
                            // 이미 존재하는 아이디
                            jsonResponse.put("is_exists", true);
                        } else {
                            // 새로운 회원 정보 가져오기
                            String cusPw = request.getParameter("cus_pw");
                            String cusName = request.getParameter("cus_name");
                            String cusNickname = request.getParameter("cus_nickname");
                            String cusGender = request.getParameter("cus_gender");
                            String cusBirth = request.getParameter("cus_birth");
                            String cusPhone = request.getParameter("cus_phone");
                            String cusEmail = request.getParameter("cus_email");

                            // 비밀번호 암호화 및 VO 설정
                            CustomerVO vo = new CustomerVO();
                            vo.setCus_id(cusId);
                            vo.setCus_pw(BCrypt.hashpw(cusPw, BCrypt.gensalt()));
                            vo.setName(cusName);
                            vo.setNickname(cusNickname);
                            vo.setGender(cusGender);
                            vo.setBirth_date(cusBirth);
                            vo.setPhone(cusPhone);
                            vo.setEmail(cusEmail);

                            // 회원 정보 저장
                            cnt = CustomerDAO.insertCustomer(vo);

                            if (cnt > 0) {
                                CustomerVO cvo = CustomerDAO.selectCustomerByCusId(vo.getCus_id());

                                // 기본 배송지 저장
                                String pos_code = request.getParameter("pos_code");
                                String addr1 = request.getParameter("addr1");
                                String addr2 = request.getParameter("addr2");

                                DeliveryDAO.insertDelivery(cvo.getId(), cusName, cusPhone, pos_code, addr1, addr2, "1", null);

                                // 로그 저장
                                LogVO lvo = new LogVO();
                                StringBuffer sb = new StringBuffer();
                                lvo.setCus_no(cvo.getId());
                                lvo.setTarget("customer 추가");
                                sb.append("cus_id : ").append(vo.getCus_id()).append(", ");
                                sb.append("name : ").append(cusName).append(", ");
                                sb.append("nickname : ").append(cusNickname).append(", ");
                                sb.append("gender : ").append(cusGender).append(", ");
                                sb.append("birth_date : ").append(cusBirth).append(", ");
                                sb.append("phone : ").append(cusPhone).append(", ");
                                sb.append("email : ").append(cusEmail);
                                lvo.setCurrent(sb.toString());
                                LogDAO.insertLog(lvo);
                            }

                            // 회원 가입 결과 응답
                            jsonResponse.put("is_exists", false);
                            jsonResponse.put("is_join", cnt > 0);
                        }

                        // 응답 전송
                        try (PrintWriter out = response.getWriter()) {
                            out.print(jsonResponse.toString());
                            out.flush();
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        try (PrintWriter out = response.getWriter()) {
                            JSONObject errorResponse = new JSONObject();
                            errorResponse.put("success", false);
                            errorResponse.put("message", "서버 처리 중 오류가 발생했습니다.");
                            out.print(errorResponse.toString());
                            out.flush();
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                    }
            }
        } else {
            viewPath = "/user/customer/jsp/signup/signup.jsp";
        }

        return viewPath;
    }
}

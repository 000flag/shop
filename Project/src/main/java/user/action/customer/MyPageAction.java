package user.action.customer;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONObject;
import org.mindrot.jbcrypt.BCrypt;
import service.S3Uploader;
import user.action.Action;
import user.dao.customer.*;
import user.vo.customer.BoardVO;
import user.vo.customer.CustomerVO;
import user.vo.customer.LogVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.Normalizer;
import java.util.List;
import java.util.UUID;
import java.util.regex.Pattern;

public class MyPageAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");

        HttpSession session = request.getSession();
        CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

        if (cvo == null) {
            request.setAttribute("session_expired", true);
            return "/user/customer/jsp/error/error.jsp";
        }

        String viewPath = null;
        if (action != null) {
            switch (action) {
                case "profile":
                    viewPath = "/user/customer/jsp/mypage/pwConfirm.jsp";
                    break;
                case "edit":
                    viewPath = "/user/customer/jsp/mypage/profileEdit.jsp";
                    break;
                case "update_profile":
                    try {
                        JSONObject responseJson = new JSONObject(); // JSON 응답을 위한 객체

                        // 파일 업로드 처리
                        DiskFileItemFactory factory = new DiskFileItemFactory();
                        ServletFileUpload upload = new ServletFileUpload(factory);
                        List<FileItem> items = upload.parseRequest(request);

                        String nickname = null;
                        String photo = null;

                        for (FileItem item : items) {
                            if (item.isFormField()) {
                                String fieldName = item.getFieldName();
                                String value = item.getString("UTF-8");

                                if (fieldName.equals("nickname")) {
                                    nickname = value;
                                }
                            } else {
                                // 파일 업로드 처리
                                if (!item.getName().isEmpty()) {
                                    String originalFileName = new File(item.getName()).getName();

                                    String safeFileName = normalizeFileName(originalFileName);
                                    String uniqueFileName = UUID.randomUUID().toString() + "_" + safeFileName;

                                    File tempFile = new File(System.getProperty("java.io.tmpdir"), uniqueFileName);
                                    item.write(tempFile);
                                    // S3 업로드 처리
                                    S3Uploader s3Uploader = new S3Uploader();
                                    photo = s3Uploader.uploadFile(tempFile, "mypage_profile_image/" + uniqueFileName);

                                    // 임시 파일 삭제
                                    tempFile.delete();
                                }
                            }
                        }
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");

                        // 필수 값 검증
                        if (nickname == null) {
                            responseJson.put("success", false);
                            responseJson.put("message", "닉네임을 올바르게 입력하세요.");
                            response.getWriter().write(responseJson.toString());
                            return null;
                        }

                        // DB 저장
                        CustomerVO c_vo = new CustomerVO();
                        c_vo.setId(cvo.getId());
                        c_vo.setNickname(nickname);
                        c_vo.setProfile_image(photo);

                        int result = CustomerDAO.updateProfile(c_vo);

                        if (result > 0) {
                            responseJson.put("success", true);
                            responseJson.put("message", "프로필이 변경되었습니다.");

                            // 프로필 변경, 추가 로그
                            LogVO lvo = new LogVO();
                            StringBuffer sb = new StringBuffer();
                            lvo.setCus_no(cvo.getId());
                            lvo.setTarget("customer 수정");
                            lvo.setLog_type("2");
                            sb.append("nickname : " + cvo.getNickname() + "\n");
                            sb.append("profile_image : " + cvo.getProfile_image());
                            lvo.setPrev(sb.toString());
                            sb = new StringBuffer();
                            sb.append("nickname : " + nickname + "\n");
                            sb.append("profile_image : " + photo);
                            lvo.setCurrent(sb.toString());
                            LogDAO.insertLog(lvo);

                            // 구매자 정보 갱신
                            CustomerVO rvo = CustomerDAO.selectCustomerById(cvo.getId());
                            session.setAttribute("customer_info", rvo);
                        } else {
                            responseJson.put("success", false);
                            responseJson.put("message", "프로필 변경에 실패했습니다. 다시 시도해 주세요.");
                        }

                        response.getWriter().write(responseJson.toString());
                        response.getWriter().flush();
                        response.getWriter().close();

                        return null;
                    } catch (Exception e) {
                        e.printStackTrace();
                        JSONObject errorJson = new JSONObject();
                        errorJson.put("success", false);
                        errorJson.put("message", "서버 내부 오류 발생: " + e.getMessage());
                        response.setContentType("application/json");
                        response.getWriter().write(errorJson.toString());
                        return null;
                    }
                case "refresh":
                    CustomerVO rvo = CustomerDAO.selectCustomerByCusId(cvo.getCus_id());

                    session.setAttribute("customer_info", rvo);

                    viewPath = "/user/customer/jsp/mypage/mypage.jsp";
                    break;
                case "confirm":
                    // 구매자 조회
                    CustomerVO result = CustomerDAO.selectCustomerByCusId(cvo.getCus_id());

                    // JSON 응답 설정
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    if (result != null) {
                        String cus_pw = request.getParameter("cus_pw");

                        boolean isValid = BCrypt.checkpw(cus_pw, result.getCus_pw());

                        // JSON 응답 반환
                        try (PrintWriter out = response.getWriter()) {
                            out.print("{");
                            out.print("\"success\": true,");
                            out.print("\"data\": {");
                            out.print("\"valid\": " + isValid);
                            out.print("}");
                            out.print("}");

                            out.flush();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    } else {
                        // result가 null인 경우 JSON 응답 반환
                        try (PrintWriter out = response.getWriter()) {
                            out.print("{");
                            out.print("\"success\": true,");
                            out.print("\"data\": {");
                            out.print("\"valid\": false");
                            out.print("}");
                            out.print("}");

                            out.flush();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }

                    return null;
                case "select_customer":
                    rvo = CustomerDAO.selectCustomerById(cvo.getId());
                    session.setAttribute("customer_info", rvo);
                    viewPath = "/user/customer/jsp/mypage/components/profile.jsp";
                    break;
                case "update_customer":
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phone");

                    // 구매자 정보 수정
                    CustomerVO uvo = new CustomerVO();
                    uvo.setId(cvo.getId());
                    uvo.setEmail(email);
                    uvo.setPhone(phone);
                    int cnt = CustomerDAO.updateCustomer(uvo);

                    if (cnt > 0) {
                        // 구매자 정보 변경, 추가 로그
                        LogVO lvo = new LogVO();
                        StringBuffer sb = new StringBuffer();
                        lvo.setCus_no(cvo.getId());
                        lvo.setTarget("customer 수정");
                        lvo.setLog_type("2");
                        sb.append("email : " + cvo.getEmail() + "\n");
                        sb.append("phone : " + cvo.getPhone());
                        lvo.setPrev(sb.toString());
                        sb = new StringBuffer();
                        sb.append("email : " + email + "\n");
                        sb.append("phone : " + phone);
                        lvo.setCurrent(sb.toString());
                        LogDAO.insertLog(lvo);
                    }

                    viewPath = "/user/customer/jsp/mypage/profileEdit.jsp";
                    break;
                case "update_password":
                    // 비밀번호 변경
                    String cus_pw = request.getParameter("change_pw");

                    cnt = CustomerDAO.updateCustomerPw(cvo.getCus_id(), BCrypt.hashpw(cus_pw, BCrypt.gensalt()));

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    if (cnt > 0) {
                        // 비밀번호 변경, 로그 추가
                        LogVO lvo = new LogVO();
                        StringBuffer sb = new StringBuffer();
                        lvo.setCus_no(cvo.getId());
                        lvo.setTarget("customer 수정");
                        lvo.setLog_type("2");
                        sb = new StringBuffer();
                        sb.append("비밀번호 변경");
                        lvo.setCurrent(sb.toString());
                        LogDAO.insertLog(lvo);
                    }

                    try (PrintWriter out = response.getWriter()) {
                        // JSON 객체 생성
                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("success", cnt > 0 ? true : false);

                        // JSON 응답 전송
                        out.print(jsonResponse.toString());
                        out.flush();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    return null;
                case "retired_customer":
                    cnt = CustomerDAO.deleteCustomer(cvo.getId());

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    
                    if (cnt > 0) {
                        // 회원 탈퇴, 로그 추가
                        LogVO lvo = new LogVO();
                        StringBuffer sb = new StringBuffer();
                        lvo.setCus_no(cvo.getId());
                        lvo.setTarget("customer 삭제");
                        sb.append("id : " + cvo.getId());
                        lvo.setPrev(sb.toString());
                        LogDAO.deleteLog(lvo);
                    }

                    try (PrintWriter out = response.getWriter()) {
                        // JSON 객체 생성
                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("success", cnt > 0 ? true : false);

                        // JSON 응답 전송
                        out.print(jsonResponse.toString());
                        out.flush();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    
                    // 세션 삭제
                    request.getSession().invalidate();

                    return null;
            }
        } else {
            // 갱신
            CustomerVO rvo = CustomerDAO.selectCustomerByCusId(cvo.getCus_id());

            session.setAttribute("customer_info", rvo);

            // 보유 적립금
            int points = PointDAO.selectSavePoint(cvo.getId());
            request.setAttribute("points", points);

            // 보유 쿠폰 수
            int coupons = CouponDAO.selectCouponCount(cvo.getId(), cvo.getGrade_no());
            request.setAttribute("coupons", coupons);

            // 후기 작성할 수 있는 건수
            int ableCount = OrderDAO.selectReviewAbleCount(cvo.getId());
            request.setAttribute("ableCount", ableCount);

            viewPath = "/user/customer/jsp/mypage/mypage.jsp";
        }

        return viewPath;
    }

    public static String normalizeFileName(String fileName) {
        String normalized = Normalizer.normalize(fileName, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(normalized).replaceAll("").replaceAll("[^a-zA-Z0-9._-]", "_");
    }
}

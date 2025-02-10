package user.action.customer;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONObject;
import service.S3Uploader;
import user.action.Action;
import user.dao.customer.BoardDAO;
import user.dao.customer.CustomerDAO;
import user.dao.customer.OrderDAO;
import user.vo.customer.BoardVO;
import user.vo.customer.CustomerVO;
import user.vo.customer.OrderVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.Normalizer;
import java.util.List;
import java.util.UUID;
import java.util.regex.Pattern;

public class ReviewAction implements Action {
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
                case "select":
                    String startDate = request.getParameter("startDate");
                    String endDate = request.getParameter("endDate");

                    if (startDate == null || startDate.isEmpty() || endDate == null || endDate.isEmpty()) {
                        startDate = null;
                        endDate = null;
                    }

                    List<BoardVO> list = BoardDAO.selectWriteReview(cvo.getId(), startDate, endDate);

                    request.setAttribute("r_list", list);
                    viewPath = "/user/customer/jsp/mypage/components/review.jsp";
                    break;
                case "edit":
                    String id = request.getParameter("board_no");

                    BoardVO vo = BoardDAO.selectReviewDetails(cvo.getId(), id);
                    request.setAttribute("o_vo", vo);

                    viewPath = "/user/customer/jsp/mypage/editReview.jsp";
                    break;
                case "write":
                    String prod_no = request.getParameter("prod_no");
                    String order_code = request.getParameter("order_code");

                    OrderVO o_vo = OrderDAO.selectReviewProduct(cvo.getId(), prod_no, order_code);
                    request.setAttribute("o_vo", o_vo);

                    viewPath = "/user/customer/jsp/mypage/writeReview.jsp";
                    break;
                case "insert":
                    try {
                        JSONObject responseJson = new JSONObject(); // JSON 응답을 위한 객체

                        // 파일 업로드 처리
                        DiskFileItemFactory factory = new DiskFileItemFactory();
                        ServletFileUpload upload = new ServletFileUpload(factory);
                        List<FileItem> items = upload.parseRequest(request);

                        prod_no = null;
                        order_code = null;
                        String rating = null;
                        String comment = null;
//                        String gender = null;
//                        String height = null;
//                        String weight = null;
//                        String isUpdateChecked = null;
                        String photo = null;

                        for (FileItem item : items) {
                            if (item.isFormField()) {
                                String fieldName = item.getFieldName();
                                String value = item.getString("UTF-8");

                                switch (fieldName) {
                                    case "prod_no":
                                        prod_no = value;
                                        break;
                                    case "order_code":
                                        order_code = value;
                                        break;
                                    case "rating":
                                        rating = value;
                                        break;
                                    case "comment":
                                        comment = value;
                                        break;
//                                    case "gender":
//                                        gender = value;
//                                        break;
//                                    case "height":
//                                        height = value;
//                                        break;
//                                    case "weight":
//                                        weight = value;
//                                        break;
//                                    case "isUpdateChecked":
//                                        isUpdateChecked = value;
//                                        break;
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
                                    photo = s3Uploader.uploadFile(tempFile, "review_images/" + uniqueFileName);

                                    // 임시 파일 삭제
                                    tempFile.delete();
                                }
                            }
                        }

                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");

                        // 필수 값 검증
                        if (rating == null || comment == null || rating.isEmpty() || comment.length() < 10) {
                            responseJson.put("success", false);
                            responseJson.put("message", "별점과 리뷰 내용을 올바르게 입력하세요.");
                            response.getWriter().write(responseJson.toString());
                            return null;
                        }

                        // DB 저장
                        BoardVO b_vo = new BoardVO();
                        b_vo.setProd_no(prod_no);
                        b_vo.setOrder_code(order_code);
                        b_vo.setCus_no(cvo.getId());
                        b_vo.setScore(String.valueOf(Integer.parseInt(rating)));
                        b_vo.setContent(comment);
                        //b_vo.setGender(gender);
                        b_vo.setAdditional_images(photo);

//                        if ("true".equals(isUpdateChecked)) {
//                            CustomerDAO.updateBodyInfo(cvo.getId(), weight, height);
//                        }

                        int result = BoardDAO.insertReview(b_vo);
                        if (result > 0) {
                            responseJson.put("success", true);
                            responseJson.put("message", "후기가 등록되었습니다.");
                        } else {
                            responseJson.put("success", false);
                            responseJson.put("message", "후기가 등록에 실패했습니다. 다시 시도해 주세요.");
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
                case "update":
                    try {
                        JSONObject responseJson = new JSONObject(); // JSON 응답을 위한 객체

                        // 파일 업로드 처리
                        DiskFileItemFactory factory = new DiskFileItemFactory();
                        ServletFileUpload upload = new ServletFileUpload(factory);
                        List<FileItem> items = upload.parseRequest(request);

                        String board_no = null;
                        String rating = null;
                        String comment = null;
                        String photo = null;

                        for (FileItem item : items) {
                            if (item.isFormField()) {
                                String fieldName = item.getFieldName();
                                String value = item.getString("UTF-8");

                                switch (fieldName) {
                                    case "board_no":
                                        board_no = value;
                                        break;
                                    case "rating":
                                        rating = value;
                                        break;
                                    case "comment":
                                        comment = value;
                                        break;
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
                                    photo = s3Uploader.uploadFile(tempFile, "review_images/" + uniqueFileName);

                                    // 임시 파일 삭제
                                    tempFile.delete();
                                }
                            }
                        }

                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");

                        // 필수 값 검증
                        if (rating == null || comment == null || rating.isEmpty() || comment.length() < 10) {
                            responseJson.put("success", false);
                            responseJson.put("message", "별점과 리뷰 내용을 올바르게 입력하세요.");
                            response.getWriter().write(responseJson.toString());
                            return null;
                        }

                        // DB 저장
                        BoardVO b_vo = new BoardVO();
                        b_vo.setId(board_no);
                        b_vo.setScore(String.valueOf(Integer.parseInt(rating)));
                        b_vo.setContent(comment);
                        b_vo.setAdditional_images(photo);

                        int result = BoardDAO.updateReview(b_vo);
                        if (result > 0) {
                            responseJson.put("success", true);
                            responseJson.put("message", "후기가 수정되었습니다.");
                        } else {
                            responseJson.put("success", false);
                            responseJson.put("message", "후기 수정에 실패했습니다. 다시 시도해 주세요.");
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
                case "delete":
                    id = request.getParameter("id");

                    int cnt = BoardDAO.deleteReview(id);

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    try (PrintWriter out = response.getWriter()) {
                        boolean success = cnt > 0;

                        out.print("{");
                        out.print("\"success\": " + success);
                        out.print("}");

                        out.flush();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    return null;
            }
        }
        return viewPath;
    }

    public static String normalizeFileName(String fileName) {
        String normalized = Normalizer.normalize(fileName, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(normalized).replaceAll("").replaceAll("[^a-zA-Z0-9._-]", "_");
    }
}
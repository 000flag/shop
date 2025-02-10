package seller.action;

import user.action.Action;
import comm.dao.CouponDAO;
import comm.dao.SellerLogDAO;
import comm.vo.seller.CouponVO;
import comm.vo.seller.SellerLogVO;
import org.json.JSONObject; // JSON 응답을 위해 필요

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class CouponUpdateAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            // 요청에서 데이터 받기
            HttpSession session = request.getSession();
            String seller_no = (String) session.getAttribute("seller_no");
            String id = request.getParameter("id");
            System.out.println("id="+id);//왜 이거 안나오냐 sout
            String name = request.getParameter("name");
            String sale_per = request.getParameter("sale_per");
            String start_date = request.getParameter("start_date");
            String end_date = request.getParameter("end_date");
            String category_no = request.getParameter("category_no");
            String grade_no = request.getParameter("grade_no");
            System.out.println(grade_no);
            // 🔹 2. 기존 쿠폰 정보 조회 (수정 전 값 저장)
            CouponVO prevCoupon = CouponDAO.getCouponById(id);  // 수정 전 데이터 조회
            String prev = (prevCoupon != null) ?
                    "쿠폰명: " + prevCoupon.getName() +
                            ", 할인율: " + prevCoupon.getSale_per() + "%" : "데이터 없음";

            // 쿠폰 객체 생성 및 값 설정
            CouponVO coupon = new CouponVO();
            coupon.setId(id);
            coupon.setName(name);
            coupon.setSale_per(sale_per);
            coupon.setStart_date(start_date);
            coupon.setEnd_date(end_date);
            coupon.setCategory_no(category_no);
            coupon.setGrade_no(grade_no);

            // 데이터베이스 업데이트 실행
            int result = CouponDAO.updateCoupon(coupon);
            System.out.println("result="+result);
            // JSON 응답 객체 생성
            JSONObject jsonResponse = new JSONObject();
            if (result > 0) {
                jsonResponse.put("status", "success");
                jsonResponse.put("message", "쿠폰이 성공적으로 수정되었습니다.");
                System.out.println("✅ CouponUpdateAction: Coupon updated successfully!");

                // 🔹 6. 로그 객체 생성 및 값 설정
                SellerLogVO log = new SellerLogVO();
                log.setSeller_no(seller_no); // 현재 로그인한 판매자 ID
                log.setWriter_type((String) request.getSession().getAttribute("writer_type")); // 작성자 유형
                log.setTarget("쿠폰수정");  // 로그 대상
                log.setLog_type("2");  // 2 = 수정
                log.setPrev(prev);  // 수정 전 데이터
                log.setCurrent("쿠폰명: " + name + ", 할인율: " + sale_per + "%"); // 수정된 데이터

                // 🔹 7. 로그 DB에 저장
                SellerLogDAO.insertSellerLog(log);
                System.out.println("✅ 로그 기록 완료: " + log);

            } else {
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "쿠폰 수정에 실패했습니다.");
                System.err.println("❌ CouponUpdateAction: Failed to update coupon.");
            }

            // 응답 설정 및 JSON 데이터 전송
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse.toString());

        } catch (IOException e) {
            e.printStackTrace();
        }

        return "seller/jsp/ajax/coupon_delete.jsp"; // AJAX 요청이므로 JSP 이동 불필요
    }
}

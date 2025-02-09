package seller.action;

import comm.action.Action;
import comm.dao.CouponDAO;
import comm.vo.CouponVO;
import org.json.JSONObject; // JSON 응답을 위해 필요

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CouponUpdateAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            // 요청에서 데이터 받기
            String id = request.getParameter("id");
            System.out.println("id="+id);
            String name = request.getParameter("name");
            String sale_per = request.getParameter("sale_per");
            String start_date = request.getParameter("start_date");
            String end_date = request.getParameter("end_date");
            String category_no = request.getParameter("category_no");
            String grade_no = request.getParameter("grade_no");
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

            // JSON 응답 객체 생성
            JSONObject jsonResponse = new JSONObject();
            if (result > 0) {
                jsonResponse.put("status", "success");
                jsonResponse.put("message", "쿠폰이 성공적으로 수정되었습니다.");
                System.out.println("✅ CouponUpdateAction: Coupon updated successfully!");
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

        return "/seller/jsp/ajax/coupon_delete.jsp"; // AJAX 요청이므로 JSP 이동 불필요
    }
}

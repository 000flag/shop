package seller.action;


import user.action.Action;
import comm.dao.CouponDAO;
import comm.dao.SellerLogDAO;
import comm.vo.CouponVO;
import comm.vo.SellerLogVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CouponInsertAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 폼에서 전달된 데이터 받기
        String name = request.getParameter("name");
        System.out.println(name);
        String sale_per = request.getParameter("sale_per");
        String start_date = request.getParameter("start_date");
        String end_date = request.getParameter("end_date");
        String category_no = request.getParameter("category_no");
        System.out.println(category_no);
        String grade_no = request.getParameter("grade_no");

        // 쿠폰 객체 생성 및 값 설정
        CouponVO coupon = new CouponVO();
        coupon.setName(name);
        coupon.setSale_per(sale_per);
        coupon.setStart_date(start_date);
        coupon.setEnd_date(end_date);
        coupon.setCategory_no(category_no);
        coupon.setGrade_no(grade_no);

        // 쿠폰 추가 실행
        int result = CouponDAO.insertCoupon(coupon);
        System.out.println(coupon);

        if (result > 0) {
            System.out.println("✅ CouponInsertAction: Coupon inserted successfully!");

            SellerLogVO vo = new SellerLogVO();
            vo.setSeller_no((String) request.getSession().getAttribute("seller_no")); // 현재 로그인한 판매자 ID
            vo.setWriter_type((String) request.getSession().getAttribute("writer_type")); // 작성자 유형
            vo.setTarget("쿠폰추가");  // 로그 대상
            vo.setLog_type("1");  // 1 = 추가
            vo.setPrev("");  // 추가 이전 값 없음
            vo.setCurrent("쿠폰명: " + name + ", 할인율: " + sale_per + "%"); // 추가된 쿠폰 정보

            // 🔹 5. 로그 DB에 저장
            SellerLogDAO.insertSellerLog(vo);
            System.out.println("✅ 로그 기록 완료: " + vo);
        } else {
            System.err.println("❌ CouponInsertAction: Failed to insert coupon.");
        }
        request.setAttribute("coupon", coupon);
        // 추가 후 쿠폰 목록 페이지로 이동
        return "/Controller?type=couponList";
    }
}
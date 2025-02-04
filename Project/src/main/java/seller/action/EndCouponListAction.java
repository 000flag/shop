package seller.action;


import comm.action.Action;
import comm.dao.CouponDAO;
import comm.vo.EndCouponVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class EndCouponListAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 만료된 쿠폰 목록 가져오기
        List<EndCouponVO> expiredCoupons = CouponDAO.getExpiredCoupons();

        if (expiredCoupons == null || expiredCoupons.isEmpty()) {
            System.err.println("❌ EndCouponListAction: No expired coupons found!");
        } else {
            System.out.println("✅ EndCouponListAction: Found " + expiredCoupons.size() + " expired coupons.");
        }

        // JSP에서 사용할 수 있도록 request에 저장
        request.setAttribute("expiredCoupons", expiredCoupons);

        return "/seller/jsp/coupon.jsp";
    }
}
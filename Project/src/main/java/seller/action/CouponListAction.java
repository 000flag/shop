package seller.action;

import user.action.Action;
import comm.dao.CouponDAO;
import comm.vo.CouponVO;
import comm.vo.EndCouponVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class CouponListAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        List<CouponVO> coupons = CouponDAO.getAvailableCoupons(); // ✅ 사용 가능한 쿠폰 조회
        List<EndCouponVO> expiredCoupons = CouponDAO.getExpiredCoupons();

        if (coupons == null || coupons.isEmpty()) {
            System.err.println("❌ CouponListAction: No available coupons found!");
        } else {
            System.out.println("✅ CouponListAction: Found " + coupons.size() + " coupons.");
            System.out.println("✅ CouponListAction: Found " + expiredCoupons.size() + " expiredCoupons.");
        }

        request.setAttribute("coupons", coupons);
        request.setAttribute("expiredCoupons", expiredCoupons);
        return "/seller/jsp/coupon.jsp";
    }
}
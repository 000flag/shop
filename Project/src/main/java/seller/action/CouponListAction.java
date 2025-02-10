package seller.action;

import user.action.Action;
import comm.dao.CouponDAO;
import comm.vo.seller.CouponVO;
import comm.vo.seller.EndCouponVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class CouponListAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String seller_no = (String) session.getAttribute("seller_no");
        List<CouponVO> coupons = CouponDAO.getAvailableCoupons(seller_no); // ✅ 사용 가능한 쿠폰 조회
        List<EndCouponVO> expiredCoupons = CouponDAO.getExpiredCoupons(seller_no);

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
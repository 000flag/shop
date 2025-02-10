package seller.action;

import user.action.Action;
import comm.dao.CouponDAO;
import comm.dao.SellerLogDAO;
import comm.vo.SellerLogVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CouponDeleteAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        SellerLogVO vo = new SellerLogVO();
        String id = request.getParameter("id");
        String target = "쿠폰삭제";
        String logType = "0";
        String prev = "";
        String current = "";
        vo.setTarget(target);
        vo.setLog_type(logType);
        vo.setPrev(prev);
        vo.setCurrent(current);
        System.out.println(vo);

        int result = CouponDAO.deleteCoupon(id);
        SellerLogDAO.insertSellerLog(vo);

        if (result > 0) {
            System.out.println("✅ CouponDeleteAction: Coupon deleted successfully!");
        } else {
            System.err.println("❌ CouponDeleteAction: Failed to delete coupon.");
        }

        return "seller/jsp/ajax/coupon_delete.jsp"; // 삭제 후 쿠폰 목록 페이지로 이동
    }
}

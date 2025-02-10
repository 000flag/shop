package admin.action;

import admin.dao.CouponDao;
import admin.dao.MajorCategoryDao;
import admin.dao.MiddleCategoryDao;
import admin.vo.CouponVO;
import admin.vo.MajorCategoryVO;
import admin.vo.MiddleCategoryVO;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class AdminCouponAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        CouponDao cdao = new CouponDao();

        List<CouponVO> list = cdao.allCoupon();
        List<String> list1_1 = cdao.allCouponCol();
        request.setAttribute("couponList", list);
        request.setAttribute("couponName", list1_1);

        return "/admin/jsp/couponmain.jsp";


    }
}

package admin.action;

import admin.dao.CouponDao;
import admin.dao.SellerDao;
import admin.vo.CouponVO;
import admin.vo.SellerVO;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class AdminSellerAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        SellerDao sdao = new SellerDao();

        List<SellerVO> list = sdao.allSeller();
        List<String> list1_1 = sdao.allSellerName();
        request.setAttribute("sellerList", list);
        request.setAttribute("sellerName", list1_1);




        return "/admin/jsp/sellermain.jsp";
    }
}

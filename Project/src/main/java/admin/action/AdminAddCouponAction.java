package admin.action;

import admin.dao.CouponDao;
import admin.dao.MajorCategoryDao;
import admin.dao.MiddleCategoryDao;
import admin.vo.CouponVO;
import admin.vo.MajorCategoryVO;
import admin.vo.MiddleCategoryVO;
import org.json.JSONObject;
import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class AdminAddCouponAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String root_no = request.getParameter("root_no");
        String category_no = request.getParameter("category_no");

        String grade_no = request.getParameter("grade_no");

        String name = request.getParameter("name");
        String sale_per = request.getParameter("sale_per");
        String start_date = request.getParameter("start_date");
        String end_date = request.getParameter("end_date");

        CouponDao cdao = new CouponDao();
        CouponVO cvo = new CouponVO();

        cvo.setRoot_no(root_no);
        cvo.setCategory_no(category_no);

        cvo.setGrade_no(grade_no);

        cvo.setName(name);
        cvo.setSale_per(sale_per);
        cvo.setStart_date(start_date);
        cvo.setEnd_date(end_date);

        boolean result = cdao.addCoupon(cvo);


        String id = request.getParameter("couponId");
        JSONObject json = new JSONObject();
        json.put("success", result);
        json.put("id", id);


        System.out.println("JSON Response: " + json.toString());


        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
        out.close();

        return null;

    }
}
package user.action.customer;

import user.action.Action;
import user.dao.customer.EventDAO;
import user.vo.customer.CustomerVO;
import user.vo.customer.EventVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.List;

public class EventAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

        if (cvo == null) {
            request.setAttribute("session_expired", true);
            return "/user/customer/jsp/error/error.jsp";
        }

        // 상품 사이즈 목록
        List<EventVO> events = EventDAO.selectEvent(cvo.getId(), cvo.getGrade_no());

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.print("{");
            out.print("\"success\": true,");
            out.print("\"data\": [");

            if (events != null && !events.isEmpty()) {
                for (int i = 0; i < events.size(); i++) {
                    EventVO vo = events.get(i);

                    out.print("{");
                    out.print("\"id\":" + vo.getId() + ",");
                    out.print("\"getBrand\":\"" + vo.getBrand() + "\",");
                    out.print("\"getCoupon_no\":\"" + vo.getCoupon_no() + "\",");
                    out.print("\"getCoupon_name\":\"" + vo.getCoupon_name() + "\",");
                    out.print("\"getCoupon_no\":\"" + vo.getSale_per() + "\",");
                    out.print("\"getGrade_no\":\"" + vo.getGrade_no() + "\",");
                    out.print("\"getEvent_time\":\"" + vo.getEvent_time() + "\",");
                    out.print("\"isRead\":" + vo.getIs_read());
                    out.print("}");

                    if (i < events.size() - 1) {
                        out.print(",");
                    }
                }
            }

            out.print("]");
            out.print("}");
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}

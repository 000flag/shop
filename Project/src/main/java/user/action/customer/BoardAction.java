package user.action.customer;

import user.action.Action;
import user.dao.customer.BoardDAO;
import user.dao.customer.LogDAO;
import user.vo.customer.BoardVO;
import user.vo.customer.CustomerVO;
import user.vo.customer.LogVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class BoardAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

        if (cvo == null) {
            request.setAttribute("session_expired", true);
            return "/user/customer/jsp/error/error.jsp";
        }

        String viewPage = null;
        if (action != null) {
            switch (action) {
                case "inquiry":
                    viewPage = "/user/customer/jsp/mypage/writeInquiry.jsp";
                    break;
                case "select":
                    List<BoardVO> all_list = BoardDAO.selectAll(cvo.getId());
                    request.setAttribute("inquiry_list", all_list);
                    viewPage = "/user/customer/jsp/mypage/components/inquiry.jsp";
                    break;
                case "search":
                    String status = request.getParameter("status");
                    status = (status != null && !status.trim().isEmpty()) ? status : null;

                    String startDate = request.getParameter("startDate");
                    startDate = (startDate != null && !startDate.trim().isEmpty()) ? startDate : null;

                    String endDate = request.getParameter("endDate");
                    endDate = (endDate != null && !endDate.trim().isEmpty()) ? endDate : null;

                    List<BoardVO> searchlist = BoardDAO.selectSearch(cvo.getId(), status, startDate, endDate);
                    request.setAttribute("inquiry_list", searchlist);
                    viewPage = "/user/customer/jsp/mypage/components/inquiry.jsp";
                    break;
                case "insert":
                    String i_type = request.getParameter("inquiryType");
                    String i_orderCode = request.getParameter("orderCode");
                    String i_content = request.getParameter("content");
                    String i_additional_images = request.getParameter("");

                    BoardVO ivo = new BoardVO();
                    ivo.setCus_no(cvo.getId());
                    ivo.setContent(i_content);
                    ivo.setAdditional_images("");
                    ivo.setOrder_code(i_orderCode);
                    ivo.setType(i_type);

                    int cnt = BoardDAO.insertInquiry(ivo);

                    if (cnt > 0) {
                        request.setAttribute("response", "true");

                        // 추가 로그
                        LogVO lvo = new LogVO();
                        StringBuffer sb = new StringBuffer();
                        lvo.setCus_no(cvo.getId());
                        lvo.setTarget("inquiry 추가");
                        sb.append("content : " + i_content + ", ");
                        sb.append("order_code : " + i_orderCode + ", ");
                        sb.append("type : " + i_type + ", ");
                        sb.append("additional_images : " + i_additional_images);
                        lvo.setCurrent(sb.toString());
                        LogDAO.insertLog(lvo);
                    } else {
                        request.setAttribute("response", "false");
                    }

                    viewPage = "/user/customer/jsp/mypage/writeInquiry.jsp";
                    break;
                case "faq":
                    viewPage = "/user/customer/jsp/board/faq.jsp";
                    break;
            }
        }

        return viewPage;
    }
}

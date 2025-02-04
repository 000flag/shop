package user.action;

import user.dao.*;
import user.vo.CustomerVO;
import user.vo.DeliveryVO;
import user.vo.OrderVO;
import user.vo.ProductVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class ExchangeRequestAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

        if (cvo == null) {
            request.setAttribute("session_expired", true);
            return "/user/jsp/error/error.jsp";
        }

        String action = request.getParameter("action");
        String id = request.getParameter("order_id");
        String order_code = request.getParameter("order_code");
        String prod_no = request.getParameter("prod_no");

        if (action != null) {
            switch (action) {
                case "select":
                    try {
                        OrderVO o_vo = OrderDAO.selectOrderProduct(id, cvo.getId(), order_code);
                        List<DeliveryVO> d_list = DeliveryDAO.selectDelivery(cvo.getId());

                        request.setAttribute("o_vo", o_vo);
                        request.setAttribute("d_list", d_list);

                        return "/user/jsp/mypage/exchangeRequest.jsp";
                    } catch (Exception e) {
                        e.printStackTrace();
                        return "/user/jsp/error/error.jsp";
                    }

                case "select_size":
                    // 상품 사이즈 목록 조회
                    List<ProductVO> productSize = ProductDAO.selectSize(prod_no);

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    try (PrintWriter out = response.getWriter()) {
                        out.print("{");
                        out.print("\"success\": true,");
                        out.print("\"data\": [");

                        if (productSize != null && productSize.size() > 0) {
                            for (int i = 0; i < productSize.size(); i++) {
                                ProductVO pvo = productSize.get(i);

                                out.print("{");
                                out.print("\"prod_no\": \"" + pvo.getId() + "\",");
                                out.print("\"inventory_no\": \"" + pvo.getInventory_no() + "\",");
                                out.print("\"option_name\": \"" + pvo.getI_option_name() + "\"");
                                out.print("}");

                                if (i < productSize.size() - 1) {
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

                case "update":
                    try {
                        // 요청 데이터 가져오기
                        String reason = request.getParameter("reason");
                        String orderCode = request.getParameter("orderCode");
                        String retrieve_deli_no = request.getParameter("retrieve_deli_no");
                        String inventory_vo = request.getParameter("inventory_no");

                        // 주문 정보 업데이트 (반품 상태로 변경)
                        int u_o_cnt = OrderDAO.updateOrderExchange(id, cvo.getId(), prod_no, orderCode, reason, retrieve_deli_no, inventory_vo);

                        // JSON 응답 설정
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");

                        try (PrintWriter out = response.getWriter()) {
                            if (u_o_cnt > 0) {
                                out.print("{\"success\": true}");
                            } else {
                                System.err.println("Database update failed: Order or Point update affected 0 rows.");
                                out.print("{\"success\": false, \"message\": \"데이터베이스 업데이트 실패\"}");
                            }
                            out.flush();
                        }
                    } catch (Exception e) {
                        e.printStackTrace();

                        if (!response.isCommitted()) {
                            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                            response.setContentType("application/json");
                            response.setCharacterEncoding("UTF-8");

                            try (PrintWriter out = response.getWriter()) {
                                out.print("{\"success\": false, \"message\": \"서버 오류 발생\"}");
                                out.flush();
                            } catch (IOException ex) {
                                ex.printStackTrace();
                            }
                        } else {
                            System.err.println("응답이 이미 커밋되었습니다.");
                        }
                    }
                    return null;
            }
        }

        return "/user/jsp/mypage/exchangeRequest.jsp";
    }
}

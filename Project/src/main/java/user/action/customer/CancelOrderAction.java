package user.action.customer;

import user.action.Action;
import user.dao.customer.*;
import user.vo.customer.CustomerVO;
import user.vo.customer.DeliveryVO;
import user.vo.customer.LogVO;
import user.vo.customer.OrderVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import static user.dao.customer.PointDAO.calculateRefundPoint;

public class CancelOrderAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

        if (cvo == null) {
            request.setAttribute("session_expired", true);
            return "/user/customer/jsp/error/error.jsp";
        }

        String action = request.getParameter("action");
        String id = request.getParameter("order_id");
        String order_code = request.getParameter("order_code");
        String prod_no = request.getParameter("prod_no");

        List<OrderVO> o_list = null;
        List<DeliveryVO> d_list = null;
        List<OrderVO> coupon = null;
        int totalPrice = 0;
        int totalSaledPrice = 0;
        int point_amount = 0;

        if (action != null) {
            switch (action) {
                case "select":
                    o_list = OrderDAO.selectOrderProduct(id, cvo.getId(), order_code);
                    d_list = DeliveryDAO.selectDelivery(cvo.getId());
                    coupon = OrderDAO.selectOrderCoupons(id, cvo.getId(), order_code, prod_no); // 쿠폰 정보 가져오기
                    totalPrice = OrderDAO.selectTotalPrice(cvo.getId(), order_code);
                    totalSaledPrice = OrderDAO.selectTotalSaledPrice(cvo.getId(), order_code);
                    point_amount = PointDAO.selectPointAmount(cvo.getId(), order_code);

                    request.setAttribute("o_list", o_list);
                    request.setAttribute("d_list", d_list);
                    request.setAttribute("coupon", coupon);
                    request.setAttribute("totalPrice", totalPrice);
                    request.setAttribute("totalSaledPrice", totalSaledPrice);
                    request.setAttribute("point_amount", point_amount);

                    return "/user/customer/jsp/mypage/cancelOrder.jsp";

                case "select_all":
                    try {
                        o_list = OrderDAO.selectOrderProductAll(cvo.getId(), order_code);
                        d_list = DeliveryDAO.selectDelivery(cvo.getId());
                        coupon = OrderDAO.selectOrderCoupons(null, cvo.getId(), order_code, null); // 쿠폰 정보 가져오기
                        totalPrice = OrderDAO.selectTotalPrice(cvo.getId(), order_code);
                        totalSaledPrice = OrderDAO.selectTotalSaledPrice(cvo.getId(), order_code);
                        point_amount = PointDAO.selectPointAmount(cvo.getId(), order_code);

                        request.setAttribute("o_list", o_list);
                        request.setAttribute("d_list", d_list);
                        request.setAttribute("coupon", coupon);
                        request.setAttribute("totalPrice", totalPrice);
                        request.setAttribute("totalSaledPrice", totalSaledPrice);
                        request.setAttribute("point_amount", point_amount);

                        return "/user/customer/jsp/mypage/cancelOrder.jsp";
                    } catch (Exception e) {
                        e.printStackTrace();
                        return "/user/customer/jsp/error/error.jsp";
                    }
                case "update":
                    try {
                        String orderCode = request.getParameter("orderCode");
                        String reason = request.getParameter("reason");
                        String refund_bank = request.getParameter("bank");
                        String refund_account = request.getParameter("account_number");
                        String refundAmount = request.getParameter("refund_amount");
                        String point_used = request.getParameter("point_used");

                        // 주문 정보 업데이트 (취소 상태로 변경)
                        int u_o_cnt = OrderDAO.updateOrderCancel(id, cvo.getId(), prod_no, orderCode, refund_bank, refund_account, reason);
                        if (u_o_cnt == 0) {
                            response.setContentType("application/json");
                            response.setCharacterEncoding("UTF-8");
                            try (PrintWriter out = response.getWriter()) {
                                out.print("{\"success\": false, \"message\": \"주문 상태 업데이트 실패\"}");
                                out.flush();
                            }
                            return null;
                        }

                        if(u_o_cnt > 0){
                            OrderVO o_vo = OrderDAO.selectOrderById(id);

                            // 개별 취소 log
                            LogVO lvo = new LogVO();
                            StringBuffer sb = new StringBuffer();
                            lvo.setCus_no(cvo.getId());
                            lvo.setTarget("order 수정");
                            sb.append("id : " + o_vo.getId() + ", ");
                            sb.append("cus_no : " + o_vo.getCus_no() + ", ");
                            sb.append("order_code : " + o_vo.getOrder_code() + ", ");
                            sb.append("status : " + o_vo.getOrder_code());
                            lvo.setPrev(sb.toString());
                            sb = new StringBuffer();
                            sb.append("id : " + id + ", ");
                            sb.append("cus_no : " + cvo.getId() + ", ");
                            sb.append("order_code : " + orderCode + ", ");
                            sb.append("status : " + "6");
                            lvo.setCurrent(sb.toString());
                            LogDAO.updateLog(lvo);
                        }

                        // point_used가 존재하고 사용된 경우에만 실행
                        int refundAmountValue = Integer.parseInt(refundAmount);
                        if (point_used != null && !point_used.isEmpty() && Integer.parseInt(point_used) > 0) {
                            int totalOrderAmount = OrderDAO.selectTotalAmount(cvo.getId(), orderCode);
                            int usedPointAmount = Integer.parseInt(point_used);

                            int refundPointAmount = PointDAO.calculateRefundPoint(totalOrderAmount, refundAmountValue, usedPointAmount);

                            // 포인트 삭제 및 복구
                            int d_p_cnt = PointDAO.deletePoint(cvo.getId(), orderCode);

                            if(d_p_cnt > 0){
                                String p_id = PointDAO.selectPointByOrderCode(cvo.getId(), orderCode);

                                // 포인트 삭제 로그
                                LogVO lvo = new LogVO();
                                StringBuffer sb = new StringBuffer();
                                lvo.setCus_no(cvo.getId());
                                lvo.setTarget("point 삭제");
                                sb.append("id : " + p_id);
                                lvo.setPrev(sb.toString());
                                LogDAO.deleteLog(lvo);
                            }

                            int i_p_cnt = PointDAO.insertPoint(cvo.getId(), String.valueOf(refundPointAmount), orderCode);

                            if(i_p_cnt > 0){

                                // 포인트 추가 로그
                                LogVO lvo = new LogVO();
                                StringBuffer sb = new StringBuffer();
                                lvo.setCus_no(cvo.getId());
                                lvo.setTarget("point 추가");
                                sb.append("cus_no : " + cvo.getId() + ", ");
                                sb.append("amount : " + String.valueOf(refundPointAmount));
                                lvo.setCurrent(sb.toString());
                                LogDAO.insertLog(lvo);
                            }
                        }

                        // 쿠폰 복구 처리
                        int u_co_cnt = CouponDAO.updateCusCoupon(cvo.getId(), orderCode);

                        if (u_co_cnt > 0){
                            OrderVO o_vo = OrderDAO.selectCusCoupon(cvo.getId(), orderCode);

                            // 쿠폰 복구 수정 로그
                            LogVO lvo = new LogVO();
                            StringBuffer sb = new StringBuffer();
                            lvo.setCus_no(cvo.getId());
                            lvo.setTarget("cus_coupon 수정");
                            sb.append("cus_no : " + cvo.getId() + ", ");
                            sb.append("coupon_no : " + o_vo.getCoupon_no() + ", ");
                            sb.append("order_code : " + o_vo.getOrder_code() + ", ");
                            sb.append("status : " + "2");
                            lvo.setPrev(sb.toString());
                            sb = new StringBuffer();
                            sb.append("cus_no : " + cvo.getId() + ", ");
                            sb.append("coupon_no : " + o_vo.getCoupon_no() + ", ");
                            sb.append("order_code : " + orderCode + ", ");
                            sb.append("status : " + "1");
                            lvo.setCurrent(sb.toString());
                            LogDAO.updateLog(lvo);
                        }

                        // 고객 누적 금액 업데이트
                        int currentTotal = (cvo.getTotal() != null && !cvo.getTotal().isEmpty()) ? Integer.parseInt(cvo.getTotal()) : 0;
                        int totalINT = currentTotal - refundAmountValue;
                        CustomerDAO.updateTotal(cvo.getId(), String.valueOf(totalINT));

                        // JSON 응답 전송
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        try (PrintWriter out = response.getWriter()) {
                            out.print("{\"success\": true}");
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
                        }
                    }
                    return null;

                case "update_all":
                    try {
                        String orderCode = request.getParameter("orderCode");
                        String reason = request.getParameter("reason");
                        String refund_bank = request.getParameter("bank");
                        String refund_account = request.getParameter("account_number");
                        String refundAmount = request.getParameter("refund_amount");
                        String point_used = request.getParameter("point_used");

                        // 전체 상품 조회
                        List<OrderVO> orderList = OrderDAO.selectOrderProductAll(cvo.getId(), orderCode);
                        if (orderList == null || orderList.isEmpty()) {
                            response.setContentType("application/json");
                            response.setCharacterEncoding("UTF-8");
                            try (PrintWriter out = response.getWriter()) {
                                out.print("{\"success\": false, \"message\": \"환불 가능한 상품이 없습니다.\"}");
                                out.flush();
                            }
                            return null;
                        }

                        List<String> idList = new ArrayList<>();
                        for (OrderVO order : orderList) {
                            idList.add(order.getId());
                        }

                        int u_o_cnt = OrderDAO.updateOrderCancelAll(idList, cvo.getId(), orderCode, refund_bank, refund_account, reason);

                        int totalRefundAmount = Integer.parseInt(refundAmount);
                        if (u_o_cnt > 0) {

                            // 전체 취소 log
                            LogVO u_lvo = new LogVO();
                            StringBuffer u_sb = new StringBuffer();
                            u_lvo.setCus_no(cvo.getId());
                            u_lvo.setTarget("order 전체 취소 수정");
                            u_sb.append("order_code : " + orderCode + "\n");
                            u_sb.append("refundAmount : " + refundAmount + "\n");
                            u_sb.append("refund_bank : " + refund_bank + "\n");
                            u_sb.append("refund_account : " + refund_account);
                            u_lvo.setCurrent(u_sb.toString());
                            LogDAO.insertEtcLog(u_lvo);

                            if (point_used != null && !point_used.isEmpty() && Integer.parseInt(point_used) > 0) {
                                int d_p_cnt = PointDAO.deletePoint(cvo.getId(), orderCode);

                                if(d_p_cnt > 0){
                                    String p_id = PointDAO.selectPointByOrderCode(cvo.getId(), orderCode);

                                    // 포인트 삭제 로그
                                    LogVO d_lvo = new LogVO();
                                    StringBuffer sb = new StringBuffer();
                                    d_lvo.setCus_no(cvo.getId());
                                    d_lvo.setTarget("point 삭제");
                                    sb.append("id : " + p_id);
                                    d_lvo.setPrev(sb.toString());
                                    LogDAO.deleteLog(d_lvo);
                                }

                                int usedPointAmount = Integer.parseInt(point_used);
                                int refundPointAmount = calculateRefundPoint(totalRefundAmount, totalRefundAmount, usedPointAmount);

                                int i_p_cnt = PointDAO.insertPoint(cvo.getId(), String.valueOf(refundPointAmount), orderCode);

                                if(i_p_cnt > 0){
                                    // 포인트 추가 로그
                                    LogVO i_lvo = new LogVO();
                                    StringBuffer sb = new StringBuffer();
                                    i_lvo.setCus_no(cvo.getId());
                                    i_lvo.setTarget("point 추가");
                                    sb.append("cus_no : " + cvo.getId() + ", ");
                                    sb.append("amount : " + String.valueOf(refundPointAmount));
                                    i_lvo.setCurrent(sb.toString());
                                    LogDAO.insertLog(i_lvo);
                                }
                            }

                            int u_co_cnt = CouponDAO.updateCusCoupon(cvo.getId(), orderCode);

                            if(u_co_cnt > 0){
                                OrderVO o_vo = OrderDAO.selectOrderById(id);

                                // 쿠폰 복구 수정 로그
                                LogVO lvo = new LogVO();
                                StringBuffer sb = new StringBuffer();
                                lvo.setCus_no(cvo.getId());
                                lvo.setTarget("order 수정");
                                sb.append("id : " + o_vo.getId() + ", ");
                                sb.append("cus_no : " + o_vo.getCus_no() + ", ");
                                sb.append("order_code : " + o_vo.getOrder_code() + ", ");
                                sb.append("status : " + "2");
                                lvo.setPrev(sb.toString());
                                sb = new StringBuffer();
                                sb.append("id : " + id + ", ");
                                sb.append("cus_no : " + cvo.getId() + ", ");
                                sb.append("order_code : " + orderCode + ", ");
                                sb.append("status : " + "1");
                                lvo.setCurrent(sb.toString());
                                LogDAO.updateLog(lvo);
                            }

                            int currentTotal = (cvo.getTotal() != null && !cvo.getTotal().isEmpty()) ? Integer.parseInt(cvo.getTotal()) : 0;
                            CustomerDAO.updateTotal(cvo.getId(), String.valueOf(currentTotal - totalRefundAmount));

                            response.setContentType("application/json");
                            response.setCharacterEncoding("UTF-8");
                            try (PrintWriter out = response.getWriter()) {
                                out.print("{\"success\": true}");
                                out.flush();
                            }
                        } else {
                            response.setContentType("application/json");
                            response.setCharacterEncoding("UTF-8");
                            try (PrintWriter out = response.getWriter()) {
                                out.print("{\"success\": false, \"message\": \"주문 상태 업데이트 실패\"}");
                                out.flush();
                            }
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
                                throw new RuntimeException(ex);
                            }
                        }
                    }
                    return null;
            }
        }

        return "/user/customer/jsp/error/error.jsp";
    }
}

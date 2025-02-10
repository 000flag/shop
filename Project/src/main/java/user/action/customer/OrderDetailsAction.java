package user.action.customer;

import user.action.Action;
import user.dao.customer.*;
import user.vo.customer.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

public class OrderDetailsAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

        if (cvo == null) {
            request.setAttribute("session_expired", true);
            return "/user/customer/jsp/error/error.jsp";
        }

        String action = request.getParameter("action");
        String order_code = request.getParameter("order_code");

        String viewPage = null;
        if(action != null){
            switch (action) {
                // 주문상세 조회
                case "select":
                    List<OrderVO> o_list = OrderDAO.selectOrderCode(cvo.getId(), order_code); // 주문상세 정보 list
                    List<DeliveryVO> deli_list = DeliveryDAO.selectDelivery(cvo.getId()); // 해당 주문의 배송지 정보
                    List<OrderVO> coupon = OrderDAO.selectOrderCoupons(null, cvo.getId(), order_code, null);
                    GradeVO grade = GradeDAO.selectGradeCustomer(cvo.getId());
                    int totalSaledPrice = OrderDAO.selectTotalSaledPrice(cvo.getId(), order_code);
                    int totalAmount = OrderDAO.selectTotalAmount(cvo.getId(), order_code); // 총 결제 금액
                    int totalPrice = OrderDAO.selectTotalPrice(cvo.getId(), order_code); // 원가 총 금액
                    int point_amount = PointDAO.selectPointAmount(cvo.getId(), order_code); // 사용한 적립금

                    // 각 상품의 수량 합산
                    int totalCount = 0;
                    if (o_list != null && !o_list.isEmpty()) {
                        for (OrderVO item : o_list) {
                            totalCount += Integer.parseInt(item.getCount());  // 상품 수량 누적
                        }
                    }

                    // 각 상품별 쿠폰 할인 계산
                    HashMap<String, Double> couponDiscounts = new HashMap<>();
                    double totalCouponDiscount = 0.0;
                    int totalUsedPointAmount = 0;

                    if (coupon != null && !coupon.isEmpty() && o_list != null && !o_list.isEmpty()) {
                        for (OrderVO coupon_vo : coupon) {
                            double salePer = Double.parseDouble(coupon_vo.getSale_per());  // 쿠폰의 할인율(%)

                            for (OrderVO item : o_list) {
                                if (item.getCoupon_no() != null && item.getCoupon_no().equals(coupon_vo.getCoupon_no())) {  // 쿠폰과 상품 연결
                                    double itemDiscount = Integer.parseInt(item.getProd_saled_price()) * (salePer / 100.0);  // 상품별 할인 금액
                                    couponDiscounts.put(coupon_vo.getCoupon_no(), itemDiscount);  // 상품 이름 기준으로 할인 금액 저장
                                    totalCouponDiscount += itemDiscount;  // 총 할인 금액 누적
                                }
                            }
                        }
                    }

                    // 적립금 사용 계산
                    if (o_list != null && !o_list.isEmpty()) {
                        for (OrderVO item : o_list) {
                            if ("1".equals(item.getBenefit_type())) {  // benefit_type이 1인 경우(적립금 선할인)
                                String amountStr = item.getAmount() != null ? item.getAmount() : "0";
                                String resultAmountStr = item.getResult_amount() != null ? item.getResult_amount() : "0";

                                int usedPoint = Integer.parseInt(amountStr) - Integer.parseInt(resultAmountStr);
                                if (usedPoint > 0) {
                                    totalUsedPointAmount += usedPoint;
                                }
                                System.out.println("Used point for item: " + usedPoint);
                            }
                        }
                    }

                    request.setAttribute("o_list", o_list);
                    request.setAttribute("deli_list", deli_list);
                    request.setAttribute("coupon", coupon);
                    request.setAttribute("grade", grade);
                    request.setAttribute("totalSaledPrice", totalSaledPrice);
                    request.setAttribute("totalAmount", totalAmount);
                    request.setAttribute("totalPrice", totalPrice);
                    request.setAttribute("point_amount", point_amount);
                    request.setAttribute("totalCouponDiscount", totalCouponDiscount);
                    request.setAttribute("couponDiscounts", couponDiscounts);
                    request.setAttribute("totalUsedPointAmount", totalUsedPointAmount);
                    request.setAttribute("totalCount", totalCount);

                    viewPage = "/user/customer/jsp/mypage/orderDetails.jsp";
                    break;
                case "update":
                    String prev_deli_no = request.getParameter("pre_delivery_id");
                    String deli_no = request.getParameter("delivery_id");
                    int o_cnt = OrderDAO.updateOrderDelivery(cvo.getId(), order_code, deli_no);

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    try (PrintWriter out = response.getWriter()) {
                        if (o_cnt > 0) {
                            // 배송지 변경 성공 시, 변경된 데이터를 다시 조회
                            DeliveryVO updatedDelivery = DeliveryDAO.selectDeliveryById(deli_no);

                            // 배송지 변경, 로그 추가
                            LogVO lvo = new LogVO();
                            StringBuffer sb = new StringBuffer();
                            lvo.setCus_no(cvo.getId());
                            lvo.setTarget("order delivery 수정");
                            sb.append("deli_no : " + prev_deli_no);
                            sb.append("order_code : " + order_code);
                            lvo.setPrev(sb.toString());
                            sb = new StringBuffer();
                            sb.append("deli_no : " + deli_no + "\n");
                            sb.append("order_code : " + order_code);
                            lvo.setCurrent(sb.toString());
                            LogDAO.updateLog(lvo);

                            out.print("{");
                            out.print("\"success\": true,");
                            out.print("\"data\": {");
                            out.print("\"deli_name\": \"" + updatedDelivery.getName() + "\",");
                            out.print("\"phone\": \"" + updatedDelivery.getPhone() + "\",");
                            out.print("\"pos_code\": \"" + updatedDelivery.getPos_code() + "\",");
                            out.print("\"addr1\": \"" + updatedDelivery.getAddr1() + "\",");
                            out.print("\"addr2\": \"" + updatedDelivery.getAddr2() + "\"");
                            out.print("}");
                            out.print("}");
                        } else {
                            // 배송지 변경 실패 시 JSON 응답
                            out.print("{");
                            out.print("\"success\": false,");
                            out.print("\"message\": \"배송지 변경에 실패했습니다.\"");
                            out.print("}");
                        }
                        out.flush();
                    } catch (IOException e) {
                        e.printStackTrace();
                        try (PrintWriter out = response.getWriter()) {
                            out.print("{");
                            out.print("\"success\": false,");
                            out.print("\"message\": \"서버 내부 오류가 발생했습니다.\"");
                            out.print("}");
                            out.flush();
                        } catch (IOException ex) {
                            ex.printStackTrace();
                        }
                    }

                    return null;
                case "select_size":
                    String prod_no = request.getParameter("prod_no");

                    // 상품 사이즈 목록
                    List<ProductVO> productSize = ProductDAO.selectSize(prod_no);

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    try (PrintWriter out = response.getWriter()) {
                        out.print("{");
                        out.print("\"success\": true,");
                        out.print("\"data\": [");

                        if (productSize != null && !productSize.isEmpty()) {
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
                case "update_size":
                    // 사이즈 변경
                    String us_id = request.getParameter("order_id");
                    String us_order_code = request.getParameter("order_code");
                    String us_prod_no = request.getParameter("prod_no");
                    String us_inventory_no = request.getParameter("inventory_no"); // 변경할 값

                    // 기존 주문 정보 가져오기
                    OrderVO p_vo = OrderDAO.selectOrderById(us_id);

                    // 사이즈 수정
                    int u_cnt = OrderDAO.updateOrderSize(us_id, cvo.getId(), us_prod_no, us_order_code, us_inventory_no);

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    try (PrintWriter out = response.getWriter()) {
                        if (u_cnt > 0) {
                            out.print("{\"success\": true}");

                            // 사이즈 변경, 로그 추가
                            LogVO lvo = new LogVO();
                            StringBuffer sb = new StringBuffer();
                            lvo.setCus_no(cvo.getId());
                            lvo.setTarget("order size 수정");
                            sb.append("id : " + us_id + "\n");
                            sb.append("prod_no : " + us_prod_no + "\n");
                            sb.append("inventory_no : " + p_vo.getInventory_no() + "\n");
                            sb.append("order_code : " + order_code);
                            lvo.setPrev(sb.toString());
                            sb = new StringBuffer();
                            sb.append("id : " + us_id + "\n");
                            sb.append("prod_no : " + us_prod_no + "\n");
                            sb.append("inventory_no : " + us_inventory_no + "\n");
                            sb.append("order_code : " + us_order_code);
                            lvo.setCurrent(sb.toString());
                            LogDAO.updateLog(lvo);
                        } else {
                            out.print("{\"success\": false, \"message\": \"업데이트 실패\"}");
                        }

                        out.flush();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                    return null;
            }
        }

        return viewPage;
    }
}

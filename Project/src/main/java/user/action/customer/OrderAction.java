package user.action.customer;

import org.json.JSONObject;
import user.action.Action;
import user.dao.customer.*;
import user.vo.customer.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class OrderAction implements Action {
    private static final String HOST = "https://open-api.kakaopay.com";
    private static final String SECRET_KEY = "DEV3FACF03E22F89D2BFE1D14B430CCD153B9BAD";
    private static final String KAKAO_PAY_URL = "/online/v1/payment/ready";
    private static final String KAKAO_APPROVE = "/online/v1/payment/approve";

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
        if (action != null){
            switch (action) {
                case "all":
                    List<OrderVO> a_list = OrderDAO.selectAll(cvo.getId());
                    request.setAttribute("o_list", a_list);
                    viewPage = "/user/customer/jsp/mypage/components/order.jsp";
                    break;
                case "date":
                    String startDate = request.getParameter("startDate");
                    String endDate = request.getParameter("endDate");
                    List<OrderVO> d_list = OrderDAO.selectDate(cvo.getId(), startDate, endDate);
                    request.setAttribute("o_list", d_list);
                    viewPage = "/user/customer/jsp/mypage/components/order.jsp";
                    break;
                case "status":
                    String orderCode = request.getParameter("orderCode");
                    String status = request.getParameter("status");

                    int u_cnt = OrderDAO.updateOrderStatus(cvo.getId(), orderCode, status);
                    
                    if (u_cnt > 0) {
                        // 구매 확정, 로그 추가
                        LogVO lvo = new LogVO();
                        lvo.setCus_no(cvo.getId());
                        lvo.setTarget("order 수정");
                        StringBuffer sb = new StringBuffer();
                        sb.append("orderCode : " + orderCode + "\n");
                        sb.append("status : 4");
                        sb = new StringBuffer();
                        sb.append("orderCode : " + orderCode + "\n");
                        sb.append("status : " + status);
                        lvo.setCurrent(sb.toString());
                        LogDAO.updateLog(lvo);
                    }

                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    try (PrintWriter out = response.getWriter())  {
                        out.print("{\"response\": " + (u_cnt > 0) + "}");
                        out.flush();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    return null;
                case "payment":
                    try {
                        String p_prod_no = request.getParameter("prod_no");
                        String p_inventory_no = request.getParameter("inventory_no");
                        String p_count = request.getParameter("count");

                        // 선택한 상품
                        List<CartVO> c_list = new ArrayList<>();
                        ProductVO p_item = ProductDAO.selectProductDetails(p_prod_no, p_inventory_no);
                        CartVO c_item = new CartVO();
                        c_item.setId("1");
                        c_item.setCus_no(cvo.getId());
                        c_item.setProd_no(p_prod_no);
                        c_item.setCount(p_count);
                        c_item.setInventory_no(p_inventory_no);
                        c_item.setOption_name(p_item.getI_option_name());
                        c_item.setP_name(p_item.getName());
                        c_item.setBrand(p_item.getBrand());
                        c_item.setPrice(p_item.getPrice());
                        c_item.setProd_image(p_item.getProd_image());
                        c_item.setSale(p_item.getSale());
                        c_item.setSaled_price(p_item.getSaled_price());
                        c_list.add(c_item);
                        session.setAttribute("cartItems", c_list);

                        // 기본 배송지
                        DeliveryVO delivery = DeliveryDAO.selectDeliveryDefault(cvo.getId());
                        request.setAttribute("delivery", delivery);

                        // 배송지 목록
                        List<DeliveryVO> o_deli_list = DeliveryDAO.selectDelivery(cvo.getId());
                        request.setAttribute("deli_list", o_deli_list);

                        // 보유 적립금
                        int points = PointDAO.selectSavePoint(cvo.getId());
                        request.setAttribute("points", points);

                        // 등급 정보
                        List<GradeVO> grades = GradeDAO.selectGradeAll();
                        request.setAttribute("grades", grades);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    viewPage = "/user/customer/jsp/payment/payment.jsp";
                    break;
                case "coupon":
                    String prod_no = request.getParameter("prod_no");

                    List<CouponVO> coupons = CouponDAO.selectProdCoupon(cvo.getId(), prod_no, cvo.getGrade_no());

                    // 세션에 저장
                    session.setAttribute("coupons", coupons);

                    // JSON 응답을 클라이언트로 반환
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");

                    try (PrintWriter out = response.getWriter()) {
                        out.print("{");
                        out.print("\"success\": true,");
                        out.print("\"data\": [");

                        if (coupons != null && !coupons.isEmpty()) {
                            for (int i = 0; i < coupons.size(); i++) {
                                CouponVO vo = coupons.get(i);

                                // JSON 객체 시작
                                out.print("{");
                                out.print("\"coupon_id\": \"" + vo.getId() + "\",");
                                out.print("\"name\": \"" + vo.getName() + "\",");
                                out.print("\"sale_per\": \"" + vo.getSale_per() + "\",");
                                out.print("\"end_date\": \"" + vo.getEnd_date() + "\"");
                                out.print("}");

                                // 마지막 요소가 아니면 쉼표 추가
                                if (i < coupons.size() - 1) {
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
                case "kakaopay":
                    String order_code = request.getParameter("order_code");
                    String deli_no = request.getParameter("deli_no");
                    String used_point = request.getParameter("used_point"); // 사용한 적립금
                    String total_amount = request.getParameter("total_amount");
                    String tax_free_amount = request.getParameter("tax_free_amount");
                    String productsJson = request.getParameter("products");  // 구매 상품
                    String benefit_type = request.getParameter("benefit_type"); // 구매 적립/선할인

                    List<CartVO> cartItems = (List<CartVO>) session.getAttribute("cartItems");

                    String prod_name = null;
                    String quantity = null;
                    if (cartItems != null && !cartItems.isEmpty()) {
                        if (cartItems.size() > 1) {
                            // 첫 번째 상품 이름 + "외" + (나머지 상품 개수) + "개"
                            prod_name = cartItems.get(0).getP_name() + " 외 " + (cartItems.size() - 1) + "개";

                            int totalQuantity = 0;
                            for (CartVO item : cartItems) {
                                totalQuantity += Integer.parseInt(item.getCount()); // 모든 아이템의 count 값을 누적
                            }
                            quantity = String.valueOf(totalQuantity); // 누적된 값을 문자열로 변환하여 저장
                        } else {
                            // 상품이 1개일 경우, 해당 상품 이름만 설정
                            prod_name = cartItems.get(0).getP_name();

                            // cartItems.size()가 1인 경우 첫 번째 아이템의 count를 가져옴
                            quantity = String.valueOf(cartItems.get(0).getCount());
                        }
                    }

                    try {
                        // 카카오페이 API에 보낼 파라미터 준비
                        HashMap<String, String> map = new HashMap<>();
                        map.put("cid", "TC0ONETIME"); // 테스트용 상점 ID
                        map.put("partner_order_id", order_code); // 주문 코드
                        map.put("partner_user_id", cvo.getId()); // 회원 번호
                        map.put("item_name", prod_name); // 상품 명
                        map.put("quantity", quantity); // 상품 수량
                        map.put("total_amount", total_amount); // 상품 가격
                        map.put("tax_free_amount", tax_free_amount); // 비과세 금액
                        map.put("approval_url", "http://localhost:8080/user/customer/jsp/payment/approve.jsp"); // 성공 시 url
                        map.put("fail_url", "http://localhost:8080/fail"); // 실패 시 url
                        map.put("cancel_url", "http://localhost:8080/cancel"); // 취소 시 url

                        // HashMap을 JSONObject로 변환
                        JSONObject json = new JSONObject(map);
                        String jsonPayload = json.toString();

                        // API 요청
                        URL url = new URL(HOST + KAKAO_PAY_URL);
                        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                        conn.setRequestMethod("POST");
                        conn.setRequestProperty("Authorization", "SECRET_KEY " + SECRET_KEY);
                        conn.setRequestProperty("Content-Type", "application/json");
                        conn.setDoOutput(true);

                        // JSON 데이터 전송
                        try (OutputStream os = conn.getOutputStream()) {
                            os.write(jsonPayload.getBytes("UTF-8"));
                            os.flush();
                        }

                        // 응답 처리
                        int responseCode = conn.getResponseCode();
                        BufferedReader br = new BufferedReader(new InputStreamReader(
                                (responseCode == 200) ? conn.getInputStream() : conn.getErrorStream(), "UTF-8"
                        ));

                        StringBuilder responseStr = new StringBuilder();
                        String line;
                        while ((line = br.readLine()) != null) {
                            responseStr.append(line);
                        }
                        br.close();

                        // 응답에서 TID 추출
                        String jsonResponse = responseStr.toString();
                        JSONObject responseJson = new JSONObject(jsonResponse);

                        if (responseCode == 200) {
                            System.out.println("payment API 요청 성공: " + jsonResponse);

                            String tid = responseJson.optString("tid");

                            session.setAttribute("tid", tid);
                            session.setAttribute("deli_no", deli_no);
                            session.setAttribute("used_point", used_point); // 사용한 적립금
                            session.setAttribute("order_code", order_code);
                            session.setAttribute("benefit_type", benefit_type);

                            if (productsJson != null) {
                                session.setAttribute("products", productsJson);
                            }

                            // JSON 응답을 클라이언트로 반환
                            response.setContentType("application/json");
                            response.setCharacterEncoding("UTF-8");

                            try (PrintWriter out = response.getWriter()) {
                                out.print("{");
                                out.print("\"success\": true,");
                                out.print("\"data\": {");
                                out.print("\"tid\": \"" + responseJson.optString("tid") + "\",");
                                out.print("\"next_redirect_pc_url\": \"" + responseJson.optString("next_redirect_pc_url") + "\"");
                                out.print("}");
                                out.print("}");

                                out.flush();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        } else {
                            System.out.println("payment API 요청 실패: " + jsonResponse);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    return null;
                case "approve":
                    String pg_token = request.getParameter("pg_token");
                    order_code = (String) session.getAttribute("order_code");
                    String tid = (String) session.getAttribute("tid");

                    HashMap<String, String> map = new HashMap<>();
                    map.put("cid", "TC0ONETIME"); // 가맹점 코드(테스트용)
                    map.put("tid", tid); // 결제 고유번호
                    map.put("partner_order_id", order_code); // 주문 번호
                    map.put("partner_user_id", cvo.getId()); // 회원 번호
                    map.put("pg_token", pg_token); // 결제 승인 요청 인증 토큰

                    // HashMap을 JSONObject로 변환
                    JSONObject json = new JSONObject(map);
                    String jsonPayload = json.toString();

                    // API 요청
                    try {
                        URL url = new URL(HOST + KAKAO_APPROVE);
                        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                        conn.setRequestMethod("POST");
                        conn.setRequestProperty("Authorization", "SECRET_KEY " + SECRET_KEY);
                        conn.setRequestProperty("Content-Type", "application/json");
                        conn.setDoOutput(true);

                        // JSON 데이터 전송
                        try (OutputStream os = conn.getOutputStream()) {
                            os.write(jsonPayload.getBytes("UTF-8"));
                            os.flush();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                        // 응답 처리
                        int responseCode = conn.getResponseCode();
                        BufferedReader br = new BufferedReader(new InputStreamReader(
                                (responseCode == 200) ? conn.getInputStream() : conn.getErrorStream(), "UTF-8"
                        ));

                        StringBuilder responseStr = new StringBuilder();
                        String line;
                        while ((line = br.readLine()) != null) {
                            responseStr.append(line);
                        }
                        br.close();

                        // 응답에서 TID 추출
                        String jsonResponse = responseStr.toString();
                        JSONObject responseJson = new JSONObject(jsonResponse);

                        if (responseCode == 200) {
                            System.out.println("approve API 요청 성공: " + jsonResponse);

                            String productsJsonString = (String) session.getAttribute("products");

                            if (productsJsonString != null && !productsJsonString.isEmpty()) {
                                try {
                                    // JSON 파싱
                                    JSONObject products = new JSONObject(productsJsonString);

                                    // 각 제품 데이터 출력 및 처리
                                    for (String cartNo : products.keySet()) {
                                        JSONObject productData = products.getJSONObject(cartNo).getJSONObject("prod");

                                        int amount = productData.optInt("amount", 0);
                                        int count = productData.optInt("count", 0);
                                        prod_no = productData.optString("prodNo");
                                        String inventory_no = productData.optString("inventoryNo");
                                        String expected_point = productData.optString("point") != null && !productData.optString("point").isEmpty() ? productData.optString("point") : null; // 적립 예정 적립금
                                        String coupon = products.getJSONObject(cartNo).optString("coupon", null);
                                        int result_amount = productData.optInt("result_amount", 0);
                                        tid = responseJson.optString("tid");
                                        order_code = responseJson.optString("partner_order_id");
                                        deli_no = (String) session.getAttribute("deli_no");
                                        benefit_type = (String) session.getAttribute("benefit_type");

                                        // DB order 테이블, 주문 저장
                                        OrderDAO.insertOrder(tid, cvo.getId(), prod_no, coupon, deli_no, order_code, String.valueOf(count), String.valueOf(amount), benefit_type, String.valueOf(result_amount), expected_point, inventory_no);

                                        // DB customer 테이블, total 수정
                                        CustomerDAO.updateAddTotal(cvo.getId(), String.valueOf(amount));

                                        if (coupon != null) {
                                            // DB cus_coupon 테이블, 사용 쿠폰 저장
                                            CouponDAO.insertCusCoupon(cvo.getId(), coupon, order_code);
                                        }

                                        // DB inventory 테이블, 수량 감소
                                        ProductDAO.updateInventory(inventory_no, String.valueOf(count));

                                        // DB log 테이블, 로그 저장
                                        LogVO lvo = new LogVO();
                                        StringBuffer sb = new StringBuffer();
                                        lvo.setCus_no(cvo.getId());
                                        lvo.setTarget("order 추가");
                                        sb.append("tid : " + tid + ", ");
                                        sb.append("inventory_no : " + inventory_no);
                                        lvo.setCurrent(sb.toString());
                                        LogDAO.insertLog(lvo);
                                    }

                                    // DB point 테이블, 사용한 적립금 저장
                                    String i_point_amount = (String) session.getAttribute("used_point");
                                    if (i_point_amount != null && !i_point_amount.isEmpty()) {
                                        PointVO u_pvo = new PointVO();
                                        u_pvo.setCus_no(cvo.getId());
                                        u_pvo.setAmount(i_point_amount);
                                        u_pvo.setOrder_code(order_code);
                                        u_pvo.setP_type("1");
                                        PointDAO.insertUsePoint(u_pvo);
                                    }

                                    // DB 장바구니 테이블 삭제
                                    cartItems = (List<CartVO>) session.getAttribute("cartItems");
                                    for (CartVO item : cartItems) {
                                        CartDAO.deleteCart(cvo.getId(), item.getId());
                                    }

                                    // 장바구니 수
                                    int cart_count = CartDAO.selectCartCount(cvo.getId());
                                    session.setAttribute("cart_count", cart_count);

                                    // 주문 코드
                                    request.setAttribute("order_code", order_code);

                                    // 세션 삭제
                                    session.removeAttribute("cartItems");
                                    session.removeAttribute("order_code");
                                    session.removeAttribute("tid");
                                    session.removeAttribute("deli_no");
                                    session.removeAttribute("used_point");

                                    viewPage = "/user/customer/jsp/payment/orderCompleted.jsp";
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    System.out.println("Error parsing products JSON.");

                                    request.setAttribute("fail_msg", "결제에 실패했습니다. 다시 시도해 주세요.");
                                    viewPage = "/user/customer/jsp/cart/cart.jsp";
                                }
                            } else {
                                System.out.println("No products data found in session.");

                                request.setAttribute("fail_msg", "결제에 실패했습니다. 다시 시도해 주세요.");
                                viewPage = "/user/customer/jsp/cart/cart.jsp";
                            }
                        } else {
                            System.out.println("approve API 요청 실패: " + jsonResponse);

                            request.setAttribute("fail_msg", "결제에 실패했습니다. 다시 시도해 주세요.");
                            viewPage = "/user/customer/jsp/cart/cart.jsp";
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    break;
                case "completed":
                    order_code = request.getParameter("order_code");

                    List<OrderVO> o_list = OrderDAO.selectOrderCode(cvo.getId(), order_code); // 주문상세 정보 list
                    List<DeliveryVO> deli_list = DeliveryDAO.selectDelivery(cvo.getId()); // 해당 주문의 배송지 정보
                    List<OrderVO> coupon_list = OrderDAO.selectOrderCoupons(null, cvo.getId(), order_code, null);
                    GradeVO grade = GradeDAO.selectGradeCustomer(cvo.getId());
                    int totalAmount = OrderDAO.selectTotalAmount(cvo.getId(), order_code); // 결제 총 금액
                    int totalPrice = OrderDAO.selectTotalPrice(cvo.getId(), order_code); // 원가 총 금액
                    int point_amount = PointDAO.selectPointAmount(cvo.getId(), order_code); // 사용한 적립금

                    List<HashMap<String, Object>> discountList = new ArrayList<>();
                    for (OrderVO item : o_list) {
                        for (OrderVO coupon : coupon_list) {
                            if (item.getCoupon_no() != null && item.getCoupon_no().equals(coupon.getCoupon_no())) {
                                int individualDiscount = (int) (Double.parseDouble(item.getProd_saled_price()) * (Double.parseDouble(coupon.getSale_per()) / 100.0));

                                HashMap<String, Object> discountInfo = new HashMap<>();
                                discountInfo.put("coupon_name", coupon.getCoupon_name());
                                discountInfo.put("sale_per", coupon.getSale_per());
                                discountInfo.put("individualDiscount", individualDiscount);

                                discountList.add(discountInfo);
                            }
                        }
                    }

                    request.setAttribute("order_code", order_code);
                    request.setAttribute("o_list", o_list);
                    request.setAttribute("deli_list", deli_list);
                    request.setAttribute("discountList", discountList);
                    request.setAttribute("grade", grade);
                    request.setAttribute("totalAmount", totalAmount);
                    request.setAttribute("totalPrice", totalPrice);
                    request.setAttribute("point_amount", point_amount);

                    viewPage = "/user/customer/jsp/payment/components/completedDetails.jsp";
            }
        }

        return viewPage;
    }
}

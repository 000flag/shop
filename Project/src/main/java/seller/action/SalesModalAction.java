package seller.action;

import user.action.Action;
import comm.dao.SalesDAO;
import comm.vo.seller.SalesModalVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

public class SalesModalAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            String order_id = request.getParameter("orderId");  // 주문 ID 받아오기
            System.out.println("🔹 요청받은 주문 ID111: " + order_id);

            if (order_id != null && !order_id.trim().isEmpty()) {
                List<SalesModalVO> deliveryInfo = SalesDAO.getDeliveryInfo(order_id);

                if (deliveryInfo == null || deliveryInfo.isEmpty()) {
                    System.err.println("❌ 주문 정보 없음222: " + order_id);
                    response.setContentType("application/json; charset=UTF-8");
                    response.getWriter().print("[]"); // 빈 배열 반환
                    return null;
                }

                System.out.println("🟢 DB 조회 성공333: " + deliveryInfo.size() + "개의 데이터");
                System.out.println(deliveryInfo);

                // JSON 변환 및 응답
                response.setContentType("application/json; charset=UTF-8");
                PrintWriter out = response.getWriter();

                StringBuilder json = new StringBuilder();
                json.append("[");

                for (int i = 0; i < deliveryInfo.size(); i++) {
                    SalesModalVO delivery = deliveryInfo.get(i);
                    json.append("{")
                            .append("\"order_id\":\"").append(delivery.getOrder_id()).append("\",")
                            .append("\"order_date\":\"").append(delivery.getOrder_date()).append("\",")
                            .append("\"status\":\"").append(delivery.getStatus()).append("\",")
                            .append("\"customer_name\":\"").append(delivery.getCustomer_name()).append("\",")
                            .append("\"customer_phone\":\"").append(delivery.getCustomer_phone()).append("\",")
                            .append("\"customer_address\":\"").append(delivery.getCustomer_address()).append("\",")
                            .append("\"product_name\":\"").append(delivery.getProduct_name()).append("\",")
                            .append("\"category_name\":\"").append(delivery.getCategory_name()).append("\",")
                            .append("\"quantity\":\"").append(delivery.getQuantity()).append("\",")
                            .append("\"price\":\"").append(delivery.getPrice()).append("\",")
                            .append("\"discount_value\":\"").append(delivery.getDiscount_value()).append("\",")
                            .append("\"total_price\":\"").append(delivery.getTotal_price()).append("\"")
                            .append("}");

                    if (i < deliveryInfo.size() - 1) {
                        json.append(",");
                    }
                }

                json.append("]");
                out.print(json.toString());
                out.flush();
                out.close();
                return null;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

package user.dao.customer;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.customer.OrderVO;

import java.util.HashMap;
import java.util.List;

public class OrderDAO {
    //전체 주문내역 조회
    public static List<OrderVO> selectAll(String cus_no){
        List<OrderVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            list = ss.selectList("order.select_all", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    //날짜 별 주문내역 조회
    public static List<OrderVO> selectDate(String cus_no, String startDate, String endDate){
        List<OrderVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("startDate", startDate);
            map.put("endDate", endDate);

            list = ss.selectList("order.select_date", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    //주문상세내역 조회
    public static List<OrderVO> selectOrderCode(String cus_no, String order_code){
        List<OrderVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("order_code", order_code);

            list = ss.selectList("order.select_order_code", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    //취소, 반품, 교환할 상품 조회
    public static List<OrderVO> selectOrderProduct(String id, String cus_no, String order_code){
        List<OrderVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            if (id != null) {
                map.put("id", id);
            }
            map.put("cus_no", cus_no);
            map.put("order_code", order_code);

            list = ss.selectList("order.select_order_product", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    // 전체 취소, 반품, 교환할 상품 조회
    public static List<OrderVO> selectOrderProductAll(String cus_no, String order_code){
        List<OrderVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("order_code", order_code);

            list = ss.selectList("order.select_order_product_all", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    // 주문 총 금액
    public static int selectTotalAmount(String cus_no, String order_code){
        int totalAmount = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("order_code", order_code);

            totalAmount = ss.selectOne("order.select_total_amount", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return totalAmount;
    }

    //상품 총 원가 금액
    public static int selectTotalPrice(String cus_no, String order_code){
        int totalPrice = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("order_code", order_code);

            totalPrice = ss.selectOne("order.select_total_price", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return totalPrice;
    }

    // 상품 총 할인가 금액
    public static int selectTotalSaledPrice(String cus_no, String order_code){
        int totalSaledPrice = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("order_code", order_code);

            totalSaledPrice = ss.selectOne("order.select_total_saled_price", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }
        return totalSaledPrice;
    }

    //배송지 변경
    public static int updateOrderDelivery(String cus_no, String order_code, String deli_no){
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("order_code", order_code);
            map.put("deli_no", deli_no);

            cnt = ss.update("order.update_order_delivery", map);

            if (cnt > 0)
                ss.commit();
            else
                ss.rollback();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }

    // 취소 요청
    public static int updateOrderCancel(String id, String cus_no, String prod_no, String order_code, String refund_bank, String refund_account, String reason){
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, Object> map = new HashMap<>();
            map.put("id", id);
            map.put("cus_no", cus_no);
            map.put("prod_no", prod_no);
            map.put("order_code", order_code);
            map.put("refund_bank", refund_bank);
            map.put("refund_account", refund_account);
            map.put("reason_customer", reason);

            cnt = ss.update("order.update_order_cancel", map);

            if (cnt > 0)
                ss.commit();
            else
                ss.rollback();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }

    // 전체 취소 요청
    public static int updateOrderCancelAll(List<String> idList, String cus_no, String order_code, String refund_bank, String refund_account, String reason){
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, Object> map = new HashMap<>();
            map.put("idList", idList);
            map.put("cus_no", cus_no);
            map.put("order_code", order_code);
            map.put("refund_bank", refund_bank);
            map.put("refund_account", refund_account);
            map.put("reason_customer", reason);

            cnt = ss.update("order.update_order_cancel_all", map);

            if (cnt > 0)
                ss.commit();
            else
                ss.rollback();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }

    // 배송 전 상품 사이즈 변경
    public static int updateOrderSize(String id, String cus_no, String prod_no, String order_code, String inventory_no){
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("id", id);
            map.put("cus_no", cus_no);
            map.put("prod_no", prod_no);
            map.put("order_code", order_code);
            map.put("inventory_no", inventory_no);

            cnt = ss.update("order.update_order_size", map);

            if (cnt > 0)
                ss.commit();
            else
                ss.rollback();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }

    // 반품 요청
    public static int updateOrderRefund(String id, String cus_no, String prod_no, String order_code, String refund_bank, String refund_account, String reason, String retrieve_deli_no){
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, Object> map = new HashMap<>();
            map.put("id", id);
            map.put("cus_no", cus_no);
            map.put("prod_no", prod_no);
            map.put("order_code", order_code);
            map.put("refund_bank", refund_bank);
            map.put("refund_account", refund_account);
            map.put("reason_customer", reason);
            map.put("retrieve_deli_no", retrieve_deli_no);

            cnt = ss.update("order.update_order_refund", map);

            if (cnt > 0)
                ss.commit();
            else
                ss.rollback();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }

    // 전체 반품 요청
    public static int updateOrderRefundll(List<String> idList, String cus_no, String order_code, String refund_bank, String refund_account, String reason, String retrieve_deli_no){
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, Object> map = new HashMap<>();
            map.put("idList", idList);
            map.put("cus_no", cus_no);
            map.put("order_code", order_code);
            map.put("refund_bank", refund_bank);
            map.put("refund_account", refund_account);
            map.put("reason_customer", reason);
            map.put("retrieve_deli_no", retrieve_deli_no);

            cnt = ss.update("order.update_order_refund_all", map);

            if (cnt > 0)
                ss.commit();
            else
                ss.rollback();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }

    // 교환 요청
    public static int updateOrderExchange(String id, String cus_no, String prod_no, String order_code, String reason, String retrieve_deli_no, String exchange_inventory_no){
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("id", id);
            map.put("cus_no", cus_no);
            map.put("prod_no", prod_no);
            map.put("order_code", order_code);
            map.put("reason_customer", reason);
            map.put("retrieve_deli_no", retrieve_deli_no);
            map.put("exchange_inventory_no", exchange_inventory_no);

            cnt = ss.update("order.update_order_exchange", map);

            if (cnt > 0)
                ss.commit();
            else
                ss.rollback();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }

    // 취소/반품/교환 상품 전체 조회
    public static List<OrderVO> selectRefundAll(String cus_no){
        List<OrderVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            list = ss.selectList("order.select_refund_all", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    // 취소/반품 상품 전체 조회
    public static List<OrderVO> selectCancelRefund(String cus_no){
        List<OrderVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            list = ss.selectList("order.select_refund_cancelRefund", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    // 교환 전체 상품 조회
    public static List<OrderVO> selectRefundExchange(String cus_no){
        List<OrderVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            list = ss.selectList("order.select_refund_exchange", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    // 주문 시 사용한 쿠폰 조회(주문 상세 조회)
    public static List<OrderVO> selectOrderCoupons(String id, String cus_no, String order_code, String prod_no){
        List<OrderVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            if (id != null) {
                map.put("id", id);
            }
            map.put("cus_no", cus_no);
            map.put("order_code", order_code);
            if (prod_no != null) {
                map.put("prod_no", prod_no);
            }

            list = ss.selectList("order.select_order_coupons", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    // 주문 시 사용한 쿠폰 조회(개별 상품 환불)
    public static OrderVO selectOrderCoupon(String id, String cus_no, String prod_no, String order_code){
        OrderVO vo = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("id", id);
            map.put("cus_no", cus_no);
            map.put("order_code", order_code);
            if (prod_no != null) {
                map.put("prod_no", prod_no);
            }

            vo = ss.selectOne("order.select_order_coupon", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return vo;
    }

    // 주문 추가
    public static int insertOrder(String tid, String cus_no, String prod_no, String coupon_no, String deli_no, String order_code, String count, String amount, String benefit_type, String result_amount, String expected_point, String inventory_no) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();
        
        try {
            // 적립만 선택된 경우 result_amount를 amount로 설정
            if ("0".equals(benefit_type)) {
                result_amount = amount;
            }

            HashMap<String, String> map = new HashMap<>();
            map.put("tid", tid);
            map.put("cus_no", cus_no);
            map.put("prod_no", prod_no);
            map.put("coupon_no", coupon_no);
            map.put("deli_no", deli_no);
            map.put("order_code", order_code);
            map.put("count", count);
            map.put("amount", amount);
            map.put("benefit_type", benefit_type);
            map.put("result_amount", result_amount);
            map.put("expected_point", expected_point);
            map.put("inventory_no", inventory_no);

            cnt = ss.insert("order.insert_order", map);

            if (cnt > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }

    // 구매확정 내역 가져오기
    public static List<OrderVO> selectPurchaseConfirm(String cus_no){
        List<OrderVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            list = ss.selectList("order.select_purchase_confirm", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    // 작성 할 리뷰 상품 정보 가져오기
    public static OrderVO selectReviewProduct(String cus_no, String prod_no, String order_code){
        OrderVO vo = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("prod_no", prod_no);
            map.put("order_code", order_code);

            vo = ss.selectOne("order.select_review_product", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return vo;
    }

    // 취소/반품/교환상품 상세 내역
    public static OrderVO selectDetailsByStatus(String id, String cus_no, String prod_no, String order_code, String status){
        OrderVO vo = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("id", id);
            map.put("cus_no", cus_no);
            map.put("prod_no", prod_no);
            map.put("order_code", order_code);
            map.put("status", status);

            vo = ss.selectOne("order.select_details_by_status", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return vo;
    }

    // 판매자 주소지 가져오기
    public static OrderVO selectSellerAddress(String id){
        OrderVO vo = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            vo = ss.selectOne("order.select_seller_address", id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return vo;
    }

    // 진행 중 주문현황 list
    public static List<OrderVO> selectOrderStatus(String cus_no){
        List<OrderVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            list = ss.selectList("order.select_order_status", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }
        return list;
    }

    // 배송현황 조회
    public static List<OrderVO> selectDeliveryStatus(String cus_no,String order_code, String brand){
        List<OrderVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("order_code", order_code);
            map.put("brand", brand);

            list = ss.selectList("order.select_delivery_status", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    // 구매 확정 처리
    public static int updateOrderStatus(String cus_no, String order_code, String status){
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("order_code", order_code);
            map.put("status", status);

            cnt = ss.update("order.update_order_status", map);

            if (cnt > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }

    // 리뷰 가능 건수
    public static int selectReviewAbleCount(String cus_no) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            cnt = ss.selectOne("order.select_review_able_count", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }

    // 주문 상세 내역
    public static OrderVO selectOrderById(String id){
        OrderVO vo = new OrderVO();
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            vo = ss.selectOne("order.select_order_by_id", id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }
        return vo;
    }

    // 사용한 쿠폰 내역 찾기
    public static OrderVO selectCusCoupon(String cus_no, String order_code){
        OrderVO vo = new OrderVO();
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("order_code", order_code);

            vo = ss.selectOne("coupon.select_cus_coupon", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }
        return vo;
    }
}

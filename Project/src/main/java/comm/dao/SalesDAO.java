package comm.dao;

import comm.service.FactoryService;
import comm.vo.seller.SalesModalVO;
import comm.vo.seller.SalesVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class SalesDAO {

    public static List<SalesVO> getSalesList(String seller_no) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<SalesVO> salesList = ss.selectList("sales.getSalesList",seller_no);
        ss.close();
        return salesList;
    }

    public static int getSalesCount(String seller_no) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("sales.getSalesCount",seller_no);
        ss.close();
        return cnt;
    }

    public static List<SalesModalVO> getDeliveryInfo(String order_id) {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<SalesModalVO> deliveryInfo = ss.selectList("sales.getDeliveryInfo", order_id);
        ss.close();

        if (deliveryInfo == null || deliveryInfo.isEmpty()) {
            System.err.println("❌ 주문 데이터 없음: " + order_id);
        } else {
            System.out.println("🟢 주문 상세 조회 성공: " + deliveryInfo.size() + "개 항목");
        }

        return deliveryInfo;
    }


}

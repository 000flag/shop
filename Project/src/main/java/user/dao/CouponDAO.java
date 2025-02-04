package user.dao;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.CouponVO;

import java.util.HashMap;
import java.util.List;

public class CouponDAO {
    // 상품에 적용할 수 있는 쿠폰 목록
    public static List<CouponVO> selectProdCoupon(String prod_no, String grade_no) {
        List<CouponVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("prod_no", prod_no);
            map.put("grade_no", grade_no);

            list = ss.selectList("coupon.select_prod_coupon", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    // 쿠폰 사용 이력 추가
    public static int insertCusCoupon(String cus_no, String coupon_no, String order_code) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("coupon_no", coupon_no);
            map.put("order_code", order_code);

            cnt = ss.insert("coupon.insert_cus_coupon", map);

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

    // 사용한 쿠폰 복구
    public static int updateCusCoupon(String cus_no, String order_code){
        HashMap<String, String> map = new HashMap<>();
        map.put("cus_no", cus_no);
        map.put("order_code", order_code);

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = 0;

        try {
            cnt = ss.update("coupon.update_cus_coupon", map);

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
}

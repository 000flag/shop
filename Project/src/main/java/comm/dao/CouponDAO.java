package comm.dao;

import comm.vo.CouponVO;
import comm.vo.EndCouponVO;
import org.apache.ibatis.session.SqlSession;
import comm.service.FactoryService;

import java.util.List;

public class CouponDAO {

    // 사용 가능한 쿠폰 조회
    public static List<CouponVO> getAvailableCoupons() {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<CouponVO> list = ss.selectList("coupon.SearchCoupon");
        ss.close();
        return list;
    }

    // 만료된 쿠폰 조회
    public static List<EndCouponVO> getExpiredCoupons() {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<EndCouponVO> list = ss.selectList("coupon.SearchEndCoupon");
        ss.close();
        return list;
    }

    // 쿠폰 추가
    public static int insertCoupon(CouponVO coupon) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("coupon.InsertCoupon", coupon);
        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        return cnt;
    }

    // 쿠폰 삭제
    public static int deleteCoupon(String id) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.delete("coupon.DeleteCoupon", id);
        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        return cnt;
    }
    public static int updateCoupon(CouponVO coupon) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("coupon.UpdateCoupon", coupon);
        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        return cnt;
    }
    public static CouponVO getCouponById(String id) {
        SqlSession ss = FactoryService.getFactory().openSession();
        CouponVO coupon = ss.selectOne("coupon.GetCouponById", id);
        ss.close();
        return coupon;
    }

}
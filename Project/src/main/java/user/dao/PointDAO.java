package user.dao;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.PointVO;

import java.util.HashMap;
import java.util.List;

public class PointDAO {
    // 적립금 전체 내역 가져오기
    public static List<PointVO> selectAll(String cus_no) {
        List<PointVO> all = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            all = ss.selectList("point.select_point", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return all;
    }

    // 적립금 적립 내역 가져오기
    public static List<PointVO> selectEarned(String cus_no) {
        List<PointVO> earned = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            earned = ss.selectList("point.select_point_earned", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return earned;
    }

    // 적립금 사용 내역 가져오기
    public static List<PointVO> selectUsed(String cus_no) {
        List<PointVO> used = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            used = ss.selectList("point.select_point_used", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return used;
    }

    // 적립 예정 내역 가져오기
    public static List<PointVO> selectUpcoming(String cus_no) {
        List<PointVO> upcoming = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            upcoming = ss.selectList("point.select_point_upcoming", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return upcoming;
    }

    // 적립 예정 금액 가져오기
    public static String selectUpcomingTotal(String cus_no) {
        String upcomingTotal = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            upcomingTotal = ss.selectOne("point.select_point_upcoming_total", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return upcomingTotal;
    }

    // 소멸 예정 적립금 가져오기
    public static String selectExpireTotal(String cus_no) {
        String expireTotal = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            expireTotal = ss.selectOne("point.select_point_expire_total", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return expireTotal;
    }

    // 보유 적립금 가져오기
    public static int selectSavePoint(String cus_no) {
        int point = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            point = ss.selectOne("point.select_save_point", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return point;
    }

    // 이전 사용 포인트 찾기
    public static int selectPointAmount(String cus_no, String order_code) {
        HashMap<String, String> map = new HashMap<>();
        map.put("cus_no", cus_no);
        map.put("order_code", order_code);

        Integer amount = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            amount = ss.selectOne("point.select_point_amount", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return amount != null ? amount : 0;
    }

    // 사용 적립금 복구
    public static int insertPoint(String cus_no, String amount, String order_code){
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        HashMap<String, String> map = new HashMap<>();
        map.put("cus_no", cus_no);
        map.put("amount", amount);
        map.put("order_code", order_code);

        try {
            cnt = ss.insert("point.insert_point_refund", map);

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

    // 환불 시 적립금 내역 삭제
    public int deletePoint(String cus_no, String order_code) {
        HashMap<String, String> map = new HashMap<>();
        map.put("cus_no", cus_no);
        map.put("order_code", order_code);

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = 0;

        try {
            cnt = ss.delete("point.delete_point", map);

            if (cnt > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
            ss.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }

    // 사용 적립금 추가
    public static int insertUsePoint(PointVO vo) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            cnt = ss.insert("point.insert_use_point", vo);

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
}

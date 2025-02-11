package admin.dao;

import admin.vo.*;
import org.apache.ibatis.session.SqlSession;
import service.FactoryService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CouponDao {
    public static List<CouponVO> allCoupon(){

        SqlSession ss = FactoryService.getFactory().openSession();
        List<CouponVO> vo = new ArrayList<>();
        vo = ss.selectList("root.allCoupon");
        ss.close();
        return vo;
    }
    public static List<String> allCouponCol(){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<String> name = new ArrayList<>();
        name = ss.selectList("root.allCouponCol");
        ss.close();
        return name;
    }
    public static boolean addCoupon(CouponVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession();

        int cnt = ss.insert("root.addCoupon", vo);  // 'root.addMajorCategory'는 MyBatis 매퍼 파일에서 설정한 ID
        if (cnt > 0) {
            ss.commit();  // 성공적으로 추가되었을 경우 커밋

            // 추가된 레코드 수 반환
        }

        ss.close();
        boolean chk = true;
        return  chk;  // 추가된 레코드 수 반환
    }
    public static CouponVO getCouponId(CouponVO VO){
        SqlSession ss = FactoryService.getFactory().openSession();
        CouponVO vo = ss.selectOne("root.getCouponId",VO);
        ss.close();
        return vo;

    }
    public static CouponVO[] searchCoupon(String searchType, String searchValue){
        Map<String,String> map = new HashMap<>();
        map.put("searchType", searchType);
        map.put("searchValue", searchValue);
        SqlSession ss = FactoryService.getFactory().openSession();
        List<CouponVO> list = ss.selectList("root.searchCoupon", map);
        CouponVO[] ar = null;
        if(list != null && list.size() > 0){
            ar = new CouponVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;
    }
    public static boolean deleteCoupon(int id){
        SqlSession ss = FactoryService.getFactory().openSession();
        int updatedRows = ss.update("root.deleteCoupon", id);
        if(updatedRows > 0){
            ss.commit();
            ss.close();
            return true;
        }
        ss.rollback();
        ss.close();
        return false;
    }
    public static int logininsert(LogVO CouponVO) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int chk = ss.insert("root.loginsert",CouponVO);
        ss.commit();
        ss.close();
        return chk;


    }
}

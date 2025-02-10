package admin.dao;

import admin.vo.BoardProdVO;
import admin.vo.CouponVO;
import admin.vo.CustomerVO;
import admin.vo.LogVO;
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

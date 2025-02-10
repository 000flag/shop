package admin.dao;

import admin.vo.LogVO;
import admin.vo.MiddleCategoryVO;
import admin.vo.SellerVO;
import org.apache.ibatis.session.SqlSession;
import service.FactoryService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SellerDao {
    public static List<SellerVO> allSeller(){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<SellerVO> vo = new ArrayList<>();
        vo = ss.selectList("root.allSeller");
        ss.close();
        return vo;
    }
    public static List<String> allSellerName(){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<String> name = new ArrayList<>();
        name = ss.selectList("root.allSellerCol");
        ss.close();
        return name;
    }
    public static SellerVO[] searchSeller(String searchType, String searchValue){
        Map<String,String> map = new HashMap<>();
        map.put("searchType", searchType);
        map.put("searchValue", searchValue);
        SqlSession ss = FactoryService.getFactory().openSession();
        List<SellerVO> list = ss.selectList("root.searchSeller", map);
        SellerVO[] ar = null;
        if(list != null && list.size() > 0){
            ar = new SellerVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;
    }
    public static boolean rejectSeller(int id){
        SqlSession ss = FactoryService.getFactory().openSession();
        int updatedRows = ss.update("root.rejectSeller", id);
        if(updatedRows > 0){
            ss.commit();
            ss.close();
            return true;
        }
        ss.rollback();
        ss.close();
        return false;
    }
    public static boolean admitSeller(int id){
        SqlSession ss = FactoryService.getFactory().openSession();
        int updatedRows = ss.update("root.admitSeller", id);
        if(updatedRows > 0){
            ss.commit();
            ss.close();
            return true;

        }
        ss.rollback();
        ss.close();
        return false;
    }
    public static boolean stopSeller(int id){
        SqlSession ss = FactoryService.getFactory().openSession();
        int updatedRows = ss.update("root.stopSeller", id);
        if(updatedRows > 0){
            ss.commit();
            ss.close();
            return true;

        }
        ss.rollback();
        ss.close();
        return false;
    }
    public static int logininsert(LogVO SellerVO) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int chk = ss.insert("root.loginsert", SellerVO);
        ss.commit();
        ss.close();
        return chk;


    }

}

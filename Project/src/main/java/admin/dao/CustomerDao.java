package admin.dao;

import admin.vo.CustomerVO;
import admin.vo.LogVO;
import admin.vo.MajorCategoryVO;
import org.apache.ibatis.session.SqlSession;
import service.FactoryService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CustomerDao {
    public static List<CustomerVO> allCustomer(){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<CustomerVO> vo = new ArrayList<CustomerVO>();
        vo = ss.selectList("root.allCustomer");
        ss.close();
        return vo;
    }
    public static List<String> allCustomerName(){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<String> name = new ArrayList<>();
        name = ss.selectList("root.allCustomerCol");
        ss.close();
        return name;
    }
    public static CustomerVO[] searchCustomer(String searchType, String searchValue){
        Map<String,String> map = new HashMap<>();
        map.put("searchType", searchType);
        map.put("searchValue", searchValue);
        SqlSession ss = FactoryService.getFactory().openSession();
        List<CustomerVO> list = ss.selectList("root.searchCustomer", map);
        CustomerVO[] ar = null;
        if(list != null && list.size() > 0){
            ar = new CustomerVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;
    }
    public static boolean stopCustomer(int id){
        SqlSession ss = FactoryService.getFactory().openSession();
        int updatedRows = ss.update("root.stopCustomer", id);
        if(updatedRows > 0){
            ss.commit();
            ss.close();
            return true;

        }
        ss.rollback();
        ss.close();
        return false;
    }
    public static boolean admitCustomer(int id){
        SqlSession ss = FactoryService.getFactory().openSession();
        int updatedRows = ss.update("root.admitCustomer", id);
        if(updatedRows > 0){
            ss.commit();
            ss.close();
            return true;

        }
        ss.rollback();
        ss.close();
        return false;
    }
    public static int logininsert(LogVO CustomerVO) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int chk = ss.insert("root.loginsert", CustomerVO);
        ss.commit();
        ss.close();
        return chk;


    }

}

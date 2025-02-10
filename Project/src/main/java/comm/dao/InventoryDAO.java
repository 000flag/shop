package comm.dao;

import comm.service.FactoryService;
import comm.vo.seller.InventoryVO;
import org.apache.ibatis.session.SqlSession;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class InventoryDAO{

    public static int updateStock(String prodNo, String stock) {
        SqlSession ss = FactoryService.getFactory().openSession();
        HashMap<String,String> map = new HashMap<>();
        map.put("prod_no",prodNo);
        map.put("stock",stock);
        int cnt = ss.update("inventory.updateStock",map);
        if(cnt>0){
            ss.commit();
        }else{
            ss.rollback();
        }
        ss.close();
        return cnt;
    }
    public static InventoryVO[] getOptions(String prod_no){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<InventoryVO> list = ss.selectList("inventory.getOptions",prod_no);
        InventoryVO[] ar=null;
        if(list!=null) {
            ar = new InventoryVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;
    }
    public static  int addOptions(InventoryVO[] ar){
        SqlSession ss= FactoryService.getFactory().openSession();
        List<InventoryVO> list = Arrays.asList(ar);

        int cnt = ss.insert("inventory.addOptions",list);

        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        return cnt;
    }
    public static int deleteOptions(String prod_no,String seller_no){
        SqlSession ss=  FactoryService.getFactory().openSession();
        int cnt = ss.update("inventory.delete_option",prod_no);
        HashMap<String,String> map = new HashMap<>();
        map.put("prod_no",prod_no);
        map.put("seller_no",seller_no);
        ss.insert("inventory.log_delete_option",map);
        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        return cnt;
    }
    public static int updateOptions(InventoryVO[] ar){
        SqlSession ss=  FactoryService.getFactory().openSession();
        List<InventoryVO> list = Arrays.asList(ar);
        int cntAdd=-1,cntDel = -1;
        cntDel= ss.update("inventory.delete_option",ar[0].getProd_no());
        if(cntDel>0) {
            cntAdd = ss.insert("inventory.addOptions", list);
        }

        if (cntAdd > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        return cntAdd;
    }
}

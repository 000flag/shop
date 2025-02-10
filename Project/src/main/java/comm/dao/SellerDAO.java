package comm.dao;

import comm.vo.seller.SellerVO;
import org.apache.ibatis.session.SqlSession;
import comm.service.FactoryService;

import java.util.HashMap;
import java.util.Map;

public class SellerDAO {

    public static int updateStock(String id, String stock){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("seller.updateStock", stock);
        if (cnt > 0){
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        return cnt;
    }
    public static int deleteProduct(String id){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.delete("seller.deleteProduct", id);
        if (cnt > 0){
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        return cnt;
    }
    public static SellerVO getSellerInfo(String seller_no) {
        SqlSession session = FactoryService.getFactory().openSession();
        SellerVO vo = session.selectOne("seller.getSellerInfo",seller_no);  // ✅ MyBatis 매핑 확인
        session.close();
        return vo;
    }
    public static int checkId(String seller_id){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt= ss.selectOne("seller.check_id",seller_id);
        ss.close();
        return cnt;
    }
    public static int updateSeller(SellerVO sellerVO) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("seller.updateSellerInfo",sellerVO);
        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        return cnt;
    }
    public static int addSeller(String seller_id,String seller_pw, String email,String phone,String name,
                                String address,String courier,String desc){
        SqlSession ss = FactoryService.getFactory().openSession();
        HashMap<String,String> map = new HashMap<>();
        map.put("seller_id",seller_id);
        map.put("seller_pw",seller_pw);
        map.put("email",email);
        map.put("phone",phone);
        map.put("name",name);
        map.put("address",address);
        map.put("courier",courier);
        map.put("desc",desc);
        int cnt=ss.insert("seller.add_seller",map);
        if(cnt>0){
            ss.commit();
        }else
            ss.rollback();
        ss.close();
        return cnt;
    }
    // ✅ 로고 이미지 (seller_icon)만 업데이트
    public static int updateSellerIcon(String seller_no, String logoUrl) {
        SqlSession ss = FactoryService.getFactory().openSession();
        try {
            Map<String, String> paramMap = new HashMap<>();
            paramMap.put("seller_no", seller_no);
            paramMap.put("logoUrl", logoUrl);

            int cnt = ss.update("seller.updateSellerIcon", paramMap);
            if (cnt > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
            return cnt;
        } finally {
            ss.close();
        }
    }
    public static SellerVO login(String seller_id){
        SqlSession ss = FactoryService.getFactory().openSession();
        SellerVO vo = ss.selectOne("seller.login",seller_id);
        ss.close();
        return  vo;
    }
    public static void Loginlog(String seller_no){
        SqlSession ss = FactoryService.getFactory().openSession();
        ss.insert("seller.log_login",seller_no);

    }
    public static void Logoutlog(String seller_no){
        SqlSession ss = FactoryService.getFactory().openSession();
        ss.insert("seller.log_logout",seller_no);

    }

}
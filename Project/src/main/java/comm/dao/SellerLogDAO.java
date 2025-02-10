package comm.dao;

import comm.service.FactoryService;
import comm.vo.seller.SellerLogVO;
import org.apache.ibatis.session.SqlSession;

public class SellerLogDAO {

    public static int insertSellerLog(SellerLogVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("sellerLog.insertSellerLog",vo);

        if(cnt>0){
            ss.commit();
            ss.close();
        }
        return cnt;

    }
}
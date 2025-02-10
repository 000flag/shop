package admin.dao;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import admin.vo.RootVO;

public class RootDao {
    public static RootVO login(RootVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession();
        RootVO vs = ss.selectOne("root.loginSelect", vo);
        if(vs != null) {
            ss.commit();

        }
        ss.close();
        return vs;
    }

}

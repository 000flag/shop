package admin.dao;

import admin.vo.CategoryVO;
import admin.vo.MajorCategoryVO;
import org.apache.ibatis.session.SqlSession;
import service.FactoryService;

import java.util.ArrayList;
import java.util.List;

public class CategoryDao {
    public static List<CategoryVO> allCategory(){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<CategoryVO> vo = new ArrayList<>();
        vo = ss.selectList("root.getMiddleCategory");
        ss.close();
        return vo;

    }
}

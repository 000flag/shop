package comm.dao;

import comm.service.FactoryService;
import comm.vo.seller.MajorCategoryVO;
import comm.vo.seller.MiddleCategoryVO;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class CategoryDAO {
    public static MajorCategoryVO[] AllMajorCategory(){
        MajorCategoryVO[] ar=null;
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MajorCategoryVO> list = ss.selectList("category.all_major_category");
        ss.close();

        if(list!=null){
            ar = new MajorCategoryVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
    public static MiddleCategoryVO[] AllMiddleCategory(){
        MiddleCategoryVO[] ar=null;
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MiddleCategoryVO> list = ss.selectList("category.all_middle_category");
        ss.close();

        if(list!=null){
            ar = new MiddleCategoryVO[list.size()];
            list.toArray(ar);
        }

        return ar;
    }
    public static MiddleCategoryVO getProdCategory(String id){
        SqlSession ss = FactoryService.getFactory().openSession();

        MiddleCategoryVO vo = ss.selectOne("category.get_prod_category",id);
        ss.close();
        return vo;
    }
    public static MajorCategoryVO majorCategoryOne(String id){
        SqlSession ss = FactoryService.getFactory().openSession();

        MajorCategoryVO vo = ss.selectOne("category.major_category_one",id);
        ss.close();
        return vo;
    }
}

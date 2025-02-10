package admin.dao;

import admin.vo.LogVO;
import admin.vo.MajorCategoryVO;
import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import admin.vo.CustomerVO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MajorCategoryDao {
    public static List<MajorCategoryVO> allMajor(){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MajorCategoryVO> vo = new ArrayList<MajorCategoryVO>();
        vo = ss.selectList("root.allMajor");
        ss.close();
        return vo;
    }
    public static List<String> allMajorCategory(){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<String> name = new ArrayList<>();
        name = ss.selectList("root.allMajorCol");
        ss.close();
        return name;
    }
    public static MajorCategoryVO[] searchMajorCategory(String searchType, String searchValue){
        Map<String,String> map = new HashMap<>();
        map.put("searchType", searchType);
        map.put("searchValue", searchValue);
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MajorCategoryVO> list = ss.selectList("root.searchMajorCategory", map);
        MajorCategoryVO[] ar = null;
        if(list != null && list.size() > 0){
            ar = new MajorCategoryVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;
    }
    public static boolean addMajorCategory(MajorCategoryVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession();

        int cnt = ss.insert("root.addMajorCategory", vo);  // 'root.addMajorCategory'는 MyBatis 매퍼 파일에서 설정한 ID
        if (cnt > 0) {
            ss.commit();  // 성공적으로 추가되었을 경우 커밋

          // 추가된 레코드 수 반환
        }

        ss.close();
        boolean chk = true;
        return  chk;  // 추가된 레코드 수 반환
    }

    public static MajorCategoryVO getMajorCategoryId(MajorCategoryVO VO){
        SqlSession ss = FactoryService.getFactory().openSession();
        MajorCategoryVO vo = ss.selectOne("root.getMajorId",VO);
        ss.close();
        return vo;


    }


    public static int logininsert(LogVO MajorCategoryVO) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int chk = ss.insert("root.loginsert", MajorCategoryVO);
        ss.commit();
        ss.close();
        return chk;


    }
    public static boolean deleteMajorCategory(int id){
        SqlSession ss = FactoryService.getFactory().openSession();
        int updatedRows = ss.update("root.deleteMajorCategory", id);
        if(updatedRows > 0){
            ss.commit();
            ss.close();
            return true;
        }
        ss.rollback();
        ss.close();
        return false;
    }

}

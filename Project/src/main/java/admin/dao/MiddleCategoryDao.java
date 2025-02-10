package admin.dao;

import admin.vo.LogVO;
import admin.vo.MajorCategoryVO;
import admin.vo.MiddleCategoryVO;
import org.apache.ibatis.session.SqlSession;
import service.FactoryService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MiddleCategoryDao {
    public static List<MiddleCategoryVO> allMiddle(){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MiddleCategoryVO> vo = new ArrayList<>();
        vo = ss.selectList("root.allMiddle");
        ss.close();
        return vo;
    }

    public static List<String> allMiddleCategory(){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<String> name = new ArrayList<>();
        name= ss.selectList("root.allMiddleCol");
        ss.close();
        return name;
    }
    public static MiddleCategoryVO[] searchMiddleCategory(String searchType, String searchValue){
        Map<String,String> map = new HashMap<>();
        map.put("searchType", searchType);
        map.put("searchValue", searchValue);
        SqlSession ss = FactoryService.getFactory().openSession();
        List<MiddleCategoryVO> list = ss.selectList("root.searchMiddleCategory", map);
        MiddleCategoryVO[] ar = null;
        if(list != null && list.size() > 0){
            ar = new MiddleCategoryVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;
    }
    public static int logininsert(LogVO boardVO) {
        SqlSession ss = FactoryService.getFactory().openSession();
        int chk = ss.insert("root.loginsert", boardVO);
        ss.commit();
        ss.close();
        return chk;


    }
    public static boolean deleteMiddleCategory(int id){
        SqlSession ss = FactoryService.getFactory().openSession();
        int updatedRows = ss.update("root.deleteMiddleCategory", id);
        if(updatedRows > 0){
            ss.commit();
            ss.close();
            return true;
        }
        ss.rollback();
        ss.close();
        return false;
    }
    public static boolean addMiddleCategory(MiddleCategoryVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession();

        int cnt = ss.insert("root.addMiddleCategory", vo);  // 'root.addMajorCategory'는 MyBatis 매퍼 파일에서 설정한 ID
        if (cnt > 0) {
            ss.commit();  // 성공적으로 추가되었을 경우 커밋

            // 추가된 레코드 수 반환
        }

        ss.close();
        boolean chk = true;
        return  chk;  // 추가된 레코드 수 반환
    }
    public  static  int getId(String name){
      SqlSession ss = FactoryService.getFactory().openSession();
      int cnd = ss.selectOne("root.getId", name);
      ss.close();
      return cnd;
    }
}

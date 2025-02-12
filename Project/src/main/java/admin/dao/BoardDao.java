package admin.dao;

import admin.vo.*;
import org.apache.ibatis.session.SqlSession;
import service.FactoryService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BoardDao {

  public int logininsert(LogVO boardVO) {
    SqlSession ss = FactoryService.getFactory().openSession();
    int chk = ss.insert("root.loginsert", boardVO);
    ss.commit();
    ss.close();
    return chk;


  }
    public static boolean addBoard(BoardVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession();

        int cnt = ss.insert("root.addBoard", vo);  // 'root.addMajorCategory'는 MyBatis 매퍼 파일에서 설정한 ID
        if (cnt > 0) {
            ss.commit();  // 성공적으로 추가되었을 경우 커밋

            // 추가된 레코드 수 반환
        }

        ss.close();
        boolean chk = true;
        return  chk;  // 추가된 레코드 수 반환
    }






  public boolean deleteBoard(int id) {
    SqlSession ss = FactoryService.getFactory().openSession();

    int updatedRows = ss.update("root.deleteBoard", id);
    if (updatedRows > 0) {
      ss.commit();
      ss.close();
      return true;
    }
    ss.rollback();
    ss.close();
    return false;
  }





  public static List<BoardVO> allBoard(){

        SqlSession ss = FactoryService.getFactory().openSession();
        List<BoardVO> vo = new ArrayList<>();
        vo = ss.selectList("root.allBoard");
        ss.close();
        return vo;
    }
    public static List<String> allBoardCategory(){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<String> name = new ArrayList<>();
        name = ss.selectList("root.allBoardCol");
        ss.close();
        return name;

    }
    public static BoardVO[] searchBoard(String searchType, String searchValue){
        Map<String,String> map = new HashMap<>();
        map.put("searchType", searchType);
        map.put("searchValue", searchValue);
        SqlSession ss = FactoryService.getFactory().openSession();
        List<BoardVO> list = ss.selectList("root.searchBoard", map);
        BoardVO[] ar = null;
        if(list != null && list.size() > 0){
            ar = new BoardVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;
    }
    public static BoardVO getBoardById(String boardId) {
        SqlSession ss = FactoryService.getFactory().openSession();
        BoardVO board = ss.selectOne("root.getBoardById", boardId); // SQL에서 해당 id로 데이터를 조회
        ss.close();
        return board;
    }

}

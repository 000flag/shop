package admin.dao;

import admin.vo.BoardProdVO;
import admin.vo.BoardVO;
import admin.vo.LogVO;
import admin.vo.MajorCategoryVO;
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

package user.dao.snap;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.snap.BoardProductVO;
import user.vo.BoardVO;
import user.vo.snap.ProductVO;

import java.util.*;
import java.util.stream.Collectors;

public class SnapDao {

  public static int insertBoard(BoardVO vo){
    SqlSession session = FactoryService.getFactory().openSession();
    int result = session.insert("board.insertBoard", vo);
    if (result > 0) session.commit();
    session.close();
    return result;
  }

  public int insertBoardProd(int boardNo, List<Integer> prodNos) {
    SqlSession session = FactoryService.getFactory().openSession();
    Map<String, Object> params = new HashMap<>();
    params.put("boardNo", boardNo);
    params.put("prodNos", prodNos);
    int result = session.insert("board.insertBoardProd", params);
    session.commit();
    session.close();
    return result;
  }

  public List<BoardVO> getSnapList(int offset, int limit) {
    SqlSession session = FactoryService.getFactory().openSession();
    Map<String, Integer> params = new HashMap<>();
    params.put("offset", offset);
    params.put("limit", limit);
    List<BoardVO> list = session.selectList("board.getSnapList", params);
    session.close();
    return list;
  }

  public int getTotalSnapCount() {
    SqlSession session = FactoryService.getFactory().openSession();
    int count = session.selectOne("board.getTotalSnapCount");
    session.close();
    return count;
  }

  public List<BoardVO> getFilteredSnapList(Map<String, Object> filters) {
    SqlSession session = FactoryService.getFactory().openSession();
    List<BoardVO> list = session.selectList("board.getFilteredSnapList", filters);
    session.close();
    return list;
  }

  public int getFilteredSnapCount(Map<String, Object> filters) {
    SqlSession session = FactoryService.getFactory().openSession();
    int count = session.selectOne("board.getTotalFilteredSnapCount", filters);
    session.close();
    return count;
  }

  public boolean checkLikeStatus(int boardId, int cusId) {
    SqlSession session = FactoryService.getFactory().openSession();
    Map<String, Integer> params = new HashMap<>();
    params.put("boardNo", boardId);
    params.put("cusNo", cusId);
    Integer result = session.selectOne("likes.checkLikeExists", params);
    session.close();
    return result != null && result > 0;
  }

  public BoardVO getBoardSns(int boardId) {
    SqlSession session = FactoryService.getFactory().openSession();
    BoardVO vo = session.selectOne("board.getSnapWithCustomerData", boardId);
    session.close();
    return vo;
  }

  public List<ProductVO> getPurchasedProducts(int cusNo) {
    SqlSession session = FactoryService.getFactory().openSession();
    List<ProductVO> productList = session.selectList("board.getPurchasedProducts", cusNo);
    session.close();
    return productList;
  }

  public List<ProductVO> getProductsByKeyword(String keyword) {
    SqlSession session = FactoryService.getFactory().openSession();
    List<ProductVO> productList = session.selectList("board.getProductsByKeyword", keyword);
    session.close();
    return productList;
  }

  public List<BoardVO> profile(int cus_no) {
    SqlSession session = FactoryService.getFactory().openSession();
    List<BoardVO> boardList = session.selectList("board.getProfile", cus_no);
    session.close();
    return boardList;
  }
  public List<BoardVO> profile1(int cus_no) {
    SqlSession session = FactoryService.getFactory().openSession();
    List<BoardVO> boardList = session.selectList("board.getProfile1", cus_no);
    session.close();
    return boardList;
  }

  public List<ProductVO> getProductsByBoardNo(int boardNo) {
    SqlSession session = FactoryService.getFactory().openSession();
    List<ProductVO> productList = session.selectList("board.getProductsByBoardNo", boardNo);
    session.close();
    return productList;
  }

//  public BoardVO getSnapDetail(int boardNo) {
//    SqlSession session = FactoryService.getFactory().openSession();
//    BoardVO snap = session.selectOne("board.getSnapDetaill", boardNo);
//    session.close();
//    return snap;
//  }

  public BoardVO getSnapDetail(int boardNo) {
    SqlSession session = FactoryService.getFactory().openSession();
    BoardVO snap = session.selectOne("board.getSnapDetail", boardNo);


    if (snap.getProducts() != null && !snap.getProducts().isEmpty()) {
      List<Integer> productList = Arrays.stream(snap.getProducts().split(","))
          .filter(prod -> !prod.trim().isEmpty()) // 빈 값 필터링
          .map(Integer::parseInt) // 숫자로 변환
          .collect(Collectors.toList());
      snap.setProductList(productList);
    } else {
      snap.setProductList(new ArrayList<>()); // 빈 리스트 설정
    }

    session.close();
    return snap;
  }




  public void deleteBoard(int id) {
    SqlSession ss = FactoryService.getFactory().openSession();
    ss.update("board.deleteSnap", id);
    ss.commit();
    ss.close();

  }

//  public boolean  updateBoard(BoardVO board) {
//    SqlSession session = FactoryService.getFactory().openSession();
//    int rows = session.update("board.updateSnap", board);
//    if (rows > 0) {
//      session.commit();
//      session.close();
//      return true;
//    }
//    session.close();
//    return false;
//  }



  public void deleteBoardProducts(int boardNo) {
    SqlSession session = FactoryService.getFactory().openSession();
    session.delete("board.deleteBoardProducts", boardNo);
    session.commit();
    session.close();
  }


  public void insertBoardProduct(BoardProductVO boardProduct) {
    SqlSession session = FactoryService.getFactory().openSession();
    session.insert("board.insertBoardProduct", boardProduct);
    session.commit();
    session.close();
  }

  public static int boardCount(int customerId){
    SqlSession session = FactoryService.getFactory().openSession();
    int chk = session.selectOne("board.boardCount",customerId);
    session.close();
    return chk;
  }

  //확인하는부분

  public BoardVO selectBoardById(int boardId) {
    SqlSession session = FactoryService.getFactory().openSession();
    BoardVO board = session.selectOne("board.selectBoardById", boardId);
    session.close();
    return board;
  }

  public int updateBoard(BoardVO board) {
    SqlSession session = FactoryService.getFactory().openSession();
    int result = session.update("board.updateBoard", board);
    session.commit();
    session.close();
    return result;
  }


  public List<ProductVO> selectProductsByBoardId(int boardId) {
    SqlSession session = FactoryService.getFactory().openSession();
    List<ProductVO> productList = session.selectList("board.selectProductsByBoardId", boardId);
    session.close();
    return productList;
  }
}


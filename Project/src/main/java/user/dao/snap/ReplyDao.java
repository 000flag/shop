package user.dao.snap;

import org.apache.ibatis.session.SqlSession;

import service.FactoryService;
import user.vo.snap.ReplyVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReplyDao {
  private SqlSession sqlSession;



  // 댓글 저장
  public void insertReply(ReplyVO reply) {
    SqlSession  ss = FactoryService.getFactory().openSession();

    ss.insert("ReplyDao.insertReply", reply);
    ss.commit();
    ss.close();
  }

  // 최신 댓글 가져오기
  public ReplyVO getLatestReply(int boardNo) {
    SqlSession  ss = FactoryService.getFactory().openSession();
    ReplyVO vo = ss.selectOne("ReplyDao.getLatestReply", boardNo);
    ss.close();
    return vo;
  }
  //댓글 다가져오기
  public List<ReplyVO> getAllReplies(int boardNo) {
    SqlSession  ss = FactoryService.getFactory().openSession();
    List<ReplyVO> list = ss.selectList("ReplyDao.getReplyList", boardNo);
    ss.close();
    return list;

  }

  public void updateComment(int commentId, String content) {
    SqlSession  ss = FactoryService.getFactory().openSession();
    Map<String, Object> paramMap = new HashMap<>();
    paramMap.put("comment_id", commentId);
    paramMap.put("content", content);
    ss.update("ReplyDao.updateComment", paramMap);
    ss.commit();
    ss.close();
  }
 public  void deleteComment(int id){
    SqlSession  ss = FactoryService.getFactory().openSession();
    ss.update("ReplyDao.deleteComment", id);
    ss.commit();
    ss.close();
 }

}

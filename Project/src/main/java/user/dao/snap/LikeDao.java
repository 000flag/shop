package user.dao.snap;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.snap.LikesVO;

public class LikeDao {

  public boolean toggleLike(LikesVO vo) {
    SqlSession session = FactoryService.getFactory().openSession();
    Integer existingLike = session.selectOne("likes.checkLikeExists1", vo);

    if (existingLike == null) {
//      vo.setStatus(0);
      session.insert("likes.insertLike", vo);
      session.update("board.incrementLikeCount", vo.getBoardNo());
    } else {
      Integer currentStatus = session.selectOne("likes.getCurrentStatus", vo);
      if (currentStatus == 1) {
        vo.setStatus(0);
        session.update("likes.updateLike", vo);

        session.update("board.decrementLikeCount", vo.getBoardNo());
      } else if (currentStatus == 0) {
        vo.setStatus(1);
        session.update("likes.updateLike", vo);
        session.update("board.incrementLikeCount", vo.getBoardNo());
      }
    }

    session.commit();
    session.close();
    return true;
  }


  public boolean checkLike(LikesVO vo) {
    SqlSession session = FactoryService.getFactory().openSession();
    Integer existingLike = session.selectOne("likes.checkLikeExists", vo);
    session.close();
    return existingLike != null && existingLike == 1;

  }
}
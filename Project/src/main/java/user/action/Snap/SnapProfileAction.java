package user.action.Snap;
import user.action.Action;

import user.dao.snap.FollowDao;
import user.dao.snap.SnapDao;
import user.vo.BoardVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

public class SnapProfileAction  implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {

    List<BoardVO> vo = new ArrayList<BoardVO>();
    user.dao.snap.SnapDao snapDao = new user.dao.snap.SnapDao();
    int cus_no =Integer.parseInt( request.getParameter("cus_no"));
    System.out.println("잘찍혀야한다"+cus_no);

    Integer customerId = (Integer) request.getSession().getAttribute("cus_id");
    if (customerId == null) {
      customerId = 0;  // 비로그인 사용자의 기본값
    }
    List<BoardVO> vo1 = new ArrayList<BoardVO>();
    vo1= snapDao.profile1(cus_no);
    vo = snapDao.profile(cus_no);
    request.setAttribute("board", vo);
    request.setAttribute("board1", vo1);

    System.out.println("test"+vo.size());



    int board_size = vo.size();
    int boardCount = SnapDao.boardCount(cus_no);



    request.setAttribute("boardCount", boardCount);


       if(customerId > 0) {
     boolean isFollowing = FollowDao.isFollowing(customerId, cus_no);
     request.setAttribute("isFollowing", isFollowing);


     FollowDao followDao = new FollowDao();
     int followerCount = followDao.getFollowerCount(cus_no);
     int followingCount = followDao.getFollowingCount(cus_no);


     request.setAttribute("boardCount", boardCount);
     request.setAttribute("boardSize", board_size );
     request.setAttribute("followerCount", followerCount);
     request.setAttribute("followingCount", followingCount);
         return "/user/snap/jsp/snap/SnapProfile.jsp";
   }


    return "/user/snap/jsp/snap/SnapProfile.jsp";
  }

}


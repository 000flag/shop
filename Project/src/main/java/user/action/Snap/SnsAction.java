package user.action.Snap;

import user.action.Action;

import user.dao.snap.*;

import user.vo.snap.CustomerVO;
import user.vo.snap.LikesVO;
import user.vo.snap.ProductVO;
import user.vo.snap.ReplyVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class SnsAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    int boardNo = Integer.parseInt(request.getParameter("id"));

    // Snap 및 연관된 제품 데이터 가져오기
    SnapDao snapDao = new SnapDao();
    user.vo.BoardVO snap = snapDao.getSnapDetail(boardNo);
    List<ProductVO> productList = snapDao.getProductsByBoardNo(boardNo);

    int cus_no = snap.getCus_no();
    Integer customerIdObj = (Integer) request.getSession().getAttribute("cus_id");
    int customerId = (customerIdObj != null) ? customerIdObj : -1; // 비로그인 사용자는 -1로 설정

   if(customerId != -1) {
     boolean isFollowing = FollowDao.isFollowing(customerId, cus_no);
     request.setAttribute("isFollowing", isFollowing);

     //  현재 로그인한 사용자 정보 가져오기
     CustomerDao userDao = new CustomerDao();
     CustomerVO myInfo = userDao.getUserProfile(customerId);
     request.setAttribute("myInfo", myInfo);

     //  추천 회원 목록 가져오기 (랜덤 5명)
     List<CustomerVO> recommendedUsers = userDao.getRandomUsers(5);
     request.setAttribute("recommendedUsers", recommendedUsers);



     //좋아요확인용
     LikeDao likeDao = new LikeDao();
     LikesVO vo =  new LikesVO();
     vo.setBoardNo(boardNo);
     vo.setCusNo(customerId);
     boolean chk = likeDao.checkLike(vo);
     System.out.println("chk = " + chk);
     request.setAttribute("liked", chk);
   }
    if (snap != null) {

      String mainImage = snap.getSnapshot_image();
      String additionalImages = snap.getAdditional_images();
      ReplyDao replyDao = new ReplyDao();
      ReplyVO latestReply = replyDao.getLatestReply(boardNo);
      request.setAttribute("latestReply", latestReply);

      if (additionalImages != null && additionalImages.trim().endsWith("_")) {
        // 서브 이미지가 `_`로 끝나면 삭제하고 메인이미지만 보냄
        snap.setAdditional_images(mainImage);
      } else {
        //  서브 이미지가 존재하면 메인 이미지 + 서브 이미지 합쳐서 저장
        snap.setAdditional_images(mainImage + (additionalImages != null ? "," + additionalImages : ""));
      }
    }
    // 데이터 전달
    request.setAttribute("snap", snap);
    request.setAttribute("productList", productList);

    return "user/snap/jsp/snap/MySnap.jsp";
  }

}


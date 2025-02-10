package user.action.Snap;

import user.action.Action;
import user.dao.snap.SnapDao;
import comm.vo.seller.BoardVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateSnapAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    // 수정할 게시글 ID를 파라미터로 받음
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
      request.setAttribute("error", "수정할 게시글이 지정되지 않았습니다.");
      return "/Controller?type=snap";
    }
    int boardId = Integer.parseInt(idParam);

    // 수정 폼에서 받아온 필드들
    String content = request.getParameter("content");
    String tags = request.getParameter("tags");
    String gender = request.getParameter("gender");
    String season = request.getParameter("season");
    String style = request.getParameter("style");
//    // 선택된 제품 번호(콤마로 구분)
//    String prodNoCombined = request.getParameter("prod_no");
//
//    // 이미지 업데이트가 없으면 기존 값을 그대로 사용
//    String existingSnapshotImage = request.getParameter("existingSnapshotImage");
//    String existingAdditionalImages = request.getParameter("existingAdditionalImages");

    // BoardVO 객체에 수정 정보를 설정
    BoardVO boardVO = new BoardVO();
    boardVO.setId(boardId);
    boardVO.setContent(content);
    boardVO.setTags(tags);
    boardVO.setGender(gender);
    boardVO.setSeason(season);
    boardVO.setStyle(style);
//    boardVO.setProd_no(prodNoCombined);
//    boardVO.setSnapshot_image(existingSnapshotImage);
//    boardVO.setAdditional_images(existingAdditionalImages);

    SnapDao dao = new SnapDao();
      dao.updateBoard(boardVO);


      return "/Controller?type=snap";

  }
}

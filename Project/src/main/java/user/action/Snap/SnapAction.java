package user.action.Snap;

import user.action.Action;
import comm.vo.seller.BoardVO;
import user.vo.snap.ProductVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SnapAction implements Action {

  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {


    String pageParam = request.getParameter("page");
    String gender = request.getParameter("gender");
    String season = request.getParameter("season");
    String style = request.getParameter("style");
    Integer cusId = (Integer) request.getSession().getAttribute("cus_id");
    int page = 1;
    int itemsPerPage = 12;

    try {
      if (pageParam != null && !pageParam.isEmpty()) {
        page = Integer.parseInt(pageParam);
      }
    } catch (NumberFormatException e) {
      System.out.println("Invalid page number: " + pageParam);
      page = 1;
    }

    if (gender == null || gender.equals("전체")) {
      gender = null;
    }
    if (season == null || season.equals("전체")) {
      season = null;
    }
    if (style == null || style.equals("전체")) {
      style = null;
    }

    int offset = (page - 1) * itemsPerPage;

    user.dao.snap.SnapDao snapDao = new user.dao.snap.SnapDao();
    Map<String, Object> filterParams = new HashMap<>();
    filterParams.put("gender", gender);
    filterParams.put("season", season);
    filterParams.put("style", style);
    filterParams.put("offset", offset);
    filterParams.put("limit", itemsPerPage);

    List<BoardVO> snapList = snapDao.getFilteredSnapList(filterParams);
    if (cusId != null) {
      for (BoardVO snap : snapList) {
        boolean isLiked = snapDao.checkLikeStatus(snap.getId(), cusId);
        snap.setLiked(isLiked); // 좋아요 상태 추가
      }
    }

    int totalItems = snapDao.getFilteredSnapCount(filterParams);
    int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

    System.out.println("Filter Params: " + filterParams);
    System.out.println("Offset: " + offset + ", Limit: " + itemsPerPage);


    //별개데이터가져오는곳
    String searchKeyword = request.getParameter("search");
    if (searchKeyword == null) {
      searchKeyword = "";
    }

    // DAO 호출
    user.dao.snap.SnapDao snapDao2 = new user.dao.snap.SnapDao();
//    List<ProductVO> purchasedProducts = cusId != null ? snapDao.getPurchasedProducts(cusId) : null;
//    System.out.println("테스트용:"+purchasedProducts.size());
    List<ProductVO> searchedProducts = snapDao2.getProductsByKeyword(searchKeyword);

    HttpSession session = request.getSession();
//    session.setAttribute("purchasedProducts", purchasedProducts);
    session.setAttribute("searchedProducts", searchedProducts);


    List<ProductVO> purchasedProducts = null;

// cusId가 null인지 확인
    if (cusId != null) {
      purchasedProducts = snapDao.getPurchasedProducts(cusId);
    } else {
      // 로그인하지 않은 경우 빈 리스트로 초기화
      purchasedProducts = new ArrayList<>();
    }

// purchasedProducts가 null이 아니라는 보장을 추가
    session.setAttribute("purchasedProducts", purchasedProducts);


////     데이터 설정
//    request.setAttribute("purchasedProducts", purchasedProducts);
//    request.setAttribute("searchedProducts", searchedProducts);

    request.setAttribute("snapList", snapList);
    request.setAttribute("currentPage", page);
    request.setAttribute("totalPages", totalPages);
    request.setAttribute("selectedGender", gender == null ? "전체" : gender);
    request.setAttribute("selectedSeason", season == null ? "전체" : season);
    request.setAttribute("selectedStyle", style == null ? "전체" : style);

    return "/user/snap/jsp/snap/mypage.jsp";
  }
}

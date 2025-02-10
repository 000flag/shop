package user.action.Snap;

import user.action.Action;

import user.vo.snap.ProductVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class GetProductsForSnapAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    // 현재 로그인한 사용자 ID 가져오기
    int cusNo = (int) request.getSession().getAttribute("cus_id");

    // 검색 키워드 가져오기 (null 처리 포함)
    String searchKeyword = request.getParameter("search");
    if (searchKeyword == null) {
      searchKeyword = "";
    }

    // DAO 호출
    user.dao.snap.SnapDao snapDao = new user.dao.snap.SnapDao();
    List<ProductVO> purchasedProducts = snapDao.getPurchasedProducts(cusNo);
    List<ProductVO> searchedProducts = snapDao.getProductsByKeyword(searchKeyword);

    // 데이터 설정
    request.setAttribute("purchasedProducts", purchasedProducts);
    request.setAttribute("searchedProducts", searchedProducts);

    // JSP 반환
    return "user/snap/jsp/snap/mypage.jsp";
  }
}

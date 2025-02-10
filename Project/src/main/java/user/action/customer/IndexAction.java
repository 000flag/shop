package user.action.customer;

import user.action.Action;
import user.dao.customer.ProductDAO;
import user.util.Paging;
import user.vo.customer.CustomerVO;
import user.vo.customer.MajorCategoryVO;
import user.vo.customer.ProductVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class IndexAction implements Action {
      @Override
      public String execute(HttpServletRequest request, HttpServletResponse response) {
          String action = request.getParameter("action");

          String viewPath = null;
          if (action != null) {
              switch (action) {
                  case "select":
                      String category = request.getParameter("category");
                      String sort = request.getParameter("sort");
                      String search = request.getParameter("search");
                      String is_login = request.getParameter("is_login");

                      // 페이징
                      Paging paging = new Paging(12, 3);

                      // 상품 수 가져오기
                      int totalCount = ProductDAO.selectTotalCountProduct(category, search);
                      paging.setTotalRecord(totalCount);

                      // 현재 페이지 값을 파라미터로 받는다.
                      String current_page = request.getParameter("page");

                      if (current_page == null) {
                          paging.setNowPage(1);
                      } else {
                          int currentPage = Integer.parseInt(current_page);
                          paging.setNowPage(currentPage);
                      }

                      HttpSession session = request.getSession();
                      CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");
                      ProductVO[] products = null;
                      if (cvo == null) {
                          // 상품 목록(비회원)
                          products = ProductDAO.selectProduct(category, sort, search, paging.getBegin(), paging.getEnd());
                      } else {
                          // 상품 목록(회원)
                          products = ProductDAO.selectProduct(cvo.getId(), category, sort, search, paging.getBegin(), paging.getEnd());
                      }

                      request.setAttribute("products", products);
                      request.setAttribute("paging", paging);

                      viewPath = "/user/customer/jsp/product/components/productList.jsp";
                      break;
              }
          } else {
              // 초기 로드 시 카테고리
              List<MajorCategoryVO> categories = ProductDAO.selectCategory();

              if (categories != null && categories.size() > 0) {
                  request.setAttribute("categories", categories);
              }

              viewPath = "/user/customer/jsp/index.jsp";
          }

          return viewPath;
      }
}

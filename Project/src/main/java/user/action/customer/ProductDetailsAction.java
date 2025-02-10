package user.action.customer;

import user.action.Action;
import user.dao.customer.ProdLikeDAO;
import user.dao.customer.ProductDAO;
import user.dao.customer.QuestionDAO;
import user.vo.customer.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class ProductDetailsAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String action = request.getParameter("action");

        String viewPath = null;
        if (action != null) {
            HttpSession session = request.getSession();
            CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

            String prod_no = request.getParameter("prod_no");

            switch (action) {
                case "select":
                    // 상품 상세 정보
                    ProductVO productDetails = ProductDAO.selectProdDetails(prod_no);
                    request.setAttribute("productDetails", productDetails);

                    // 상품 사이즈 목록
                    List<ProductVO> productSize = ProductDAO.selectSize(prod_no);
                    request.setAttribute("productSize", productSize);

                    // 상품 좋아요 정보
                    if (cvo != null) {
                        ProdLikeVO s_vo = new ProdLikeVO();
                        s_vo.setCus_no(cvo.getId());
                        s_vo.setProd_no(prod_no);
                        ProdLikeVO plvo = ProdLikeDAO.selectProdLike(s_vo);
                        request.setAttribute("product_like", plvo);
                    }

                    viewPath = "/user/customer/jsp/product/productDetails.jsp";
                    break;
                case "review":
                    String gender = request.getParameter("gender");
                    String height = request.getParameter("height");
                    String weight = request.getParameter("weight");
                    List<BoardVO> reviews = ProductDAO.selectReview(prod_no, gender, height, weight);
                    request.setAttribute("reviews", reviews);
                    viewPath = "/user/customer/jsp/product/components/reviewList.jsp";
                    break;
                case "question":
                    List<BoardVO> questions = QuestionDAO.selectProdQuestion(prod_no);
                    request.setAttribute("questions", questions);
                    viewPath = "/user/customer/jsp/product/components/questionList.jsp";
                    break;
                case "like":
                    ProdLikeVO i_vo = new ProdLikeVO();
                    i_vo.setCus_no(cvo.getId());
                    i_vo.setProd_no(prod_no);
                    ProdLikeDAO.insertProdLike(i_vo);
                    viewPath = "/user/customer/jsp/product/productDetails.jsp";
                    break;
                case "unlike":
                    ProdLikeVO d_vo = new ProdLikeVO();
                    d_vo.setCus_no(cvo.getId());
                    d_vo.setProd_no(prod_no);
                    ProdLikeDAO.deleteProdLike(d_vo);
                    viewPath = "/user/customer/jsp/product/productDetails.jsp";
                    break;
            }
        }

        return viewPath;
    }
}

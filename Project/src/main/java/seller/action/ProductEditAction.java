package seller.action;

import user.action.Action;
import comm.dao.CategoryDAO;
import comm.dao.InventoryDAO;
import comm.dao.ProductDAO;
import comm.vo.seller.InventoryVO;
import comm.vo.seller.MajorCategoryVO;
import comm.vo.seller.MiddleCategoryVO;
import comm.vo.seller.ProductVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class ProductEditAction implements Action{
    List<ProductVO> p_list;
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();

        String  prod_no = request.getParameter("prod_no");
        String  cPage = request.getParameter("cPage");

        ProductVO vo = ProductDAO.getProductOne(prod_no);
        MajorCategoryVO[] majorCategoryAr = CategoryDAO.AllMajorCategory();
        MiddleCategoryVO[] middleCategoryAr = CategoryDAO.AllMiddleCategory();

        request.setAttribute("majorCategoryAr",majorCategoryAr);
        request.setAttribute("middleCategoryAr",middleCategoryAr);
        if(vo!=null) {
            InventoryVO[] options = InventoryDAO.getOptions(prod_no);

            MajorCategoryVO majorCategory = CategoryDAO.majorCategoryOne(vo.getMajor_category());

            MiddleCategoryVO middleCategory = CategoryDAO.getProdCategory(vo.getCategory_no());
            vo.setOptions(options);
            if(vo.getAdditional_images()!=null) {
                String[] images = vo.getAdditional_images().replace(" ", "").split(",");
                vo.setAr_images(images);
            }
            System.out.println("내용: "+vo.getContent());
            request.setAttribute("middleCategory",middleCategory);
            request.setAttribute("majorCategory",majorCategory);
            request.setAttribute("vo", vo);
            request.setAttribute("cPage", cPage);
            return "/seller/jsp/product_edit.jsp";
        }
        else
            return "/seller/jsp/product_new.jsp";


    }

}

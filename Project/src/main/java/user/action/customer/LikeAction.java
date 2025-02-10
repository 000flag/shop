package user.action.customer;

import user.action.Action;
import user.dao.customer.ProdLikeDAO;
import user.vo.customer.CustomerVO;
import user.vo.customer.ProdLikeVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class LikeAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String action = request.getParameter("action");

        String viewPath = null;
        if (action != null) {
            HttpSession session = request.getSession();
            CustomerVO cvo = (CustomerVO) session.getAttribute("customer_info");

            if (cvo == null) {
                request.setAttribute("session_expired", true);
                return "/user/customer/jsp/error/error.jsp";
            }

            String prod_no = request.getParameter("prod_no");
            List<ProdLikeVO> like_list = null;
            switch (action) {
                case "select":
                    ProdLikeVO vo = new ProdLikeVO();
                    vo.setCus_no(cvo.getId());

                    like_list = ProdLikeDAO.selectProdLikeList(vo);
                    request.setAttribute("like_list", like_list);

                    viewPath = "/user/customer/jsp/like/like.jsp";
                    break;
                case "like":
                    ProdLikeVO l_vo = new ProdLikeVO();
                    l_vo.setCus_no(cvo.getId());
                    l_vo.setProd_no(prod_no);

                    ProdLikeDAO.insertProdLike(l_vo);
                    request.setAttribute("like_list", like_list);

                    viewPath = "/user/customer/jsp/like/like.jsp";
                    break;
                case "unlike":
                    ProdLikeVO d_vo = new ProdLikeVO();
                    d_vo.setCus_no(cvo.getId());
                    d_vo.setProd_no(prod_no);

                    ProdLikeDAO.deleteProdLike(d_vo);

                    viewPath = "/user/customer/jsp/like/like.jsp";
                    break;
            }
        }

        return viewPath;
    }
}

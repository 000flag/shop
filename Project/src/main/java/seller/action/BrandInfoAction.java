package seller.action;

import user.action.Action;
import comm.dao.SellerDAO;
import comm.vo.seller.SellerVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class BrandInfoAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // DB에서 데이터 가져오기
        HttpSession session = request.getSession();
        String seller_no = (String) session.getAttribute("seller_no");
        SellerVO vo = SellerDAO.getSellerInfo(seller_no);// ✅ DAO에서 seller 정보 가져오기
        if (vo == null) {
            System.err.println("❌ BrandInfoAction: SellerVO is NULL!");
        } else {
            System.out.println("✅ BrandInfoAction: SellerVO found - " + vo.getSeller_id());
        }

        // JSP에서 사용할 수 있도록 저장
        request.setAttribute("vo", vo);

        return "/seller/jsp/brandinfo.jsp";
    }

}

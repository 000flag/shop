package seller.action;

import user.action.Action;
import comm.dao.SellerDAO;
import comm.vo.SellerVO;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

public class SellerLoginAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response){
        String seller_id = request.getParameter("seller_id");
        String seller_pw = request.getParameter("seller_pw");
        HttpSession session = request.getSession();
        SellerVO vo = SellerDAO.login(seller_id);

        if(BCrypt.checkpw(seller_pw,vo.getSeller_pw())){
            session.setAttribute("seller_no",vo.getId());
           session.setAttribute("seller_id",vo.getSeller_id());
            System.out.println("seller_no: "+vo.getId());
            return "Controller?type=dashBoard";
        }else{
            System.out.println("로그인 실패");
            return "Controller?type=sellerLogout";
        }
    }
}

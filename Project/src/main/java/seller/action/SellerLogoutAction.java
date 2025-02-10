package seller.action;

import user.action.Action;
import comm.dao.SellerDAO;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SellerLogoutAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession();
        session.removeAttribute("seller_no");
        return "/seller/jsp/login/login.jsp";
    }
}

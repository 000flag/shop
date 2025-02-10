package seller.action;

import user.action.Action;
import comm.dao.InventoryDAO;
import comm.dao.SellerDAO;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddSellerAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String seller_id = request.getParameter("seller_id");
        String password = request.getParameter("seller_pw");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String name = request.getParameter("name");
        String ename = request.getParameter("ename");
        String address = request.getParameter("address");
        String courier = request.getParameter("courier");
        String desc = request.getParameter("desc");
        String seller_pw = BCrypt.hashpw(password, BCrypt.gensalt());
        int cnt = SellerDAO.addSeller(seller_id,seller_pw,email,phone,name,address,courier,desc);


        // JSON 응답 반환
        request.setAttribute("cnt",cnt);
        return "/seller/jsp/login/login.jsp";
    }
}

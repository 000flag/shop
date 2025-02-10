package seller.action;

import user.action.Action;
import comm.dao.SellerDAO;
import comm.vo.seller.SellerVO;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.*;

public class SellerLoginAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response){
        String seller_id = request.getParameter("seller_id");
        String seller_pw = request.getParameter("seller_pw");
        HttpSession session = request.getSession();
        SellerVO vo = SellerDAO.login(seller_id);
            if (vo!=null&&BCrypt.checkpw(seller_pw, vo.getSeller_pw())) {
                session.setAttribute("seller_no", vo.getId());
                session.setAttribute("seller_id", vo.getSeller_id());
                SellerDAO.Loginlog(vo.getId());
                return "Controller?type=dashBoard";
            } else {
                System.out.println("로그인 실패");
                JOptionPane.showMessageDialog(null,"아이디가 틀립니다");
            }
        return "Controller?type=sellerLogout";
    }
}

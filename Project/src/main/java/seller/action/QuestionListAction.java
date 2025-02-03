package seller.action;

import com.mysql.cj.Session;
import comm.action.Action;
import comm.dao.QuestionDAO;
import comm.vo.QuestionVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class QuestionListAction implements Action {
    @Override
    public String execute(HttpServletRequest request ,HttpServletResponse response){
        HttpSession session = request.getSession();
        String seller_no = (String) session.getAttribute("seller_no");
        System.out.println("action:"+seller_no);
        QuestionVO[] ar = QuestionDAO.getQuestionAll(seller_no);

        request.setAttribute("ar",ar);



        return "/seller/jsp/question.jsp";

    }
}

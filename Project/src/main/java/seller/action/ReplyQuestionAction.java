package seller.action;

import user.action.Action;
import comm.dao.QuestionDAO;
import comm.vo.QuestionVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ReplyQuestionAction implements Action {
    @Override
    public String execute(HttpServletRequest request , HttpServletResponse response){
        HttpSession session = request.getSession();
        String question_no = request.getParameter("question_no");
        String cus_no = request.getParameter("cus_no");
        String content = request.getParameter("answer");
        String seller_no =(String) session.getAttribute("seller_no");

        int cnt = QuestionDAO.replyQuestion(seller_no,cus_no,question_no,content);
        request.setAttribute("cnt",cnt);
        return "/seller/jsp/ajax/change_active.jsp";

    }
}

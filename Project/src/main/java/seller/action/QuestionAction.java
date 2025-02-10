package seller.action;

import user.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class QuestionAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();

        String  question_no= (String) session.getAttribute("question_no");


        if(question_no == null){

            return "/seller/jsp/question.jsp";
        }

        return "/seller/jsp/question.jsp";
    }

}

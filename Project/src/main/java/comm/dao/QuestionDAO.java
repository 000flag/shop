package comm.dao;

import comm.service.FactoryService;
import comm.vo.seller.QuestionVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;

public class QuestionDAO{
    public static QuestionVO[] getQuestionAll(String seller_no){
        QuestionVO[] ar = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        List<QuestionVO> list = ss.selectList("question.get_question_all",seller_no);
        if(list!=null){
            ar = new QuestionVO[list.size()];
            list.toArray(ar);
        }
        ss.close();

        return ar;
    }
    public static int replyQuestion(String seller_no,String cus_no,String board_no,String content){
        SqlSession ss = FactoryService.getFactory().openSession();
        HashMap<String,String> map = new HashMap<>();
        map.put("seller_no",seller_no);
        map.put("cus_no",cus_no);
        map.put("board_no",board_no);
        map.put("content",content);
        int cnt = ss.insert("question.reply_question",map);
        ss.insert("question.log_reply_question",map);
        if(cnt>0){
            ss.commit();
        }else
            ss.rollback();
        ss.close();
        return cnt;
    }
}

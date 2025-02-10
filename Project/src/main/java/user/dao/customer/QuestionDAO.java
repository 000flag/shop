package user.dao.customer;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.customer.BoardVO;

import java.util.HashMap;
import java.util.List;

public class QuestionDAO {
    // 문의 가져오기
    public static List<BoardVO> selectAll(String cus_no) {
        List<BoardVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            list = ss.selectList("question.select_all", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        }
        ss.close();

        return list;
    }

    // 상품 문의 상세 가져오기
    public static List<BoardVO> selectProdQuestion(String prod_no) {
        List<BoardVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            list = ss.selectList("question.select_prod_question", prod_no);
        } catch (Exception e) {
            e.printStackTrace();
        }
        ss.close();

        return list;
    }

    // 답변 상태에 따른 상품문의 조회
    public static List<BoardVO> selectOption(String cus_no, String status, String startDate, String endDate){
        List<BoardVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("status", status);
            map.put("startDate", startDate);
            map.put("endDate", endDate);

            list = ss.selectList("question.select_option", map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        ss.close();

        return list;
    }

    // 상품 문의 등록
    public static int insertQuestion(String cus_no, String prod_no, String title, String content, String type, String is_private, String additional_images){
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            BoardVO vo = new BoardVO();
            vo.setCus_no(cus_no);
            vo.setProd_no(prod_no);
            vo.setTitle(title);
            vo.setContent(content);
            vo.setType(type);
            vo.setIs_private(is_private);
            vo.setAdditional_images(additional_images);

            cnt = ss.insert("question.insert_question", vo);

            if (cnt > 0)
                ss.commit();
            else
                ss.rollback();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }
}

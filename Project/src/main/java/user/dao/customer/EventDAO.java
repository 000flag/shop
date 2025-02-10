package user.dao.customer;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.customer.EventVO;

import java.util.HashMap;
import java.util.List;

public class EventDAO {
    // 이벤트 가져오기
    public static List<EventVO> selectEvent(String cus_no, String grade_no) {
        List<EventVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("grade_no", grade_no);

            list = ss.selectList("event.select_event", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }
}

package user.dao.customer;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.customer.LogVO;

public class LogDAO {
    // 삭제 로그
    public static void deleteLog(LogVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            int cnt = ss.insert("log.delete_log", vo);

            if (cnt > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }
    }

    // 추가 로그
    public static void insertLog(LogVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            int cnt = ss.insert("log.insert_log", vo);

            if (cnt > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }
    }

    // 수정 로그
    public static void updateLog(LogVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            int cnt = ss.insert("log.update_log", vo);

            if (cnt > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }
    }

    // 기타 로그
    public static void insertEtcLog(LogVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            int cnt = ss.insert("log.insert_etc_log", vo);

            if (cnt > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }
    }
}

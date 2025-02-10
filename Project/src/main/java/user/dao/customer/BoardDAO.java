package user.dao.customer;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.customer.BoardVO;

import java.util.HashMap;
import java.util.List;

public class BoardDAO {
    // 1:1문의 전체 조회
    public static List<BoardVO> selectAll(String cus_no) {
        List<BoardVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            list = ss.selectList("inquiry.select_all", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    // 1:1문의 검색 조건 조회
    public static List<BoardVO> selectSearch(String cus_no, String status, String startDate, String endDate) {
        List<BoardVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("status", status);
            map.put("startDate", startDate);
            map.put("endDate", endDate);

            list = ss.selectList("inquiry.select_search", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    // 1:1문의 등록
    public static int insertInquiry(BoardVO vo) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            cnt = ss.insert("inquiry.insert_inquiry", vo);

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

        return cnt;
    }

    // 구매확정 리뷰 작성
    public static int insertReview(BoardVO vo) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            cnt = ss.insert("review.insert_review", vo);

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

        return cnt;
    }

    // 작성한 리뷰 목록 가져오기
    public static List<BoardVO> selectWriteReview(String cus_no, String startDate, String endDate) {
        List<BoardVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("startDate", startDate);
            map.put("endDate", endDate);

            list = ss.selectList("review.select_write_review", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    // 리뷰 상세 조회
    public static BoardVO selectReviewDetails(String cus_no, String board_no) {
        BoardVO vo = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_no", cus_no);
            map.put("id", board_no);

            vo = ss.selectOne("review.select_review_details", map);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return vo;
    }

    // 리뷰 수정
    public static int updateReview(BoardVO vo) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            cnt = ss.update("review.update_review", vo);

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

        return cnt;
    }

    // 리뷰 삭제
    public static int deleteReview(String id) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            cnt = ss.update("review.delete_review", id);

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

        return cnt;
    }
}

package user.dao.customer;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.customer.ProdLikeVO;

import java.util.List;

public class ProdLikeDAO {
    // 좋아요 조회
    public static ProdLikeVO selectProdLike(ProdLikeVO vo) {
        ProdLikeVO pvo = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            pvo = ss.selectOne("prod_like.select_prod_like", vo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return pvo;
    }

    // 좋아요 목록
    public static List<ProdLikeVO> selectProdLikeList(ProdLikeVO vo) {
        List<ProdLikeVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            list = ss.selectList("prod_like.select_prod_like_list", vo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    // 좋아요 설정
    public static void insertProdLike(ProdLikeVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            int cnt = ss.insert("prod_like.insert_prod_like", vo);

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

    // 좋아요 해제
    public static void deleteProdLike(ProdLikeVO vo) {
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            int cnt = ss.delete("prod_like.delete_prod_like", vo);

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

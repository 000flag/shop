package user.dao.customer;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.customer.DeliveryVO;

import java.util.HashMap;
import java.util.List;

public class DeliveryDAO {
    // 배송지 정보 가져오기
    public static List<DeliveryVO> selectDelivery(String cus_no) {
        List<DeliveryVO> list = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            list = ss.selectList("delivery.select_delivery", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return list;
    }

    // 기본 배송지 조회
    public static DeliveryVO selectDeliveryDefault(String cus_no) {
        DeliveryVO dvo = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            dvo = ss.selectOne("delivery.select_delivery_default", cus_no);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return dvo;
    }

    // 배송지 상세 조회
    public static DeliveryVO selectDeliveryById(String id) {
        DeliveryVO vo = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            vo = ss.selectOne("delivery.select_delivery_by_id", id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return vo;
    }

    //배송지 정보 입력하기
    public static int insertDelivery(String cus_no, String name, String phone, String pos_code, String addr1, String addr2, String chkDefault, String deli_request) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            DeliveryVO vo = new DeliveryVO();
            vo.setCus_no(cus_no);
            vo.setName(name);
            vo.setPhone(phone);
            vo.setPos_code(pos_code);
            vo.setAddr1(addr1);
            vo.setAddr2(addr2);
            vo.setIs_default(chkDefault);
            vo.setRequest(deli_request);

            cnt = ss.insert("delivery.insert_delivery", vo);

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

    //배송지 수정하기
    public static int updateDelivery(String id, String name, String phone, String pos_code, String addr1, String addr2, String chkDefault, String deli_request) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            DeliveryVO vo = new DeliveryVO();
            vo.setId(id);
            vo.setName(name);
            vo.setPhone(phone);
            vo.setPos_code(pos_code);
            vo.setAddr1(addr1);
            vo.setAddr2(addr2);
            vo.setIs_default(chkDefault);
            vo.setRequest(deli_request);

            cnt = ss.update("delivery.update_delivery", vo);

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

    //배송지 삭제하기
    public static int deleteDelivery(String id) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            cnt = ss.update("delivery.delete_delivery", id);

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

    // 모든 배송지의 is_default를 false로 설정
    public static void updateIsDefault(String cus_no) {
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            int cnt = ss.update("delivery.update_delivery_is_default", cus_no);

            if (cnt > 0)
                ss.commit();
            else
                ss.rollback();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }
    }

    // 회수 배송지 조회
    public static DeliveryVO selectRetrieveInfo(String id) {
        DeliveryVO dvo = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            dvo = ss.selectOne("delivery.select_retrieve_info", id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return dvo;
    }
}

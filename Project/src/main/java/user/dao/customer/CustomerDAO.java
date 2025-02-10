package user.dao.customer;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.customer.CustomerVO;

import java.util.HashMap;

public class CustomerDAO {
    // 로그인
    public static CustomerVO login(CustomerVO vo) {
        CustomerVO vs = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            vs = ss.selectOne("customer.login", vo);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return vs;
    }

    // 아이디 중복 확인
    public static int selectCusId(String cus_id) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            cnt = ss.selectOne("customer.select_cus_id", cus_id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return cnt;
    }

    // 회원 가입
    public static int insertCustomer(CustomerVO vo) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            cnt = ss.insert("customer.insert_customer", vo);

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

    // 회원 정보 보기(id)
    public static CustomerVO selectCustomerById(String id) {
        CustomerVO vo = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            vo = ss.selectOne("customer.select_customer", id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return vo;
    }

    // 비밀번호 찾기
    public static String searchCusPWByCusId(String cus_id) {
        String pw = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            pw = ss.selectOne("customer.search_cus_pw_by_cus_id", cus_id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return pw;
    }

    // 회원 정보 보기(cus_id)
    public static CustomerVO selectCustomerByCusId(String cus_id) {
        CustomerVO vo = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            vo = ss.selectOne("customer.select_customer_by_cus_id", cus_id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ss.close();
        }

        return vo;
    }

    // 비밀번호 재설정
    public static int updateCustomerPw(String cus_id, String cus_pw) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("cus_id", cus_id);
            map.put("cus_pw", cus_pw);

            cnt = ss.update("customer.update_cus_pw", map);

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

    // 회원 정보 수정
    public static int updateCustomer(CustomerVO vo) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            cnt = ss.update("customer.update_customer", vo);

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

    // 프로필 변경
    public static int updateProfile(CustomerVO vo) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            cnt = ss.update("customer.update_profile", vo);

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

    // 누적 금액 수정(취소/반품)
    public static int updateTotal(String id, String total) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("id", id);
            map.put("total", total);

            cnt = ss.update("customer.update_total", map);

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

    // 누적 금액 추가
    public static int updateAddTotal(String id, String total) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("id", id);
            map.put("total", total);

            cnt = ss.update("customer.update_add_total", map);

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

    // 신체정보 업데이트
    public static int updateBodyInfo(String id, String weight, String height){
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            HashMap<String, String> map = new HashMap<>();
            map.put("id", id);
            map.put("weight", weight);
            map.put("height", height);

            cnt = ss.update("customer.update_customer", map);

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

    // 회원 탈퇴
    public static int deleteCustomer(String id){
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        try {
            cnt = ss.update("customer.delete_customer", id);

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

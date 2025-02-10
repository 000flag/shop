package user.dao.snap;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.snap.CustomerVO;

import java.util.List;

public class CustomerDao {

  // 현재 로그인한 사용자 정보 가져오기
  public CustomerVO getUserProfile(int cusId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    CustomerVO userProfile = ss.selectOne("customer.getUserProfile", cusId);
    ss.close();
    return userProfile;
  }

  // 랜덤 추천 사용자 5명 가져오기
  public List<CustomerVO> getRandomUsers(int excludeCusId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    List<CustomerVO> randomUsers = ss.selectList("customer.getRandomUsers", excludeCusId);
    ss.close();
    return randomUsers;
  }

  // 로그인
  public static CustomerVO login(CustomerVO vo) {
    SqlSession ss = FactoryService.getFactory().openSession();
    CustomerVO vs = ss.selectOne("customer.loginSelect", vo);
    if(vs != null) {
      ss.commit();
    }
    ss.close();
    return vs;
  }

  // 회원가입
  public static int cusadd(CustomerVO vo){
    SqlSession ss = FactoryService.getFactory().openSession();
    int cnt = ss.insert("customer.signupInsert",vo);
    if(cnt > 0){
      ss.commit();
    }
    ss.close();
    return cnt;
  }

  public static int getId(String nickname){
    SqlSession ss = FactoryService.getFactory().openSession();
    int id = ss.selectOne("customer.getId", nickname);
    ss.close();
    return id;
  }
}
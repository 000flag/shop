package user.dao.snap;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.snap.CustomerVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FollowDao {
  public static boolean addFollow(int customerId, int followingId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    Map<String, Integer> params = new HashMap<>();
    params.put("customerId", customerId);
    params.put("followingId", followingId);
    ss.insert("FollowMapper.addFollow", params);
    ss.commit();
    ss.close();
    return true;
  }

  public static boolean removeFollow(int customerId, int followingId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    Map<String, Integer> params = new HashMap<>();
    params.put("customerId", customerId);
    params.put("followingId", followingId);
    ss.delete("FollowMapper.removeFollow", params);
    ss.commit();
    ss.close();
    return true;
  }

  public static boolean isFollowing(int customerId, int followingId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    Map<String, Integer> params = new HashMap<>();
    params.put("customerId", customerId);
    params.put("followingId", followingId);
    Integer count = ss.selectOne("FollowMapper.isFollowing", params);
    ss.close();
    return count != null && count > 0;
  }

  public List<CustomerVO> getFollowers(int userId, int sessionUserId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    Map<String, Integer> params = new HashMap<>();
    params.put("userId", userId);
    params.put("sessionUserId", sessionUserId);
    List<CustomerVO> followers = ss.selectList("FollowMapper.getFollowers", params);
    ss.close();
    return followers;
  }

  public List<CustomerVO> getFollowings(int userId, int sessionUserId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    Map<String, Integer> params = new HashMap<>();
    params.put("userId", userId);
    params.put("sessionUserId", sessionUserId);
    List<CustomerVO> followings = ss.selectList("FollowMapper.getFollowings", params);
    ss.close();
    return followings;
  }

  public int getFollowerCount(int userId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    int count = ss.selectOne("FollowMapper.getFollowerCount", userId);
    ss.close();
    return count;
  }

  public int getFollowingCount(int userId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    int count = ss.selectOne("FollowMapper.getFollowingCount", userId);
    ss.close();
    return count;
  }
  public List<CustomerVO> getFollowerSearch(String keyword) {
    SqlSession ss = FactoryService.getFactory().openSession();
    List<CustomerVO> list = ss.selectList("FollowMapper.searchUsers",keyword);
    ss.close();
    return list;


  }



}

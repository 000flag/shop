package user.dao.snap;

import org.apache.ibatis.session.SqlSession;
import service.FactoryService;
import user.vo.snap.ChatRoomVO;
import user.vo.snap.ChatMessageVO;

import user.vo.snap.CustomerVO;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import java.math.BigInteger;
public class ChatDao {




  public ChatRoomVO getChatRoom(int user1Id, int user2Id) {
    SqlSession ss = FactoryService.getFactory().openSession();
    Map<String, Integer> params = new HashMap<>();
    params.put("user1Id", user1Id);
    params.put("user2Id", user2Id);
    ChatRoomVO chatRoom = ss.selectOne("ChatMapper.getChatRoom", params);
    ss.close();
    return chatRoom;
  }



  public int createChatRoom(int user1Id, int user2Id) {
    SqlSession ss = FactoryService.getFactory().openSession();
    Map<String, Object> params = new HashMap<>();
    params.put("user1Id", user1Id);
    params.put("user2Id", user2Id);
    ss.insert("ChatMapper.createChatRoom", params);
    ss.commit();

    Object idObj = params.get("id");
    int chatRoomId;
    if (idObj instanceof BigInteger) {
      chatRoomId = ((BigInteger) idObj).intValue();
    } else if (idObj instanceof Integer) {
      chatRoomId = (Integer) idObj;
    } else {
      throw new IllegalStateException("Unexpected id type: " + idObj.getClass());
    }

    ss.close();
    return chatRoomId;
  }


  public List<ChatRoomVO> getChatRooms(int userId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    List<ChatRoomVO> chatRooms = ss.selectList("ChatMapper.getChatRooms", userId);
    ss.close();
    return chatRooms;
  }

  public List<ChatMessageVO> getChatMessages(int roomId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    List<ChatMessageVO> chatMessages = ss.selectList("ChatMapper.getChatMessages", roomId);
    ss.close();
    return chatMessages;
  }

  public boolean sendMessage(int roomId, int senderId, String message) {
    SqlSession ss = FactoryService.getFactory().openSession();
    Map<String, Object> params = new HashMap<>();
    params.put("roomId", roomId);
    params.put("senderId", senderId);
    params.put("message", message);
    ss.insert("ChatMapper.sendMessage", params);
    ss.commit();
    ss.close();
    return true;
  }

  public static int getUnreadMessageCount(int roomId, int userId) {
     SqlSession ss = FactoryService.getFactory().openSession();
     Map<String, Object> params = new HashMap<>();
     params.put("roomId", roomId);
     params.put("userId", userId);
     int cnt = ss.selectOne("ChatMapper.getUnreadMessageCount", params);
     ss.close();
     return cnt;
  }

  public String getLastMessage(int roomId) {
    SqlSession session = FactoryService.getFactory().openSession();
    String lastMessage = session.selectOne("ChatMapper.getLastMessage", roomId);
    session.close();
    return lastMessage != null ? lastMessage : "";  // null 방지

  }


  public CustomerVO getUserProfile(int userId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    CustomerVO userProfile = ss.selectOne("ChatMapper.getUserInfo", userId);
    ss.close();
    return userProfile;
  }



  public void markMessagesAsRead(int roomId, int userId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    Map<String, Object> params = new HashMap<>();
    params.put("roomId", roomId);
    params.put("sender_id", userId);
    ss.update("ChatMapper.markMessagesAsRead", params);
    ss.commit();
    ss.close();
  }

  public LocalDateTime getLastMessageTime(int roomId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    Timestamp lastMessageTimeTs = ss.selectOne("ChatMapper.getLastMessageTime", roomId);
    ss.close();
    return (lastMessageTimeTs != null) ? lastMessageTimeTs.toLocalDateTime() : null;
  }

  //읽음처리
  public boolean updateMessageReadStatus(int roomId, int userId) {
    SqlSession ss = FactoryService.getFactory().openSession();
    Map<String, Object> params = new HashMap<>();
    params.put("roomId", roomId);
    params.put("userId", userId);

    int result = ss.update("ChatMapper.updateMessageReadStatus", params);
    ss.commit();
    ss.close();

    return result > 0;
  }

  public static boolean sendMessage(ChatMessageVO vo) {
    SqlSession ss = FactoryService.getFactory().openSession();
    Map<String, Object> params = new HashMap<>();
   ;  // 이미지 URL 추가

    int result = ss.insert("ChatMapper.sendMessage", vo);
    ss.commit();
    ss.close();

    return result > 0;
  }



}

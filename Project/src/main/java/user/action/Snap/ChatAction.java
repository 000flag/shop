package user.action.Snap;

import user.action.Action;
import user.dao.snap.ChatDao;
import user.vo.snap.ChatRoomVO;
import user.vo.snap.CustomerVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

public class ChatAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    int userId = (int) request.getSession().getAttribute("cus_id"); // 현재 로그인한 유저 ID
    int receiverId = request.getParameter("receiverId") != null ? Integer.parseInt(request.getParameter("receiverId")) : -1;
    System.out.println("receiverId:" + receiverId);
    ChatDao chatDao = new ChatDao();

    // 채팅방이 있는지 확인
    ChatRoomVO chatRoom = null;
    if (receiverId > 0) {
      chatRoom = chatDao.getChatRoom(userId, receiverId);
      if (chatRoom == null) {
        // 채팅방이 없으면 생성
        int newRoomId = chatDao.createChatRoom(userId, receiverId);
        System.out.println();
        chatRoom = chatDao.getChatRoom(userId, receiverId);
      }
    }

    // 채팅방 목록 조회
    List<ChatRoomVO> chatRooms = chatDao.getChatRooms(userId);
    for (ChatRoomVO room : chatRooms) {
      String lastMessage = chatDao.getLastMessage(room.getId());
      int unreadCount = chatDao.getUnreadMessageCount(room.getId(), userId);
      LocalDateTime lastMessageTime = chatDao.getLastMessageTime(room.getId());
      room.setLastMessageTimeStr(formatTimeAgo(lastMessageTime));

      room.setUnreadCount(unreadCount);
      room.setLastMessageTime(lastMessageTime);
    }
    request.setAttribute("chatRooms", chatRooms);

    // 내 정보 조회 (프로필, 닉네임)
    CustomerVO myInfo = chatDao.getUserProfile(userId);
    request.setAttribute("myInfo", myInfo);

    // 채팅방이 새로 생성되었거나 기존 채팅방이 있을 경우 해당 방을 자동으로 열기
    if (chatRoom != null){
      request.setAttribute("selectedRoomId", chatRoom.getId());
      request.setAttribute("selectedReceiverId", receiverId);
    }

    return "/user/snap/jsp/snap/Chat.jsp";
  }

  public static String formatTimeAgo(LocalDateTime lastMessageTime) {
    if (lastMessageTime == null) return "";
    Duration duration = Duration.between(lastMessageTime, LocalDateTime.now());
    long seconds = duration.getSeconds();

    if (seconds < 60) return seconds + "초 전";
    long minutes = seconds / 60;
    if (minutes < 60) return minutes + "분 전";
    long hours = minutes / 60;
    if (hours < 24) return hours + "시간 전";
    long days = hours / 24;
    if (days < 30) return days + "일 전";
    long months = days / 30;
    if (months < 12) return months + "개월 전";
    return (months / 12) + "년 전";
  }

}

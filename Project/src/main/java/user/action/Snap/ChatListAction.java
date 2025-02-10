package user.action.Snap;

import user.action.Action;
import user.dao.snap.ChatDao;
import user.vo.snap.ChatRoomVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

public class ChatListAction implements Action {
  @Override
  public String execute(HttpServletRequest request, HttpServletResponse response) {
    try {
      int userId = (int) request.getSession().getAttribute("cus_id");
      ChatDao chatDao = new ChatDao();
      List<ChatRoomVO> chatRooms = chatDao.getChatRooms(userId);

      response.setContentType("application/json");
      PrintWriter out = response.getWriter();
      out.print("[");
      for (int i = 0; i < chatRooms.size(); i++) {
        ChatRoomVO room = chatRooms.get(i);
        out.print("{\"id\": " + room.getId() + ", \"otherUserId\": " + room.getUser2Id() +
            ", \"otherUserProfile\": \"" + room.getOtherUserProfileImage() + "\", " +
            "\"otherUserNickname\": \"" + room.getOtherUserNickname() + "\", " +
            "\"lastMessage\": \"" + room.getLastMessage() + "\"}");
        if (i < chatRooms.size() - 1) out.print(",");
      }
      out.print("]");
      out.flush();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }
}

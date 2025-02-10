package user.vo.snap;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.concurrent.TimeUnit;

public class ChatRoomVO {
  private int id;
  private int user1Id;
  private int user2Id;
  private Date createdAt;
  private String lastMessage;
  private LocalDateTime lastMessageTime;
  private String otherUserNickname;
  private String otherUserProfileImage;
  private int unreadCount;
  private String lastMessageTimeStr;

  public String getLastMessageTimeStr() {
    return lastMessageTimeStr;
  }

  public void setLastMessageTimeStr(String lastMessageTimeStr) {
    this.lastMessageTimeStr = lastMessageTimeStr;
  }

  public int getUnreadCount() {
    return unreadCount;
  }

  public void setUnreadCount(int unreadCount) {
    this.unreadCount = unreadCount;
  }

  public ChatRoomVO() {}

  public ChatRoomVO(int id, int user1Id, int user2Id, Date createdAt) {
    this.id = id;
    this.user1Id = user1Id;
    this.user2Id = user2Id;
    this.createdAt = createdAt;
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public int getUser1Id() {
    return user1Id;
  }

  public void setUser1Id(int user1Id) {
    this.user1Id = user1Id;
  }

  public int getUser2Id() {
    return user2Id;
  }

  public void setUser2Id(int user2Id) {
    this.user2Id = user2Id;
  }

  public Date getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(Date createdAt) {
    this.createdAt = createdAt;
  }

  public String getLastMessage() {
    return lastMessage;
  }

  public void setLastMessage(String lastMessage) {
    this.lastMessage = lastMessage;
  }

  public LocalDateTime getLastMessageTime() {
    return lastMessageTime;
  }

  public void setLastMessageTime(LocalDateTime lastMessageTime) {
    this.lastMessageTime = lastMessageTime;
  }

  public String getOtherUserNickname() {
    return otherUserNickname;
  }

  public void setOtherUserNickname(String otherUserNickname) {
    this.otherUserNickname = otherUserNickname;
  }

  public String getOtherUserProfileImage() {
    return otherUserProfileImage;
  }

  public void setOtherUserProfileImage(String otherUserProfileImage) {
    this.otherUserProfileImage = otherUserProfileImage;
  }

  //  마지막 메시지 시간을 "몇 분 전", "몇 시간 전" 형식으로 변환
  public String getFormattedLastMessageTime() {
    if (lastMessageTime == null) {
      return "방금 전";
    }


    long diffInMillis = new Date().getTime() - Date.from(lastMessageTime.atZone(ZoneId.systemDefault()).toInstant()).getTime();


    long minutes = TimeUnit.MILLISECONDS.toMinutes(diffInMillis);
    long hours = TimeUnit.MILLISECONDS.toHours(diffInMillis);
    long days = TimeUnit.MILLISECONDS.toDays(diffInMillis);

    if (minutes < 1) {
      return "방금 전";
    } else if (minutes < 60) {
      return minutes + "분 전";
    } else if (hours < 24) {
      return hours + "시간 전";
    } else if (days < 30) {
      return days + "일 전";
    } else {
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
      return sdf.format(lastMessageTime);
    }
  }
}

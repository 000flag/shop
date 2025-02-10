package user.vo.snap;

import java.util.Date;

public class ChatMessageVO {
  private int id;
  private int roomId;
  private int sender_id;  //
  private String senderNickname;
  private String senderProfileImage;
  private String message;
  private Date created_at; //
  private boolean isRead;
  private int is_read;
  private String image_url;

  public boolean isRead() {
    return isRead;
  }

  public void setRead(boolean read) {
    isRead = read;
  }

  public int getIs_read() {
    return is_read;
  }

  public void setIs_read(int is_read) {
    this.is_read = is_read;
  }

  public String getImage_url() {
    return image_url;
  }

  public void setImage_url(String image_url) {
    this.image_url = image_url;
  }

  public ChatMessageVO() {}

  public ChatMessageVO(int id, int roomId, int sender_id, String message, Date created_at, int is_read) {
    this.id = id;
    this.roomId = roomId;
    this.sender_id = sender_id;
    this.message = message;
    this.created_at = created_at;
    this.is_read = is_read;
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public int getRoomId() {
    return roomId;
  }

  public void setRoomId(int roomId) {
    this.roomId = roomId;
  }

  public int getSender_id() {  // ✅ Getter 수정
    return sender_id;
  }

  public void setSender_id(int sender_id) {  // ✅ Setter 수정
    this.sender_id = sender_id;
  }

  public String getSenderNickname() {
    return senderNickname;
  }

  public void setSenderNickname(String senderNickname) {
    this.senderNickname = senderNickname;
  }

  public String getSenderProfileImage() {
    return senderProfileImage;
  }

  public void setSenderProfileImage(String senderProfileImage) {
    this.senderProfileImage = senderProfileImage;
  }

  public String getMessage() {
    return message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

  public Date getCreated_at() {  // ✅ Getter 수정
    return created_at;
  }

  public void setCreated_at(Date created_at) {  // ✅ Setter 수정
    this.created_at = created_at;
  }


}

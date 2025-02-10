package user.vo.snap;

import java.util.Date;

public class ReplyVO {
  private int id;
  private int board_no;
  private int seller_no;
  private int cus_no;
  private String content;
  private int is_like;
  private Date write_date;
  private int is_del;
  private String nickname;
  private String profile_image;

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public int getBoard_no() {
    return board_no;
  }

  public void setBoard_no(int board_no) {
    this.board_no = board_no;
  }

  public int getSeller_no() {
    return seller_no;
  }

  public void setSeller_no(int seller_no) {
    this.seller_no = seller_no;
  }

  public int getCus_no() {
    return cus_no;
  }

  public void setCus_no(int cus_no) {
    this.cus_no = cus_no;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public int getIs_like() {
    return is_like;
  }

  public void setIs_like(int is_like) {
    this.is_like = is_like;
  }

  public Date getWrite_date() {
    return write_date;
  }

  public void setWrite_date(Date write_date) {
    this.write_date = write_date;
  }

  public int getIs_del() {
    return is_del;
  }

  public void setIs_del(int is_del) {
    this.is_del = is_del;
  }

  public String getProfile_image() {
    return profile_image;
  }

  public void setProfile_image(String profile_image) {
    this.profile_image = profile_image;
  }

  public String getNickname() {
    return nickname;
  }

  public void setNickname(String nickname) {
    this.nickname = nickname;
  }
// Getters & Setters
}

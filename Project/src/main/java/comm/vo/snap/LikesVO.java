package user.vo.snap;

public class LikesVO {
  private int id;
  private int boardNo; // 카멜케이스로 수정
  private int cusNo;   // 카멜케이스로 수정
  private int status;

  // Getter와 Setter
  public int getId() {
    return id;
  }
  public void setId(int id) {
    this.id = id;
  }
  public int getBoardNo() {
    return boardNo;
  }
  public void setBoardNo(int boardNo) {
    this.boardNo = boardNo;
  }
  public int getCusNo() {
    return cusNo;
  }
  public void setCusNo(int cusNo) {
    this.cusNo = cusNo;
  }
  public int getStatus() {
    return status;
  }
  public void setStatus(int status) {
    this.status = status;
  }
}

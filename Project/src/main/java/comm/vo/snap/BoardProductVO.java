package user.vo.snap;

public class BoardProductVO {
  private int id;          // 관계 ID (Primary Key, 필요하면 사용)
  private int board_no;    // Snap 게시글 ID (FK)
  private int prod_no;     // 선택한 제품 ID (FK)

  public BoardProductVO() {}

  public BoardProductVO(int board_no, int prod_no) {
    this.board_no = board_no;
    this.prod_no = prod_no;
  }

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

  public int getProd_no() {
    return prod_no;
  }

  public void setProd_no(int prod_no) {
    this.prod_no = prod_no;
  }

  @Override
  public String toString() {
    return "BoardProductVO{" +
        "id=" + id +
        ", board_no=" + board_no +
        ", prod_no=" + prod_no +
        '}';
  }
}

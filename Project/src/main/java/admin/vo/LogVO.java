package admin.vo;

public class LogVO {
  String id,   seller_no, cus_no, writer_type, target, log_type, prev, current, log_date;
  int root_no;



  String is_del;

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getSeller_no() {
    return seller_no;
  }

  public void setSeller_no(String seller_no) {
    this.seller_no = seller_no;
  }

  public String getCus_no() {
    return cus_no;
  }

  public void setCus_no(String cus_no) {
    this.cus_no = cus_no;
  }

  public String getWriter_type() {
    return writer_type;
  }

  public void setWriter_type(String writer_type) {
    this.writer_type = writer_type;
  }

  public String getLog_type() {
    return log_type;
  }

  public void setLog_type(String log_type) {
    this.log_type = log_type;
  }

  public String getTarget() {
    return target;
  }

  public void setTarget(String target) {
    this.target = target;
  }

  public String getPrev() {
    return prev;
  }

  public void setPrev(String prev) {
    this.prev = prev;
  }

  public String getCurrent() {
    return current;
  }

  public void setCurrent(String current) {
    this.current = current;
  }

  public String getLog_date() {
    return log_date;
  }

  public void setLog_date(String log_date) {
    this.log_date = log_date;
  }

  public int getRoot_no() {
    return root_no;
  }

  public void setRoot_no(int root_no) {
    this.root_no = root_no;
  }
}

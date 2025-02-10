package comm.vo.seller;

public class SellerLogVO {
    private String id, root_no, seller_no, cus_no, writer_type, target, log_type, prev, current, log_date;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRoot_no() {
        return root_no;
    }

    public void setRoot_no(String root_no) {
        this.root_no = root_no;
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

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public String getLog_type() {
        return log_type;
    }

    public void setLog_type(String log_type) {
        this.log_type = log_type;
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

    @Override
    public String toString() {
        return "LogVO{" +
                "id='" + id + '\'' +
                ", root_no='" + root_no + '\'' +
                ", seller_no='" + seller_no + '\'' +
                ", cus_no='" + cus_no + '\'' +
                ", writer_type='" + writer_type + '\'' +
                ", target='" + target + '\'' +
                ", log_type='" + log_type + '\'' +
                ", prev='" + prev + '\'' +
                ", current='" + current + '\'' +
                ", log_date='" + log_date + '\'' +
                '}';
    }
}

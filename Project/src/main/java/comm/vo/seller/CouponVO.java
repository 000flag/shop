package comm.vo.seller;

public class CouponVO {
    private String id, root_no, category_no, seller_no, grade_no, type, name, sale_per, start_date, end_date, status, is_del;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIs_del() {
        return is_del;
    }

    public void setIs_del(String is_del) {
        this.is_del = is_del;
    }

    public String getRoot_no() {
        return root_no;
    }

    public void setRoot_no(String root_no) {
        this.root_no = root_no;
    }

    public String getCategory_no() {
        return category_no;
    }

    public void setCategory_no(String category_no) {
        this.category_no = category_no;
    }

    public String getSeller_no() {
        return seller_no;
    }

    public void setSeller_no(String seller_no) {
        this.seller_no = seller_no;
    }

    public String getGrade_no() {
        return grade_no;
    }

    public void setGrade_no(String grade_no) {
        this.grade_no = grade_no;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSale_per() {
        return sale_per;
    }

    public void setSale_per(String sale_per) {
        this.sale_per = sale_per;
    }

    public String getStart_date() {
        return start_date;
    }

    public void setStart_date(String start_date) {
        this.start_date = start_date;
    }

    public String getEnd_date() {
        return end_date;
    }

    public void setEnd_date(String end_date) {
        this.end_date = end_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "CouponVO{" +
                "id='" + id + '\'' +
                ", root_no='" + root_no + '\'' +
                ", category_no='" + category_no + '\'' +
                ", seller_no='" + seller_no + '\'' +
                ", grade_no='" + grade_no + '\'' +
                ", type='" + type + '\'' +
                ", name='" + name + '\'' +
                ", sale_per='" + sale_per + '\'' +
                ", start_date='" + start_date + '\'' +
                ", end_date='" + end_date + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}

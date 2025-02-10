package comm.vo.seller;

public class SalesVO {
    private String order_id, order_date,product_name, category_name, discount_value, final_price, status;

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public String getOrder_date() {
        return order_date;
    }

    public void setOrder_date(String order_date) {
        this.order_date = order_date;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public String getCategory_name() {
        return category_name;
    }

    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }

    public String getDiscount_value() {
        return discount_value;
    }

    public void setDiscount_value(String discount_value) {
        this.discount_value = discount_value;
    }

    public String getFinal_price() {
        return final_price;
    }

    public void setFinal_price(String final_price) {
        this.final_price = final_price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "SalesVO{" +
                "order_id='" + order_id + '\'' +
                ", order_date='" + order_date + '\'' +
                ", product_name='" + product_name + '\'' +
                ", category_name='" + category_name + '\'' +
                ", discount_value='" + discount_value + '\'' +
                ", final_price='" + final_price + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
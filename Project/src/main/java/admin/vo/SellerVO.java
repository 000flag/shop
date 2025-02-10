package admin.vo;

public class SellerVO {
    String id;
    String seller_id;
    String seller_pw;
    String name;
    String phone;
    String email;
    String desc;
    String courier;
    String address;
    String is_del;

    public String getActive() {
        return active;
    }

    public void setActive(String active) {
        this.active = active;
    }

    String active;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSeller_id() {
        return seller_id;
    }

    public void setSeller_id(String seller_id) {
        this.seller_id = seller_id;
    }

    public String getSeller_pw() {
        return seller_pw;
    }

    public void setSeller_pw(String seller_pw) {
        this.seller_pw = seller_pw;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getCourier() {
        return courier;
    }

    public void setCourier(String courier) {
        this.courier = courier;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getIs_del() {
        return is_del;
    }

    public void setIs_del(String is_del) {
        this.is_del = is_del;
    }

    public String getSeller_icon() {
        return seller_icon;
    }

    public void setSeller_icon(String seller_icon) {
        this.seller_icon = seller_icon;
    }

    String seller_icon;

}

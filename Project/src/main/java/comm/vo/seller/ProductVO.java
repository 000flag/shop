package comm.vo.seller;

public class ProductVO {
    private String id;
    private String category_no;
    private String seller_no;
    private String name;
    private String price;
    private String add_date;
    private String view_count;
    private String inventory;
    private String active;
    private String sale;
    private String prod_image;
    private String additional_images;
    private String is_del;
    private String saled_price;
    private String major_category;
    private String content;
    private String content_image;
    private String[] ar_images;
    private InventoryVO[] options;

    public String getContent_image() {
        return content_image;
    }

    public void setContent_image(String content_image) {
        this.content_image = content_image;
    }

    public String getMajor_category() {
        return major_category;
    }

    public void setMajor_category(String major_category) {
        this.major_category = major_category;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }



    public String[] getAr_images() {
        return ar_images;
    }

    public void setAr_images(String[] ar_images) {
        this.ar_images = ar_images;
    }

    public String getAdditional_images() {
        return additional_images;
    }

    public void setAdditional_images(String additional_images) {
        this.additional_images = additional_images;
    }

    public String getSaled_price() {
        return saled_price;
    }

    public void setSaled_price(String saled_price) {
        this.saled_price = saled_price;
    }



    public InventoryVO[] getOptions() {
        return options;
    }

    public void setOptions(InventoryVO[] options) {
        this.options = options;
    }

    public String getIs_del() {
        return is_del;
    }

    public void setIs_del(String is_del) {
        this.is_del = is_del;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getAdd_date() {
        return add_date;
    }

    public void setAdd_date(String add_date) {
        this.add_date = add_date;
    }

    public String getView_count() {
        return view_count;
    }

    public void setView_count(String view_count) {
        this.view_count = view_count;
    }

    public String getInventory() {
        return inventory;
    }

    public void setInventory(String inventory) {
        this.inventory = inventory;
    }

    public String getActive() {
        return active;
    }

    public void setActive(String active) {
        this.active = active;
    }

    public String getSale() {
        return sale;
    }

    public void setSale(String sale) {
        this.sale = sale;
    }

    public String getProd_image() {
        return prod_image;
    }

    public void setProd_image(String prod_image) {
        this.prod_image = prod_image;
    }

}

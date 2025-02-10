package user.vo.snap;

public class ProductVO {

  private int id; // 제품 ID
  private int seller_no; // 판매자 ID
  private String sellerName; // 판매자 이름
  private String name; // 제품명
  private String prod_image; // 제품 이미지 URL
  private int price; // 가격
  private int sale; // 할인율

  // 기본 생성자
  public ProductVO() {
  }

  // 매개변수 생성자
  public ProductVO(int id, int seller_no, String sellerName, String name, String prod_image, int price, int sale) {
    this.id = id;
    this.seller_no = seller_no;
    this.sellerName = sellerName;
    this.name = name;
    this.prod_image = prod_image;
    this.price = price;
    this.sale = sale;
  }

  // Getter and Setter
  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public int getSeller_no() {
    return seller_no;
  }

  public void setSeller_no(int seller_no) {
    this.seller_no = seller_no;
  }

  public String getSellerName() {
    return sellerName;
  }

  public void setSellerName(String sellerName) {
    this.sellerName = sellerName;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getProd_image() {
    return prod_image;
  }

  public void setProd_image(String prod_image) {
    this.prod_image = prod_image;
  }

  public int getPrice() {
    return price;
  }

  public void setPrice(int price) {
    this.price = price;
  }

  public int getSale() {
    return sale;
  }

  public void setSale(int sale) {
    this.sale = sale;
  }

  // toString() 메서드
  @Override
  public String toString() {
    return "ProductVO{" +
        "id=" + id +
        ", seller_no=" + seller_no +
        ", sellerName='" + sellerName + '\'' +
        ", name='" + name + '\'' +
        ", prod_image='" + prod_image + '\'' +
        ", price=" + price +
        ", sale=" + sale +
        '}';
  }
}

package user.vo;

import java.util.List;

public class BoardVO {
  private int id;
  private String nickname;
  private String gender;
  private String season;
  private String style;
  private String title;
  private String content;
  private String snapshot_image; // 필드 이름 변경
  private int likeCount;
  private String writeDate;
  private int isDel;
  private int cus_no;
  public String bname;
  private boolean liked;
  private String tags;
  private String Introduce;




  public String getIntroduce() {
    return Introduce;
  }


  public void setIntroduce(String introduce) {
    Introduce = introduce;
  }

  private String products; // MyBatis에서 GROUP_CONCAT 결과를 받을 필드
  private List<Integer> productList; // 변환된 리스트

  public String getProducts() {
    return products;
  }

  public void setProducts(String products) {
    this.products = products;
  }

  public List<Integer> getProductList() {
    return productList;
  }

  public void setProductList(List<Integer> productList) {
    this.productList = productList;
  }


  public String getProd_no() {
    return prod_no;
  }

  public String getTags() {
    return tags;
  }

  public void setTags(String tags) {
    this.tags = tags;
  }

  public void setProd_no(String prod_no) {
    this.prod_no = prod_no;
  }

  private String additional_images;
  private String prod_no;

  //나중에지울것들 customer테이블에서 가져온거
  private int height;
  private int weight;
  private String profile_image;

  public int getHeight() {
    return height;
  }

  public void setHeight(int height) {
    this.height = height;
  }

  public int getWeight() {
    return weight;
  }

  public void setWeight(int weight) {
    this.weight = weight;
  }

  public String getProfile_image() {
    return profile_image;
  }

  public void setProfile_image(String profile_image) {
    this.profile_image = profile_image;
  }

  public String getAdditional_images() {
    return additional_images;
  }

  public void setAdditional_images(String additional_images) {
    this.additional_images = additional_images;
  }

  public boolean isLiked() {
    return liked;
  }




  public void setLiked(boolean liked) {
    this.liked = liked;
  }

  public String getBname() {
    return bname;
  }

  public void setBname(String bname) {
    this.bname = bname;
  }

  public int getCus_no() {
    return cus_no;
  }

  public void setCus_no(int cus_no) {
    this.cus_no = cus_no;
  }

  // Getter 및 Setter
  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getNickname() {
    return nickname;
  }

  public void setNickname(String nickname) {
    this.nickname = nickname;
  }

  public String getGender() {
    return gender;
  }

  public void setGender(String gender) {
    this.gender = gender;
  }

  public String getSeason() {
    return season;
  }

  public void setSeason(String season) {
    this.season = season;
  }

  public String getStyle() {
    return style;
  }

  public void setStyle(String style) {
    this.style = style;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public String getSnapshot_image() { // 메서드 이름 변경
    return snapshot_image;
  }

  public void setSnapshot_image(String snapshot_image) { // 메서드 이름 변경
    this.snapshot_image = snapshot_image;
  }

  public int getLikeCount() {
    return likeCount;
  }

  public void setLikeCount(int likeCount) {
    this.likeCount = likeCount;
  }

  public String getWriteDate() {
    return writeDate;
  }

  public void setWriteDate(String writeDate) {
    this.writeDate = writeDate;
  }

  public int getIsDel() {
    return isDel;
  }

  public void setIsDel(int isDel) {
    this.isDel = isDel;
  }
}

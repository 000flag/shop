package user.vo.snap;

public class CustomerVO {
  private String id, grade_code, cus_id, cus_pw, name, nickname, gender, birth_date, phone, email, weight, height, total, expire_date, is_del;
  private String profile_image;
  String customer_id,following_id,follower_count;

  public String getFollower_count() {
    return follower_count;
  }

  public void setFollower_count(String follower_count) {
    this.follower_count = follower_count;
  }

  public String getFollowing_id() {
    return following_id;
  }

  public void setFollowing_id(String following_id) {
    this.following_id = following_id;
  }

  public String getCustomer_id() {
    return customer_id;
  }

  public void setCustomer_id(String customer_id) {
    this.customer_id = customer_id;
  }

  public String getId() {
    return id;
  }

  public String getProfile_image() {
    return profile_image;
  }

  public void setProfile_image(String profile_image) {
    this.profile_image = profile_image;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getGrade_code() {
    return grade_code;
  }

  public void setGrade_code(String grade_code) {
    this.grade_code = grade_code;
  }

  public String getCus_id() {
    return cus_id;
  }

  public void setCus_id(String cus_id) {
    this.cus_id = cus_id;
  }

  public String getCus_pw() {
    return cus_pw;
  }

  public void setCus_pw(String cus_pw) {
    this.cus_pw = cus_pw;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
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

  public String getBirth_date() {
    return birth_date;
  }

  public void setBirth_date(String birth_date) {
    this.birth_date = birth_date;
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

  public String getWeight() {
    return weight;
  }

  public void setWeight(String weight) {
    this.weight = weight;
  }

  public String getHeight() {
    return height;
  }

  public void setHeight(String height) {
    this.height = height;
  }

  public String getTotal() {
    return total;
  }

  public void setTotal(String total) {
    this.total = total;
  }

  public String getExpire_date() {
    return expire_date;
  }

  public void setExpire_date(String expire_date) {
    this.expire_date = expire_date;
  }

  public String getIs_del() {
    return is_del;
  }

  public void setIs_del(String is_del) {
    this.is_del = is_del;
  }
}

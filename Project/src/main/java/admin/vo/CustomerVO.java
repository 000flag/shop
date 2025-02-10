package admin.vo;

public class CustomerVO {
  String id;

  public String getGrade_no() {
    return grade_no;
  }

  public void setGrade_no(String grade_no) {
    this.grade_no = grade_no;
  }

  public CustomerVO(String id) {
    this.id = id;
  }

  public String getGrade_name() {
    return grade_name;
  }

  public void setGrade_name(String grade_name) {
    this.grade_name = grade_name;
  }

  String grade_name;
  String grade_no;
  String cus_id;
  String cus_pw;
  String name;
  String nickname;
  String gender;
  String birth_date;
  String phone;
  String email;
  String profile_image;
  String weight;
  String height;
  String total;
  String grade_expire_date;
  String is_del;

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
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

  public String getProfile_image() {
    return profile_image;
  }

  public void setProfile_image(String profile_image) {
    this.profile_image = profile_image;
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

  public String getGrade_expire_date() {
    return grade_expire_date;
  }

  public void setGrade_expire_date(String grade_expire_date) {
    this.grade_expire_date = grade_expire_date;
  }

  public String getIs_del() {
    return is_del;
  }

  public void setIs_del(String is_del) {
    this.is_del = is_del;
  }


}

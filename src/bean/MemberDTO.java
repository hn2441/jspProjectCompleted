package bean;

public class MemberDTO {
private String id;
private String pw;
private String name;
private String tel;
boolean category;
String salt;
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public String getPw() {
	return pw;
}
public void setPw(String pw) {
	this.pw = pw;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getTel() {
	return tel;
}
public void setTel(String tel) {
	this.tel = tel;
}
public boolean isCategory() {
	return category;
}
public void setCategory(boolean category) {
	this.category = category;
}
public String getSalt() {
	return salt;
}
public void setSalt(String salt) {
	this.salt = salt;
}

}

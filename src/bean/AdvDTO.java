package bean;

public class AdvDTO {
	private int no;
	private String sid;
	private String title;
	private String price;
	private String content;
	private String img;
	
	public AdvDTO() {
	}
	public AdvDTO(String sid, String title, String price, String content, String img) {
		super();
		this.sid = sid;
		this.title = title;
		this.price = price;
		this.content = content;
		this.img = img;
	}


	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	
	
}

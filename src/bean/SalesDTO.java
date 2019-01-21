package bean;

public class SalesDTO {
	private int no;
	private String mid;
	private String sid;
	private int price;
	private String date;
	
	public SalesDTO() {
	}
	
	public SalesDTO(String mid, String sid, int price, String date) {
		super();
		this.mid = mid;
		this.sid = sid;
		this.price = price;
		this.date = date;
	}

	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	
}

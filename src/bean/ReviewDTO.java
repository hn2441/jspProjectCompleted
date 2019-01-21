package bean;

public class ReviewDTO {
	private int no;
	private String mid;
	private String sid;
	private int adno;
	private String content;
	private int starsc;
	private String date;
	
	public ReviewDTO() {
	}
	public ReviewDTO(String mid, String sid, int adno, String content, int starsc, String date) {
		super();
		this.mid = mid;
		this.sid = sid;
		this.adno = adno;
		this.content = content;
		this.starsc = starsc;
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
	
	public int getAdno() {
		return adno;
	}
	public void setAdno(int adno) {
		this.adno = adno;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public int getStarsc() {
		return starsc;
	}
	public void setStarsc(int starsc) {
		this.starsc = starsc;
	}
	public String getDate() {
		return date;
	}
	void setDate(String date) {
		this.date = date;
	}
	
	
	
}

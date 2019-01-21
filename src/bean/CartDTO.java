package bean;

public class CartDTO {
	private String Id;
	private int adno;
	private String date;
	
	public CartDTO() {
	}
	public CartDTO(String Id, int adno,String date) {
		super();
		this.Id = Id;
		this.adno = adno;
		this.date = date;
	}

	public String getId() {
		return Id;
	}
	public void setId(String Id) {
		this.Id = Id;
	}
	
	public int getAdno() {
		return adno;
	}
	public void setAdno(int adno) {
		this.adno = adno;
	}
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}

	
	
	
}

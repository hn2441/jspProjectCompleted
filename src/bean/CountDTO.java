package bean;

import java.sql.Date;

public class CountDTO {
 Date VisitDate;
 int count;


public Date getVisitDate() {
	return VisitDate;
}
public void setVisitDate(Date visitDate) {
	VisitDate = visitDate;
}
public int getCount() {
	return count;
}
public void setCount(int count) {
	this.count = count;
}
}

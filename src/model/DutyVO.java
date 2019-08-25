package model;

import java.sql.Date;

public class DutyVO {
	private int Id;
	private String title;
	private String etc;
	private Date createDate;
	
	
	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "DutyVO [Id=" + Id + ", title=" + title + ", etc=" + etc + ", createDate=" + createDate + "]";
	}

	
	

	
}

package model;

import java.util.Date;

public class BoardBookVO {
	private int Id;
	private String memberId;
	private String memberNm;
	private String title;
	private String bookName;
	private String price;
	private String pchURL;
	private Date regDate;
	private String formatDate;
	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberNm() {
		return memberNm;
	}
	public void setMemberNm(String memberNm) {
		this.memberNm = memberNm;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getPchURL() {
		return pchURL;
	}
	public void setPchURL(String pchURL) {
		this.pchURL = pchURL;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getFormatDate() {
		return formatDate;
	}
	public void setFormatDate(String formatDate) {
		this.formatDate = formatDate;
	}
	
	
	
	
}

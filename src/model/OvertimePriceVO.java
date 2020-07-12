package model;

import java.sql.Date;

public class OvertimePriceVO {
	private int Id;
	private String cardType;
	private String memberId;
	private String memberNm;
	private String content;
	private String targetMbrId;
	private String targetMbrNm;
	private int price;
	private String cardHolder;
	private Date useDate;
	private Date updateDate;
	
	
	public String getCardType() {
		return cardType;
	}
	public void setCardType(String cardType) {
		this.cardType = cardType;
	}
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTargetMbrId() {
		return targetMbrId;
	}
	public void setTargetMbrId(String targetMbrId) {
		this.targetMbrId = targetMbrId;
	}
	public String getTargetMbrNm() {
		return targetMbrNm;
	}
	public void setTargetMbrNm(String targetMbrNm) {
		this.targetMbrNm = targetMbrNm;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getCardHolder() {
		return cardHolder;
	}
	public void setCardHolder(String cardHolder) {
		this.cardHolder = cardHolder;
	}
	public Date getUseDate() {
		return useDate;
	}
	public void setUseDate(Date useDate) {
		this.useDate = useDate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	@Override
	public String toString() {
		return "OvertimePriceVO [Id=" + Id + ", cardType=" + cardType + ", memberId=" + memberId + ", memberNm="
				+ memberNm + ", content=" + content + ", targetMbrId=" + targetMbrId + ", targetMbrNm=" + targetMbrNm
				+ ", price=" + price + ", cardHolder=" + cardHolder + ", useDate=" + useDate + ", updateDate="
				+ updateDate + "]";
	}
   
	
	
}

package model;

import java.sql.Date;


public class TrafficPriceVO {
	private int Id;
	private String memberId;
	private String cardType;
	private String memberNm;
	private String content;
	private String departure;
	private String destination;
	private String departureTime;
	private String destinationTime;
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
	public String getDeparture() {
		return departure;
	}
	public void setDeparture(String departure) {
		this.departure = departure;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public String getDepartureTime() {
		return departureTime;
	}
	public void setDepartureTime(String departureTime) {
		this.departureTime = departureTime;
	}
	public String getDestinationTime() {
		return destinationTime;
	}
	public void setDestinationTime(String destinationTime) {
		this.destinationTime = destinationTime;
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
		return "TrafficPriceVO [Id=" + Id + ", memberId=" + memberId + ", cardType=" + cardType + ", memberNm="
				+ memberNm + ", content=" + content + ", departure=" + departure + ", destination=" + destination
				+ ", departureTime=" + departureTime + ", destinationTime=" + destinationTime + ", useDate=" + useDate
				+ ", updateDate=" + updateDate + "]";
	}
	
}

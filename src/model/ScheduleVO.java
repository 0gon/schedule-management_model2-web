package model;

import java.sql.Date;

public class ScheduleVO {
	private int Id;
	private int memberId;
	private int dutyId;
	private Date startDate;
	private Date endDate;
	private String content;
	private String startWorkTime;
	private String endWorkTime;
	private UserVO userVO;
	private DutyVO dutyVO;
	
	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
	}
	public int getMemberId() {
		return memberId;
	}
	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	public int getDutyId() {
		return dutyId;
	}
	public void setDutyId(int dutyId) {
		this.dutyId = dutyId;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public UserVO getUserVO() {
		return userVO;
	}
	public void setUserVO(UserVO userVO) {
		this.userVO = userVO;
	}
	public DutyVO getDutyVO() {
		return dutyVO;
	}
	public void setDutyVO(DutyVO dutyVO) {
		this.dutyVO = dutyVO;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStartWorkTime() {
		return startWorkTime;
	}
	public void setStartWorkTime(String startWorkTime) {
		this.startWorkTime = startWorkTime;
	}
	public String getEndWorkTime() {
		return endWorkTime;
	}
	public void setEndWorkTime(String endWorkTime) {
		this.endWorkTime = endWorkTime;
	}
	@Override
	public String toString() {
		return "ScheduleVO [Id=" + Id + ", memberId=" + memberId + ", dutyId=" + dutyId + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", content=" + content + ", startWorkTime=" + startWorkTime
				+ ", endWorkTime=" + endWorkTime + ", userVO=" + userVO + ", dutyVO=" + dutyVO + "]";
	}
	
	
	
	

	
	

	
}

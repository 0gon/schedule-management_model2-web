package model;

public class AlterDateVO {

	private int Id;
	private int memberId;
	private int dutyId;
	private String workingDate;
	private String holidayDate;
	
	
	private UserVO userVO;
	private DutyVO dutyVO;
	
	private String content2;
	
	
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
	
	
	
	public int getId() {
		return Id;
	}
	public void setId(int Id) {
		this.Id = Id;
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
	public void setDutyId(int DutyId) {
		this.dutyId = dutyId;
	}
	
	
	public String getWorkingDate() {
		return workingDate;
	}
	public void setWorkingDate(String workingDate) {
		this.workingDate = workingDate;
	}
	
	public String getHolidayDate() {
		return holidayDate;
	}
	public void setHolidayDate(String holidayDate) {
		this.holidayDate = holidayDate;
	}
	
	public String getContent2() {
		return content2;
	}
	public void setContent2(String content2) {
		this.content2 = content2;
	}
	
	
	
	@Override
	public String toString() {
		return "ScheduleVO [Id=" + Id + ", memberId=" + memberId + ", dutyId=" + dutyId + ", workingDate=" + workingDate
				+ ", holidayDate=" + holidayDate + ", userVO=" + userVO + ", dutyVO=" + dutyVO + ", content2=" + content2 +"]";
	}
	
	
	
}


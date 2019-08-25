package model;



public class UserVO {
	private int Id;
	private String memberId;
	//@NotEmpty
	//@Pattern(regexp="(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$%^&+=])(?=\\S+$).{5,}")	
	private String memberPwd;
	//@NotEmpty
	//@Length(min=3)
	private String memberNm;
	private int dptNo;
	private int grade;
	private String createDate;
	
	
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
	public String getMemberPwd() {
		return memberPwd;
	}
	public void setMemberPwd(String memberPwd) {
		this.memberPwd = memberPwd;
	}
	public String getMemberNm() {
		return memberNm;
	}
	public void setMemberNm(String memberNm) {
		this.memberNm = memberNm;
	}
	public int getDptNo() {
		return dptNo;
	}
	public void setDptNo(int dptNo) {
		this.dptNo = dptNo;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "UserVO [Id=" + Id + ", memberId=" + memberId + ", memberPwd=" + memberPwd + ", memberNm=" + memberNm
				+ ", dptNo=" + dptNo + ", grade=" + grade + ", createDate=" + createDate + "]";
	}
	
}

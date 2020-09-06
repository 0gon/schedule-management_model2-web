package model;
import java.util.Date;
public class BoardAllVO {
	private int Id;
	private String boardId;
	private String memberId;
	private String memberNm;
	private String title;
	private String content;
	private Date regDate;
	private String formatDate;
	private int cmtCnt;
	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
	}
	public String getBoardId() {
		return boardId;
	}
	public void setBoardId(String boardId) {
		this.boardId = boardId;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public int getCmtCnt() {
		return cmtCnt;
	}
	public void setCmtCnt(int cmtCnt) {
		this.cmtCnt = cmtCnt;
	}
	@Override
	public String toString() {
		return "BoardALLVO [Id=" + Id + ", boardId=" + boardId + ", memberId=" + memberId + ", memberNm=" + memberNm
				+ ", title=" + title + ", content=" + content + ", regDate=" + regDate + ", formatDate=" + formatDate
				+ ", cmtCnt=" + cmtCnt + "]";
	}
	
}

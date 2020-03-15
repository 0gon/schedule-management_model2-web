package model;

import java.util.Date;

public class CommentVO {
	private int Id;
	private String memberId;
	private String boardId;
	private String memberNm;
	private String content;
	private Date regDate;
	private String formatDate;
	
	public String getFormatDate() {
		return formatDate;
	}
	public void setFormatDate(String formatDate) {
		this.formatDate = formatDate;
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
	public String getBoardId() {
		return boardId;
	}
	public void setBoardId(String boardId) {
		this.boardId = boardId;
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
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "CommentVO [Id=" + Id + ", memberId=" + memberId + ", boardId=" + boardId + ", memberNm=" + memberNm
				+ ", content=" + content + ", regDate=" + regDate + ", formatDate=" + formatDate + "]";
	}
	
}

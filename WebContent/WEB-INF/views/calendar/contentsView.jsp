<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="w3-modal-content w3-light-grey w3-card-4"
	style="max-width: 400px;">
	<div class="w3-container w3-center w3-teal" style="height: 38px">
	<div style="margin-top:4px">
	<font size=5>일정 보기</font>
	</div>
	</div>
	<div class="w3-container w3-padding">
		<span
			onclick="document.getElementById('message').style.display='none'; document.getElementById('startdate').value=''; document.getElementById('enddate').value='';location.reload(); "
			class="w3-button w3-display-topright">&times;</span>

		<div class="calendarForm w3-center  w3-container w3-padding"
			id="modal">
			<form id="userinput">
				<table class="w3-table w3-bordered">
					<tr>
						<td style="width: 30%;"><label>제목</label></td>
					 	<td>${schedule.dutyVO.title}</td> 
					</tr>
					<tr>
						<td style="width: 30%;"><label>상세</label></td>
					 	<td>${schedule.content}</td> 
					</tr>
					<tr>
						<td><label>시작일</label></td>
						<td>${schedule.startDate}</td>
					</tr>
					<tr>
						<td><label>종료일</label></td>
						<td>${schedule.endDate}</td>
					</tr>

				</table>
				<div style="margin-top:10px">
				<c:if test="${schedule.content!='책임당직'}">
					<button class="w3-button w3-border" onclick="toUpdatePage(${schedule.id});">수정</button>
				</c:if>
				<input type="reset" class="w3-button w3-red"
					onclick="deleteScheduleIncludeHoli(${schedule.id},${userVO.id});" value="삭제">
				<button onclick="document.getElementById('message').style.display='none';event.preventDefault();location.reload();"
               class="w3-button w3-border">취소</button>	
				</div>

			</form>
		</div>
	</div>
</div>

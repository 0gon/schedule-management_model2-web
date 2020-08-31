<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="w3-container w3-display-middle" style="width:550px;">
  <div class="w3-container w3-white">
       <h6>회원등록</h6>
      </div>
    <div class="w3-card-4 ">
      <div class="w3-container " style="overflow:auto; height:500px;  background: rgba(241, 241, 241, 0.75); ">
<div class="w3-container  w3-margin-top">
<form method="post"  id="createForm">
<table class="w3-table">
<tr>
	<td><label>아이디 : </label></td>
	<td><input type="text" placeholder="ex) L23074"  class="w3-input" name = "memberId" style="width:120px;display: inline;">
 </td>
</tr>
<tr>
	<td><label>이 름 : </label></td>
	<td><input type="text" placeholder="ex) 송영곤" class="w3-input" name = "memberNm" style="width:100px;display: inline;"></td>
</tr>
<tr> 
	<td><label>암 호 :</label></td>
	<td><input type="text" placeholder="password" class="w3-input" name = "memberPwd" style="width:100px;display: inline;"></td>
</tr>
<tr> 
	<td><label>부 서 : </label></td>
	<td>
	<select name="dptNo" class="w3-select" style="width:100px;padding:6px;">
     
     </select>
     </td>
</tr> 
<tr>
	<td><label>권 한 : </label></td>
	<td>
	<select id="grade_${member.id}" name="grade" class="w3-select" style="width:100px;padding:6px;">
	            <option value="0" selected="selected">일반</option>
	           <!--   <option value="1" >관리자</option>-->
	            <option value="2" >파트장</option>
				<!--  <option value="3" >슈퍼관리자</option>-->
     </select> 
	</td> 
</tr>
<tr>
	<td><label>연 차 : </label></td>
	<td><input type="text" placeholder="0.0" id="monthHoliday_${member.id}"class="w3-input" name="monthHoliday" style="width:50px;display: inline;"> 개</td>
</tr>
<tr>
	<td><label>대체휴무 : </label></td>
	<td><input type="text" placeholder="0.0" id="alterHoliday_${member.id}" class="w3-input" name="alterHoliday" style="width:50px;display: inline;"> 개</td>
</tr>
<tr>
	<td><label>하계휴가: </label></td>
	<td><input type="text" placeholder="0" id="holiday_${member.id}" class="w3-input" name="holiday" style="width:50px;display: inline;"> 개</td>
</tr>
</table>
<div class="w3-center w3-padding">
     	<button class="w3-button w3-teal" onclick="createMember()"type="submit">등록</button> 
     	<button class="w3-button w3-red" type="reset">다시작성</button> 
</div>
     	</form> 
</div>
		</div>
      </div>
    </div>
  
</body>
</html>
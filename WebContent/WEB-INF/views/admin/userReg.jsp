<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="w3-container w3-display-middle" style="width:600px;">
  <div class="w3-container w3-white">
       <h6>회원등록</h6>
      </div>
    <div class="w3-card-4 w3-padding-large">
      <div class="w3-container " style="overflow:auto; height:600px;  background: rgba(241, 241, 241, 0.75); ">
<div class="w3-container  w3-margin-top">
     <input type="text" class="w3-input" name = "memberId">
     <input type="text" class="w3-input" name = "memberNm">
     <input type="text" class="w3-input" name = "memberPwd">
     
     <select name="dptNo" class="w3-select" style="width:100px;padding:6px;">
      	 <c:forEach var="dpt" items="${dptList}">
  	        	<c:if test="${dpt.title!='관리자'}">
		            <option value="${dpt.id}">${dpt.title}</option>
   	        	</c:if>
      	 </c:forEach>
     </select>
     
	      	<select id="grade_${member.id}" name="grade" class="w3-select" style="width:100px;padding:6px;">
	            <option value="0" selected="selected">일반</option>
	            <option value="1" >관리자</option>
	            <option value="2" >파트장</option>
	            <option value="3" >슈퍼관리자</option>
	        </select>
       	
      	<input type="text" id="monthHoliday_${member.id}"class="w3-input" name="monthHoliday" style="width:50px;" 
      	>
      	<input type="text" id="alterHoliday_${member.id}" class="w3-input" name="alterHoliday" style="width:50px;" 
      	>
      	<input type="text" id="holiday_${member.id}" class="w3-input" name="holiday" style="width:50px;" 
      	>
</div>

          
		</div>
      </div>
    </div>
</body>
</html>
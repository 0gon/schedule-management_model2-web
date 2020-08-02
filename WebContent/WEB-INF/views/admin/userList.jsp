<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="w3-container w3-display-middle" style="width:1200px;">
  <div class="w3-container w3-white">
       <h6>회원수  (총 : ${count })명</h6>
      </div>
    <div class="w3-card-4 w3-padding-large">
      <div class="w3-container " style="overflow:auto; height:600px;  background: rgba(241, 241, 241, 0.75); ">
<div class="w3-container  w3-margin-top">
	    <c:if test="${count==0 }">
			<div class="w3-center w3-padding-top">
			<table class="w3-table table-bordered w3-center" width="100%">
			<tr  >
			<td class="w3-center w3-padding"><br>
			<span class="w3-tag w3-white w3-border">저장된 글이 없습니다.</span><br><br></td>
			</tr>
			</table>
			</div>
		</c:if>
    
       	<c:if test="${count>0}">
       	<table class="w3-table  w3-centered" style="border:black; ">
		    <tr class="w3-black">
		      <th class="w3-center" >No.</th>
		      <th class="w3-center" >아이디</th>
		      <th class="w3-center" >암호</th>
		      <th class="w3-center">이름</th>
		      <th class="w3-center">부서명</th>
		      <th class="w3-center">등급</th>
		      <th class="w3-center">사용여부</th>
		      <th class="w3-center">등록일</th>
		    </tr>
    
     <c:forEach var="member" items="${members}">
     <tr id="board2_List" class="w3-hover-white" onclick="goContent()">
      <td class="w3-center" width="50">${number}</td>
         <c:set var="number" value="${number-1}"/>
      <td>${member.memberId}</td>
      <td>${member.memberPwd}</td>
       <td>${member.memberNm}</td>
      <td>${member.dptNo}</td>
      <td>${member.grade}</td>
       <td>${member.useyn}</td>
       <td>${member.createDate}</td>
    </tr>
    </c:forEach>   
  </table>
     </c:if>
      
      
</div>


  <!-- Pagination -->

      <c:if test="${count>0 }">
       <div class="w3-center w3-padding-16">
    <div class="w3-bar">
         <c:if test="${startPage>bottomLine }">
            <a href="userList?pageNum=${startPage-bottomLine}" class="w3-bar-item w3-button w3-hover-black">«</a>            
            
         </c:if>
         
         <c:forEach var="i" begin="${startPage }" end="${endPage }">
      
               
               <!-- pageNum넘김 -->
               <c:if test="${i!=currentPage }">
                    <a href="userList?pageNum=${i }" class="w3-bar-item w3-button w3-hover-black">${i }</a>
               </c:if>
               <c:if test="${i==currentPage }">
                  <a href="userList?pageNum=${i }" class="w3-bar-item w3-button w3-hover-black">${i }</a>                
               </c:if>
         </c:forEach>
            
            <c:if test="${endPage<pageCount}">
         
               <a href="userList?pageNum=${startPage+bottomLine}"class="w3-bar-item w3-button w3-hover-black">»</a> 
            </c:if>

   </div>
   </div>
         </c:if>
          
</div>
      </div>
    </div>
</body>
</html>
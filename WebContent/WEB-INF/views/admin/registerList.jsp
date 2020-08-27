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
	<!-- 상단바 -->
  <div class="w3-bar w3-teal">  
    <button class="w3-bar-item w3-button tablink w3-red" onclick="openCity(event,'London')">교통비</button>
    <button class="w3-bar-item w3-button tablink" onclick="openCity(event,'Paris')">야근식대</button>
  </div>
  <!-- end -->
  <div  class="w3-container w3-white">
       <h6>건수  (총 : ${count })건</h6>
      </div> 
    <div class="w3-card-4 city" id="London" >
      <div class="w3-container " style="overflow:auto; height:500px;  background: rgba(241, 241, 241, 0.75); ">
<div class="w3-container  w3-margin-top">

	    <c:if test="${count==0 }">
			<div class="w3-center w3-padding-top">
			<table class="w3-table table-bordered w3-center" width="100%">
			<tr  >
			<td class="w3-center w3-padding"><br>
			<span class="w3-tag w3-white w3-border">저장된 내역이 없습니다.</span><br><br></td>
			</tr>
			</table>
			</div>
		</c:if>
    
       	<c:if test="${count>0}">
       	<table class="w3-table  w3-centered" style="border:black; ">
		    <tr class="w3-black">
		      <th class="w3-center" >No.</th>
		      <th class="w3-center" >일자</th>
		      <th class="w3-center">이름</th>
		      <th class="w3-center">용무</th>
		      <th class="w3-center">출발지</th>
		      <th class="w3-center">도착지</th>
		      <th class="w3-center">출발시간</th>
		      <th class="w3-center">도착시간</th>
		      <th class="w3-center">교통비</th>
		    </tr>
     <c:forEach var="member" items="${membersLi}">
     <tr  class="w3-hover-white" >
      <td class="w3-center" width="50">${number}</td>
         <c:set var="number" value="${number-1}"/>
      <td class="w3-center">
      	<input type="text" class="w3-input" id="memberId_${member.id}"name="memberId" style="width:100px;height:30px" value="${member.memberId}">
      </td> 
      <td class="w3-center">
      	<input type="text" class="w3-input" id="memberPwd_${member.id}" name="memberPwd" style="width:100px;height:30px" value="${member.memberPwd}">
      </td>
       <td>
        <input type="text" class="w3-input" id="memberNm_${member.id}" name="memberNm" style="width:80px;height:30px" value="${member.memberNm}">
       
       </td>
      <td> 
      	  	<select name="dptNo" id="dptNo_${member.id}"class="w3-select" style="width:100px;padding:6px;">
      	  	<option value="${member.dptVO.id}" selected="selected">${member.dptVO.title}</option>
      	 <c:forEach var="dpt" items="${dptList}">
  	        	<c:if test="${dpt.title!='관리자'}">
		            <option value="${dpt.id}">${dpt.title}</option>
   	        	</c:if>
      	 </c:forEach>
	        </select>
      
      </td>
      <td>
      <!-- 
      	0: 일반
      	1: 관리자
      	2: 파트장
      	3: 슈퍼관리자
       --> 
       	<c:if test="${member.grade==0}">
	      	<select id="grade_${member.id}" name="grade" class="w3-select" style="width:100px;padding:6px;">
	            <option value="0" selected="selected">일반</option>
	            <option value="1" >관리자</option>
	            <option value="2" >파트장</option>
	            <option value="3" >슈퍼관리자</option>
	        </select>
       	</c:if>
       	<c:if test="${member.grade==1}">
	      	<select id="grade_${member.id}" name="grade" class="w3-select" style="width:100px;padding:6px;">
	            <option value="0" >일반</option>
	            <option value="1" selected="selected">관리자</option>
	            <option value="2" >파트장</option>
	            <option value="3" >슈퍼관리자</option>
	        </select>
       	</c:if> 
       	<c:if test="${member.grade==2}">
	      	<select id="grade_${member.id}" name="grade" class="w3-select" style="width:100px;padding:6px;">
	            <option value="0" >일반</option>
	            <option value="1" >관리자</option>
	            <option value="2" selected="selected">파트장</option>
	            <option value="3" >슈퍼관리자</option>
	        </select>
       	</c:if>
       	<c:if test="${member.grade==3}">
	      	<select id="grade_${member.id}" name="grade" class="w3-select" style="width:100px;padding:6px;">
	            <option value="0" >일반</option>
	            <option value="1" >관리자</option>
	            <option value="2" >파트장</option>
	            <option value="3" selected="selected">슈퍼관리자</option>
	        </select>
       	</c:if>
      </td>
          
      <td>
      	<input type="text" id="monthHoliday_${member.id}"class="w3-input" name="monthHoliday" style="width:50px;height:30px" 
      	value="${member.monthHoliday}">
      </td> 
      <td>
      	<input type="text" id="alterHoliday_${member.id}" class="w3-input" name="alterHoliday" style="width:50px;height:30px" 
      	value="${member.alterHoliday}">
      </td>
      <td>
      	<input type="text" id="holiday_${member.id}" class="w3-input" name="holiday" style="width:50px;height:30px" 
      	value="${member.holiday}">
      </td> 
       <td>
       <!--  0: 미사용, 1: 사용 -->
      
       	<c:if test="${member.useyn==1}">
	       <select id="useYn_${member.id}" name="useYn" class="w3-select" style="width:70px;padding:6px;">
				<option value="1" selected="selected">사용</option>	       
				<option value="0">미사용</option>	       
	       </select>
       	</c:if>
       	<c:if test="${member.useyn==0}">
	       <select id="useYn_${member.id}" name="useYn" class="w3-select" style="width:70px;padding:6px;">
				<option value="1">사용</option>	       
				<option value="0" selected="selected">미사용</option>	       
	       </select>
       	</c:if>
       </td>
       <td>
       <!-- 	<button class="w3-button w3-red" onclick="deleteMember(${member.id})">삭제</button>&nbsp; -->
       	<button class="w3-button w3-teal" onclick="updateMember('${member.id}')">수정</button>
       </td>
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
      
      <div id="Paris" class="w3-card-4 city" style="display:none">
      <div class="w3-container " style="overflow:auto; height:500px;  background: rgba(241, 241, 241, 0.75); ">
<div class="w3-container  w3-margin-top">

	    <c:if test="${count==0 }">
			<div class="w3-center w3-padding-top">
			<table class="w3-table table-bordered w3-center" width="100%">
			<tr  >
			<td class="w3-center w3-padding"><br>
			<span class="w3-tag w3-white w3-border">저장된 내역이 없습니다.</span><br><br></td>
			</tr>
			</table>
			</div>
		</c:if>
    
       	<c:if test="${count>0}">
       	<table class="w3-table  w3-centered" style="border:black; ">
		    <tr class="w3-black">
		      <th class="w3-center" >No.</th>
		      <th class="w3-center" >일자</th>
		      <th class="w3-center">등록인</th>
		      <th class="w3-center">동행인</th>
		      <th class="w3-center">내용</th>
		      <th class="w3-center">금액</th>
		      <th class="w3-center">음식점</th>
		      <th class="w3-center">카드소지자</th>
		    </tr>
     <c:forEach var="member" items="${membersLi}">
     <tr  class="w3-hover-white" >
      <td class="w3-center" width="50">${number}</td>
         <c:set var="number" value="${number-1}"/>
      <td class="w3-center">
      	<input type="text" class="w3-input" id="memberId_${member.id}"name="memberId" style="width:100px;height:30px" value="${member.memberId}">
      </td> 
      <td class="w3-center">
      	<input type="text" class="w3-input" id="memberPwd_${member.id}" name="memberPwd" style="width:100px;height:30px" value="${member.memberPwd}">
      </td>
       <td>
        <input type="text" class="w3-input" id="memberNm_${member.id}" name="memberNm" style="width:80px;height:30px" value="${member.memberNm}">
       
       </td>
      <td> 
      	  	<select name="dptNo" id="dptNo_${member.id}"class="w3-select" style="width:100px;padding:6px;">
      	  	<option value="${member.dptVO.id}" selected="selected">${member.dptVO.title}</option>
      	 <c:forEach var="dpt" items="${dptList}">
  	        	<c:if test="${dpt.title!='관리자'}">
		            <option value="${dpt.id}">${dpt.title}</option>
   	        	</c:if>
      	 </c:forEach>
	        </select>
      
      </td>
      <td>
      <!-- 
      	0: 일반
      	1: 관리자
      	2: 파트장
      	3: 슈퍼관리자
       --> 
       	<c:if test="${member.grade==0}">
	      	<select id="grade_${member.id}" name="grade" class="w3-select" style="width:100px;padding:6px;">
	            <option value="0" selected="selected">일반</option>
	            <option value="1" >관리자</option>
	            <option value="2" >파트장</option>
	            <option value="3" >슈퍼관리자</option>
	        </select>
       	</c:if>
       	<c:if test="${member.grade==1}">
	      	<select id="grade_${member.id}" name="grade" class="w3-select" style="width:100px;padding:6px;">
	            <option value="0" >일반</option>
	            <option value="1" selected="selected">관리자</option>
	            <option value="2" >파트장</option>
	            <option value="3" >슈퍼관리자</option>
	        </select>
       	</c:if> 
       	<c:if test="${member.grade==2}">
	      	<select id="grade_${member.id}" name="grade" class="w3-select" style="width:100px;padding:6px;">
	            <option value="0" >일반</option>
	            <option value="1" >관리자</option>
	            <option value="2" selected="selected">파트장</option>
	            <option value="3" >슈퍼관리자</option>
	        </select>
       	</c:if>
       	<c:if test="${member.grade==3}">
	      	<select id="grade_${member.id}" name="grade" class="w3-select" style="width:100px;padding:6px;">
	            <option value="0" >일반</option>
	            <option value="1" >관리자</option>
	            <option value="2" >파트장</option>
	            <option value="3" selected="selected">슈퍼관리자</option>
	        </select>
       	</c:if>
      </td>
          
      <td>
      	<input type="text" id="monthHoliday_${member.id}"class="w3-input" name="monthHoliday" style="width:50px;height:30px" 
      	value="${member.monthHoliday}">
      </td> 
      <td>
      	<input type="text" id="alterHoliday_${member.id}" class="w3-input" name="alterHoliday" style="width:50px;height:30px" 
      	value="${member.alterHoliday}">
      </td>
      <td>
      	<input type="text" id="holiday_${member.id}" class="w3-input" name="holiday" style="width:50px;height:30px" 
      	value="${member.holiday}">
      </td> 
       <td>
       <!--  0: 미사용, 1: 사용 -->
      
       	<c:if test="${member.useyn==1}">
	       <select id="useYn_${member.id}" name="useYn" class="w3-select" style="width:70px;padding:6px;">
				<option value="1" selected="selected">사용</option>	       
				<option value="0">미사용</option>	       
	       </select>
       	</c:if>
       	<c:if test="${member.useyn==0}">
	       <select id="useYn_${member.id}" name="useYn" class="w3-select" style="width:70px;padding:6px;">
				<option value="1">사용</option>	       
				<option value="0" selected="selected">미사용</option>	       
	       </select>
       	</c:if>
       </td>
       <td>
       <!-- 	<button class="w3-button w3-red" onclick="deleteMember(${member.id})">삭제</button>&nbsp; -->
       	<button class="w3-button w3-teal" onclick="updateMember('${member.id}')">수정</button>
       </td>
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
    
    <script>
function openCity(evt, cityName) {
  var i, x, tablinks;
  x = document.getElementsByClassName("city");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < x.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" w3-red", "");
  }
  document.getElementById(cityName).style.display = "block";
  evt.currentTarget.className += " w3-red";
}
</script>
</body>
</html>
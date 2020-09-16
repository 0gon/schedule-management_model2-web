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
    <div class="w3-card-4 city" id="London" >
  <div  class=" w3-white" style="padding:5px">
        <div class="w3-left w3-padding" style="display:inline;"> 
	       ${currentMonth}월<font color="red"> 교통비 </font>건수  (총 ${count_t } 건)
       </div>
       <div class="w3-margin-left" style="display:inline;"> 
        <select class="w3-select " style="width:100px;padding:6px;">
     	  	<option selected="selected">--년도--</option>
     	  	<option >${currentYear }</option>
     	  	<option >${previousOneYear }</option>
     	  	<option >${previousTwoYear }</option>
     	  	<option >${previousThreeYear }</option>
        </select>
        <select class="w3-select " style="width:70px;padding:6px;">
     	  	<option selected="selected">--월--</option>
     	  	<option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option>
     	  	<option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option>
     	  	<option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>
        </select>
    	   <button class="w3-button w3-border " style="padding:5px">바로가기</button>
       </div>
       <div class="w3-right" style="display:inline;">
	       <button class="w3-button w3-green w3-border" style="padding:5px">엑셀로 저장</button>
       </div>
       
       
       
      </div> 
      <div class="w3-container " style="overflow:auto; height:500px;  background: rgba(241, 241, 241, 0.75); ">
<div class="w3-container  w3-margin-top">

	    <c:if test="${count_t==0 }">
			<div class="w3-center w3-padding-top">
			<table class="w3-table table-bordered w3-center" width="100%">
			<tr  >
			<td class="w3-center w3-padding"><br>
			<span class="w3-tag w3-white w3-border">저장된 내역이 없습니다.</span><br><br></td>
			</tr>
			</table>
			</div>
		</c:if>
    
       	<c:if test="${count_t>0}">
       	<table class="w3-table  w3-centered" style="border:black; ">
		    <tr class="w3-black">
		      <th class="w3-center">이용일자</th>
		      <th class="w3-center">교통편</th>
		      <th class="w3-center">이름</th>
		      <th class="w3-center">용무</th>
		      <th class="w3-center">출발지</th>
		      <th class="w3-center">도착지</th>
		      <th class="w3-center">출발시간</th>
		      <th class="w3-center">도착시간</th>
		      <th class="w3-center">교통비</th>
		    </tr>
     <c:forEach var="traffic" items="${traffics}">
     <tr  class="w3-hover-white" >
	      <td>
	      	${traffic.useDate}
	      </td>
	      <td>
	      	${traffic.cardType}
	      </td>
	      <td>
	      	${traffic.memberNm}
	      </td>
	      <td>
	      	${traffic.content}
	      </td>
	      <td>
	      	${traffic.departure}
	      </td> 
	      <td>
	      	${traffic.destination}
	      </td>
	      <td>
	      	${traffic.departureTime}
	      </td> 
	      <td>
	      	${traffic.destinationTime}
	      </td>
	      <td>
	      	${traffic.price} 원
	      </td>
    </tr>
    </c:forEach>   
  </table>
     </c:if>
</div>
		</div>
      </div>
      <div id="Paris" class="w3-card-4 city" style="display:none">
       <div  class=" w3-white" style="padding:5px">
       <div class="w3-left w3-padding" style="display:inline;">
	       ${currentMonth}월<font color="red"> 야근식대 </font>건수  (총 ${count_o } 건)
       </div>
       <div class="w3-margin-left" style="display:inline;"> 
        <select class="w3-select " style="width:100px;padding:6px;">
     	  	<option selected="selected">--년도--</option>
     	  	<option >${currentYear }</option>
     	  	<option >${previousOneYear }</option>
     	  	<option >${previousTwoYear }</option>
     	  	<option >${previousThreeYear }</option>
        </select>
        <select class="w3-select " style="width:70px;padding:6px;">
     	  	<option value="nv" selected="selected">--월--</option>
     	  	<option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option>
     	  	<option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option>
     	  	<option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option>
        </select>
    	   <button class="w3-button w3-border " style="padding:5px">바로가기</button>
       </div>
       <div class="w3-right" style="display:inline;">
	       <button class="w3-button w3-green w3-border" style="padding:5px">엑셀로 저장</button>
       </div>
      </div> 
      <div class="w3-container " style="overflow:auto; height:500px;  background: rgba(241, 241, 241, 0.75); ">
<div class="w3-container  w3-margin-top">

	    <c:if test="${count_o==0 }">
			<div class="w3-center w3-padding-top">
			<table class="w3-table table-bordered w3-center" width="100%">
			<tr  >
			<td class="w3-center w3-padding"><br>
			<span class="w3-tag w3-white w3-border">저장된 내역이 없습니다.</span><br><br></td>
			</tr>
			</table>
			</div>
		</c:if>
    
       	<c:if test="${count_o>0}">
       	<table class="w3-table  w3-centered" style="border:black; ">
		    <tr class="w3-black">
		      <th class="w3-center">사용일자</th>
		      <th class="w3-center">등록인</th>
		      <th class="w3-center">동행인</th>
		      <th class="w3-center">내용</th>
		      <th class="w3-center">음식점</th>
		      <th class="w3-center">카드소지자</th>
		      <th class="w3-center">금액</th>
		    </tr>
     <c:forEach var="overtime" items="${overtimes}">
     <tr class="w3-hover-white">
      <td>
       	${overtime.useDate}
      </td>
      <td> 
       	${overtime.memberNm}
      </td>
      <td>
      <c:if test="${overtime.targetListCount>0}">
       	${overtime.targetListName} (${overtime.targetListCount} 명)
      </c:if>
       <c:if test="${overtime.targetListCount<=0}">
           <font color="grey">-</font>
       </c:if>
      </td>
      <td>
       	${overtime.content}
      </td> 
      <td>
       	${overtime.shopName}
      </td>
      <td>
       	${overtime.cardHolder}
      </td> 
       <td>
       	${overtime.price} 원
       </td>
    </tr>
    </c:forEach>   
  </table>
     </c:if>
      
     
</div>


          
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
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
    <button class="w3-bar-item w3-button tablink w3-red" onclick="openCity(event,'London')">야근식대</button>
    <button class="w3-bar-item w3-button tablink" onclick="openCity(event,'Paris')">교통비</button>
    <form action="${ pageContext.servletContext.contextPath }/page/registerList" method="post">
    <div class="w3-margin-left" style="display:inline;"> 
        <select name="sYear" class="w3-select " style="width:100px;padding:6px;">
     	  	<option id="${currentYear}" value="${currentYear}" >${currentYear }</option>
     	  	<option id="${previousOneYear}" value="${previousOneYear}">${previousOneYear }</option>
     	  	<option id="${previousTwoYear}" value="${previousTwoYear}">${previousTwoYear }</option>
     	  	<option id="${previousThreeYear}" value="${previousThreeYear}">${previousThreeYear }</option>
        </select>
        <select name="sMonth" class="w3-select " style="width:70px;padding:6px;">
     	  	<option id="01" value="01">1월</option><option id="02" value="02">2월</option><option id="03" value="03">3월</option><option id="04" value="04">4월</option>
     	  	<option id="05" value="05">5월</option><option id="06" value="06">6월</option><option id="07" value="07">7월</option><option id="08" value="08">8월</option>
     	  	<option id="09" value="09">9월</option><option id="10" value="10">10월</option><option id="11" value="11">11월</option><option id="12" value="12">12월</option>
        </select>
    	   <button class="w3-button w3-border " style="padding:5px" type="submit">바로가기</button>
       </div>
    </form>
    
    
  </div>
  <!-- end -->
    <div class="w3-card-4 city" id="London" >
       <div  class=" w3-white" style="padding:5px">
	       ${currentMonth}월<font color="red"> 야근식대 </font>건수  (총 ${count_o } 건)&nbsp;&nbsp;
	       <button class="w3-button w3-green w3-border" style="padding:5px">엑셀로 저장</button>
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
		      <th class="w3-center">총 인원</th>
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
       	${overtime.targetListName}
      </c:if>
       <c:if test="${overtime.targetListCount<=0}">
           <font color="grey">-</font>
       </c:if>
      </td>
      <td>
       ${overtime.targetListCount} 명
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
      
       
      <div id="Paris" class="w3-card-4 city" style="display:none">
		<div  class=" w3-white" style="padding:5px">
	       ${currentMonth}월<font color="red"> 교통비 </font>건수  (총 ${count_t } 건)&nbsp;&nbsp;
	       <button class="w3-button w3-green w3-border" style="padding:5px">엑셀로 저장</button>
      </div> 
      <div class="w3-container " style="overflow:auto; height:500px;  background: rgba(241, 241, 241, 0.75); ">
<div class=" w3-margin-top">

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
		      <th class="w3-center">등록일자</th>
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
};
	$(document).ready(function(){
		var currentYear = '${currentYear}';
		var onlyMonth = '${onlyMonth}';
		$('#'+currentYear).attr( 'selected', true );
		$('#'+onlyMonth).attr( 'selected', true );
	});
</script>
</body>
</html>
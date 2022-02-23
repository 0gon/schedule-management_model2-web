<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- !PAGE CONTENT! -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<link rel="stylesheet" href="//mugifly.github.io/jquery-simple-datetimepicker/jquery.simple-dtpicker.css">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap" rel="stylesheet">

<script src="//mugifly.github.io/jquery-simple-datetimepicker/jquery.simple-dtpicker.js"></script>

<script>
	sessionStorage.setItem('temp_day', new Date())</script>

 <style>
	 .ui-timepicker-container{ 
	 	 position: fixed;
	     z-index:1151 !important; 
	}
 </style>
<script>

	function memberDBtoALL() {
		var memberList_ALL = new Array();
		<c:forEach var="member" items="${Allmembers}">
			memberList_ALL.push("${member.memberNm}");
		</c:forEach>
		return memberList_ALL;
	}
	function memberDBtoPOS() {
		var memberList_POS = new Array();
		<c:forEach var="member" items="${POSmembers}">
			var memberVO = {
				memberId : "${member.id}",
				memberNm : "${member.memberNm}",
			}
			memberList_POS.push(memberVO);
		</c:forEach>
		return memberList_POS;
	}
	function memberDBtoMD() {
		var memberList_MD = new Array();
		<c:forEach var="member" items="${MDmembers}">
			var memberVO = {
				memberId : "${member.id}",
				memberNm : "${member.memberNm}",
			}
			memberList_MD.push(memberVO);
		</c:forEach>
		return memberList_MD;
	}
	function memberDBtoMKT() {
		var memberList_MKT = new Array();
		<c:forEach var="member" items="${MKTmembers}">
			var memberVO = {
				memberId : "${member.id}",
				memberNm : "${member.memberNm}",
			}
			memberList_MKT.push(memberVO);
		</c:forEach>
		return memberList_MKT;
	}
	function memberDBtoSPT() {
		var memberList_SPT = new Array();
		<c:forEach var="member" items="${SPTmembers}">
			var memberVO = {
				memberId : "${member.id}",
				memberNm : "${member.memberNm}",
			}
			memberList_SPT.push(memberVO);
		</c:forEach>
		return memberList_SPT;
	}
	function memberDBtoINF() {
		var memberList_INF = new Array();
		<c:forEach var="member" items="${INFmembers}">
			var memberVO = {
				memberId : "${member.id}",
				memberNm : "${member.memberNm}",
			}
			memberList_INF.push(memberVO);
		</c:forEach>
		return memberList_INF;
	}
	function memberDBtoGFT() {
		var memberList_GFT = new Array();
		<c:forEach var="member" items="${GFTmembers}">
			var memberVO = {
				memberId : "${member.id}",
				memberNm : "${member.memberNm}",
			}
			memberList_GFT.push(memberVO);
		</c:forEach>
		return memberList_GFT;
	}
	function memberDBtoFIN() {
		var memberList_FIN = new Array();
		<c:forEach var="member" items="${FINmembers}">
			var memberVO = {
				memberId : "${member.id}",
				memberNm : "${member.memberNm}",
			}
			memberList_FIN.push(memberVO);
		</c:forEach>
		return memberList_FIN;
	}
	 
	function buildMemberList (memberListType) {
		var memberList ='<table class="w3-table"><tr>';
	    for(var j=0;j<memberListType.length;j++){
	    	// UI 맞추기 위한 반복문, 한줄에 7명
	    	if(j!=0 && j%7==0){
	    		memberList +='</tr><tr><td class="memberSelector w3-center w3-border w3-button" id="'+memberListType[j].memberId
	    		+'" onclick="memberClick('+memberListType[j].memberId+')">'+memberListType[j].memberNm+'</td>'
	    	}else{
	    		memberList +='<td class="memberSelector w3-center w3-border w3-button" id="'+memberListType[j].memberId
	    		+'" onclick="memberClick('+memberListType[j].memberId+')">'+memberListType[j].memberNm+'</td>'
	    	}
	    }
	    memberList += '</tr>';
	    return memberList
	}
	
	$(function() { 
		//dptNo에 따라 select 담당선택
		var userDpt = "${userVO.dptNo}";
		var userId = "${userVO.id}";
		//영업1담당인 경우
		if(userDpt == 1 || userDpt == 2){
			 areaChange(1);
			 $('#dptchk1').attr("checked", true); 
		}
		//영업2담당인 경우
		else if(userDpt == 0 || userDpt == 5 ){
			 areaChange(2);
			 $('#dptchk2').attr("checked", true); 
		}else {
			areaChange(3);	
			 $('#dptchk3').attr("checked", true); 
		};
		var memberList_POS = memberDBtoPOS();
		var memberList_MD = memberDBtoMD();
		var memberList_MKT = memberDBtoMKT();
		var memberList_SPT = memberDBtoSPT();
		var memberList_INF = memberDBtoINF();
		var memberList_GFT = memberDBtoGFT();
		var memberList_FIN = memberDBtoFIN();
		
	    var POSlist =buildMemberList(memberList_POS);
	    var MDlist =buildMemberList(memberList_MD);
	    var MKTlist =buildMemberList(memberList_MKT);
	    var SPTlist =buildMemberList(memberList_SPT);
	    var INFlist =buildMemberList(memberList_INF);
	    var GFTlist =buildMemberList(memberList_GFT);
	    var FINlist =buildMemberList(memberList_FIN);
		
		
	    $('#POSmembers').append(POSlist);
	    $('#MDmembers').append(MDlist);
	    $('#MKTmembers').append(MKTlist);
	    $('#SPTmembers').append(SPTlist);
	    $('#INFmembers').append(INFlist);
	    $('#GFTmembers').append(GFTlist);
	    $('#FINmembers').append(FINlist);
	    document.getElementById(userId).classList.add('w3-blue');
		$('#selectMemberCount').text("1"); 
		$('#price').val(10000);
	    
	    $('#startTime, #endTime').appendDtpicker({
		    'locale' : 'ko', // 한글화
		    'autodateOnStart' : false, // 초기값 x
		    'timelistScroll' : false, // 시간 자동 스크롤 x
		    'closeOnSelected' : true, // 선택하면 선택창 x
		    'minuteInterval' : 30 // 시간 간격 조절 (m)
    	});
	    
	    $('#message').draggable();
	    
	});
</script>

<div class="w3-main" style="margin-left:100px;margin-top:50px">
  <!-- Header -->
  <header id="portfolio">
    <div >
        <font size="4">법인카드 사용내역 </font>
        <button class="w3-black" style="margin-left:1050px"
        onclick = "document.getElementById('cardList').style.display='block'"
        >카드소지자</button>
       
         <div class=" w3-bottombar">
	        <font size="3">달력에 등록된</font> 
	        <font size="4" color="red">[교통비], [야근식대]</font>
	        <font size="3">를 드래그하여 다른 날짜로 이동가능합니다.</font>
         </div>
        
    <!-- 일정관리에서 법인카드 사용으로 변경_2020.07 -->
    <!-- 
    <div class="w3-padding w3-bottombar">
     <c:if test="${userVO.grade==0}">
     <table>
     	<tr>
     		<td rowspan="2">
		     	<button class="w3-button w3-white w3-border w3-border-red w3-wide"
		     	onclick="startAnim('caution')">주의사항</button>
		     	<button class="w3-button w3-white w3-border w3-border-red w3-wdie"
		     	onclick="startAnim('regDel')">등록/삭제 방법</button>
		     	<button class="w3-button w3-white w3-border w3-border-red w3-wide"
		     	onclick="startAnim('updateAni')">수정방법</button>
     		</td>
     		<td class="animTest caution w3-animate-zoom" style="display:none" >
	     		<font size="4" color="grey">&nbsp;ㆍ[주의] </font><font size="5"> 같은 날 2개 일정 만들지 않도록 해주세요.</font>
     		</td>
     		<td class="animTest regDel w3-animate-zoom" style="display:none">
	     		<font size="4" color="grey">&nbsp;ㆍ[등록] </font><font size="5">날짜칸 선택 및 드래그</font>
     		</td>
     		<td class="animTest updateAni w3-animate-zoom" style="display:none">
	     		<font size="4" color="grey">&nbsp;ㆍ[수정] </font><font size="5">1) 등록된 일정 클릭 혹은 누른상태로 이동</font>
     		</td>
     	</tr>
     	<tr>
     		<td class="animTest caution w3-animate-zoom" style="display:none"  >
	     		<font size="4" color="grey">&nbsp;ㆍ[주의] </font><font size="5"> 하나의 일정이 다음달 넘기지 않도록 해주세요. ex) 7.31~8.01(X) → 7.31, 8.01(2번 등록)</font>
     		</td>
     		<td class="animTest regDel w3-animate-zoom" style="display:none">
	     		<font size="4" color="grey">&nbsp;ㆍ[삭제] </font><font size="5">해당일정 클릭 후 삭제버튼</font>
     		</td>
     		<td class="animTest updateAni w3-animate-zoom"  style="display:none">
	     		<font size="4" color="grey">&nbsp;ㆍ[수정] </font><font size="5">2) 등록된 일정 우측 끝 크기조절</font>
     		</td>
     	</tr>
     </table>
     </c:if>
     <c:if test="${userVO.grade==1}">
     <div >
     	<font size="5" color="red"> 관리자 권한</font>
     	<h6>특정인 혹은 전체일정 등록가능, 수정은 삭제 후 재등록(삭제는 파트원현황에서 해당일정 클릭) </h6> 
     </div>
     </c:if>	
    </div>
      
    </div>
  </header>
  
<!-- 달력 출력-->
    <div class=" w3-pale-blue  " id="calendar" style="margin-left:50px;width:1200px; z-index: 0; position: relative;">
    </div>

     <!-- 메시지 모달 -->
<div id="message" class="w3-modal" style="background-color: rgba(0,0,0,0.0);width:700px;margin-left:30%;">
   <div id="messageContent" class=" w3-container w3-padding">
   </div>  
</div>


<div id="cardList" class="w3-modal" style="background-color: rgba(0,0,0,0.0);padding-top:10px;" >
    <div id="cardListDrag" class="w3-border w3-modal-content w3-light-grey w3-card-2" style="width: 1400px;">
        <div  class="w3-container w3-center w3-teal" style="height:38px">
            <div class="w3-container w3-left w3-teal"><font style ="font-family : Do Hyeon;" size=5>카드소지자 등록내역</font>
			<div class="w3-container w3-right w3-teal" style="height : 38px">
             <!-- 내가추가 --> 
             <form action="${pageContext.servletContext.contextPath }/page/register" method="post">
             <select id="sYear_p" name="sYear" class="w3-select " style="font-family : Do Hyeon; width:100px;padding:6px;">
     	  	<option id="${currentYear}" value="${currentYear}" >${currentYear }</option>
     	  	<option id="${previousOneYear}" value="${previousOneYear}">${previousOneYear }</option>
     	  	<option id="${previousTwoYear}" value="${previousTwoYear}">${previousTwoYear }</option>
     	  	<option id="${previousThreeYear}" value="${previousThreeYear}">${previousThreeYear}</option>
        </select>
             <select id="sMonth_p" name="sMonth" class="w3-select " style="font-family : Do Hyeon; width:80px;padding:6px;">
     	  	<option id="01" value="01">1월</option><option id="02" value="02">2월</option><option id="03" value="03">3월</option><option id="04" value="04">4월</option>
     	  	<option id="05" value="05">5월</option><option id="06" value="06">6월</option><option id="07" value="07">7월</option><option id="08" value="08">8월</option>
     	  	<option id="09" value="09">9월</option><option id="10" value="10">10월</option><option id="11" value="11">11월</option><option id="12" value="12">12월</option>
        </select>
    	   <button type = "button" class="w3-button w3-border" onclick = "moveSelectMonth()" style="font-family : Do Hyeon;padding:5px" type="submit">바로가기</button>
    	   <!-- 내가추가 --> 
            </form>
           </div> 
        </div>
        </div>
        
        <div class="w3-container " id="cardListArea" >
        <button id='xbutton_crd' onclick="document.getElementById('cardList').style.display='none';" class="w3-button w3-display-topright">&times;</button>
	        <div class="w3-center  w3-container" id= "modalMonth" >
	        	<br>
	    <!-- 사용 내역이 없으면 아래-->
	    <c:if test="${count_o == 0 }">
			<div class="w3-center w3-padding-top">
			<table class="w3-table table-bordered w3-center" width="100%">
			<tr  >
			<td class="w3-center w3-padding"><br>
			<span class="w3-tag w3-white w3-border">등록된 내역이 없습니다.</span><br><br></td>
			</tr>
			</table>
			</div>
		</c:if>
		
	 <!-- 사용 내역이 있으면 아래-->
<!--  overtimesLiCard -->
	        	  	<c:if test="${count_o>0}">
       	<table class="w3-table w3-centered" style="border:black; ">
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
     <c:forEach var="overtime" items="${overtimesLiCard}">
     <tr class="w3-hover-white">
      <td width="120px" class="w3-border">
       	${overtime.useDate}
      </td>
      <td width="80px"  class="w3-border"> 
       	${overtime.memberNm}
      </td>
      <td style="word-break:break-all"  class="w3-border">
      <c:if test="${not empty overtime.targetListName}">
       	${overtime.targetListName} 
      </c:if>
       <c:if test="${empty overtime.targetListName}">
           <font color="grey">-</font>
       </c:if>
      </td>
        <td width="80px"  class="w3-border">
       ${overtime.targetListCount} 명
      </td>
      <td  class="w3-border">
       	${overtime.content}
      </td> 
      <td  class="w3-border">
       	${overtime.shopName}
      </td>
      <td width="80px"  class="w3-border">
       	${overtime.cardHolder}
      </td> 
       <td width="100px"  class="w3-border">
       	${overtime.price} 원
       </td>
    </tr>
    </c:forEach>   
  </table>
     </c:if>
     <br>
	        	<button class="w3-black w3-button"  onclick="document.getElementById('cardList').style.display='none';" style ="font-family : Do Hyeon;">닫기</button>
	        	<br><br>
	        </div>
        </div>
    </div>
</div>



    <!-- 일정 등록 모달 -->
<div id="addDay" class="w3-modal" style="background-color: rgba(0,0,0,0.0); padding-top:10px;" >
    <div id="addDayDrag" class="w3-border w3-modal-content w3-light-grey w3-card-2" style="max-width: 500px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style=""><font size=5>법인카드 사용등록</font></div>
        </div>
        <div class="w3-container " >
        <button id='xbutton' onclick="document.getElementById('addDay').style.display='none';" class="w3-button w3-display-topright">&times;</button>
        <div class="calendarForm w3-center  w3-container" id="modal">
            <form id="userinput" method="post" action="${ pageContext.servletContext.contextPath }/page/regcarduse" >
            	<input type="hidden" name="memberId" value="${userVO.id }" >
            	<input type="hidden" name="memberNm" value="${userVO.memberNm }" >
                <ul class="w3-ul w3-light-grey">
                <li><label>사용구분</label>
                    <div style="margin-left: 25px; padding-bottom: 5px;width: 350px" >
                        <select id="useCode" name="useCode" onchange="useChange(this)" class="w3-select"  >
                            <option value="2">야근식대</option>
                            <option value="1">교통비</option>
                       </select>
                        <p></p>
                        <label>내 용 : </label>
                        <input type="text" id="content" name="content" class="w3-input w3-round" style="display: inline;width: 160px;height: 35" placeholder=" 20자 이내">
                        <div id="shopDIV" style="margin-top:5px;">
                        <label>음식점 : </label>
                        <input type="text" id="shopName" name="shopName" class="w3-input w3-round" style="display: inline;width: 160px;height: 35" placeholder="20자 이내">
                        </div>
                    </div>
                    </li>
                    <!--교통비 내용--> 
                    <li> 
                    <div id="taxi_content" style="display:none">
                    <div style='padding-bottom: 10px'>
                        <span >
                            택시: <input type="radio" value="1" name="trafficType" checked="checked" class="w3-radio" >
                        </span>
                        &nbsp;
                        <span>
                            지하철: <input type="radio" value="2" name="trafficType" class="w3-radio" >
                        </span>
                        &nbsp;
                        <span>
                            버스: <input type="radio" value="3" name="trafficType" class="w3-radio" >
                        </span>
                    </div>
                    
                        <div style="padding-top:5px" >
                              출발지 : <input type="text" id="departure" name="departure" value="${userVO.likedDpr }" class="w3-input w3-round" style="display: inline;width: 170px;height: 35" placeholder="ex) 중구 장교동">
                            <i class="fa fa-star w3-center w3-large w3-button" onclick="likedReg(${userVO.id},1)" style="padding:8px"title="자주가는 출발지 등록" ></i>
                        </div>
                              <i class="fa fa-refresh w3-button" onclick="placeChange()" style="padding:8px"></i>
                        <div style="padding-bottom:5px" >
                              도착지 : <input type="text" id="destination" name="destination" value="${userVO.likedDest }" class="w3-input w3-round" style="display: inline;width: 170px;height: 35" placeholder="ex) 경기도 대화동">
                           <i class="fa fa-star w3-center w3-large w3-button" onclick="likedReg(${userVO.id},2)" style="padding:8px" title="자주가는 도착지 등록" ></i>
                        </div>     
                    </div>    
                    <!--교통비 end-->
                    
                    <!-- 야근식대 -->
                    <div id="overtime_content" >
                    <div style='padding-bottom: 10px'>
                        <span >
                            영업1담당: <input type="radio" id="dptchk1" name="area" onclick="areaChange(1)" class="w3-radio" >
                        </span>
                        <span>
                            영업2담당: <input type="radio" id="dptchk2" name="area" onclick="areaChange(2)" class="w3-radio" >
                        </span>
                        <span>
                 지원1담당: <input type="radio" id="dptchk3" name="area" onclick="areaChange(3)" class="w3-radio" >
                        </span>
                        <span>
                 지원2담당: <input type="radio" id="dptchk4" name="area" onclick="areaChange(4)" class="w3-radio" >
                        </span>
                    </div>
                        
                         <div class=" ">
                         <!-- zerogon id값을 실제 회원id값으로 변경필요 -->
                        <div class="memberSelector w3-border w3-padding w3-margin w3-button" 
                        id="1" onclick="memberClick('1');" style="display: inline">황영민</div>
                        <div class="memberSelector w3-border  w3-button" 
                        id="2" onclick="memberClick('2');" style="display: inline">윤재웅</div>
                        <div class="memberSelector w3-border  w3-button" 
                        id="4" onclick="memberClick('4');" style="display: inline">유승록</div>
                        <div class="memberSelector w3-border  w3-button" 
                        id="51" onclick="memberClick('51');" style="display: inline">김재우</div>
                        <div class="memberSelector w3-border  w3-button" 
                        id="64" onclick="memberClick('64');" style="display: inline">김상국</div>
                        </div>
                        <!-- **영업1담당** -->
                        <div id="business1">
	                        <!-- MD -->
	                        <div id="MDmembers" style='padding-top: 10px; padding-bottom: 10px'>
	                        <label style="color:darkred">[ IT_MD Part ]</label>
	                        </div>
	                        <!-- 마케팅 -->
	                        <div id="MKTmembers" style='padding-top: 10px; padding-bottom: 10px'>
	                        <label style="color:darkred">[ IT_마케팅 Part ]</label>
	                        </div>
                        </div>
                        <!-- **영업2담당** -->
                        <div id="business2" style="display:none">
	                        <!-- POS -->
	                        <div id="POSmembers" style='padding-top: 10px; padding-bottom: 10px'>
	                        <label style="color:darkred">[ IT_POS Part ]</label>
	                        </div>
	                        <!-- 상품권 -->
	                        <div id="GFTmembers"style='padding-top: 10px; padding-bottom: 10px'>
	                        <label style="color:darkred">[ IT_상품권 Part ]</label>
	                        </div>
                        </div>
                        
                        <!-- **지원담당** -->
                        <div id="support" style="display:none">
	                        <!-- 인프라 -->
	                        <br>
	                        <div id="INFmembers" style='padding-bottom: 10px'>
	                        <label style="color:darkred">[ IT_인프라 Part ]</label>
	                        </div> 
                        </div>  
                        <!-- **지원2담당** -->
                        <div id="support2" style="display:none">
	                        <!-- 경영지원 -->
	                        <br>
	                        <div id="SPTmembers" style='padding-top: 10px; padding-bottom: 10px'>
	                        <label style="color:darkred">[ IT_경영지원 Part ]</label>
	                        </div>
	                        <!-- 재무  -->   
	                        <div id="FINmembers" style='padding-bottom: 10px'>
	                        <label style="color:darkred">[ IT_재무 Part ]</label>
	                        </div>
                        </div>  
                </div>    
                </li>
        <!--교통비 등록시간-->     
        <li id="taxi_reg" style="display: none; ">
            <div style="padding-top: 5px;" >
                  출발일시 : <input type="text" readonly="readonly" id="startTime" placeholder="연도-월-일 시간" name="departureTime" class=" w3-input w3-round" style="display: inline;width: 130px;height: 35;">&nbsp;
                  도착일시 : <input type="text" readonly="readonly" id="endTime" placeholder="연도-월-일 시간" name="destinationTime" class=" w3-input w3-round" style="display: inline;width: 130px;height: 35" >
            </div>    
       </li>        
        <!--야근식대 금액등록-->         
      <li id="overtime_price" style="padding: 8px">
            <div style="padding-top: 10px;" >
               선택인원 : <font size="5" id="selectMemberCount" color='grey'></font> 명
               <!--  <i class="fa fa-search w3-large" ></i>-->
               &nbsp;&nbsp;
               금액입력 : <input type="text" id="price" name="price" class=" w3-input w3-round" 
               style="display: inline;width: 80px;height: 35"> 원
	            <button class="w3-button w3-black w3-border w3-border-white w3-round" onclick="memberSelectorDel()" style="margin-left:3px;padding:3px">전체 선택해제</button>
            </div>
        </li> 
       <li>
       <div style="display:inline;width:110px">
	       <label>사용일 : </label>
	       <input type="text" id="useDate" readonly="readonly"  name="useDate"  class="w3-input w3-border"
	       style="display: inline;width: 100px;">
       </div>
       <div id="taxi_price"style="display:none;width:110px;">
	       <label> 금액: </label>
	       <input type="text" id="taxiPrice" name="taxiPrice" class="w3-input w3-border"
	       style="display: inline;width: 100px;"> 원
       </div>
       <div id="card_owner"style="display:inline;width:110px;">
	       <label>카드소지자: </label>
	       <input type="text" id="cardInput" name="cardHolder" placeholder="ex) 황영민" class="w3-input w3-border"
	       style="display: inline;width: 100px;">
       </div>

       </li>
   
       <li>
       <button class="w3-button w3-black" id="commitbtn" onclick="checkValue()" >
             등록
       </button>
               <button id="cancelbtn" onclick="document.getElementById('addDay').style.display='none';event.preventDefault();location.reload();"
               class="w3-button w3-red">취소</button>
       </li>
       
                </ul>
            </form>
       <!--  <font size="3" color="grey"> * 등록한 내용은 드래그시 다른날짜로 이동가능합니다.</font> -->
        </div>
        </div>
    </div>
</div>
    </div>
<script>

$('#content, #departure, #destination, #shopName').on('keyup', function() {
	if($(this).val().length > 20) {
		alert("20자로 이내로 제한됩니다.");
		$(this).val($(this).val().substring(0, 20));
	}
});


function autocomplete(inp, arr) {
  var currentFocus;
  inp.addEventListener("input", function(e) {
      var a, b, i, val = this.value;
      closeAllLists();
      if (!val) { return false;}
      currentFocus = -1;
      a = document.createElement("DIV");
      a.setAttribute("id", this.id + "autocomplete-list");
      a.setAttribute("class", "autocomplete-items");
      this.parentNode.appendChild(a);
      for (i = 0; i < arr.length; i++) {
        if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
          b = document.createElement("DIV");
          b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
          b.innerHTML += arr[i].substr(val.length);
          b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
          b.addEventListener("click", function(e) {
              inp.value = this.getElementsByTagName("input")[0].value;
              closeAllLists();
          });
          a.appendChild(b);
        }
      }
  });
  inp.addEventListener("keydown", function(e) {
      var x = document.getElementById(this.id + "autocomplete-list");
      if (x) x = x.getElementsByTagName("div");
      if (e.keyCode == 40) {
        currentFocus++;
        addActive(x);
      } else if (e.keyCode == 38) { //up
        currentFocus--;
        addActive(x);
      } else if (e.keyCode == 13) {
        e.preventDefault();
        if (currentFocus > -1) {
          if (x) x[currentFocus].click();
        }
      }
  });
  function addActive(x) {
    if (!x) return false;
    removeActive(x);
    if (currentFocus >= x.length) currentFocus = 0;
    if (currentFocus < 0) currentFocus = (x.length - 1);
    x[currentFocus].classList.add("autocomplete-active");
  }
  function removeActive(x) {
    for (var i = 0; i < x.length; i++) {
      x[i].classList.remove("autocomplete-active");
    }
  }
  function closeAllLists(elmnt) {
    var x = document.getElementsByClassName("autocomplete-items");
    for (var i = 0; i < x.length; i++) {
      if (elmnt != x[i] && elmnt != inp) {
        x[i].parentNode.removeChild(x[i]);
      }
    }
  }
  document.addEventListener("click", function (e) {
      closeAllLists(e.target);
  });
}

var memberAll = memberDBtoALL();
autocomplete(document.getElementById("cardInput"), memberAll);

</script>
  
<script >
$.datepicker.setDefaults({
	dateFormat: 'yy-mm-dd' //Input Display Format 변경
		,showOtherMonths: false //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		,stepMonths: 1 //월 넘어가는 수 
		,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
		,changeYear: false //콤보박스에서 년 선택 가능
		,changeMonth: false //콤보박스에서 월 선택 가능                
		,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
			,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
				,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
});

//연 월데이터를 모달창으로 
function moveSelectMonth() {
	 
	var sYear_p = $("#sYear_p").val();
	var sMonth_p = $("#sMonth_p").val();
	console.log(sYear_p + "--"+sMonth_p);
	
	$.ajax({
     url : "${ pageContext.servletContext.contextPath}/page/registerMonth", 
   	 method : "GET",  
   	 dataType:"text",
   	 data:{
   		"sYear_p" : sYear_p,
   		"sMonth_p" :sMonth_p,
   			}, 
         success: function(data){
        	console.log(data)
       	  	$('#modalMonth').html(data);
		}, 
	error: function(request, status, error) {
		alert("error");
	}
	});	
}

//추가 끝


function checkValue(){
	var input=eval("document.userinput");
	var thisform=document.userinput;
	var useCode = userinput.useCode.value;
	event.preventDefault();
	
	// 교통비인경우 else 야근식대 
	if(useCode == 1){
		var replaceNotInt = /[^0-9]/gi;
	    var taxiPrice = $("#taxiPrice").val();
		if(!userinput.content.value){
			alert("내용을 입력하세요");
			return userinput.content.focus();
		}else if(!userinput.departure.value){
			alert("출발지를 입력하세요");
			return userinput.departure.focus();
		}else if(!userinput.destination.value){
			alert("도착지를 입력하세요");
			return userinput.destination.focus();
		}else if(!userinput.startTime.value){
			alert("출발일시를 선택하세요");
			return userinput.startTime.focus();
		}else if(!userinput.endTime.value){
			alert("도착일시를 선택하세요");
			return userinput.endTime.focus();
		}else if(!userinput.useDate.value){ 
			alert("사용일을 선택하세요");
			return userinput.useDate.focus();
		}else if(taxiPrice == 0 || taxiPrice == ''){ 
			alert("금액을 입력하세요");
			$("#taxiPrice").focus();
		}else{
			if(userinput.startTime.value>=userinput.endTime.value){
				alert("도착일시를 출발일시보다 이전으로 선택할 수 없습니다.");
				return userinput.endTime.focus();
			//정상적으로 입력이 완료된 경우
			}else if(!replaceNotInt.test(taxiPrice)){
				$('#commitbtn, #cancelbtn, #xbutton').attr('disabled',true); 
				$('#commitbtn').html('<i class="fa fa-spinner fa-spin" style="font-size:16px;padding:3px" ></i>');
				$('#userinput').submit();
				$('#content, #departure, #destination').val('');
			}
			else{
		    	alert("금액을 확인하세요.");
		    	$("#taxiPrice").val("");
		    	$("#taxiPrice").focus();
			}
		}
	}else {
	    var replaceNotInt = /[^0-9]/gi;
	    var price = $("#price").val();
	    if(!userinput.content.value){
			alert("내용을 입력하세요");
			return userinput.content.focus();
		}
	    else if(!userinput.shopName.value){
			alert("음식점을  입력하세요");
			return userinput.shopName.focus();
		}
	    else if(!userinput.cardHolder.value){
			alert("카드소지자를  입력하세요");
			return userinput.cardHolder.focus();
		}
	    else if(price == 0 || price == ''){
	    	alert('금액을 입력하세요.');
	    	$("#price").focus();
	    }else if(!userinput.useDate.value){
			alert("사용일을 선택하세요");
			return userinput.useDate.focus();
		}
	    else{
		    if(!replaceNotInt.test(price)){
		    	var selectList = document.getElementsByClassName("w3-blue");
		    	var selectIdList = new Array();
		    	//선택대상 이름 List로 전송, server 구분자 ','
		    	for(var i = 0 ; i < selectList.length ; i++){
		    		selectIdList.push(selectList[i].id);
		    	}
				//선택대상 hidden으로 form에 append
				var form = document.getElementById("userinput");
				var hiddenField = document.createElement("input");
				hiddenField.setAttribute("type", "hidden");
				hiddenField.setAttribute("name", "selectIdList");
				hiddenField.setAttribute("value", selectIdList);
				form.appendChild(hiddenField);
				$('#commitbtn, #cancelbtn, #xbutton').attr('disabled',true); 
				$('#commitbtn').html('<i class="fa fa-spinner fa-spin" style="font-size:16px;padding:3px" ></i>'); 
				$('#userinput').submit();
				$('#content, #cardHolder').val('');
		    	memberSelectorDel();
		    }else{
		    	alert("숫자값만 입력하세요.")
		    	$("#price").val("");
		    	$("#price").focus();
		    }
	    }
		event.preventDefault(); 
	}
}



$('#addDayDrag').draggable();
$('#useDate').datepicker();
$('.ui-timepicker-container').draggable();

function areaChange(areaCode){
	//영업1담당
	if(areaCode == 1){
		$('#business1').show(); 
		$('#business2, #support, #support2').hide(); 
	}
	//영업2담당
	else if(areaCode ==2 ){
		$('#business2').show(); 
		$('#business1, #support, #support2').hide(); 
	}
	//지원1담당
	else if(areaCode ==3 ){
		$('#business1, #business2, #support2').hide(); 
		$('#support').show(); 
	}
	//지원2담당
	else {
		$('#business1, #business2, #support').hide(); 
		$('#support2').show(); 
	}
	
}
function areaChange_u(areaCode){
	//영업1담당
	if(areaCode == 1){
		$('#business1_u').show(); 
		$('#business2_u, #support_u').hide(); 
	}
	//영업2담당
	else if(areaCode ==2 ){
		$('#business2_u').show(); 
		$('#business1_u, #support_u').hide(); 
	}
	//지원담당
	else{
		$('#business1_u, #business2_u').hide(); 
		$('#support_u').show(); 
	}
	
}
function updateForCal(data) {
	sendRequest("<%=request.getContextPath()%>/page/updateProForCal", data, fromServer, "POST");
}
function contentViewForCal(data) {
	var id = "id=" + data;
	sendRequest("<%=request.getContextPath()%>/page/contentsViewForCal", id, fromServer, "POST");
}
function toUpdatePageForCal(data) {
	var data1 = "id=" + data;
	sendRequest("<%=request.getContextPath()%>/page/updateFormForCal", data1, fromServerForUpdate, "POST");
	event.preventDefault();
}
function deleteCardForCal(data) {
	var id = "id=" + data;
	sendRequest("<%=request.getContextPath()%>/page/deleteCardForCal", id, fromServer, "POST");
}
function fromServerForUpdate() {
	if (httpRequest.readyState == 4) {
		if (httpRequest.status == 200) {
			document.getElementById("messageContent").innerHTML =  httpRequest.responseText ;
			function datePicker_u(){
				//jQuery datepicker 기본설정
				$.datepicker.setDefaults({
					dateFormat: 'yy-mm-dd' //Input Display Format 변경
						,showOtherMonths: false //빈 공간에 현재월의 앞뒤월의 날짜를 표시
						,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
						,stepMonths: 1 // 월 넘어가는 수 
						,changeYear: false //콤보박스에서 년 선택 가능
						,changeMonth: false //콤보박스에서 월 선택 가능                
						,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
							,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
								,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
				,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
				,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
				,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
				});
				$("#useDate_u").datepicker();
			}
			datePicker_u();
			$('#startTime_u, #endTime_u').appendDtpicker({
			    'locale' : 'ko', // 한글화
			    'autodateOnStart' : false, // 초기값 x
			    'timelistScroll' : false, // 시간 자동 스크롤 x
			    'closeOnSelected' : true, // 선택하면 선택창 x
			    'minuteInterval' : 30 // 시간 간격 조절 (m)
			});

			$('#content_u, #departure, #destination').on('keyup', function() {
				if($(this).val().length > 20) {
					alert("20자로 이내로 제한됩니다.");
					$(this).val($(this).val().substring(0, 20));
				}
			});
		}
	}
}

function checkValue_u(){
	var input=eval("document.userinput_u");
	var thisform=document.userinput_u;
	event.preventDefault();
	// 교통비인경우 else 야근식대 
		var replaceNotInt = /[^0-9]/gi;
	    var taxiPrice = $("#taxiPrice_u").val();
		if(!userinput_u.content_u.value){
			alert("내용을 입력하세요");
			return userinput_u.content_u.focus();
		}else if(!userinput_u.departure.value){
			alert("출발지를 입력하세요");
			return userinput_u.departure.focus();
		}else if(!userinput_u.destination.value){
			alert("도착지를 입력하세요");
			return userinput_u.destination.focus();
		}else if(!userinput_u.startTime_u.value){
			alert("출발일시를 선택하세요");
			return userinput_u.startTime.focus();
		}else if(!userinput_u.endTime_u.value){
			alert("도착일시를 선택하세요");
			return userinput_u.endTime.focus();
		}else if(!userinput_u.useDate_u.value){ 
			alert("사용일을 선택하세요");
			return userinput_u.useDate_u.focus();
		}else if(taxiPrice == 0 || taxiPrice == ''){ 
			alert("금액을 입력하세요");
			$("#taxiPrice_u").focus();
		}else{
			if(userinput_u.startTime_u.value>=userinput_u.endTime_u.value){
				alert("도착일시를 출발일시보다 이전으로 선택할 수 없습니다.");
				return userinput_u.endTime_u.focus();
			//정상적으로 입력이 완료된 경우
			}else if(!replaceNotInt.test(taxiPrice)){
				$('#commitbtn, #cancelbtn, #xbutton').attr('disabled',true); 
				$('#commitbtn').html('<i class="fa fa-spinner fa-spin" style="font-size:16px;padding:3px" ></i>');
				$('#userinput_u').submit();
				$('#content_u, #departure, #destination').val('');
			}
			else{
		    	alert("금액을 확인하세요.");
		    	$("#taxiPrice_u").val("");
		    	$("#taxiPrice_u").focus();
			}
		}
}
function checkValue_u_o(){
	 var replaceNotInt = /[^0-9]/gi;
	    var price_u = $("#price_u").val();
	    if(!userinput_u.content_u.value){
			alert("내용을 입력하세요");
			return userinput_u.content_u.focus();
		}
	    else if(!userinput_u.cardHolder_u.value){
			alert("카드소지자를  입력하세요");
			return userinput_u.cardHolder_u.focus();
		}
	    else if(price_u == 0 || price_u == ''){
	    	alert('금액을 입력하세요.');
	    	$("#price_u").focus();
	    }else if(!userinput_u.useDate_u.value){
			alert("사용일을 선택하세요");
			return userinput_u.useDate_u.focus();
		}
	    else{
		    if(!replaceNotInt.test(price_u)){
		    	var selectList = document.getElementsByClassName("w3-blue");
		    	var selectIdList = new Array();
				$('#commitbtn, #cancelbtn, #xbutton').attr('disabled',true); 
				$('#commitbtn').html('<i class="fa fa-spinner fa-spin" style="font-size:16px;padding:3px" ></i>'); 
				$('#userinput_u').submit();
				$('#content_u, #cardHolder_u').val('');
		    	memberSelectorDel();
		    }else{
		    	alert("숫자값만 입력하세요.")
		    	$("#price_u").val("");
		    	$("#price_u").focus();
		    }
	    }
		event.preventDefault(); 
}
function fromServer(){
	if(httpRequest.readyState==4){
		if(httpRequest.status==200){
			document.getElementById("messageContent").innerHTML=httpRequest.responseText;
		}
	}	
}

var menuClick = function(url){
	if(url == '/'){
		location.reload(true);
		return;
	}
	$.ajax({
		type: 'POST',
		url: url,
		async:false,
		data: "",
		contentType:"application/x-www-form-urlencoded; charset=UTF-8",
		success: function(data) {
			$('#messageContent').html(data);
		},
		error: function(request, status, error) {
			alert(error);
		}
	});
};

function useChange(useCode){
	//value 1 : 교통비, else : 야근식대
	if(useCode.value==1){
		$('#taxi_content, #taxi_reg, #taxi_price').show(); 
		$('#overtime_content, #overtime_price, #card_owner, #shopDIV').hide(); 
		$('#taxi_price').attr('style','display:inline;'); 
	}else{
		$('#taxi_content, #taxi_reg, #taxi_price').hide(); 
		$('#overtime_content, #overtime_price,  #shopDIV').show(); 
		$('#card_owner').attr('style','display:inline;'); 
		}
}
//자주가는 출발지, 도착지 등록
function likedReg(userId, type){
	//type 1: 출발지 등록 , 2: 등록지 등록
	event.preventDefault();
	var departure = $("#departure").val();
	var destination = $("#destination").val();
	
	if(type == 1){
		if(confirm("자주가는 출발지로 등록하시겠습니까?")){
			$.ajax({
				 url : "${ pageContext.servletContext.contextPath }/page/user/likedReg", 
		    	 method : "POST",  
		    	 dataType:"text",
		    	 data:{ 
		    			"type":type,
		    			"userId":userId,
		    			"departure":departure,
		    			}, 
	              success: function(data){
	            	  alert("등록이 완료됐습니다.\n\n **삭제원할 시 빈칸 입력 후 재등록해주세요.")
					},
			error: function(request, status, error) {
				alert(error);
			}
			});	
		}
	}else{
		if(confirm("자주가는 도착지로 등록하시겠습니까?")){
			$.ajax({
				 url : "${ pageContext.servletContext.contextPath }/page/user/likedReg", 
		    	 method : "POST",  
		    	 dataType:"text",
		    	 data:{ 
		    			"type":type,
		    			"userId":userId,
		    			"destination":destination,
		    			}, 
	              success: function(data){
	            	  alert("등록이 완료됐습니다.\n\n **삭제원할 시 빈칸 입력 후 재등록해주세요.")
					},
			error: function(request, status, error) {
				alert(error);
			}
			});	
		}
	}
}


function startAnim(animName) {
    var i;
    var x = document.getElementsByClassName("animTest");
    for (i = 0; i < x.length; i++) {
       x[i].style.display = "none";  
    }
    var y =document.getElementsByClassName('animTest '+animName);
    for (i = 0; i < y.length; i++) {
       y[i].style.display = "block";  
    }
    
}



function memberClick(memberId) {
	var selectMemberCount = Number($('#selectMemberCount').text());
	var selectPrice = 	Number($('#price').val()); 
	var fixedPrice = 10000;
	//True 시 w3-blue 클래스 추가
	var isTrue = document.getElementById(memberId).classList.toggle('w3-blue');
	if(isTrue){
		selectMemberCount += 1
		selectPrice = fixedPrice * selectMemberCount;
	}else{
		selectMemberCount -= 1
		selectPrice = fixedPrice * selectMemberCount;
	}
	$('#selectMemberCount').text(selectMemberCount); 
	$('#price').val(selectPrice)
}
function memberClick_u(memberId) {
	var selectMemberCount = Number($('#selectMemberCount_u').text());
	var selectPrice = 	Number($('#price_u').val()); 
	var fixedPrice = 10000;
	//True 시 w3-blue 클래스 추가
	var isTrue = document.getElementById(memberId).classList.toggle('w3-blue');
	if(isTrue){
		selectMemberCount += 1
		selectPrice = fixedPrice * selectMemberCount;
	}else{
		selectMemberCount -= 1
		selectPrice = fixedPrice * selectMemberCount;
	}
	$('#selectMemberCount_u').text(selectMemberCount); 
	$('#price_u').val(selectPrice)
}

function memberSelectorDel() {
	event.preventDefault();
	$('#price').val(0)
	$('#selectMemberCount').text(0); 
	$('.memberSelector').removeClass('w3-blue'); 
}
function memberSelectorDel_u() {
	event.preventDefault();
	$('#price_u').val(0)
	$('#selectMemberCount_u').text(0); 
	$('.memberSelector').removeClass('w3-blue'); 
}

function placeChange(){
	var tmp = $('#departure').val();
	$('#departure').val($('#destination').val());
	$('#destination').val(tmp);
}




</script>


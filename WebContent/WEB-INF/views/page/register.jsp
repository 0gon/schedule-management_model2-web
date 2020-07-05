<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- !PAGE CONTENT! -->
<script>
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
	
	$(function() {
		var memberList_POS = memberDBtoPOS();
		var memberList_MD = memberDBtoMD();
		var memberList_MKT = memberDBtoMKT();
		var memberList_SPT = memberDBtoSPT();
		var memberList_INF = memberDBtoINF();
		var memberList_GFT = memberDBtoGFT();
		var memberList_FIN = memberDBtoFIN();
		
	    var POSlist ='<table class="w3-table"><tr>';
	    for(var j=0;j<memberList_POS.length;j++){
	    	if(j!=0 && j%7==0){
		    	POSlist +='</tr><tr><td class="w3-center w3-border">'+memberList_POS[j].memberNm+'</td>'
	    	}else{
		    	POSlist +='<td class="w3-center w3-border">'+memberList_POS[j].memberNm+'</td>'
	    	}
	    }
	    POSlist += '</tr>';
	    var MDlist ='<table class="w3-table"><tr>';
	    for(var j=0;j<memberList_MD.length;j++){
	    	if(j!=0 &&j%7==0){
	    		MDlist +='</tr><tr><td class="w3-center w3-border">'+memberList_MD[j].memberNm+'</td>'
	    	}else{
	    		MDlist +='<td class="w3-center w3-border">'+memberList_MD[j].memberNm+'</td>'
	    	}
	    }
	    MDlist += '</tr>';
	    var MKTlist ='<table class="w3-table"><tr>';
	    for(var j=0;j<memberList_MKT.length;j++){
	    	if(j!=0 &&j%7==0){
	    		MKTlist +='</tr><tr><td class="w3-center w3-border">'+memberList_MKT[j].memberNm+'</td>'
	    	}else{
	    		MKTlist +='<td class="w3-center w3-border">'+memberList_MKT[j].memberNm+'</td>'
	    	}
	    }
	    MKTlist += '</tr>';
	    var SPTlist ='<table class="w3-table"><tr>';
	    for(var j=0;j<memberList_SPT.length;j++){
	    	if(j!=0 &&j%7==0){
	    		SPTlist +='</tr><tr><td class="w3-center w3-border">'+memberList_SPT[j].memberNm+'</td>'
	    	}else{
	    		SPTlist +='<td class="w3-center w3-border">'+memberList_SPT[j].memberNm+'</td>'
	    	}
	    }
	    SPTlist += '</tr>';
	    var INFlist ='<table class="w3-table"><tr>';
	    for(var j=0;j<memberList_INF.length;j++){
	    	if(j!=0 && j%7==0){
	    		INFlist +='</tr><tr><td class="w3-center w3-border">'+memberList_INF[j].memberNm+'</td>'
	    	}else{
	    		INFlist +='<td class="w3-center w3-border">'+memberList_INF[j].memberNm+'</td>'
	    	}
	    }
	    INFlist += '</tr>';
	    var GFTlist ='<table class="w3-table"><tr>';
	    for(var j=0;j<memberList_GFT.length;j++){
	    	if(j!=0 &&j%7==0){
	    		GFTlist +='</tr><tr><td class="w3-center w3-border">'+memberList_GFT[j].memberNm+'</td>'
	    	}else{
	    		GFTlist +='<td class="w3-center w3-border">'+memberList_GFT[j].memberNm+'</td>'
	    	}
	    }
	    GFTlist += '</tr>';
	    var FINlist ='<table class="w3-table"><tr>';
	    for(var j=0;j<memberList_FIN.length;j++){
	    	if(j!=0 &&j%7==0){
	    		FINlist +='</tr><tr><td class="w3-center w3-border">'+memberList_FIN[j].memberNm+'</td>'
	    	}else{
	    		FINlist +='<td class="w3-center w3-border">'+memberList_FIN[j].memberNm+'</td>'
	    	}
	    }
	    FINlist += '</tr>';
	    $('#POSmembers').append(POSlist);
	    $('#MDmembers').append(MDlist);
	    $('#MKTmembers').append(MKTlist);
	    $('#SPTmembers').append(SPTlist);
	    $('#INFmembers').append(INFlist);
	    $('#GFTmembers').append(GFTlist);
	    $('#FINmembers').append(FINlist);
	});
</script>

<div class="w3-main" style="margin-left:100px">
  <!-- Header -->
  <header id="portfolio">
    <a href="#"><img src="${ pageContext.servletContext.contextPath }/imgs/avatar_g2.jpg" style="width:65px;" class="w3-circle w3-right w3-margin w3-hide-large w3-hover-opacity"></a>
    <div class="w3-container" style="padding-top:  10px">
        <font size="6">일정관리 </font>
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
  
<div class="w3-container w3-padding-large" style="margin-bottom:32px">
<div style="width: 100%; height:500px; background: rgba(241, 241, 241, 1); ">
<!-- 달력 출력-->
    <div class="w3-container  w3-padding w3-padding-right w3-padding-left" id="calendar" style="width:95%; z-index: 0; position: relative;">
    </div>
</div>
</div>

     <!-- 메시지 모달 -->
<div id="message" class="w3-modal" >
   <div id="messageContent" class=" w3-container w3-padding">
   </div>  
</div>
<input type="hidden" value="${memberid }" id="memberidCal">
    
    <!-- 일정 등록 모달 -->
    
<div id="addDay" class="w3-modal" style="background-color: rgba(0,0,0,0.0); padding-top:10px;" >
    <div id="addDayDrag" class="w3-border w3-modal-content w3-light-grey w3-card-2" style="max-width: 500px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style=""><font size=5>법인카드 사용등록</font></div>
        </div>
        <div class="w3-container " >
        <span onclick="document.getElementById('addDay').style.display='none'; document.getElementById('startdate').value='';" class="w3-button w3-display-topright">&times;</span>
        <div class="calendarForm w3-center  w3-container" id="modal">
            <form id="userinput" method="post" >
                <ul class="w3-ul w3-light-grey">
                <li><label>사용구분</label>
                    <div style="margin-left: 25px; padding-bottom: 5px;width: 350px" >
                        <select id="" onchange="useChange(this)" class="w3-select"  >
                            <option value="1">교통비</option>
                            <option value="2">야근식대</option>
                       </select>
                        <p></p>
                        <label>내 용 : </label>
                        <input type="text" id="etc" name="etc" class="w3-input w3-round" style="display: inline;width: 260px;height: 35" placeholder=" 10자 이내">
                    </div>
                    </li>
                    <!--교통비 내용--> 
                    <li>
                    <div id="taxi_content">
                        <div style="padding-top:5px" >
                              출발지 : <input type="text" id="etc" name="etc" class="w3-input w3-round" style="display: inline;width: 170px;height: 35" placeholder="ex) 중구 장교동">
                              <i class="fa fa-star w3-center w3-large w3-button" style="padding:8px"title="자주가는 출발지 등록" ></i>
                        </div>
                              <i class="fa fa-refresh w3-button" style="padding:8px"></i>
                        <div style="padding-bottom:5px" >
                              도착지 : <input type="text" id="etc" name="etc" class="w3-input w3-round" style="display: inline;width: 170px;height: 35" placeholder="ex) 경기도 대화동">
                             <i class="fa fa-star w3-center w3-large w3-button" style="padding:8px" title="자주가는 도착지 등록" ></i>
                        </div>     
                    </div>    
                    <!--교통비 end-->
                    
                    <!-- 야근식대 -->
                    <div id="overtime_content" style="display:none">
                    <div style='padding-bottom: 10px'>
                        <span >
                            영업1담당: <input type="radio" name="area" onclick="areaChange(1)" class="w3-radio" checked>
                        </span>
                        <span>
                            영업2담당: <input type="radio" name="area" onclick="areaChange(2)" class="w3-radio" >
                        </span>
                        <span>
                            지원담당: <input type="radio" name="area" onclick="areaChange(3)" class="w3-radio" >
                        </span>
                    </div>
                        
                         <div class="w3-padding ">
                        <div class="w3-border w3-padding w3-margin" id="hwang" onclick="memberClick('hwang');" style="display: inline">
                         황영민
                        </div>
                        <div class="w3-border w3-padding" id="yoon" onclick="memberClick('yoon');" style="display: inline">
                         윤재웅
                        </div>
                        <div class="w3-border-top w3-border-bottom w3-padding" id="choi" onclick="memberClick('choi');" style="display: inline">
                         최광명
                        </div>
                        <div class="w3-border w3-padding" id="you" onclick="memberClick('you');" style="display: inline">
                         유승록
                        </div>
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
	                        <!-- 경영지원 -->
	                        <div id="SPTmembers" style='padding-top: 10px; padding-bottom: 10px'>
	                        <label style="color:darkred">[ IT_경영지원 Part ]</label>
	                        </div>
	                        <!-- 인프라 -->
	                        <div id="INFmembers" style='padding-bottom: 10px'>
	                        <label style="color:darkred">[ IT_인프라 Part ]</label>
	                        </div> 
	                        <!-- 재무  -->   
	                        <div id="FINmembers" style='padding-bottom: 10px'>
	                        <label style="color:darkred">[ IT_재무 Part ]</label>
	                        </div>
                        </div>  
                </div>    
                </li>
                <!--  
                md : 엄재상 정수경 권혜진 김형열 김혜진 남지훈 박민준 설수연 신학춘 유은주 임채은 전미경 황명헌 
                마케팅: 서윤미 허창녕 김남수 김지연 김철웅 서종덕 송영곤 안소현 안지흔 유예근 최윤선
                경영지원: 곽미숙 김진우 이은경 이재민 장우현 김시아
                인프라: 최승원 김재우 남궁우진 공정훈 김재범 방효진 안무혁 장영현 전상영 정채린 진성호 홍윤표 황종하
                상품권: 김영준 김나라 김진성
                재무 : 김상국 강민승 김연준 소유니 송병준 이한주 
                
                -->
        <!--교통비 등록시간-->     
        <li id="taxi_reg">
            <div style="padding-top: 10px;" >
                  출발시간 : <input type="text" id="etc" name="etc" class=" w3-input w3-round" style="display: inline;width: 110px;height: 35">&nbsp;&nbsp;&nbsp;
                  도착시간 : <input type="text" id="etc" name="etc" class=" w3-input w3-round" style="display: inline;width: 110px;height: 35" >
            </div>    
       </li>        
        <!--야근식대 금액등록-->         
      <li id="overtime_price" style="display: none">
            <div style="padding-top: 10px;" >
               선택인원 : <font size="5" color='grey'>13</font> 명
               <i class="fa fa-search w3-large" ></i>
               &nbsp;&nbsp;
               금액입력 : <input type="text" id="etc" name="etc" class=" w3-input w3-round" style="display: inline;width: 110px;height: 35">
            </div>    

        </li>
                    
                    
       <li><label>사용일</label>
       <input type="text" id="startdate" readonly="readonly"  name="startDate" placeholder="연도-월-일" class="w3-input w3-border">
       </li>
	   
       <li>
       <button class="w3-button w3-black" id="commitbtn" onclick="">등록</button>
       <span class="w3-button w3-red" onclick="document.getElementById('addDay').style.display='none';">
                취소</span>
       </li>
       
                </ul>
            </form>
        </div>
        </div>
    </div>
</div>
    </div>

  
<script >
$('#addDayDrag').draggable();

function areaChange(areaCode){
	//영업1담당
	if(areaCode == 1){
		$('#business1').show(); 
		$('#business2').hide(); 
		$('#support').hide(); 
	}
	//영업2담당
	else if(areaCode ==2 ){
		$('#business1').hide(); 
		$('#business2').show(); 
		$('#support').hide(); 
	}
	//지원담당
	else{
		$('#business1').hide(); 
		$('#business2').hide(); 
		$('#support').show(); 
		
	}
	
}
function checkValue(){
	
	var input=eval("document.userinput");
	var thisform=document.userinput;
	if(!userinput.startdate.value){
		alert("시작일을 입력하세요");
		event.preventDefault(); 
		return userinput.startdate.focus();
	}else
	if(!userinput.enddate.value){
		alert("종료일을 입력하세요");
		event.preventDefault(); 
		return userinput.enddate.focus();
	}else

	if(userinput.startdate.value>userinput.enddate.value){
		alert("종료일을 시작일보다 이전으로 선택할 수 없습니다.");
		event.preventDefault(); 
		return userinput.enddate.focus();
	}else{ 
		$('#userinput').submit(function(event){
		  var data=$(this).serialize();
		  addSchedule(data);
		  document.getElementById('addDay').style.display='none';
		  document.getElementById('message').style.display='block';
          event.preventDefault(); } 
		); 

	};
		
}
function checkReg(){
    	
    	var input=eval("document.regForm");
    	var thisform=document.regForm;
    	if(!regForm.sDate.value){
    		alert("시작일을 입력하세요");
    		event.preventDefault(); 
    		return regForm.sDate.focus();
    	}else
    	if(!regForm.eDate.value){
    		alert("종료일을 입력하세요");
    		event.preventDefault(); 
    		return regForm.eDate.focus();
    	}else

    	if(regForm.sDate.value>regForm.eDate.value){
    		alert("종료일을 시작일보다 이전으로 선택할 수 없습니다.");
    		event.preventDefault(); 
    		return regForm.eDate.focus();
    	}else{ 
    		$('#regForm').submit(function(event){
    		  var data=$(this).serialize();
    		  addSchedule(data);
    		  document.getElementById('addDay').style.display='none';
    		  document.getElementById('message').style.display='block';
              event.preventDefault(); } //기본 폼의 submit이 발생되지 않게 막기
    		); 

    	};
    		
    }
function checkUpdateValue(){
	
	var input=eval("document.updateinput");
	var thisform=document.updateinput;
	if(!updateinput.startdate.value){
		alert("시작일을 입력하세요");
		event.preventDefault(); 
		return updateinput.startdate.focus();
	}else
	if(!updateinput.enddate.value){
		alert("종료일을 입력하세요");
		event.preventDefault(); 
		return updateinput.enddate.focus();
	}else
	if(updateinput.startdate.value>updateinput.enddate.value){
		alert("종료일을 시작일보다 이전으로 선택할 수 없습니다.");
		event.preventDefault(); 
		return updateinput.enddate.focus();
	}else{ 
		$('#updateinput').submit(function(event){
		 
		  var data=$(this).serialize();
		  updateInclueDuty(data);
		   document.getElementById('addDay').style.display='none';
		   document.getElementById('message').style.display='block';
			  
			  event.preventDefault(); } //기본 폼의 submit이 발생되지 않게 막기
		); 
	};
		
}
function contentView(data){
	var id="id="+data;
	sendRequest("<%=request.getContextPath()%>/page/contentsView",id,fromServer,"POST");
}

function fromServer(){
	if(httpRequest.readyState==4){
		if(httpRequest.status==200){
			document.getElementById("messageContent").innerHTML=httpRequest.responseText;
		}
	}	
}

function deleteSchedule(data){
	var id="id="+data;
	sendRequest("<%=request.getContextPath()%>/page/deleteSchedule",id,fromServer,"POST");
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


function addSchedule(data){
 	sendRequest("<%=request.getContextPath()%>/page/addSchedule",data,fromServer,"POST"); 
}

function update(data){
	sendRequest("<%=request.getContextPath()%>/page/updatePro",data,fromServer,"POST");
}
function updateInclueDuty(data){
	sendRequest("<%=request.getContextPath()%>/page/updateProDuty",data,fromServer,"POST");
}
function toUpdatePage(data){
	var data1="id="+data;
		sendRequest("<%=request.getContextPath()%>/page/updateForm",data1,fromServer,"POST");	
		event.preventDefault(); 	
}
function useChange(useCode){
	//value 1 : 교통비, else : 야근식대
	if(useCode.value==1){
		$('#taxi_content').show(); 
		$('#taxi_reg').show(); 
		$('#overtime_content').hide(); 
		$('#overtime_price').hide(); 
	}else{
		$('#taxi_content').hide(); 
		$('#taxi_reg').hide(); 
		$('#overtime_content').show(); 
		$('#overtime_price').show(); 
		}
}


function dutyChange(dutyCode){
    if(dutyCode.value==1){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
        $('#registerWork').hide(); 
        $('#duty1').show();$('#duty2').hide();
        $('#duty3').hide();$('#duty4').hide();$('#duty5').hide(); $('#duty6').hide(); 
        
    }else if(dutyCode.value==2){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
        var tmp = $('#eduTime').is(':checked')
        if(tmp){
            $('#registerWork').show();
        }else{
            $('#registerWork').hide(); 
        }
        $('#duty1').hide();$('#duty2').show();
        $('#duty3').hide();$('#duty4').hide();$('#duty5').hide();$('#duty6').hide(); 
    }else if(dutyCode.value==3){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
        $('#registerWork').hide();$('#duty1').hide();
        $('#duty2').hide();$('#duty3').show();
        $('#duty4').hide();$('#duty5').hide();$('#duty6').hide(); 
    }else if(dutyCode.value==4){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
         var tmp = $('#etcTime').is(':checked')
        if(tmp){
            $('#registerWork').show();
        }else{
            $('#registerWork').hide(); 
        }
        $('#duty1').hide();$('#duty2').hide();
        $('#duty3').hide();$('#duty4').show();$('#duty5').hide();$('#duty6').hide(); 
    }else if(dutyCode.value==5){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
        $('#registerWork').hide();$('#duty1').hide();
        $('#duty2').hide();$('#duty3').hide();$('#duty4').hide();$('#duty6').hide();  
        $('#duty5').show();
    }else if(dutyCode.value==6){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
        $('#duty1').hide();$('#duty2').hide();$('#duty3').hide(); 
        $('#duty4').hide();$('#duty5').hide();$('#duty6').hide();  
        $('#registerWork').hide(); 
    }else if(dutyCode.value==7){
    	$('#eduSubject').val(null);
    	$('#etc').val(null);
        $('#registerWork').hide();$('#duty1').hide();
        $('#duty2').hide();$('#duty3').hide();$('#duty4').hide();$('#duty5').hide();  
        $('#duty6').show();
    }
}
function eduCheck(chk){
    if(chk==1){
        var tmp = $('#eduTime').is(':checked')
        if(tmp){
            $('#registerWork').show();
        }else{
            $('#registerWork').hide(); 
        }
    }else if(chk==2){
         var tmp = $('#etcTime').is(':checked')
        if(tmp){
            $('#registerWork').show();
        }else{
            $('#registerWork').hide(); 
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
	document.getElementById(memberId).classList.toggle('w3-blue')    
}
</script>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:100px">
  <!-- Header -->
  <header id="portfolio">
    <a href="#"><img src="${ pageContext.servletContext.contextPath }/imgs/avatar_g2.jpg" style="width:65px;" class="w3-circle w3-right w3-margin w3-hide-large w3-hover-opacity"></a>
    <span class="w3-button w3-hide-large w3-xxlarge w3-hover-text-grey" onclick="w3_open()"><i class="fa fa-bars"></i></span>
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
<div id="addDay" class="w3-modal" >
    <div class="w3-modal-content w3-light-grey w3-card-4" style="max-width: 400px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style="margin-top:2px"><font size=5>일정 등록</font></div>
        </div>
        <div class="w3-container w3-padding" >
        <span onclick="document.getElementById('addDay').style.display='none'; document.getElementById('startdate').value=''; document.getElementById('enddate').value=''; " class="w3-button w3-display-topright">&times;</span>
       
        <div class="calendarForm w3-center  w3-container w3-padding" id="modal">
            <form id="userinput" method="post" >
             <c:if test="${userVO.grade==0}">
             	<input type="hidden" name="memberId" value="${userVO.id}">
		     </c:if>
                <ul class="w3-ul w3-light-grey">
             <c:if test="${userVO.grade==1}">
			    <li><label>등록시킬 사람</label>
			    <select  name="memberId" class="w3-select" >
			   		 <c:forEach var="member" items="${members}">
                        <option value="${member.id}">${member.memberNm}</option>
                     </c:forEach>
                     <option value="0">전체등록</option>
                 </select>
			    </li>
             </c:if>
                <li><label>일정구분</label>
                  <select id="dutyCode" onchange="dutyChange(this)" name="dutyId" class="w3-select" >
                     <c:forEach var="duty" items="${duties}">
                        <option value="${duty.id}">${duty.title}</option>
                     </c:forEach>
                   </select>
                   <!--휴무  humu로 보내서 1 or 2로 받음--> 
                    <div class="w3-padding" id="duty1">
                        <span class="">
                            연차: <input type="radio" name="humu" value="1" class="w3-radio" checked>
                        </span>
                        <span>
                            대체휴무: <input type="radio" name="humu" value="2" class="w3-radio" >
                        </span>
                        <span>
                            공가: <input type="radio" name="humu" value="3" class="w3-radio" >
                        </span>
                        <span class="">
                             보상: <input type="radio" name="humu" value="4" class="w3-radio" >
                        </span>
                        <c:if test="${userVO.grade==1}">
                        <span>
                            정기휴무: <input type="radio" name="humu" value="5" class="w3-radio" >
                        </span>
                        <span>
                            의무연차: <input type="radio" name="humu" value="6" class="w3-radio" >
                        </span>
                            <span>
                            공휴일: <input type="radio" name="humu" value="7" class="w3-radio" >
                        </span> 
                        </c:if>
                        
                    </div>
                   <!--교육 eduSubject로 보냄-->
                    <div id="duty2" style="display: none">
                    <div class="w3-padding">
                          교육명 : <input type="text" id="eduSubject" name="eduSubject" class="w3-input w3-round" style="display: inline;width: 205px;height: 35" placeholder="10자 이내">
                    </div>
                    <div>
                        <span>근무시간 등록여부 :</span>
                        <span >
                         <input type="checkbox" name="chkBox" id="eduTime" class="w3-radio"  onchange="eduCheck(1)" > (체크시 등록)
                        </span>
                    </div>
                    </div>
                    
                    <!-- 휴가 huga로 보내서 1 or 2로 받음-->
                    <div class="w3-padding" id="duty3" style="display: none">
                        <span class="w3-margin">
                            Refresh 휴가: <input type="radio" name="huga" value="1" class="w3-radio" checked>
                        </span>
                        <span>
                            하계휴가: <input type="radio" name="huga" value="2" class="w3-radio">
                        </span>
                    </div>
                    
                    <!-- 기타일정 etc로 보냄-->
                    <!-- 기타일정 출장으로 변경-->
                    <div id="duty4" style="display: none">
                    <div class="w3-padding">
                          내용 : <input type="text" id="etc" name="etc" class="w3-input w3-round" style="display: inline;width: 205px;height: 35" placeholder="10자 이내">
                    </div>
                    <div>
                        <span>근무시간 등록여부 :</span>
                        <span >
                         <input type="checkbox" name="chkBox" id="etcTime"  class="w3-radio" onclick="eduCheck(2)"> (체크시 등록)
                        </span>
                    </div>
                    </div>
                    <!-- 근무 -->
                    <div class="w3-padding" id="duty5" style="display: none">
                        <span class="w3-margin">
                            주말근무: <input type="radio" name="working" value="1" class="w3-radio" checked>
                        </span>
                        <span>
                            책임당직: <input type="radio" name="working" value="2" class="w3-radio">
                        </span>
                    </div>
                    <!--  기타일정 추가-->
                    <div id="duty6" style="display: none">
                    <div class="w3-padding">
                          내용 : <input type="text" id="Realetc" name="Realetc" class="w3-input w3-round" style="display: inline;width: 205px;height: 35" placeholder="10자 이내">
                    </div>
                    </div>
                    
                    <!--근무 시간 등록-->
                     <div id="registerWork" class="w3-row-padding w3-padding" style="display: none">
                      <div class="w3-half">
                        <label>시작시간</label>
                            <select name="startWorkTime" class="w3-select w3-round w3-center" >
                                <option value="06:00">06:00</option>
                                <option value="06:30">06:30</option>
                                <option value="07:00">07:00</option>
                                <option value="07:30">07:30</option>
                                <option value="08:00">08:00</option>
                                <option value="08:30">08:30</option>
                                <option value="09:00" selected>09:00</option>
                                <option value="09:30">09:30</option>
                                <option value="10:00">10:00</option>
                                <option value="10:30">10:30</option>
                                <option value="11:00">11:00</option>
                                <option value="11:30">11:30</option>
                                <option value="12:00">12:00</option>
                                <option value="12:30">12:30</option>
                                <option value="13:00">13:00</option>
                                <option value="13:30">13:30</option>
                                <option value="14:00">14:00</option>
                                <option value="14:30">14:30</option>
                                <option value="15:00">15:00</option>
                                <option value="15:30">15:30</option>
                                <option value="16:00">16:00</option>
                                <option value="16:30">16:30</option>
                                <option value="17:00">17:00</option>
                                <option value="17:30">17:30</option>
                                <option value="18:00">18:00</option>
                                <option value="18:30">18:30</option>
                                <option value="19:00">19:00</option>
                                <option value="19:30">19:30</option>
                                <option value="20:00">20:00</option>
                                <option value="20:30">20:30</option>
                                <option value="21:00">21:00</option>
                                <option value="21:30">21:30</option>
                                <option value="22:00">22:00</option>
                           </select>
                      </div>
                      <div class="w3-half">
                        <label>종료시간</label>
                        <select name="endWorkTime" class="w3-select w3-round" >
                                <option value="06:00">06:00</option>
                                <option value="06:30">06:30</option>
                                <option value="07:00">07:00</option>
                                <option value="07:30">07:30</option>
                                <option value="08:00">08:00</option>
                                <option value="08:30">08:30</option>
                                <option value="09:00">09:00</option>
                                <option value="09:30">09:30</option>
                                <option value="10:00">10:00</option>
                                <option value="10:30">10:30</option>
                                <option value="11:00">11:00</option>
                                <option value="11:30">11:30</option>
                                <option value="12:00">12:00</option>
                                <option value="12:30">12:30</option>
                                <option value="13:00">13:00</option>
                                <option value="13:30">13:30</option>
                                <option value="14:00">14:00</option>
                                <option value="14:30">14:30</option>
                                <option value="15:00">15:00</option>
                                <option value="15:30">15:30</option>
                                <option value="16:00">16:00</option>
                                <option value="16:30">16:30</option>
                                <option value="17:00">17:00</option>
                                <option value="17:30">17:30</option>
                                <option value="18:00" selected>18:00</option>
                                <option value="18:30">18:30</option>
                                <option value="19:00">19:00</option>
                                <option value="19:30">19:30</option>
                                <option value="20:00">20:00</option>
                                <option value="20:30">20:30</option>
                                <option value="21:00">21:00</option>
                                <option value="21:30">21:30</option>
                                <option value="22:00">22:00</option>
                        </select>
                      </div>
                    </div>
                </li>
       <li><label>시작일</label>
       <input type="date" id="startdate" name="startDate"  placeholder="YYYY-MM-DD"  value="" class="w3-input w3-border">
       </li>
       <li><label>종료일</label>
       <input type="date" id="enddate" name="endDate"  placeholder="YYYY-MM-DD" value="" class="w3-input w3-border">
       </li>
       
       <li><button class="w3-button w3-black" id="commitbtn" onclick="checkValue();"
       >등록</button>
       <input type="reset" class="w3-button w3-border" value="리셋">
       
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
</script>


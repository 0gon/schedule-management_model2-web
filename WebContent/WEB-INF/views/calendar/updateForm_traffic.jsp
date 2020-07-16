<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="addDayDrag" class="w3-border w3-modal-content w3-light-grey w3-card-2" style="max-width: 500px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style=""><font size=5>교통비내역 수정</font></div>
        </div>
        <div class="w3-container" >
        <button id='xbutton' onclick="document.getElementById('message').style.display='none';location.reload();" class="w3-button w3-display-topright">&times;</button>
        <div class="calendarForm w3-center  w3-container" id="modal">
            <form id="userinput_u" method="post" action="${ pageContext.servletContext.contextPath }/page/updateProForCal" >
                <input type="hidden" name="id" value="t${trafficVO.id }" >
                <input type="hidden" name="memberId" value="${userVO.id }" >
            	<input type="hidden" name="memberNm" value="${userVO.memberNm }" >
            	<div class="w3-padding">
                     <label>내 용 : </label>
                     <input type="text" id="content_u" value="${trafficVO.content}" name="content" class="w3-input w3-round" style="display: inline;width: 260px;height: 35" placeholder=" 12자 이내">
            	</div>
                	<ul class="w3-ul w3-light-grey">
                    <!--교통비 내용--> 
                    <li>
                    <div id="taxi_content">
                        <div style="padding-top:5px" >
                              출발지 : <input type="text" id="departure" value="${trafficVO.departure}" name="departure" class="w3-input w3-round" style="display: inline;width: 170px;height: 35" placeholder="ex) 중구 장교동">
                        </div>
                              <i class="fa fa-refresh w3-button" onclick="placeChange()" style="padding:8px"></i>
                        <div style="padding-bottom:5px" >
                              도착지 : <input type="text" id="destination" value="${trafficVO.destination}" name="destination" class="w3-input w3-round" style="display: inline;width: 170px;height: 35" placeholder="ex) 경기도 대화동">
                        </div>     
                    </div>    
                    <!--교통비 end--> 
                </li>
        <!--교통비 등록시간-->     
        <li id="taxi_reg">
            <div style="padding-top: 5px;" >
                  출발일시 : <input type="text" readonly="readonly" value="${trafficVO.departureTime}" id="startTime_u" placeholder="연도-월-일 시간" name="departureTime" class=" w3-input w3-round" style="display: inline;width: 130px;height: 35;">&nbsp;
                  도착일시 : <input type="text" readonly="readonly" value="${trafficVO.destinationTime}" id="endTime_u" placeholder="연도-월-일 시간" name="destinationTime" class=" w3-input w3-round" style="display: inline;width: 130px;height: 35" >
            </div>    
       </li>        
                    
       <li>
       <div style="display:inline;width:110px">
	       <label>사용일 : </label>
	       <input type="text" id="useDate_u" value="${trafficVO.useDate}" readonly="readonly"  name="useDate"  class="w3-input w3-border"
	       style="display: inline;width: 100px;">
	       <label>금액 : </label>
	       <input type="text" id="taxiPrice_u" value="${trafficVO.price}"  name="taxiPrice"  class="w3-input w3-border"
	       style="display: inline;width: 100px;"> 원
       </div>
       </li>
	   
       <li>
       <button class="w3-button w3-black" id="commitbtn" onclick="checkValue_u()" >
             등록
       </button>
               <button id="cancelbtn" onclick="document.getElementById('message').style.display='none';event.preventDefault();location.reload();" class="w3-button w3-red">취소</button>
       </li>
                </ul>
            </form>
        </div>
        </div>
    </div>

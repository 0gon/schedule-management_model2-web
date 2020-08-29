<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>POS 휴무관리시스템</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/api/w3css.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   <!--달력 api-->  
<link href="${ pageContext.servletContext.contextPath }/api/fullcalendar-3.9.0/fullcalendar.css" rel="stylesheet"/> 
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/api/fullcalendar-3.9.0/lib/moment.min.js"></script>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/api/fullcalendar-3.9.0/lib/jquery.min.js"></script>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/api/fullcalendar-3.9.0/fullcalendar.js"></script>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/api/fullcalendar-3.9.0/locale-all.js"></script>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/api/fullcalendar-3.9.0/gcal.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/api/httpRequest.js"></script>
<script type="text/javascript">

var dataset = [
    <c:forEach var="list" items="${trafficsLi}" varStatus="status">
            {"id":'t<c:out value="${list.id}" />'
            ,"title":'<c:out value="${list.cardType}" />'
            ,"start":'<c:out value="${list.useDate}" />'
            ,"end":'<c:out value="${list.useDate}" />'
            } 
            ,
    </c:forEach>
    <c:forEach var="list" items="${overtimesLi}" varStatus="status">
            {"id":'o<c:out value="${list.id}" />'
            ,"title":'<c:out value="${list.cardType}" />'
            ,"start":'<c:out value="${list.useDate}" />'
            ,"end":'<c:out value="${list.useDate}" />'
            ,"groupId":'<c:out value="${list.groupId}" />'
            } 
            <c:if test="${!status.last}">,</c:if>
    </c:forEach>
];
    $().ready(function(){
        jQuery("#calendar").fullCalendar({
        	customButtons: {
        	    addButton: {
        	      text: '사용등록',
        	      click: function() {
        	    	  document.getElementById('addDay').style.display='block';
        	      }
        	    }
        	  }
            , selectable: true,
        	    header: {
        	      left: 'prev,next today ',
        	      center: 'title',
        	      right: 'month,agendaWeek,agendaDay listWeek,addButton'
        	    }
            , defaultDate : new Date()
            , nowIndicator: true
            ,now: new Date()
          
            , aspectRatio: 2
            , handleWindowResize:true
            , locale : 'ko'
            , editable : true
            , eventResize: function(event, delta, revertFunc) {
            	revertFunc();
            	/*
            	 var parseEnddate = new Date(event.end);
                 parseEnddate.setDate(parseEnddate.getDate()-1)
                if (!confirm(event.title+"의 종료일을 "+parseEnddate.toISOString().substring(0, 10)+"로 변경합니다.")) {
                  revertFunc();
                }else{
                  var data='id='+event.id+"&useDate="+event.start.format()+"&endDate="+event.end.format();
                  update(data);};*/
                }
            , eventLimit : true
            , events: dataset
            , eventClick: 
                function(calEvent, jsEvent, view) {
            	contentViewForCal(calEvent.id);
                   document.getElementById('addDay').style.display='none';
                   document.getElementById('message').style.display='block';
            }
            , eventDrop: function(event, delta, revertFunc) {
                if (!confirm(event.title + " 등록일을 " + event.start.format() + "로 이동합니다.")) {	
                     revertFunc(); 
                }else{
                  var data='id='+event.id+"&useDate="+event.start.format()+"&groupId="+event.groupId;
          		  updateForCal(data);
          		location.reload();
          		  };
            }
            , navLinks: true
            , navLinkDayClick: function(date, jsEvent) {
        	  }
            , eventDragStop: function(event,jsEvent) {

            } 
            , select: function(useDate) {
        	   //document.getElementById('title').value='';
               document.getElementById('useDate').value=useDate.format();
               /*
               var parseEnddate = new Date(endDate);
               parseEnddate.setDate(parseEnddate.getDate()-1)
           	   document.getElementById('enddate').value=parseEnddate.toISOString().substring(0, 10);
               */
               document.getElementById('addDay').style.display='block';
           }

        });
});
</script>
    
    
<style>
body {
  background-image: url('${ pageContext.servletContext.contextPath }/imgs/bak3.jpeg');
  min-height: 100%;
  background-position: center;
  background-size: cover;
}

#mySidebar {
  background-image: url('${ pageContext.servletContext.contextPath }/imgs/navBack.jpeg');
  min-height: 100%;
  background-position: center;
  background-size: cover;
}
</style>
    <style>
@font-face {
  font-family: 'Do Hyeon';
  font-style: normal;
  font-weight: 400;
  src: url('${ pageContext.servletContext.contextPath }/api/fonts/do-hyeon-v11-latin_korean-regular.eot'); /* IE9 Compat Modes */
  src: local('Do Hyeon Regular'), local('DoHyeon-Regular'),
       url('${ pageContext.servletContext.contextPath }/api/fonts/do-hyeon-v11-latin_korean-regular.eot?#iefix') format('embedded-opentype'), /* IE6-IE8 */
       url('${ pageContext.servletContext.contextPath }/api/fonts/do-hyeon-v11-latin_korean-regular.woff2') format('woff2'), /* Super Modern Browsers */
       url('${ pageContext.servletContext.contextPath }/api/fonts/do-hyeon-v11-latin_korean-regular.woff') format('woff'), /* Modern Browsers */
       url('${ pageContext.servletContext.contextPath }/api/fonts/do-hyeon-v11-latin_korean-regular.ttf') format('truetype'), /* Safari, Android, iOS */
       url('${ pageContext.servletContext.contextPath }/api/fonts/do-hyeon-v11-latin_korean-regular.svg#DoHyeon') format('svg'); /* Legacy iOS */
}
body,h1,h2,h3,h4,h5,h6 {font-family: "Do Hyeon"}

</style>
    
    
<body class="w3-light-grey w3-content" style="max-width:2000px">
  <button id="openNav" class="w3-button w3-black w3-xlarge"  onclick="w3_open()">&#9776;</button>
<!-- Sidebar/menu -->
<div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display:none;width:200px" id="mySidebar"><br>
  <button class="w3-bar-item w3-button w3-large w3-black w3-center"
  onclick="w3_close()">Close <i class="fa fa-close"></i></button>
  <br>
  <div class="w3-container" >
    <img src="${ pageContext.servletContext.contextPath }/imgs/avatar_g2.jpg" onclick="document.getElementById('posInfo').style.display='block'" 
    style="width:55%;margin-left:40px;" class="w3-round"><br><br>
  </div>
  <div class="w3-bar-block">
    <a href="${ pageContext.servletContext.contextPath }/page/schedule" 
    onclick="w3_close()" class="w3-bar-item w3-button w3-padding ">
    <i class="fa fa-users fa-fw w3-margin-right"></i><font color="blue">팀</font> 전체현황</a>
    
    <a href="${ pageContext.servletContext.contextPath }/page/schedule" 
    onclick="w3_close()" class="w3-bar-item w3-button w3-padding ">
    <i class="fa fa-calendar fa-fw w3-margin-right"></i><font color="red">휴무</font> 등록</a>
     
    <a href="${ pageContext.servletContext.contextPath }/page/scheduleHG" 
    onclick="w3_close()" class="w3-bar-item w3-button w3-padding ">
    <i class="fa fa-user fa-fw w3-margin-right"></i><font color="red">책임당직</font> 등록</a>
     
    <a href="${ pageContext.servletContext.contextPath }/page/register" 
    onclick="w3_close()" class="w3-bar-item w3-button w3-padding ">
    <i class="fa fa-credit-card fa-fw w3-margin-right"></i><font color="red">법인카드</font> 사용등록</a> 
    
    <a href="${ pageContext.servletContext.contextPath }/page/register" 
    onclick="w3_close()" class="w3-bar-item w3-button w3-padding ">
    <i class="fa fa fa-server fa-fw w3-margin-right"></i>전체 게시판</a> 
    
    <a href="${ pageContext.servletContext.contextPath }/page/user/logout" onclick="w3_close()" class="w3-bar-item w3-button w3-padding">
    <i class="fa fa-sign-out fa-fw w3-margin-right "></i>로그아웃</a>
    
 <!-- 관리자 영역 -->
 	<hr>
    <a href="${ pageContext.servletContext.contextPath }/page/registerList" 
    onclick="w3_close()" class="w3-bar-item w3-button w3-padding ">
    <i class="fa fa-th-large fa-fw w3-margin-right"></i><font color="blue">법인카드</font> 사용내역</a>
    <a href="${ pageContext.servletContext.contextPath }/page/userList" 
    onclick="w3_close()" class="w3-bar-item w3-button w3-padding ">
    <i class="fa fa fa-user-circle fa-fw w3-margin-right"></i><font color="blue">사원</font> 관리</a> 
    <a href="${ pageContext.servletContext.contextPath }/page/userReg" 
    onclick="w3_close()" class="w3-bar-item w3-button w3-padding ">
    <i class="fa fa-user-plus fa-fw w3-margin-right"></i><font color="blue">사원</font> 등록</a> 
 <!-- 관리자 영역 end -->
    
  </div>
  <!-- 계정정보 모달 -->
  <div id="posInfo" class="w3-modal">
    <div class="w3-modal-content">
      <div class="w3-container">
        <span onclick="document.getElementById('posInfo').style.display='none'" class="w3-button w3-display-topright">&times;</span>
        <p>
        <img src="${ pageContext.servletContext.contextPath }/imgs/pos.jpg" 
        style="width:95%;" class="w3-round">
        </p>
      </div>
    </div>
  </div>
</div>

<div id="main">




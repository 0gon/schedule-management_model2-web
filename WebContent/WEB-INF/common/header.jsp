<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>POS 휴무관리시스템</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap" rel="stylesheet">
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
    <c:forEach var="list" items="${schedules}" varStatus="status">
            {"id":'<c:out value="${list.id}" />'
            ,"title":'<c:out value="${list.dutyVO.title}" />'
            ,"start":'<c:out value="${list.startDate}" />'
            ,"end":'<c:out value="${list.endDate}" />'
            } 
            <c:if test="${!status.last}">,</c:if>
    </c:forEach> 
];
    $().ready(function(){
        jQuery("#calendar").fullCalendar({
        	customButtons: {
        	    addButton: {
        	      text: '일정등록',
        	      click: function() {
        	    	  /*document.getElementById('title').value='';
        	    	  document.getElementById('place').value='';
        	    	  document.getElementById('description').value='';*/
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
            	 var parseEnddate = new Date(event.end);
                 parseEnddate.setDate(parseEnddate.getDate()-1)
             	 
            	
            	
                if (!confirm(event.title+"의 종료일을 "+parseEnddate.toISOString().substring(0, 10)+"로 변경합니다.")) {
                  revertFunc();
                }else{
                  var data='id='+event.id+"&startDate="+event.start.format()+"&endDate="+event.end.format();
                  update(data);};
                }
            , eventLimit : true
            , events: dataset
            , eventClick: 
                function(calEvent, jsEvent, view) {
                   contentView(calEvent.id);
                   document.getElementById('addDay').style.display='none';
                   document.getElementById('message').style.display='block';
            }
            , eventDrop: function(event, delta, revertFunc) {
                if (!confirm(event.title + "을(를) " + event.start.format() + "로 이동합니다.")) {	
                     revertFunc(); 
                }else{
                  var data='id='+event.id+"&startDate="+event.start.format()+"&endDate="+event.end.format()
                  "&dutyId="+event.dutyId;
          		  update(data);};
            }
            , navLinks: true
            , navLinkDayClick: function(date, jsEvent) {
        	  }
            , eventDragStop: function(event,jsEvent) {

            } 
            , select: function(startDate, endDate) {
        	   //document.getElementById('title').value='';
               document.getElementById('startdate').value=startDate.format();
               var parseEnddate = new Date(endDate);
               parseEnddate.setDate(parseEnddate.getDate()-1)
           	   document.getElementById('enddate').value=parseEnddate.toISOString().substring(0, 10);
               document.getElementById('addDay').style.display='block';
           }

        });
});
</script>
    
    
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Do Hyeon", sans-serif}
#mySidebar {
  background-image: url('${ pageContext.servletContext.contextPath }/imgs/navBack.jpeg');
  min-height: 100%;
  background-position: center;
  background-size: cover;
}
</style>
    
    
    
<body class="w3-light-grey w3-content" style="max-width:2000px">

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white" style="z-index:3;width:230px;" id="mySidebar"><br>
  <div class="w3-container">
    <a href="#" onclick="w3_close()" class="w3-hide-large w3-right w3-jumbo w3-padding w3-hover-grey" title="close menu">
      <i class="fa fa-remove"></i>
    </a>
    <img src="${ pageContext.servletContext.contextPath }/imgs/avatar_g2.jpg" style="width:55%;" class="w3-round"><br><br>
    <h4><b>${userVO.memberNm }</b></h4>
    <p class="w3-text-grey">POS part_휴무관리시스템</p>
  </div>
  <div class="w3-bar-block">
    <a href="${ pageContext.servletContext.contextPath }/page/register?memberId=${userVO.memberId}" onclick="w3_close()" class="w3-bar-item w3-button w3-padding w3-text-teal"><i class="fa fa-th-large fa-fw w3-margin-right"></i>일정등록</a> 
    <a href="${ pageContext.servletContext.contextPath }/page/schedule?memberId=${userVO.memberId}" onclick="w3_close()" class="w3-bar-item w3-button w3-padding">
    <i class="fa fa-users fa-fw w3-margin-right"></i>파트원 현황</a> 
    <a href="${ pageContext.servletContext.contextPath }/page/user/logout" onclick="w3_close()" class="w3-bar-item w3-button w3-padding">
    <i class="fa fa-sign-out fa-fw w3-margin-right "></i>로그아웃</a> 
  
  </div>
</nav>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>



<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script>
/*
	$(function() {
		$("#resizable").resizable({});
	});
*/
	function sendEvent() {
		$('#sendinput').submit(function(event) {
			var data = $(this).serialize();
			update(data);
			document.getElementById('addDay').style.display = 'none';
			document.getElementById('message').style.display = 'block';
			event.preventDefault();
		});
	}
	function resetFile() {
		document.getElementById('upload-nameBox').style.display = 'none';
		document.getElementById('upload-display').style.display = 'none';

	}
</script>
<style type="text/css">
.filebox input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}
/* named upload */
.filebox .upload-name {
	display: inline-block;
	padding: .5em .75em;
	font-size: inherit;
	font-family: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #f5f5f5;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
}

pre {
	margin: 0;
	padding: 0;
	font-size: inherit;
	font-family: inherit;
	font-style: inherit;
	font: inherit;
	white-space: pre-wrap;
}
/* imaged preview */
.filebox .upload-display {
	/* 이미지가 표시될 지역 */
	margin-bottom: 5px;
}

@media ( min-width : 768px) {
	.filebox .upload-display {
		display: inline-block;
		margin-right: 5px;
		margin-bottom: 0;
	}
}

.filebox .upload-thumb-wrap {
	/* 추가될 이미지를 감싸는 요소 */
	display: inline-block;
	width: 54px;
	padding: 2px;
	vertical-align: middle;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #fff;
}

.filebox .upload-display img {
	/* 추가될 이미지 */
	display: block;
	max-width: 100%;
	width: 100% \9;
	height: auto;
}

#messageWindow img {
	max-height: 300px;
	width: auto;
	max-width: 100%;
	height: auto;
}

#messageWindow .profileThum {
	width: 30px;
	height: 30px;
	margin-bottom: 5px;
}
</style>
</head>
<body>

	<div class="w3-container " style="margin: 0; padding: 0;">

		<div class="w3-container w3-padding"
			style="height: 340px;  overflow-y: auto; background: inherit;"
			id="messageWindow"></div>

		<!-- 전송창부분   -->
		<form id="form" onsubmit="event.preventDefault();" method="post">

			<div class="w3-container w3-white ">

				<div class="w3-panel w3-round-large w3-border w3-padding ">
					<div id="upload-nameBox" style="display: none;">
						<span class="w3-tag w3-white " style="font-size: 12px;"> <input
							class="upload-name " id="upload-name" disabled="disabled">
							<button class="w3-button w3-padding-small "
								onclick="resetFile();">&times;</button>
						</span>
					</div>

					<table style="width: 100%;">
						<tr>
							<td style="width: 90%;"><textarea id="inputMessage"
									class="w3-input" wrap=hard
									style="border: 0; display: inline-block;"
									onkeydown="checkKey(event.keyCode);"></textarea></td>
							<td>
								<button class="w3-button  w3-teal" type="submit"
									onclick="if((inputMessage.value!='')){send();}"
									id="submitBtn">전송</button>

							</td>
					</table>
					<span class=" w3-margin-left w3-tag w3-white w3-border" >
					<font color="w3-grey" style="font-size:12px;" id="curCount"></font></span>
				</div>


			</div>
			<input type="hidden" name="name" value="${name}"> 
			<input type="hidden" name="studynum" value="${group}">

		</form>
	</div>

	<input id="isEmpty" type="hidden" value="${isEmpty }">
	<!-- 전송창부분 끝 -->

</body>
<script type="text/javascript">
var lastday=${lastday};
var today =getFormatDate(new Date());
 var isEmpty=document.getElementById('isEmpty').value;
 var memArr=new Array();
  var chatdata = [
	    <c:forEach var="list" items="${chatdata}" varStatus="status">
	            {"name":'<c:out value="${list.name}" />'
	            ,"date":'<c:out value="${list.date}" />'
	            ,"content":'<c:out value="${list.content}" />'	               
	            } 
	            <c:if test="${!status.last}">,</c:if>
	       
	    </c:forEach>
	];
  
  ${nameJs};
  ${nameJs2};
  ${nameJs3};
        var textarea = document.getElementById("messageWindow");
        var webSocket = new WebSocket(
   'ws://172.30.1.2:8080${ pageContext.servletContext.contextPath }/webGroup?name='
   		+encodeURIComponent('${name}')+'&group='+encodeURIComponent('${group}'));
        var inputMessage = document.getElementById('inputMessage');
    
    webSocket.onerror = function(event) {     onError(event)   };
    webSocket.onopen = function(event) {     onOpen(event)    };
    webSocket.onmessage = function(event) {   onMessage(event) };
    
    function testProcess(data){
    	var t=data.trim();
		var tmp=t.substr(t.indexOf('[')+1,t.lastIndexOf(']')-1);
    	var cutTmp = tmp.split('] [');
    	for(var i=0;i<cutTmp.length;i++){
    		cutTmp[i].trim();
    	}
    	return cutTmp;
    }
    function onMessage(event) {
    	 if(event.data.substr(0,16)=='===fromServer==='){
      		var serverMessage=event.data.substr(16,event.data.length);
      		var fromServer=serverMessage.split(',');
      		document.getElementById("curMember").innerHTML ="";
      		var count=0;
      		for(var i=0; i<fromServer.length-1;i++){
      			var groupAndName=fromServer[i].split("-");
      			memArr[groupAndName[1]]= groupAndName[1]
      			if(groupAndName[0]==${group}){
      				count++;
      				document.getElementById("curMember").innerHTML +=
      		      		"<a href='#' class='w3-bar-item w3-button w3-center'>"+groupAndName[1]+"</a>"; 
      			}
      		}
      		document.getElementById("curCount").innerHTML ='현재 접속자 : '+count+'명'; 
      		 textarea.scrollTop=textarea.scrollHeight;
      		return;
      	}
     var texts=testProcess(event.data);
     console.log("texts:" + texts)
     if((lastday!=today)||(isEmpty=='true')){
    	 var todaytext=getFormatDate(new Date());
    	 textarea.innerHTML +="<div class='w3-margin-top dateTitle' style='width:100%;' align='center'>"
 			+"<span class='w3-tag w3-white w3-border w3-margin-top'>"+todaytext+"</span></div><br>";
     	lastday=today;
     	isEmpty='false';
     }
    textarea.innerHTML +="<div><table align='left' style='width:100%;'><tr><td>"
		 +"<ul class='w3-ul' style='display:block;' ><li class='w3-large' style='border:none; max-width:80%;'> "
	        +texts[0]+"<br>"
	        +" <div class='w3-panel w3-round-large w3-padding' style='margin:0; background: rgba(0, 150, 136, 0.75); display:inline-block;'>"
	        +" <span class='w3-medium'><font color='white'>"+texts[2]+"</font></span>"
	      +" </div><br><span class='w3-small'>"+texts[1]+"</span></li></ul></td></tr></table></div>"; 
         textarea.scrollTop=textarea.scrollHeight;
         }
    function onOpen(event) {
	for(var i=0;i<chatdata.length;i++){
		  var l0=chatdata[i].name;
		  var l1=chatdata[i].date;
		var l2=chatdata[i].content.replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&amp;/g, "&"); 
		if(l0=='server'){
			textarea.innerHTML +="<div class='w3-margin-top dateTitle' style='width:100%;' align='center'>"
			+"<span class='w3-tag w3-white w3-border w3-margin-top'>"+l2+"</span></div><br>";
		}	
		else if(l0=='${name}'){
			 textarea.innerHTML +="<div><table align='right' width='100%'><tr><td><ul class='w3-ul w3-margin-bottom' style='display:block; '>"
   	  		  +"<li class='w3-large' style='border:none;' align='right'>"
   	  	          +"<span class='w3-small'>"+l1+"</span>&nbsp;"
   	  	         +"<span class='w3-panel w3-round-large w3-padding w3-right '  style='margin:0; max-width:80%; background: rgba(255, 193, 7, 0.75);'>"
   	  	          +"<span class='w3-medium w3-left' style='text-align: left;'>"+l2
   	  	          +"</span></span></li></ul></td></tr></table></div>";
			  
		  }else{
		 textarea.innerHTML +="<div><table align='left' style='width:100%;'><tr><td>"
		 +"<ul class='w3-ul' style='display:block;' ><li class='w3-large' style='border:none; max-width:80%;'> "
	        +map2[l0]+"<br>"
	        +" <div class='w3-panel w3-round-large w3-padding' style='margin:0; background: rgba(0, 150, 136, 0.75); display:inline-block;'>"
	        +" <span class='w3-medium'><font color='white'>"+l2+"</font></span>"
	      +" </div><br><span class='w3-small'>"+l1+"</span></li></ul></td></tr></table></div>"; 
	       
		  
		  
		  }
		
	}
             textarea.scrollTop=textarea.scrollHeight;
    }
    
    
    function onError(event) {     alert(event.data);   }
  
    function send() {
    	today=getFormatDate(new Date());
    	
    	var rename="";
    	 var now = new Date();
    	 var nowText="";
         var nowHour = now.getHours();
         var nowMt = now.getMinutes();
         if(nowMt<10){
        	 nowMt='0'+nowMt;
         }
         if ( nowHour <12   ) {
        
           nowText='오전 ' + nowHour + ':' + nowMt;
         } else if (  nowHour >= 12   ) {
        	 if(nowHour>=13){
        		 nowHour=nowHour-12;
        	 }
        	 nowText='오후 ' + nowHour + ':' + nowMt;
        	 
         	}
         if((lastday!=today)||(isEmpty=='true')){
        	 var todaytext=getFormatDate(new Date());

        	 textarea.innerHTML +="<div class='w3-margin-top dateTitle' style='width:100%;' align='center'>"
     			+"<span class='w3-tag w3-white w3-border w3-margin-top'>"+todaytext+"</span></div><br>";
        	 
         	lastday=today;
         	isEmpty='false';
         }
    	   textarea.innerHTML +="<div><table  align='right' width='100%'><tr><td><ul class='w3-ul w3-margin-bottom' style='display:block; '>"
 			  +"<li class='w3-large' style='border:none;' align='right'>"
 		          +"<span class='w3-small'>"+nowText+"</span>&nbsp;"
 		         +"<span class='w3-panel w3-round-large w3-padding w3-right '  style='margin:0; max-width:80%; background: rgba(255, 193, 7, 0.75);'>"
 		          +"<span class='w3-medium' style='text-align: left;'><pre>"+inputMessage.value+"</pre></span></span></li></ul></td></tr></table></div>";
		 textarea.scrollTop=textarea.scrollHeight;
         webSocket.send(inputMessage.value.trim());
        inputMessage.value = "";
             $("#messageWindow > div").show();
       textarea.scrollTop=textarea.scrollHeight;
    }
    $(document).ready(function() {
        $('#searchText').keyup(function() {
            var k = $(this).val();
          	if(k==""||k==null){
            	k=" ";
            	 var temp = $("#messageWindow > div>table:contains('" + k + "')");
             	$('.dateTitle').show();
                     $(temp).parent().show(); 
                     textarea.scrollTop=textarea.scrollHeight;         
          	}
          	else{
            $("#messageWindow > div").hide();
            var temp = $("#messageWindow > div>table:contains('" + k + "')");
    	$('.dateTitle').show();
            $(temp).parent().show(); }
    })
    })
    function checkFileType(){
    	if (!$('.filebox .upload-hidden')[0].files[0].type.match(/image\//)) {
    		return false;}
    }
    
function checkKey(e){
    if(!e){ e = window.event; }
    var code = e.keyCode ? e.keyCode : e.charCode;
    var shift = e.shiftKey;
    if(!shift&&(code==13)){ 
    	event.preventDefault(); 
    	if((inputMessage.value!='')){
    		send(); }
    	}
	}
	document.getElementById('inputMessage').onkeypress = checkKey;
	
	
	function getFormatDate(date){
	    var year = date.getFullYear();              //yyyy
	    var month = (1 + date.getMonth());          //M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = date.getDate();                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return  year + '-' + month + '-' + day;
	}
</script> 



</body>
</html>
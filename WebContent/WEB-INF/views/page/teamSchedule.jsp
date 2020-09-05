<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
  <div class=" w3-light-grey " style="width: 1402px; margin-left:55px ">
        <div class=" w3-center w3-border w3-border-black w3-light-grey" style="height:38px">
            <div style="margin-top:2px"><font size=5>◆ 공 지 사 항 ◆</font></div>
        </div> 
                <table>
            <tr>
                <td class="w3-border w3-center" width="200px">
                    [1]
                </td>
                <td class="w3-border w3-center w3-sand  w3-hover-orange" width="1000px">
                    안녕하세요 글제목입니다. <i class="fa fa fa-mail-reply-all"></i>
                </td>
                <td class="w3-border w3-center" width="200px">
                    2020.01.20(금)
                </td>
            </tr>
        </table>
    </div>
       <div class="w3-center">
  			  <div class="w3-bar">
            <a href="userList?pageNum=${startPage-bottomLine}" class="w3-bar-item w3-button w3-hover-black">«</a>            
		   </div>
		</div>  <br>
  

<div class="w3-container" style="margin-left:36px;">
    <div class="w3-border w3-light-grey " style="width: 1402px;">
        <div class="w3-container w3-border w3-border-black w3-center w3-teal" style="height:38px">
            <div style="margin-top:2px"><font size=5>${currentYear } 년 ${currentMonth } 월</font></div>
        </div> 
        <div style="float:left;width:200px" class="w3-border  w3-light-gray w3-center">
            <div id ="week${week1 }"><font>일(${week1 }) </font></div>
            <div class="w3-white w3- w3-padding">
             <span class="w3-small">&nbsp;</span><br>
             <span class="w3-small">근무 : ${weekVO1.work } </span><br>
             <span class="w3-small">&nbsp;</span><br>
             <span class="w3-small">&nbsp;</span><br>
            </div>
            <div class="w3-sand w3-border w3-border-black">
             연차
                <div class="w3-white w3-padding"> 
                 <span class="w3-small">홍길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                </div>
            </div>
            <div class="w3-sand w3-border w3-border-black">
             연차
                <div class="w3-white w3-padding">
                 <span class="w3-small">홍길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                </div>
            </div>
        </div>
        <div style="float:left;width:200px" class="w3-border w3-light-gray w3-center">
            <div id="week${week2 }"><font>월(${week2 }) </font></div>
             <div class="w3-white w3-padding">
	             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : ${weekVO2.humu }</span><br>
	             <span class="w3-small">휴가 <font color="grey">(Refresh + 하계)</font> : ${weekVO2.huga }</span><br>
	             <span class="w3-small">교육 : ${weekVO2.education }</span><br>
	             <span class="w3-small">출장 : ${weekVO2.chul }</span><br>
            </div>
            <div class="w3-sand w3-border w3-border-black">
             연차/대휴/공가/보상
                <div class="w3-white w3-padding">
                 <span class="w3-small">홍길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                </div>
            </div>
            <div class="w3-sand w3-border w3-border-black">
             반차
                <div class="w3-white w3-padding">
                 <span class="w3-small">홍길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                </div>
            </div>
             <div class="w3-sand w3-border w3-border-black">
             휴가<font color="grey">(Refresh+하계)</font>
                <div class="w3-white w3-padding">
                 <span class="w3-small">홍길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                </div>
            </div>
              <div class="w3-sand w3-border w3-border-black">
             교육 및 세미나
                <div class="w3-white w3-padding">
                 <span class="w3-small">홍길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                </div>
            </div>
             <div class="w3-sand w3-border w3-border-black">
             출장
                <div class="w3-white w3-padding">
                 <span class="w3-small">홍길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                </div>
            </div>
        </div>
        <div style="float:left;width:200px" class="w3-border w3-light-gray w3-center">
            <div id="week${week3 }"><font>화(${week3 }) </font></div>
             <div class="w3-white w3- w3-padding">
	             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : ${weekVO3.humu }</span><br>
	             <span class="w3-small">휴가 <font color="grey">(Refresh + 하계)</font> : ${weekVO3.huga }</span><br>
	             <span class="w3-small">교육 : ${weekVO3.education }</span><br>
	             <span class="w3-small">출장 : ${weekVO3.chul }</span><br>
            </div>
            ${weekVO3.members[0] }
            ${weekVO3.members[1] }
         
            <div class="w3-sand w3-border w3-border-black">
             연차
                <div class="w3-white w3-padding">
                 <span class="w3-small">홍길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                 <span class="w3-small">김길동</span><br>
                </div>
            </div>
        </div>
        <div style="float:left;width:200px" class="w3-border w3-light-gray w3-center">
            <div id="week${week4 }"><font>수(${week4 }) </font></div>
            <div class="w3-white w3- w3-padding">
	             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : ${weekVO4.humu }</span><br>
	             <span class="w3-small">휴가 <font color="grey">(Refresh + 하계)</font> : ${weekVO4.huga }</span><br>
	             <span class="w3-small">교육 : ${weekVO4.education }</span><br>
	             <span class="w3-small">출장 : ${weekVO4.chul }</span><br>
            </div>
        </div>
        <div style="float:left;width:200px" class="w3-border w3-light-gray w3-center">
            <div id="week${week5 }" ><font >목(${week5 }) </font></div>
            <div class="w3-white w3- w3-padding">
	             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : ${weekVO5.humu }</span><br>
	             <span class="w3-small">휴가 <font color="grey">(Refresh + 하계)</font> : ${weekVO5.huga }</span><br>
	             <span class="w3-small">교육 : ${weekVO5.education }</span><br>
	             <span class="w3-small">출장 : ${weekVO5.chul }</span><br>
            </div>
        </div>
        <div style="float:left;width:200px" class="w3-border w3-light-gray w3-center">
            <div id="week${week6 }" ><font>금(${week6 }) </font></div>
            <div class="w3-white w3- w3-padding">
	             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : ${weekVO6.humu }</span><br>
	             <span class="w3-small">휴가 <font color="grey">(Refresh + 하계)</font> : ${weekVO6.huga }</span><br>
	             <span class="w3-small">교육 : ${weekVO6.education }</span><br>
	             <span class="w3-small">출장 : ${weekVO6.chul }</span><br>
            </div>
        </div>
        <div style="float:left;width:200px" class="w3-border w3-light-gray w3-center">
            <div id="week${week7 }"><font>토(${week7 }) </font></div>
            <div class="w3-white w3- w3-padding">
	             <span class="w3-small">&nbsp;</span><br>
	             <span class="w3-small">근무 :  ${weekVO7.work }</span><br>
	             <span class="w3-small">&nbsp;</span><br>
	             <span class="w3-small">&nbsp;</span><br>
            </div>
        </div>
    </div>
</div>
  
  <script>
    $(document).ready(function(){
		var today = new Date();
	    var todayDate = today.getDate();
	    todayDate = todayDate < 9 ? todayDate = '0'+(todayDate).toString() : today_month ; 
		$('#week'+todayDate).attr({
			'class' :'w3-orange'
		});
		$('#week'+todayDate).append("<i class='fa fa-calendar-check-o'></i>");

		
	});
  </script>
</body>
</html>

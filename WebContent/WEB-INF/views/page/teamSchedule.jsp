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
            <font>일(${week1 })</font><br>
            <div class="w3-white w3- w3-padding">
             <span class="w3-small">&nbsp;</span><br>
             <span class="w3-small">근무 : 1</span><br>
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
            <font>월(${week2 })</font>
             <div class="w3-white w3-padding">
	             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : ${weekVO2.humu }</span><br>
	             <span class="w3-small">휴가 <font color="grey">(리프레쉬 + 하계)</font> : ${weekVO2.huga }</span><br>
	             <span class="w3-small">교육 : ${weekVO2.education }</span><br>
	             <span class="w3-small">출장 : ${weekVO2.chul }</span><br>
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
            <font>화(${week3 })</font>
             <div class="w3-white w3- w3-padding">
	             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : 1</span><br>
	             <span class="w3-small">휴가 <font color="grey">(리프레쉬 + 하계)</font> : 13</span><br>
	             <span class="w3-small">교육 : 8</span><br>
	             <span class="w3-small">출장 : 8</span><br>
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
            <font>수(${week4 })</font>
            <div class="w3-white w3- w3-padding">
	             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : 1</span><br>
	             <span class="w3-small">휴가 <font color="grey">(리프레쉬 + 하계)</font> : 13</span><br>
	             <span class="w3-small">교육 : 8</span><br>
	             <span class="w3-small">출장 : 8</span><br>
            </div>
        </div>
        <div style="float:left;width:200px" class="w3-border w3-light-gray w3-center">
            <font>목(${week5 })</font>
            <div class="w3-white w3- w3-padding">
	             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : 1</span><br>
	             <span class="w3-small">휴가 <font color="grey">(리프레쉬 + 하계)</font> : 13</span><br>
	             <span class="w3-small">교육 : 8</span><br>
	             <span class="w3-small">출장 : 8</span><br>
            </div>
        </div>
        <div style="float:left;width:200px" class="w3-border w3-light-gray w3-center">
            <font>금(${week6 })</font>
            <div class="w3-white w3- w3-padding">
	             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : 1</span><br>
	             <span class="w3-small">휴가 <font color="grey">(리프레쉬 + 하계)</font> : 13</span><br>
	             <span class="w3-small">교육 : 8</span><br>
	             <span class="w3-small">출장 : 8</span><br>
            </div>
        </div>
        <div style="float:left;width:200px" class="w3-border w3-light-gray w3-center">
            <font>토(${week7 })</font>
            <div class="w3-white w3- w3-padding">
	             <span class="w3-small">&nbsp;</span><br>
	             <span class="w3-small">근무 : 1</span><br>
	             <span class="w3-small">&nbsp;</span><br>
	             <span class="w3-small">&nbsp;</span><br>
            </div>
        </div>
    </div>
</div>
  
</body>
</html>

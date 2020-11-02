<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
  <div style="width: 1410px; margin-left:25px;margin-top:60px"> 
        <div class=" w3-center w3-border w3-border-black w3-light-grey" style="height:38px">
            <div style="margin-top:2px"><font size=5>◆ 공 지 사 항 ◆</font>
            <!--슈퍼관리자인 경우만 공지사항 쓸 수 있게끔  -->
               <c:if test="${userVO.grade==3}">
					<span class="w3-right">&nbsp;&nbsp;</span>
		            <span style="margin-top:2px" onclick="boardWriteForm()"
						class="w3-tag w3-round w3-right w3-border w3-border-white w3-hover-opacity w3-hover-white">
						<i class="fa fa-pencil"></i> 쓰 기
					</span>
               </c:if>
			<!--  -->
            </div>
        </div> 
        <!-- 쓰기 버튼 눌렀을 시 나오는 모달 -->
        
		<div id="borderReg" class="w3-modal" style="background-color: rgba(0,0,0,0.0);" >
		    <div id="borderRegDrag" class="w3-modal-content w3-light-grey w3-card-4" style="max-width: 650px;">
		        <div class="w3-container w3-center w3-teal" style="height:38px">
		            <div style="margin-top:2px"><font size=5>작 성 하 기</font></div>
		        </div>
		        <div class="w3-container w3-padding" >
		        <button id="xbutton_b" onclick="document.getElementById('borderReg').style.display='none';" class="w3-button w3-display-topright">&times;</button>
		                <div class="w3-row w3-padding">
		                <form method="post">
		                   <table class="w3-table-all">
		                    <tr>
		                      <td class="w3-sand w3-center" style="width: 200px">제 목 :</td>
		                      <td><input name="title" maxlength="30" id="boardTitle" class="w3-input" required="required" placeholder="30자 이내로 작성해주세요." style="padding: 2px;width: 90%"/></td>
		                    </tr>
		                    <tr>
		                      <td class="w3-sand w3-center" style="padding-top:80px;padding-bottom: 80px">내 용 : </td>
		                      <td> <textarea name="content" maxlength="500" id="boardArea"cols="60" rows="10" style="resize: none;"></textarea></td>
		                    </tr>
		                  </table>
		                  <div class="w3-container w3-padding w3-row"> 
		                        <div class="w3-padding w3-center">
		                            <button id="commitbtn_b" onclick="boardReg()" class="w3-button  w3-black">등록</button>
		                            <button id="cancelbtn_b" class="w3-button  w3-red"
		                                    onclick="document.getElementById('borderReg').style.display='none';" 
		                                    >취소</button>
		                        </div>
		                  </div>
		                </form>
		                </div>
		        </div>
		    </div>
		</div>
        
        <!-- 공지사항 영역 load -->
        <div id="boardList">
        </div>
    </div>
  

<div class="w3-container" style="margin-left:6px;">
    <div class="w3-border w3-light-grey " style="width: 1405px;">
        <div class=" w3-border w3-border-black w3-center w3-teal" style="height:38px">
            <div>
            <button class="w3-button w3-hover-white" style="padding:5px"
            onclick = "teamChangeWeek('pre')"
            > ◀ </button>
            <a class="w3-button w3-hover-white" style="padding:1px;font-size: 23px"
            href='${ pageContext.servletContext.contextPath }/page/teamSchedule'> ${currentYear } 년 ${currentMonth } 월 </a>
            <font size=4 color='black'> -${currentWeek } 주차-</font>
            <button class="w3-button w3-hover-white" style="padding:5px"
            onclick = "teamChangeWeek('nxt')"
            > ▶ </button>
            </div>
        </div> 
        <div style="float:left;width:200px" class="w3-border  w3-gray w3-center">
            <div id ="week${week1 }"><font>일(${week1 }) </font></div>
            <div class="w3-white w3- w3-padding">
             <span class="w3-small">&nbsp;</span><br>
             <span class="w3-small">근무 : ${weekVO1.work } </span><br>
             <span class="w3-small">&nbsp;</span><br>
             <span class="w3-small">&nbsp;</span><br>
            </div>
              <c:if test="${not empty weekVO1.members[0]}">
            	<div class="w3-sand w3-border w3-border-black">
             		주말당직
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO1.members[0]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
            </c:if>
        </div>
        <div style="float:left;width:200px" class="w3-border w3-light-gray w3-center">
            <div id="week${week2 }"><font>월(${week2 }) </font></div>
         	<c:if test="${jungCnt1 == 0}">
	         	<div class="w3-white w3-padding">
		             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : ${weekVO2.humu }</span><br>
		             <span class="w3-small">휴가 <font color="grey">(Refresh + 하계)</font> : ${weekVO2.huga }</span><br>
		             <span class="w3-small">교육 : ${weekVO2.education }</span><br>
		             <span class="w3-small">출장 : ${weekVO2.chul }</span><br>
	            </div>
	             <c:if test="${not empty weekVO2.members[0]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		연차/대휴/공가/보상
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO2.members[0]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
	            <c:if test="${not empty weekVO2.members[1]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		반차
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO2.members[1]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
	            <c:if test="${not empty weekVO2.members[2]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		휴가<font color="grey">(Refresh+하계)</font>
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO2.members[2]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
	            <c:if test="${not empty weekVO2.members[3]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		교육 및 세미나
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO2.members[3]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
	            <c:if test="${not empty weekVO2.members[4]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		출장
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO2.members[4]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
         	</c:if>
         	<c:if test="${jungCnt1 > 0}">
         		<div class="w3-white w3-padding">
	             <span class="w3-small">&nbsp;</span><br>
	             <span class="w3-small"><font color="red"> - 휴 무 - </font></span><br>
	             <span class="w3-small">근무 : ${weekVO2.work } </span><br>
	             <span class="w3-small">&nbsp;</span><br>
                </div>
                <c:if test="${not empty weekVO2.members[0]}">
            	<div class="w3-sand w3-border w3-border-black">
             		당 직
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO2.members[0]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
           		 </c:if>
         	</c:if>
             
        </div>
        <div style="float:left;width:200px" class="w3-border w3-light-gray w3-center">
            <div id="week${week3 }"><font>화(${week3 }) </font></div>
            <c:if test="${jungCnt2 == 0}">
             <div class="w3-white w3- w3-padding">
	             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : ${weekVO3.humu }</span><br>
	             <span class="w3-small">휴가 <font color="grey">(Refresh + 하계)</font> : ${weekVO3.huga }</span><br>
	             <span class="w3-small">교육 : ${weekVO3.education }</span><br>
	             <span class="w3-small">출장 : ${weekVO3.chul }</span><br>
            </div>
            <!-- 유저 List start -->
            <c:if test="${not empty weekVO3.members[0]}">
            	<div class="w3-sand w3-border w3-border-black">
             		연차/대휴/공가/보상
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO3.members[0]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
            </c:if>
            <c:if test="${not empty weekVO3.members[1]}">
            	<div class="w3-sand w3-border w3-border-black">
             		반차
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO3.members[1]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
            </c:if>
            <c:if test="${not empty weekVO3.members[2]}">
            	<div class="w3-sand w3-border w3-border-black">
             		휴가<font color="grey">(Refresh+하계)</font>
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO3.members[2]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
            </c:if>
            <c:if test="${not empty weekVO3.members[3]}">
            	<div class="w3-sand w3-border w3-border-black">
             		교육 및 세미나
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO3.members[3]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
            </c:if>
            <c:if test="${not empty weekVO3.members[4]}">
            	<div class="w3-sand w3-border w3-border-black">
             		출장
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO3.members[4]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
            </c:if>
            </c:if>
            <!-- user 리스트 end -->
            <c:if test="${jungCnt2 > 0}">
         		<div class="w3-white w3-padding">
	             <span class="w3-small">&nbsp;</span><br>
	             <span class="w3-small"><font color="red"> - 휴 무 - </font></span><br>
	             <span class="w3-small">근무 : ${weekVO3.work } </span><br>
	             <span class="w3-small">&nbsp;</span><br>
                </div>
                <c:if test="${not empty weekVO3.members[0]}">
            	<div class="w3-sand w3-border w3-border-black">
             		당 직
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO3.members[0]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
           		 </c:if>
         	</c:if>
        </div>
        <div style="float:left;width:200px" class="w3-border w3-light-gray w3-center">
            <div id="week${week4 }"><font>수(${week4 }) </font></div>
            <c:if test="${jungCnt3 == 0}">
	            <div class="w3-white w3- w3-padding">
		             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : ${weekVO4.humu }</span><br>
		             <span class="w3-small">휴가 <font color="grey">(Refresh + 하계)</font> : ${weekVO4.huga }</span><br>
		             <span class="w3-small">교육 : ${weekVO4.education }</span><br>
		             <span class="w3-small">출장 : ${weekVO4.chul }</span><br>
	            </div>
	             <c:if test="${not empty weekVO4.members[0]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		연차/대휴/공가/보상
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO4.members[0]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
	            <c:if test="${not empty weekVO4.members[1]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		반차
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO4.members[1]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
	            <c:if test="${not empty weekVO4.members[2]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		휴가<font color="grey">(Refresh+하계)</font>
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO4.members[2]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
	            <c:if test="${not empty weekVO4.members[3]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		교육 및 세미나
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO4.members[3]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
	            <c:if test="${not empty weekVO4.members[4]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		출장
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO4.members[4]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
            </c:if>
            <c:if test="${jungCnt3 > 0}">
         		<div class="w3-white w3-padding">
	             <span class="w3-small">&nbsp;</span><br>
	             <span class="w3-small"><font color="red"> - 휴 무 - </font></span><br>
	             <span class="w3-small">근무 : ${weekVO4.work } </span><br>
	             <span class="w3-small">&nbsp;</span><br>
                </div>
                <c:if test="${not empty weekVO4.members[0]}">
            	<div class="w3-sand w3-border w3-border-black">
             		당 직
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO4.members[0]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
           		 </c:if>
         	</c:if>
        </div>
        <div style="float:left;width:200px" class="w3-border w3-light-gray w3-center">
            <div id="week${week5 }" ><font >목(${week5 }) </font></div>
            <c:if test="${jungCnt4 == 0}">
	            <div class="w3-white w3- w3-padding">
		             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : ${weekVO5.humu }</span><br>
		             <span class="w3-small">휴가 <font color="grey">(Refresh + 하계)</font> : ${weekVO5.huga }</span><br>
		             <span class="w3-small">교육 : ${weekVO5.education }</span><br>
		             <span class="w3-small">출장 : ${weekVO5.chul }</span><br>
	            </div>
	             <c:if test="${not empty weekVO5.members[0]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		연차/대휴/공가/보상
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO5.members[0]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
	            <c:if test="${not empty weekVO5.members[1]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		반차
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO5.members[1]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
	            <c:if test="${not empty weekVO5.members[2]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		휴가<font color="grey">(Refresh+하계)</font>
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO5.members[2]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
	            <c:if test="${not empty weekVO5.members[3]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		교육 및 세미나
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO5.members[3]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
	            <c:if test="${not empty weekVO5.members[4]}">
	            	<div class="w3-sand w3-border w3-border-black">
	             		출장
		                <div class="w3-white w3-padding">
				          	 <c:forEach var="member" items="${weekVO5.members[4]}">
				                 <span class="w3-small"> ${member.memberNm}</span><br>
				          	 </c:forEach>
		                </div>
		            </div>
	            </c:if>
            </c:if>
            <c:if test="${jungCnt4 > 0}">
         		<div class="w3-white w3-padding">
	             <span class="w3-small">&nbsp;</span><br>
	             <span class="w3-small"><font color="red"> - 휴 무 - </font></span><br>
	             <span class="w3-small">근무 : ${weekVO5.work } </span><br>
	             <span class="w3-small">&nbsp;</span><br>
                </div>
                <c:if test="${not empty weekVO5.members[0]}">
            	<div class="w3-sand w3-border w3-border-black">
             		당 직
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO5.members[0]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
           		 </c:if>
         	</c:if>
        </div>
        <div style="float:left;width:200px" class="w3-border w3-light-gray w3-center">
            <div id="week${week6 }" ><font>금(${week6 }) </font></div>
            <c:if test="${jungCnt5 == 0}">
            <div class="w3-white w3- w3-padding">
	             <span class="w3-small">휴무 <font color="grey">(반차포함)</font> : ${weekVO6.humu }</span><br>
	             <span class="w3-small">휴가 <font color="grey">(Refresh + 하계)</font> : ${weekVO6.huga }</span><br>
	             <span class="w3-small">교육 : ${weekVO6.education }</span><br>
	             <span class="w3-small">출장 : ${weekVO6.chul }</span><br>
            </div>
             <c:if test="${not empty weekVO6.members[0]}">
            	<div class="w3-sand w3-border w3-border-black">
             		연차/대휴/공가/보상
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO6.members[0]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
            </c:if>
            <c:if test="${not empty weekVO6.members[1]}">
            	<div class="w3-sand w3-border w3-border-black">
             		반차
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO6.members[1]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
            </c:if>
            <c:if test="${not empty weekVO6.members[2]}">
            	<div class="w3-sand w3-border w3-border-black">
             		휴가<font color="grey">(Refresh+하계)</font>
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO6.members[2]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
            </c:if>
            <c:if test="${not empty weekVO6.members[3]}">
            	<div class="w3-sand w3-border w3-border-black">
             		교육 및 세미나
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO6.members[3]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
            </c:if>
            <c:if test="${not empty weekVO6.members[4]}">
            	<div class="w3-sand w3-border w3-border-black">
             		출장
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO6.members[4]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
            </c:if>
            </c:if>
            <c:if test="${jungCnt5 > 0}">
         		<div class="w3-white w3-padding">
	             <span class="w3-small">&nbsp;</span><br>
	             <span class="w3-small"><font color="red"> - 휴 무 - </font></span><br>
	             <span class="w3-small">근무 : ${weekVO6.work } </span><br>
	             <span class="w3-small">&nbsp;</span><br>
                </div>
                <c:if test="${not empty weekVO6.members[0]}">
            	<div class="w3-sand w3-border w3-border-black">
             		당 직
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO6.members[0]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
           		 </c:if>
         	</c:if>
        </div>
        <div style="float:left;width:200px" class="w3-border w3-gray w3-center">
            <div id="week${week7 }"><font>토(${week7 }) </font></div>
            <div class="w3-white w3- w3-padding">
	             <span class="w3-small">&nbsp;</span><br>
	             <span class="w3-small">근무 :  ${weekVO7.work }</span><br>
	             <span class="w3-small">&nbsp;</span><br>
	             <span class="w3-small">&nbsp;</span><br>
            </div>
            <c:if test="${not empty weekVO7.members[0]}">
            	<div class="w3-sand w3-border w3-border-black">
             		주말당직
	                <div class="w3-white w3-padding">
			          	 <c:forEach var="member" items="${weekVO7.members[0]}">
			                 <span class="w3-small"> ${member.memberNm}</span><br>
			          	 </c:forEach>
	                </div>
	            </div>
            </c:if>
        </div>
    </div>
</div>
    <!-- 게시판 모달 상세보기-->
<div id="borderDetail" class="w3-modal" style="background-color: rgba(0,0,0,0.0);padding:5px;width:700px;margin-left:27%" >
</div>
  
  <script>
	//공지사항 쓰기폼 모달
	function boardWriteForm() {
		document.getElementById('borderReg').style.display = 'block';
	}
	function boardDetail(boardId,pageNum) {
		document.getElementById('borderDetail').style.display = 'block';
		$('#borderDetail').load('${ pageContext.servletContext.contextPath }/page/board/boardAllContent?bid='+boardId+'&pnum='+pageNum)
	}
	$('#borderDetail').draggable();
	
	function boardReg(){
		event.preventDefault();
		var memberId = '<c:out value="${userVO.id }"/>'
	    var memberNm = '<c:out value="${userVO.memberNm }"/>'
		var content = $('#boardArea').val();
		var title = $('#boardTitle').val();
		if(title==""){
			alert("제목을 입력해주세요.");
		}else{
		    $('#commitbtn_b, #cancelbtn_b, #xbutton_b').attr('disabled',true); 
		    $('#commitbtn_b').html('<i class="fa fa-spinner fa-spin" style="font-size:16px;padding:3px" ></i>');
		 	document.getElementById('borderReg').style.display = 'none';
			$.ajax({
				 url : "${ pageContext.servletContext.contextPath }/page/board/boardAllReg", 
		    	 method : "GET",  
		    	 dataType:"text",
		    	 data:{
		    			"title":title,
		    			"memberId":memberId,
		    			"memberNm":memberNm,
		    			"content":content,
		    			}, 
	              success: function(data){
	            	  $('#boardList').html(data);
	            	  $('#commitbtn_b, #cancelbtn_b, #xbutton_b').attr('disabled',false); 
	            	  $('#commitbtn_b').html('등록');
	      		 	
				}, 
			error: function(request, status, error) {
				alert(error);
			}
			});
		}
	}
	function teamChangeWeek(action) {
    	var sendDate = '${currentYear }${currentMonth}${currentDay}'
		location.href='${ pageContext.servletContext.contextPath }/page/teamSchedule?sdate='+sendDate+'&action='+action;			
	}
    $(document).ready(function(){
    	//오늘 날짜에 해당하는 영역 주황색 음영
		var today = new Date();
	    var todayDate = today.getDate();
	    todayDate = todayDate < 10 ? todayDate = '0'+(todayDate).toString() : todayDate ; 
		$('#week'+todayDate).attr({
			'class' :'w3-orange'
		});
		$('#week'+todayDate).append("<i class='fa fa-calendar-check-o'></i>");
		
		//공지사항 로드
		$('#boardList').load('${ pageContext.servletContext.contextPath }/page/board/boardAllList');
		
	
	});
  </script>
</body>
</html>

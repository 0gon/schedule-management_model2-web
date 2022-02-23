<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="//mugifly.github.io/jquery-simple-datetimepicker/jquery.simple-dtpicker.css">
<link rel="stylesheet" 
href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" 
integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" 
crossorigin="anonymous">
<link rel="stylesheet" href="${ pageContext.servletContext.contextPath }/api/w3css.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap" rel="stylesheet">

 <meta charset="UTF-8">
 
        <div class="w3-container " id="cardList" >
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
	<c:if test="${count_o>0}">
       	<table id = "modalMonth" class=" table-bordered" style="margin-left: auto; margin-right: auto; margin-top : 50px; text-align : center;" width ="100%">
		    <tr class="w3-black" bgcolor = black >
		      <th class="w3-center"  style = "border:1px solid black; border-collapse:collapse;"><font style ="font-family : Do Hyeon;"color ="white">사용일자</font></th>
		      <th class="w3-center" style = "border:1px solid black; border-collapse:collapse; "><font style ="font-family : Do Hyeon;"color ="white">등록인</font></th>
		      <th class="w3-center" style = "border:1px solid black; border-collapse:collapse; "><font style ="font-family : Do Hyeon;"color ="white">동행인</font></th>
		      <th class="w3-center" style = "border:1px solid black; border-collapse:collapse; "><font style ="font-family : Do Hyeon;"color ="white">총 인원</font></th>
		      <th class="w3-center" style = "border:1px solid black; border-collapse:collapse; "><font style ="font-family : Do Hyeon;"color ="white">내용</font></th>
		      <th class="w3-center" style = "border:1px solid black; border-collapse:collapse; "><font style ="font-family : Do Hyeon;"color ="white">음식점</font></th>
		      <th class="w3-center" style = "border:1px solid black; border-collapse:collapse; "><font style ="font-family : Do Hyeon;"color ="white">카드소지자</font></th>
		      <th class="w3-center" style = "border:1px solid black; border-collapse:collapse; "><font style ="font-family : Do Hyeon;"color ="white">금액</font></th>
		      
		    </tr>
     <c:forEach var="overtime" items="${overtimes}" >
     <tr height= "40px" bgcolor = #f1f1f1 style = "border:1px solid black; border-collapse:collapse; bordercolor : black">
      <td   width= "100px">
      <font style ="font-family : Do Hyeon;">
       	${overtime.useDate}
       	</font>
      </td>
      <td width= "80px" class="w3-border">
       <font style ="font-family : Do Hyeon;"> 
       	${overtime.memberNm}
       	</font>
      </td>
      <td style="word-break:break-all;">
      <c:if test="${not empty overtime.targetListName}">
       <font style ="font-family : Do Hyeon;">
       	${overtime.targetListName} 
       	</font>
      </c:if>
       <c:if test="${empty overtime.targetListName}">
       
           <font color="grey">-</font>
       </c:if>
      </td>
        <td width= "80px">
         <font style ="font-family : Do Hyeon;">
       ${overtime.targetListCount} 명
       </font>
      </td>
      <td>
       <font style ="font-family : Do Hyeon;">
       	${overtime.content}
       	</font>
      </td> 
      <td >
       <font style ="font-family : Do Hyeon;" >
       	${overtime.shopName}
       	</font>
      </td>
      <td width= "80px" >
       <font style ="font-family : Do Hyeon;">
       	${overtime.cardHolder}
       	</font>
      </td> 
       <td  width= "100px">
        <font style ="font-family : Do Hyeon;">
       	${overtime.price} 원
       	</font>
       </td>
    </tr>
    </c:forEach>   
  </table>
     </c:if>
     <br>
	        	<br><br>
	        </div>
     			<form action="${pageContext.servletContext.contextPath }/page/register" method="post">
	        	<button class="w3-black w3-button" style ="font-size : 15px; font-family : Do Hyeon; margin-left: auto; margin-right: auto;margin-bottom: 50px; margin-top : 10px; padding : 8px 16px" onclick="document.getElementById('cardList').style.display='none';">닫기</button>
	        	</form>
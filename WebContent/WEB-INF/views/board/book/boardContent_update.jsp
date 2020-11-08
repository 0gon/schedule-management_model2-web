<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="w3-modal-content w3-light-grey w3-card-4" style="max-width: 650px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style="margin-top:2px"><font size=5>수 정 하 기</font></div>
        </div>
        <div class="w3-container w3-padding" >
        <span onclick="document.getElementById('borderDetail').style.display='none';" class="w3-button w3-display-topright">&times;</span>
                <div class="w3-row w3-padding">
                <form method="post">
                   <table class="w3-table-all" >
                    <tr>
                      <td style="width:15%" class="w3-sand w3-center">책 제목 :</td>
                      <td>
                      <input name="bookName" maxlength="35" id="bookName_u" required="required" 
                      style="padding: 2px;width: 90%" value="${boardVO.bookName}"/>
                      </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center">작 성 자 : </td>
                      <td> ${boardVO.memberNm }</td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center">작 성 일 : </td>
                      <td class="w3-light-gray"> ${boardVO.formatDate }</td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center">가격 : </td>
                      <td class="w3-white"> 
                      <input name="price" maxlength="30" id="price_u"  required="required" 
                      style="padding: 2px;width: 60%" value="${boardVO.price }"/>
                      <font color="grey"> * 숫자만 입력해주세요.</font>
                     </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center" style="padding-top:30px;padding-bottom: 30px">구매URL : </td>
                      <td>
                      <textarea name="pchURL" maxlength="500" id="pchURL_u"cols="60" rows="3" style="resize: none;">${boardVO.pchURL }</textarea>
                      </td></tr>
                  </table>
                  <div class="w3-container w3-padding w3-row">
                        <div class="w3-padding w3-center">
                            <button onclick="boardUpdate()" class="w3-button  w3-black">수정</button>
                            <button class="w3-button  w3-red"
                                    onclick="document.getElementById('borderDetail').style.display='none';" 
                                    >취소</button>
                        </div>
                 </div>
                  </form>
                </div>
        </div>
    </div>
    
    <script>
	
	function boardUpdate(){
		event.preventDefault();
		var boardId = ${boardVO.id };
		var bookName = $('#bookName_u').val();
		var price = $('#price_u').val();
		var pchURL = $('#pchURL_u').val();
		
		$.ajax({
			 url : "${ pageContext.servletContext.contextPath }/page/board/book/boardUpdatePro", 
	    	 method : "GET",  
	    	 dataType:"text",
	    	 data:{
	    			"boardId":boardId,
	    			"bookName":bookName,
	    			"price":price,
	    			"pchURL":pchURL,
	    			}, 
              success: function(data){
            	  $('#borderDetail').html(data);
			},
		error: function(request, status, error) {
			alert(error);
		}
	});
	}
    </script>
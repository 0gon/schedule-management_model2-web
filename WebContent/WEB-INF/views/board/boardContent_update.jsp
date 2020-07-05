<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="" class="w3-modal-content w3-light-grey w3-card-4" style="max-width: 700px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style="margin-top:2px"><font size=5>수 정 하 기</font></div>
        </div>
        <div class="w3-container w3-padding" >
        <span onclick="document.getElementById('borderDetail').style.display='none';" class="w3-button w3-display-topright">&times;</span>
                <div class="w3-row w3-padding">
                <form method="post">
                   <table class="w3-table-all" >
                    <tr>
                      <td style="width:15%" class="w3-sand w3-center">제 목 :</td>
                      <td>
                      <input name="title" maxlength="30" id="boardTitle_update" class="w3-input" required="required" 
                      style="padding: 2px;width: 90%" value="${boardVO.title}"/>
                      </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center">작 성 자 : </td>
                      <td> ${boardVO.memberNm }</td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center">작 성 일 : </td>
                      <td> ${boardVO.formatDate }</td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center" style="padding-top:70px;padding-bottom: 70px">내 용 : </td>
                      <td>
                      <textarea name="content" maxlength="500" id="boardArea_update"cols="60" rows="10" style="resize: none;">${boardVO.content }</textarea>
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
	$('#boardTitle_update').on('keyup', function() {
		if($(this).val().length > 30) {
			alert("글자수는 30자로 이내로 제한됩니다.");
			$(this).val($(this).val().substring(0, 30));
		}
	});
	
	$('#boardArea_update').on('keyup', function() {
		if($(this).val().length > 500) {
			alert("글자수는 500자로 이내로 제한됩니다.");
			$(this).val($(this).val().substring(0, 500));
		}
	});
	function boardUpdate(){
		event.preventDefault();
		var boardId = ${boardVO.id };
		var content = $('#boardArea_update').val();
		var title = $('#boardTitle_update').val();
		
		$.ajax({
			 url : "${ pageContext.servletContext.contextPath }/page/board/boardUpdatePro", 
	    	 method : "GET",  
	    	 dataType:"text",
	    	 data:{
	    			"boardId":boardId,
	    			"title":title,
	    			"content":content,
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
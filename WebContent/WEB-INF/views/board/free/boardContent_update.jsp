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
                      <td style="width:15%" class="w3-sand w3-center">글 제목 :</td>
                      <td>
                      <input name="title" maxlength="35" id="title_u" required="required" 
                      style="padding: 2px;width: 90%" value="${boardVO.title}"/>
                      </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center">작 성 자 : </td>
                      		<c:if test="${boardVO.openYn == 'Y'}">
		                      <td id="openName"> ${boardVO.memberNm }</td>
                      		</c:if>
                      		<c:if test="${boardVO.openYn == 'N'}">
		                      <td id="openName"> 비공개</td>
                      		</c:if>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center">작 성 일 : </td>
                      <td class="w3-light-gray"> ${boardVO.formatDate }</td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center">공개여부 : </td>
                     <td >
                          공개: <input type="radio" value="Y" onclick="openChange_u(1)" id="openYn_u" name="openYn" checked="checked" class="w3-radio" style="width:17px;height:17px">
                 &nbsp;&nbsp;  비공개: <input type="radio" onclick="openChange_u(2)" value="N" name="openYn" class="w3-radio" style="width:17px;height:17px">
                     </td>
                    </tr>
                    
                    <tr>
                      <td class="w3-sand w3-center" style="padding-top:30px;padding-bottom: 30px">내용 : </td>
                      <td>
                      <textarea name="content" maxlength="500" id="content_u"cols="60" rows="3" style="resize: none;">${boardVO.content }</textarea>
                      </td></tr>
                  </table>
                  <div class="w3-container w3-padding w3-row">
                        <div class="w3-padding w3-center">
                            <button onclick="boardUpdate1()" class="w3-button  w3-black">수정</button>
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
	function openChange_u(type) {
		if(type==1){
			$('#openName').text('${userVO.memberNm }');
		}else if(type==2){
			$('#openName').text('비공개');
		}
	}
	function boardUpdate1(){
		event.preventDefault();
		var boardId = ${boardVO.id };
		var title = $('#title_u').val();
		var content = $('#content_u').val();
		var isOpenYn = $('#openYn_u').is(':checked');
		var openYn = 'Y';
		if(!isOpenYn){
			openYn = 'N';
		}
		$.ajax({
			 url : "${ pageContext.servletContext.contextPath }/page/board/free/boardUpdatePro", 
	    	 method : "GET",  
	    	 dataType:"text",
	    	 data:{
	    			"boardId":boardId,
	    			"title":title,
	    			"content":content,
	    			"openYn":openYn,
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
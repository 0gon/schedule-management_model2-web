<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="w3-modal-content w3-light-grey w3-card-4" style="max-width: 850px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style="margin-top:2px"><font size=5>상 세 보 기</font></div>
        </div>
        <div class="w3-container w3-padding" >
        <span onclick="exitDoit()" class="w3-button w3-display-topright">&times;</span>
                <div class="w3-row w3-padding">
                <!-- 세션아이디와 작성자 동일할 경우 update, delete  memberId-->
                	<button class="w3-button w3-black w3-right" onclick="exitDoit()" style="margin-top:-5px;">닫기</button>
                <c:if test="${boardVO.memberId == userVO.id }">
                	<button class="w3-button w3-red w3-right" onclick="boardDelete(${boardVO.id})" style="margin-top:-5px;margin-right:10px">삭제</button>
                	<button class="w3-button w3-teal w3-right" onclick="boardUpdate(${boardVO.id})" style="margin-top:-5px;margin-right:10px">수정</button>
                </c:if>
                	<br><br>
                <!--  update,delete end-->	
                   <table class="w3-table-all">
                    <tr>
                      <td class="w3-sand w3-center" style="width:90px">글 제목 :</td>
                      <td><font color="grey">${boardVO.title}</font> </td>
                      <td class="w3-sand w3-center">작 성 일 : </td>
                      <td> ${boardVO.formatDate }</td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center">작 성 자 : </td>
                      <td colspan="3"> ${boardVO.memberNm }</td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center">책 제목 : </td>
                      <td> ${boardVO.bookName }</td>
                      <td class="w3-sand w3-center">가 격 : </td>
                      <td> ${boardVO.price } 원</td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center">구매URL :</td>
                      <td colspan="3" style="word-break:break-all"> ${boardVO.pchURL }</td>
                    </tr>
                  </table>
                </div>
        </div>
    </div>
    
    <script>
	function boardUpdate(boardId){
		$('#borderDetail').load('${ pageContext.servletContext.contextPath }/page/board/book/boardUpdate?bid='+boardId);
	}
	function boardDelete(boardId){
		if(confirm("정말로 삭제하시겠습니까? ")){
			var boardPageNum = '<c:out value="${boardPageNum}"/>'
			document.getElementById('borderDetail').style.display='none';
			$.ajax({
				 url : "${ pageContext.servletContext.contextPath }/page/board/book/boardDelete", 
		    	 method : "GET",  
		    	 dataType:"text",
		    	 data:{ 
		    			"bid":boardId,
		    			"bpnum":boardPageNum,
		    			}, 
	              success: function(data){
	            	  $('#bookArea').html(data);
					},
			error: function(request, status, error) {
				alert(error);
			}
			});	
		}	
	}
	function exitDoit(){
		var boardPageNum = '<c:out value="${boardPageNum}"/>'
		document.getElementById('borderDetail').style.display='none';
	    $('#bookArea').load('${ pageContext.servletContext.contextPath }/page/board/book/boardList?pageNum='+boardPageNum)
	}
    </script>
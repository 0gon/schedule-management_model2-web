<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="w3-modal-content w3-light-grey w3-card-4" style="max-width: 700px;">
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
                      <td style="width:15%" class="w3-sand w3-center">제 목 :</td>
                      <!-- 댓글 갯수 표시 -->
                       <c:if test="${count==0}">
	                      <td>${boardVO.title} </td>
                       </c:if>
                       <c:if test="${count>0}">
	                      <td>${boardVO.title} <font color="red">(${count})</font></td>
                       </c:if>
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
                      <td>${boardVO.content }</tr>
                   
                  </table>
                    <div class="w3-container w3-padding w3-row">
                        <div class="w3-col" style="width:90%">
                    <form id="commentForm" method="post">
                        <input id="commentInput" maxlength="50" class="w3-input w3-right-grey w3-card-2" style="margin-top:8px;"/>
                    </form>
                        </div>
                        <div class="w3-col w3-padding" style="width:5px">
                            <button onclick="commentAjax()" class="w3-button w3-card-4 w3-black">댓글</button>
                        </div>
                  </div>
                  <!--  댓글 영역, ajax로 load-->
                  <div id = "commentDiv">
                  <table class="w3-table w3-border">
					<tr class="w3-border">
						<th></th>
						<c:if test="${count==0 }">
						<td style="padding-top: 8px;"><label style="margin-left: -40px">[댓글목록]</label></td>
						</c:if>
						<c:if test="${count>0 }">
						<td style="padding-top: 8px;"><label style="margin-left: 200px">[댓글목록] <font color="red">(${count })</font></label></td>
							<td class="w3-button w3-center" style="padding-top: 8px;"></td>
						</c:if>
					</tr>
					 <!--  댓글 영역 -->
					 
					 	<c:if test="${count==0 }">
			<tr>
				<td colspan="2" style="width: 10%; padding: 4px" class="w3-center">
				 *** 등록된 댓글이 없습니다. ***
				</td>
			</tr>
						</c:if>
					 
		<c:forEach var="comment" items="${comments}">
			<tr>
				<th style="width: 10%; padding: 4px" class="w3-pale-blue w3-center">${comment.memberNm }
				</th>
				<td style="padding: 4px" class="w3-pale-blue">${comment.formatDate }
				</td>
				<td style="padding: 4px; width: 5%" class="w3-pale-blue"></td>
			</tr>
			<!-- 자신댓글인 경우 삭제 아이콘 -->
			 <c:if test="${comment.memberId == userVO.id }">
				<tr>
					<td colspan="2" class="w3-white">> ${comment.content }</td>
					<td class="w3-white" onclick="commentDelete(${comment.id})"><i class="fa fa-close w3-button w3-white"
						style="padding: 3px"></i></td>
				</tr>
			 </c:if>
			<!-- 자신의 댓글이 아닌 경우  -->
			 <c:if test="${comment.memberId != userVO.id }">
				<tr>
					<td colspan="3" class="w3-white">> ${comment.content }</td>
				</tr>
			 </c:if>
		</c:forEach>
</table>
<!--  페이징 처리 -->
	<c:if test="${count>0 }">
			<div class="w3-center" style="margin-top:3px">
				<div class="w3-bar">
					<c:if test="${startPage>bottomLine }">
						<a	onclick="$('#borderDetail').load('${ pageContext.servletContext.contextPath }/page/board/boardContent?bid='+${boardId}+'&pageNum=${startPage-bottomLine}');"
							class="w3-bar-item w3-button w3-hover-black" style="padding:9px">«</a>
					</c:if>
					<c:forEach var="i" begin="${startPage }" end="${endPage}">
						<c:if test="${i!=currentPage }">
							<a
								onclick="$('#borderDetail').load('${ pageContext.servletContext.contextPath }/page/board/boardContent?bid='+${boardId}+'&pageNum=${i }');"
								class="w3-bar-item w3-button w3-hover-black" style="padding:9px">${i }</a>
						</c:if>
						<c:if test="${i==currentPage }">
							<a
								onclick="$('#borderDetail').load('${ pageContext.servletContext.contextPath }/page/board/boardContent?bid='+${boardId}+'&pageNum=${i }');"
								class="w3-bar-item w3-black w3-button" style="padding:9px">${i }</a>
						</c:if>
					</c:forEach>
					<c:if test="${endPage<pageCount }">

						<a
							onclick="$('#borderDetail').load('${ pageContext.servletContext.contextPath }/page/board/boardContent?bid='+${boardId}+'&pageNum=${startPage+bottomLine}');"
							class="w3-bar-item w3-button w3-hover-black" style="padding:9px">»</a>
					</c:if>
				</div>
			</div>
		</c:if>
                <!--  페이징 end -->  
                  </div>
                </div>
        </div>
    </div>
    
    <script>
	$('#commentInput').on('keyup', function() {
		if($(this).val().length > 50) {
			alert("댓글은 50자로 이내로 제한됩니다.");
			$(this).val($(this).val().substring(0, 50));
		}
	});
	function commentDelete(commentId){
		event.preventDefault();
		var boardId = '<c:out value="${boardVO.id}"/>'
		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				 url : "${ pageContext.servletContext.contextPath }/page/board/commentDelete", 
		    	 method : "GET",  
		    	 dataType:"text",
		    	 data:{ 
		    			"cid":commentId,
		    			"boardId":boardId,
		    			}, 
	              success: function(data){
	            	  
	            	  $('#borderDetail').html(data);
					},
			error: function(request, status, error) {
				alert(error);
			}
			});	
		}
	}
	function boardUpdate(boardId){
		$('#borderDetail').load('${ pageContext.servletContext.contextPath }/page/board/boardUpdate?bid='+boardId);
	}
	function boardDelete(boardId){
		if(confirm("정말로 삭제하시겠습니까?\n\n***삭제 시 등록된 댓글도 함께 삭제됩니다.***")){
			var boardPageNum = '<c:out value="${boardPageNum}"/>'
			document.getElementById('borderDetail').style.display='none';
			$.ajax({
				 url : "${ pageContext.servletContext.contextPath }/page/board/boardDelete", 
		    	 method : "GET",  
		    	 dataType:"text",
		    	 data:{ 
		    			"bid":boardId,
		    			"bpnum":boardPageNum,
		    			}, 
	              success: function(data){
	            	  $('#boardContent').html(data);
					},
			error: function(request, status, error) {
				alert(error);
			}
			});	
		}	
	}
	function commentAjax(){
		event.preventDefault();
		var memberNm = '<c:out value="${userVO.memberNm}"/>'
		var memberId = '<c:out value="${userVO.id}"/>'
		var boardId = '<c:out value="${boardVO.id}"/>'
		var content = $('#commentInput').val();
		if(content==""){
			alert("내용을 입력해주세요.")
		}else{
			$.ajax({
				 url : "${ pageContext.servletContext.contextPath }/page/board/commentReg", 
		    	 method : "GET",  
		    	 dataType:"text",
		    	 data:{
		    			"memberNm":memberNm,
		    			"memberId":memberId,
		    			"boardId":boardId,
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
	}
	function exitDoit(){
		var boardPageNum = '<c:out value="${boardPageNum}"/>'
		document.getElementById('borderDetail').style.display='none';
	    $('#boardContent').load('${ pageContext.servletContext.contextPath }/page/board/boardList?pageNum='+boardPageNum)
	}
    </script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="w3-modal-content w3-light-grey w3-card-4" style="max-width: 700px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style="margin-top:2px"><font size=5>상 세 보 기</font></div>
        </div>
        <div class="w3-container w3-padding" >
        <span onclick="document.getElementById('borderDetail').style.display='none';" class="w3-button w3-display-topright">&times;</span>
                <div class="w3-row w3-padding">
                	<button class="w3-button w3-red w3-right" style="margin-top:-5px">삭제</button>
                	<button class="w3-button w3-teal w3-right" style="margin-top:-5px;margin-right:10px">수정</button>
                	<br><br>
                   <table class="w3-table-all">
                    <tr>
                      <td style="width:15%" class="w3-sand w3-center">제 목 :</td>
                      <td>${boardVO.title} (6)</td>
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
                        <input id="commentInput" class="w3-input w3-right-grey w3-card-2" style="margin-top:8px;"/>
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
						<td style="padding-top: 8px;"><label style="margin-left: 200px">[댓글목록] (6)</label></td>
						<td class="w3-button w3-center" style="padding-top: 8px;">▼</td>
					</tr>
					
					<!--  자기자신 댓글인 경우
	                  	<tr>
							<th style="width: 10%; padding: 4px" class="w3-pale-blue w3-center">송영곤
							</th>
							<td style="padding: 4px" class="w3-pale-blue">2020.03.15 토요일
								15:12</td>
							<td style="padding: 4px; width: 5%" class="w3-pale-blue"></td>
						</tr>
						<tr>
							<td colspan="2" class="w3-white">> 댓글내용입니다. 몇글자로 제한할지 미정입니다.</td>
							<td class="w3-white"><i class="fa fa-close w3-button w3-white"
								style="padding: 3px"></i></td>
						</tr>
					 -->
		<c:forEach var="comment" items="${comments}">
			<tr>
				<th style="width: 10%; padding: 4px" class="w3-pale-blue w3-center">${comment.memberNm }
				</th>
				<td style="padding: 4px" class="w3-pale-blue">${comment.formatDate }
				</td>
				<td style="padding: 4px; width: 5%" class="w3-pale-blue"></td>
			</tr>
			<tr>
				<td colspan="3" class="w3-white">> ${comment.content }</td>
			</tr>
		</c:forEach>
</table>
	<c:if test="${count>0 }">
			<div class="w3-center" style="margin-top:3px">
				<div class="w3-bar">
					<c:if test="${startPage>bottomLine }">
					
					<!-- 
	
	"/page/board/boardContent?bid="+boardId);
	 -->
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
	function commentAjax(){
		event.preventDefault();
		var memberNm = '<c:out value="${userVO.memberNm}"/>'
		var memberId = '<c:out value="${userVO.id}"/>'
		var boardId = '<c:out value="${boardVO.id}"/>'
		var content = $('#commentInput').val();
		
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
    </script>
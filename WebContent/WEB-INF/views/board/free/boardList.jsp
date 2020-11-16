<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<font size="5">◆ 자유 게시판 ◆</font>
	  <span  style="margin-top:5px" onclick="boardWriteForm('2')"
						class="w3-tag w3-round w3-right w3-border w3-border-white w3-hover-opacity w3-hover-white">
						<i class="fa fa-pencil"></i> 쓰 기
	 </span>
	<div class="w3-border w3-border-black" >
		<table class="w3-table w3-striped w3-bordered">
			<tr >
				<th width="50px"  class="w3-center">번호</th>
				<th width="200px" class="w3-center">제목</th>
				<th width="100px" class="w3-center">작성자</th>
				<th width="200px" class="w3-center">작성일</th>
			</tr>
			<c:forEach var="board" items="${freeBoards}">
							<tr onclick="boardDetail(${board.id},${pageNum},'2')" class="w3-white w3-hover-opacity w3-hover-sand">
								<td class="w3-center">[${number}]</td>
								<c:set var="number" value="${number-1}" />
								<td class="w3-center">${board.title }</td>
									<c:if test="${board.openYn == 'Y'}">
										<td class="w3-center">${board.memberNm }</td>
									</c:if>
									<c:if test="${board.openYn == 'N'}">
										<td class="w3-center">비공개</td>
									</c:if>
								<td class="w3-center">${board.formatDate }</td>
							</tr>
			</c:forEach>
			<c:if test="${count==0 }">
							<tr class="w3-white">
								<td colspan="4" class="w3-border w3-center" >*** 작성된 글이 없습니다. ***</td>
							</tr>
			</c:if>
			
             </table>
    </div>
    <c:if test="${count>0 }">
			<div class="w3-center" style="margin-top:3px">
				<div class="w3-bar">
					<c:if test="${startPage>bottomLine }">
						<a	onclick="$('#freeArea').load('${ pageContext.servletContext.contextPath }/page/board/free/boardList?pageNum=${startPage-bottomLine}');"
							class="w3-bar-item  w3-button w3-hover-black" style="padding:7px">«</a>
					</c:if>
					<c:forEach var="i" begin="${startPage }" end="${endPage}">
						<c:if test="${i!=currentPage }">
							<a
								onclick="$('#freeArea').load('${ pageContext.servletContext.contextPath }/page/board/free/boardList?pageNum=${i }');"
								class="w3-bar-item w3-round w3-button w3-hover-black" style="padding:7px">${i }</a>
						</c:if>
						<c:if test="${i==currentPage }">
							<a
								onclick="$('#freeArea').load('${ pageContext.servletContext.contextPath }/page/board/free/boardList?pageNum=${i }');"
								class="w3-bar-item w3-round w3-black w3-button" style="padding:7px">${i }</a>
						</c:if>
					</c:forEach>
					<c:if test="${endPage<pageCount }">

						<a
							onclick="$('#freeArea').load('${ pageContext.servletContext.contextPath }/page/board/free/boardList?pageNum=${startPage+bottomLine}');"
							class="w3-bar-item w3-button w3-hover-black" style="padding:7px">»</a>
					</c:if>
				</div>
			</div>
		</c:if>
    

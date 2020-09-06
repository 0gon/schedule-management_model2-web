<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!--  -->
<div class="w3-row">
	<div class="w3-col w3-center"
		style="width: 140px; margin-top: 5px; padding-bottom: 5px">
		<div class="w3-tag w3-round" style="padding: 3px">
			<div onclick="boardWriteForm()"
				class="w3-tag w3-round w3-border w3-border-white w3-hover-opacity w3-hover-white">
				<i class="fa fa-pencil"></i> 쓰 기
			</div>
		</div>
		<!-- 페이지 이동 bar -->
		<c:if test="${count>0 }">
			<div class="w3-center" style="margin-top:3px">
				<div class="w3-bar">
					<c:if test="${startPage>bottomLine }">
						<a	onclick="$('#boardContent').load('${ pageContext.servletContext.contextPath }/page/board/boardList?pageNum=${startPage-bottomLine}');"
							class="w3-bar-item  w3-button w3-hover-black" style="padding:9px">«</a>
					</c:if>
					<c:forEach var="i" begin="${startPage }" end="${endPage}">
						<c:if test="${i!=currentPage }">
							<a
								onclick="$('#boardContent').load('${ pageContext.servletContext.contextPath }/page/board/boardList?pageNum=${i }');"
								class="w3-bar-item w3-round-xlarge w3-button w3-hover-black" style="padding:9px">${i }</a>
						</c:if>
						<c:if test="${i==currentPage }">
							<a
								onclick="$('#boardContent').load('${ pageContext.servletContext.contextPath }/page/board/boardList?pageNum=${i }');"
								class="w3-bar-item w3-round-xlarge w3-grey w3-button" style="padding:9px">${i }</a>
						</c:if>
					</c:forEach>
					<c:if test="${endPage<pageCount }">

						<a
							onclick="$('#boardContent').load('${ pageContext.servletContext.contextPath }/page/board/boardList?pageNum=${startPage+bottomLine}');"
							class="w3-bar-item w3-button w3-hover-black" style="padding:9px">»</a>
					</c:if>
				</div>
			</div>
		</c:if>
		<!-- 페이지 이동 bar end -->
	</div>
	<!-- board list 영역 -->
	<div class="w3-rest">
		<table class="w3-white "
			style="border-collapse: collapse; width:99%; margin-top:7px">
			<c:forEach var="board" items="${boards}">
				<tr onclick="boardDetail(${board.id},${pageNum})" class="w3-hover-opacity w3-hover-pale-yellow">
					<td style="width:23px"><font color="grey">[${number}]</font></td>
					<c:set var="number" value="${number-1}" />
					<td class="w3-text-indigo" style="width: 50px">${board.memberNm }</td>
					<!-- 댓글이 있는 경우 표시 -->
					<c:if test="${board.cmtCnt!=0 }">
					<td style="width: 60%">: ${board.title } <font color="red">(${board.cmtCnt })</font> </td>
					</c:if>
					<!-- 댓글이 없는 경우 -->
					<c:if test="${board.cmtCnt==0 }"> 
					<td style="width: 57%">: ${board.title }</td>
					</c:if>
					<td style="width: 25%">&nbsp;${board.formatDate }</td>
				</tr>
			</c:forEach>
		<c:if test="${count==0 }">
			<tr>
					<td >*** 작성된 글이 없습니다. ***</td>
			</tr>
		</c:if>
		</table>
	
	
	</div>
</div>
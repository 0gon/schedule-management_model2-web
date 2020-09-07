<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<table>
	<c:if test="${count>0 }">
		<c:forEach var="board" items="${boards}">
			<tr onclick="boardDetail(${board.id},${pageNum})">
				<td class="w3-border w3-center" width="200px"><font
					color="grey">[${number}]</font></td>
				<c:set var="number" value="${number-1}" />
				<td class="w3-border w3-center w3-sand  w3-hover-orange"
					width="1000px">${board.title }</td>
				<td class="w3-border w3-center" width="200px">${board.formatDate }</td>
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${count==0 }">
		<tr class="w3-center">
			<td class="w3-border w3-center" width="1400px">*** 작성된 글이 없습니다.
				***</td>
		</tr>
	</c:if>
</table>
<c:if test="${count>0 }">
	<div class="w3-center ">
		<div class="w3-bar">
			<c:if test="${startPage>bottomLine }">
				<a 
					onclick="$('#boardList').load('${ pageContext.servletContext.contextPath }/page/board/boardAllList?pageNum=${startPage-bottomLine}');"
					class="w3-bar-item  w3-button w3-hover-black" style="padding: 5px">«</a>
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage}">
				<c:if test="${i!=currentPage }">
					<a
						onclick="$('#boardList').load('${ pageContext.servletContext.contextPath }/page/board/boardAllList?pageNum=${i }');"
						class="w3-bar-item w3-round w3-button w3-hover-black"
						style="padding: 5px">${i }</a>
				</c:if>
				<c:if test="${i==currentPage }">
					<a
						onclick="$('#boardList').load('${ pageContext.servletContext.contextPath }/page/board/boardAllList?pageNum=${i }');"
						class="w3-bar-item w3-round w3-black w3-button"
						style="padding: 5px">${i }</a>
				</c:if>
			</c:forEach>
			<c:if test="${endPage<pageCount }">

				<a
					onclick="$('#boardList').load('${ pageContext.servletContext.contextPath }/page/board/boardAllList?pageNum=${startPage+bottomLine}');"
					class="w3-bar-item w3-button w3-hover-black" style="padding: 5px">»</a>
			</c:if>
		</div>
	</div>
</c:if>
<br>
<!-- 페이지 이동 bar end -->



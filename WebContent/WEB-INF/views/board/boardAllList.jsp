<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<table>
	<c:if test="${count>0 }">
		<c:forEach var="board" items="${boards}">
			<tr onclick="boardDetail(${board.id},${pageNum})" >
				<td class="w3-border w3-center" width="200px"><font color="grey">[${number}]</font></td>
				<c:set var="number" value="${number-1}" />
				<td class="w3-border w3-center w3-sand  w3-hover-orange"
				width="1000px">${board.title }</td>
				<td class="w3-border w3-center" width="200px">${board.formatDate }</td>
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${count==0 }">
			<tr class="w3-center">
					<td class="w3-border w3-center" width="1400px" >*** 작성된 글이 없습니다. ***</td>
			</tr>
	</c:if>
</table>


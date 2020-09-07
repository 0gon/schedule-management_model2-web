<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
 <!-- 쓰기 버튼 눌렀을 시 나오는 모달 -->
<div id="borderReg" class="w3-modal" style="background-color: rgba(0,0,0,0.0);" >
    <div id="borderRegDrag" class="w3-modal-content w3-light-grey w3-card-4" style="max-width: 650px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style="margin-top:2px"><font size=5>작 성 하 기</font></div>
        </div>
        <div class="w3-container w3-padding" >
        <button id="xbutton_b" onclick="document.getElementById('borderReg').style.display='none';" class="w3-button w3-display-topright">&times;</button>
                <div class="w3-row w3-padding">
                <form method="post">
                   <table class="w3-table-all">
                    <tr>
                      <td class="w3-sand w3-center" style="width: 200px">제 목 :</td>
                      <td><input name="title" value="2020년 09월" readonly="readonly" id="boardTitle" class="w3-input" style="padding: 2px;width: 90%"/>
                      
                      </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center" style="padding-top:80px;padding-bottom: 80px">내 용 : </td>
                      <td> <textarea name="content" maxlength="500" id="boardArea"cols="60" rows="10" style="resize: none;"></textarea></td>
                    </tr>
                  </table>
                  <div class="w3-container w3-padding w3-row"> 
                        <div class="w3-padding w3-center">
                            <button id="commitbtn_b" onclick="boardReg()" class="w3-button  w3-black">등록</button>
                            <button id="cancelbtn_b" class="w3-button  w3-red"
                                    onclick="document.getElementById('borderReg').style.display='none';" 
                                    >취소</button>
                        </div>
                  </div>
                </form>
                </div>
        </div>
    </div>
</div>

<div class="w3-container w3-display-middle" style="width:550px;">
	 <font size="5">◆ 도 서 신 청 ◆</font>
	  <span  style="margin-top:5px" onclick="boardWriteForm()"
						class="w3-tag w3-round w3-right w3-border w3-border-white w3-hover-opacity w3-hover-white">
						<i class="fa fa-pencil"></i> 쓰 기
	 </span>
	<div class="w3-border w3-border-black" >
		<table class="w3-table w3-striped w3-bordered">
			<tr>
				<th width="50px"  class="w3-center">번호</th>
				<th width="200px" class="w3-center">제목</th>
				<th width="100px" class="w3-center">작성자</th>
				<th width="200px" class="w3-center">작성일</th>
			</tr>
			<tr>
				<td class="w3-center">[1]</td>
				<td class="w3-center">2020.09월 도서신청</td>
				<td class="w3-center">송영곤</td>
				<td class="w3-center">2020.09.07(화)</td>
			</tr>
			<tr>
				<td class="w3-center">[1]</td>
				<td class="w3-center">2020.09월 도서신청</td>
				<td class="w3-center">송영곤</td>
				<td class="w3-center">2020.09.07(화)</td>
			</tr>
			<!--  
	<c:if test="${count>0 }">
	
	</c:if>
	<c:if test="${count==0 }">
		<tr class="w3-center">
			<td class="w3-border w3-center" width="1400px">*** 작성된 글이 없습니다.
				***</td>
		</tr>
	</c:if>
	
	-->
	 </table>
	</div>
</div>
<script>
		function boardWriteForm() {
			document.getElementById('borderReg').style.display = 'block';
		}
		function boardDetail(boardId,pageNum) {
			document.getElementById('borderDetail').style.display = 'block';
			$('#borderDetail').load('${ pageContext.servletContext.contextPath }/page/board/boardAllContent?bid='+boardId+'&pnum='+pageNum)
		}
		$('#borderDetail').draggable();
		
		function boardReg(){
			event.preventDefault();
			var memberId = '<c:out value="${userVO.id }"/>'
		    var memberNm = '<c:out value="${userVO.memberNm }"/>'
			var content = $('#boardArea').val();
			var title = $('#boardTitle').val();
			if(title==""){
				alert("제목을 입력해주세요.");
			}else{
			    $('#commitbtn_b, #cancelbtn_b, #xbutton_b').attr('disabled',true); 
			    $('#commitbtn_b').html('<i class="fa fa-spinner fa-spin" style="font-size:16px;padding:3px" ></i>');
			 	document.getElementById('borderReg').style.display = 'none';
				$.ajax({
					 url : "${ pageContext.servletContext.contextPath }/page/board/boardAllReg", 
			    	 method : "GET",  
			    	 dataType:"text",
			    	 data:{
			    			"title":title,
			    			"memberId":memberId,
			    			"memberNm":memberNm,
			    			"content":content,
			    			}, 
		              success: function(data){
		            	  $('#boardList').html(data);
		            	  $('#commitbtn_b, #cancelbtn_b, #xbutton_b').attr('disabled',false); 
		            	  $('#commitbtn_b').html('등록');
		      		 	
					}, 
				error: function(request, status, error) {
					alert(error);
				}
				});
			}
		}
		

</script>


</body>
</html>
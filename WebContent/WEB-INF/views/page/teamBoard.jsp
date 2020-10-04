<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
 <!-- 쓰기 버튼 눌렀을 시 나오는 모달 (신청하기) -->
<div id="borderReg" class="w3-modal" style="background-color: rgba(0,0,0,0.0);" >
    <div id="borderRegDrag" class="w3-modal-content w3-light-grey w3-card-4" style="max-width: 650px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style="margin-top:2px"><font size=5>신 청 하 기</font></div>
        </div>
        <div class="w3-container w3-padding" >
        <button id="xbutton_b" onclick="document.getElementById('borderReg').style.display='none';" class="w3-button w3-display-topright">&times;</button>
                <div class="w3-row w3-padding">
                <form method="post">
                   <table class="w3-table-all">
                    <tr>
                      <td class="w3-sand w3-center" style="width: 200px">글 제목 :</td>
                      <td class="w3-light-gray">
                      <input name="title" disabled="disabled" id="bookTitle" class="w3-input" style="padding: 2px;width: 90%"/>
                      </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center" style="width: 200px">책 제목 :</td>
                      <td>
                      <input name="bookName"  id="bookName" class="" style="padding: 2px;width: 90%"/>
                      </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center" style="width: 200px">가격 :</td>
                      <td  class="w3-light-gray">
                      <input name="price"  id="price" style="padding: 2px;width: 60%"/>
                      <font color="grey">*숫자만 입력해주세요.</font>
                      </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center" style="padding-top:30px;padding-bottom: 30px">구매URL : </td>
                      <td> <textarea name="pchURL" maxlength="500" id="pchURL"cols="60" rows="3" style="resize: none;"></textarea></td>
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
<!-- 글 눌렀을 때 나오는 content -->
<div id="borderDetail" class="w3-modal" style="background-color: rgba(0,0,0,0.0);" ></div>



 <!-- 쓰기 버튼 눌렀을 시 나오는 모달 (쓰기) -->
<div id="borderReg2" class="w3-modal" style="background-color: rgba(0,0,0,0.0);" >
    <div id="borderRegDrag2" class="w3-modal-content w3-light-grey w3-card-4" style="max-width: 650px;">
        <div class="w3-container w3-center w3-teal" style="height:38px">
            <div style="margin-top:2px"><font size=5>작 성 하 기</font></div>
        </div>
        <div class="w3-container w3-padding" >
        <button id="xbutton_b2" onclick="document.getElementById('borderReg2').style.display='none';" class="w3-button w3-display-topright">&times;</button>
                <div class="w3-row w3-padding">
                <form method="post">
                   <table class="w3-table-all">
                    <tr>
                      <td class="w3-sand w3-center" style="width: 200px">글 제목 :</td>
                      <td class="w3-light-gray">
                      <input name="title2" id="boardTitle2" class="w3-input" style="padding: 2px;width: 90%"/>
                      </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center" style="width: 200px">작성자 :</td>
                      <td>
                      <input name="title" disabled="disabled" id="boardTitle" class="" style="padding: 2px;width: 90%"/>
                      </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center" style="width: 200px">공개유무 :</td>
                      <td  class="w3-light-gray">
                      
                      공개: <input type="radio" value="1" name="trafficType" checked="checked" class="w3-radio" >
                   비공개: <input type="radio" value="2" name="trafficType" class="w3-radio" >
                      </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center" style="padding-top:30px;padding-bottom: 30px">내 용 : </td>
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

   <div style="width:1150px;margin-top:80px;margin-left: 30px">
        <div class="w3-cell-row">
        <!--도서게시판 영역  -->
             <div class="w3-container w3-cell" id="bookArea">
            </div>
		<!-- 자유게시판 영역 -->
		
              <div class="w3-container w3-cell">
                 <font size="5">◆ 자유 게시판 ◆</font>
	  <span  style="margin-top:5px" onclick="alert('개발중입니다.')"
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
			<tr class="w3-white">
			<td colspan="4" class="w3-border w3-center" >*** 작성된 글이 없습니다. ***</td>
			</tr>
			
             </table>
    </div>
              </div>
        </div>
        </div>
<script>
		function boardWriteForm(type) {
				document.getElementById('borderReg'+type).style.display = 'block';
		}
		function boardDetail(boardId,pageNum) {
			document.getElementById('borderDetail').style.display = 'block';
			$('#borderDetail').load('${ pageContext.servletContext.contextPath }/page/board/book/boardContent?bid='+boardId+'&pnum='+pageNum)
		}
		$('#borderReg, #borderReg2, #borderDetail, #borderDetail2').draggable();
		
		function boardReg(type){
			event.preventDefault();
			var memberId = '<c:out value="${userVO.id }"/>'
		    var memberNm = '<c:out value="${userVO.memberNm }"/>'
			var title = $('#bookTitle').val();
			var bookName = $('#bookName').val();
			var price = $('#price').val();
			var pchURL = $('#pchURL').val();
			if(bookName==""){
				alert("책 제목을 입력해주세요.");
			}else{
			    $('#commitbtn_b, #cancelbtn_b, #xbutton_b').attr('disabled',true); 
			    $('#commitbtn_b').html('<i class="fa fa-spinner fa-spin" style="font-size:16px;padding:3px" ></i>');
			 	document.getElementById('borderReg').style.display = 'none';
				$.ajax({
					 url : "${ pageContext.servletContext.contextPath }/page/board/book/boardBookReg", 
			    	 method : "GET",  
			    	 dataType:"text",
			    	 data:{
			    			"title":title,
			    			"memberId":memberId,
			    			"memberNm":memberNm,
			    			"bookName":bookName,
			    			"pchURL":pchURL,
			    			"memberNm":memberNm,
			    			"price":price,
			    			}, 
		              success: function(data){
		            	  $('#bookArea').html(data);
		            	  $('#commitbtn_b, #cancelbtn_b, #xbutton_b').attr('disabled',false); 
		            	  $('#commitbtn_b').html('등록');
		      		 	
					}, 
				error: function(request, status, error) {
					alert(error);
				}
				});
			}
		}
		$(document).ready(function(){
				//공지사항 로드
				$('#bookArea').load('${ pageContext.servletContext.contextPath }/page/board/book/boardList');
				var today = new Date();
			    var year = today.getFullYear();
			    var month = today.getMonth();
			    month = month < 9 ? month = '0'+(month+1).toString() : month + 1; 
			    var bookTitle = year + '년 '+ month+'월 도서신청';
			    
				$('#bookTitle').val(bookTitle);
				
		});

</script>


</body>
</html>
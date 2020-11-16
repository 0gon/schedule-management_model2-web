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
                      <input name="bookName" placeholder=" * 35자 내로 입력해주세요." id="bookName" maxlength="35" style="padding: 2px;width: 90%"/>
                      </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center" style="width: 200px">가격 :</td>
                      <td  class="w3-light-gray">
                      <input name="price" placeholder=" * 숫자만 입력해주세요." id="price" style="padding: 2px;width: 60%"/>
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
                      <input name="title" id="freeTitle" class="w3-input" style="padding: 2px;width: 90%"/>
                      </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center" style="width: 200px">작성자 :</td>
                      <td>
                      <input name="memberNm" disabled="disabled" id="memberNm" value="${userVO.memberNm }" style="padding: 2px;width: 90%"/>
                      </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center" style="width: 200px">공개유무 :</td>
                      <td  class="w3-light-gray">
                      
                      공개: <input type="radio" value="Y" id="openYn" onclick="openChange(1)" name="openYn" checked="checked" class="w3-radio" style="width:17px;height:17px">
               &nbsp;&nbsp;    비공개: <input type="radio" onclick="openChange(2)" value="N" name="openYn" class="w3-radio" style="width:17px;height:17px" >
                      </td>
                    </tr>
                    <tr>
                      <td class="w3-sand w3-center" style="padding-top:30px;padding-bottom: 30px">내 용 : </td>
                      <td> <textarea name="content" maxlength="500" id="freeContent"cols="60" rows="10" style="resize: none;"></textarea></td>
                    </tr>
                  </table>
                  <div class="w3-container w3-padding w3-row"> 
                        <div class="w3-padding w3-center">
                            <button id="commitbtn_b2" onclick="boardReg2()" class="w3-button  w3-black">등록</button>
                            <button id="cancelbtn_b2" class="w3-button  w3-red"
                                    onclick="document.getElementById('borderReg2').style.display='none';" 
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
              <div class="w3-container w3-cell" id="freeArea">
              </div>
        </div>
        </div>
<script>
		function boardWriteForm(type) {
				document.getElementById('borderReg'+type).style.display = 'block';
		}
		function openChange(type) {
			if(type==1){
				$('#memberNm').val('${userVO.memberNm }');
			}else if(type==2){
				$('#memberNm').val('비공개');
			}
		}
		function boardDetail(boardId,pageNum,type) {
			document.getElementById('borderDetail').style.display = 'block';
			if(type==1){
				$('#borderDetail').load('${ pageContext.servletContext.contextPath }/page/board/book/boardContent?bid='+boardId+'&pnum='+pageNum)
			}else{
				$('#borderDetail').load('${ pageContext.servletContext.contextPath }/page/board/free/boardContent?bid='+boardId+'&pnum='+pageNum)
			}
		}
		$('#borderReg, #borderReg2, #borderDetail, #borderDetail2').draggable();
		
		function boardReg(type){
			event.preventDefault();
			var memberId = '<c:out value="${userVO.id }"/>'
		    var memberNm = '<c:out value="${userVO.memberNm }"/>'
			var title = $('#bookTitle').val();
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
		function boardReg2(type){
			event.preventDefault();
			var memberId = '<c:out value="${userVO.id }"/>'
		    var memberNm = '<c:out value="${userVO.memberNm }"/>'
			var title = $('#freeTitle').val();
			var content = $('#freeContent').val();
			var isOpenYn = $('#openYn').is(':checked');
			
			var openYn = 'Y';
			if(!isOpenYn){
				openYn = 'N';
			}
			if(title==""){
				alert("글 제목을 입력해주세요.");
			}else if(content==""){
				alert("내용을 입력해주세요.");
			}else{
			    $('#commitbtn_b2, #cancelbtn_b2, #xbutton_b2').attr('disabled',true); 
			    $('#commitbtn_b2').html('<i class="fa fa-spinner fa-spin" style="font-size:16px;padding:3px" ></i>');
			 	document.getElementById('borderReg2').style.display = 'none';
				$.ajax({
					 url : "${ pageContext.servletContext.contextPath }/page/board/free/boardFreeReg", 
			    	 method : "GET",  
			    	 dataType:"text",
			    	 data:{
			    			"title":title,
			    			"memberId":memberId,
			    			"memberNm":memberNm,
			    			"content":content,
			    			"openYn":openYn,
			    			}, 
		              success: function(data){
		            	  $('#freeArea').html(data);
		            	  $('#commitbtn_b2, #cancelbtn_b2, #xbutton_b2').attr('disabled',false); 
		            	  $('#commitbtn_b2').html('등록');
		      		 	
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
				$('#freeArea').load('${ pageContext.servletContext.contextPath }/page/board/free/boardList');
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
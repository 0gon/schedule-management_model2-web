<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 글 눌렀을 때 나오는 content -->
<div id="borderDetail" class="w3-modal" style="background-color: rgba(0,0,0,0.0);" ></div>

 <!-- 쓰기 버튼 눌렀을 시 나오는 모달 (쓰기) -->
   <div  class="w3-main"  style="overflow: scroll; height: auto;margin-top:80px;margin-left: 30px">
        <!--도서게시판 영역  -->
             <div class="w3-container " id="bookArea" style="width:500px">
            </div>
		<!-- 자유게시판 영역 -->
              <div class="w3-container " id="freeArea" style="width:500px">
              </div>
    </div>
    
<script>

		function boardWriteForm(type) {
			 alert('모바일에서는 지원하지 않습니다.')
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



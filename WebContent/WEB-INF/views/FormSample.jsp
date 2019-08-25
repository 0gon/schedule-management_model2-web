<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<body>
<div class="w3-display-middle w3-container w3-border w3-white w3-padding-large">
     <form method="post" action="somewhere">    
    선택기능 <select id="sizeSelect" name = "">
        <option selected="selected" value="1500">1500 원 </option>
        <option value="2000"> 2000 원</option>
    </select><p>
    
SHOT 추가 가능  <input type="checkbox" name="shot" value="1"><p>
우유 변경 가능 <input type="radio" name="milk" value="1" onchange="showdiv()" ><p>
        <div id="milkdiv" style="display: none;">
        가능한 우유 <p>
        저지방<input type="checkbox" name="lowpat" value="1"><p>
        두유<input type="checkbox" name="soymilk" value="1"><p>
    소화잘되는우유<input type="checkbox" name="lactofree" value="1">
        </div><p>
우유 변경 불가능 <input type="radio" id="milkcheck" name="milk" value="0" onchange="hidediv()" ><p>
    숫자선택 <input type="number" min="1" value="1" name="serverVal"
                style="width: 20%"><p>
    날짜선택:<input type="date" ><p>
    <input type="submit" value="전송" class="w3-black w3-button ">
    <div class="w3-center w3-padding">
        <button id="cart" class="w3-button w3-border w3-blue">다음</button>
        <button id="cancel" class="w3-button w3-border">취소</button>
    </div>  
    </form>
</div> 
        
    <script>
        function showdiv(){
            $('#milkdiv').attr('style','display:block');   
        } 
        function hidediv(){
            $('#milkdiv').attr("style","display:none");   
        }
        $('#cart').click(function(){
			var sizeSelect = parseInt($('#sizeSelect').val());
			var hamCount = parseInt($('#hamCount').val());
			var totalPrice= sizeSelect*hamCount
			$('form').prepend("<input id='price' type='hidden' name='totalPrice' value='"+totalPrice+"'>");
			$('form').attr('action','${ pageContext.servletContext.contextPath }/page/addCart');
			$('form').submit();
	        });
        $('#cancel').click(function(){
            location.href="${ pageContext.servletContext.contextPath }/page/main"
        }); 
    </script>    
       
</body>

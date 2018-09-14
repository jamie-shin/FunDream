<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/JCE_REPORT.css">
<title>FunDream</title>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
</head>
<script>
$(function(){
	var p_index =<%=request.getParameter("p_index")%>;
	var c_index =<%=request.getParameter("c_index")%>;
	var m_id = <%=request.getParameter("m_id")%>;
	
	$('.JCE-reportbtn').on('click', function(){
		var c_report =$(this).parent().siblings('#reportContent').val();
		alert(c_report);
		if (c_report == null || c_report==''){
			alert("입력된 내용이 없습니다.");
		}
		else{
			$.ajax({
				url : "JCE_REPORT.do",
				type : "POST",
				data : {c_report : c_report,
						c_index : c_index},
				success: function(){
			  		alert("해당 댓글이 신고 처리 되었습니다.");
			  		window.close();
			  		opener.parent.location.href = "JPS_DETAIL.do?p_index="+<%=request.getParameter("p_index")%>+"&m_id=${m_id}";
			  		//opener.location.reload();
			  		
				},
				error: function(){
					alert("oh no");
				}
				
			});
		}
	});
    
    $('.JCE-cancelbtn').on('click', function(){
    	window.close();
    })
});
</script>
<body>
	
		<div class="JCE-container">
			<h1>${title}</h1><br>
			<h2>신고내용</h2>	
			<textarea id="reportContent" class="JCE-textarea" maxlength="500" placeholder="500자 이내로 내용을 입력해주세요"></textarea>
			<div class="JCE-textlocation">
				<!-- <span id="counter">###</span> -->
			</div>
			<div class="JCE-centerbox">
				<button class="JCE-reportbtn">신고하기</button>
				<button class="JCE-cancelbtn">취소</button>
			</div>
		</div>	
	
</body>
</html>
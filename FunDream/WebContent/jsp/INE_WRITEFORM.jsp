<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunDream 관리자 공지사항 등록</title>
<link rel="stylesheet" href="css/INE-WRITEFORM.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.css" rel="stylesheet">
<!-- <script src="js/summernote-ko-KR.js"></script> -->
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.js"></script>
<script type="text/javascript">
	$(function(){
		$('#addBtn').on('click', function(){
			var an_title = $('#an_title').val();
			console.log(an_title);
			var an_contents = $('#summernote').summernote('code');
			console.log(an_contents);
			$.ajax({
				url : "INI_WRITENOTICE.do",
				type : "POST",
				data : {an_title : an_title,
						an_contents : an_contents},
				success : function(data){
					console.log(data);
					if(data == '0'){
						console.log("등록 실패...");
					}
					else{
						alert("공지사항 등록이 완료되었습니다.");
						location.href = "INS_NOTICELIST.do";
					}						
				},
				error : function(){
					console.log("공지사항 등록 오류...");
				}
			});
		});
	});
</script>
</head>
<body class="INE-WRITE-body">
	<div class="INE-WRITE-container">
		<div class="INE-WRITE-title"><h1>공지사항 등록</h1></div><br>
		<form action="#" method="post" id="form">
		<input type="text" id="an_title" name="an_title" placeholder="제목입력" class="INE-WRITE-noticetitle">
		<textarea id="summernote" id="an_contents" name="an_contents"></textarea>
		<script>
			$('#summernote').summernote({
				tabsize: 2,
			   	height: 300,
			   	focus: true,
			   	callbacks: {
			   		onImageUpload: function(files, editor, welEditable){
			   			for(var i = files.length - 1; i >= 0; i--){
			   				sendFile(files[i], this);
			   			}
			   		}
			   	}
			});
			
			function sendFile(file, el) {
				var form_data = new FormData();
		      	form_data.append('file', file);
		      	$.ajax({
		        	data: form_data,
		        	type: "POST",
		        	url: 'uploadImage.do',
		        	cache: false,
		        	contentType: false,
		        	enctype: 'multipart/form-data',
		        	processData: false,
		        	success: function(img_name) {
		          		$(el).summernote('editor.insertImage', img_name);
		        	}
		      	});
		    }
		</script>
		<br>
		<div class="INE-WRITE-lrbox">
			<div class="INE-WRITE-left">
				<button type="button" class="INE-WRITE-listbtn" onclick="location.href='INS_NOTICELIST.do'">목록으로</button>
			</div>
			<div class="INE-WRITE-right">
				<button type="button" class="INE-WRITE-addbtn" id="addBtn">등록</button>
			</div>
		</div>
		</form>
	</div>
	<jsp:include page="Header.jsp" />
</body>
</html>


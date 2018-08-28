<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/SearchPassword.css">
<title>FunDream_SetPassword</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		var code="";
		var email="";
		var name="";
		$(document).find('#sendCodeBtn').on('click',function(){
			var inputEmail = $('#inputEmail').val();
			var inputName = $('#inputName').val();
			$.ajax({
				url : 'MSS_SETPW.do',
				data : {email : inputEmail, name : inputName},
				method : "post",
				success : function(data){
					if(data==""){
						alert("일치하는 회원 정보가 없습니다.");
					}
					else{
						code = data;
						email = inputEmail;
						name = inputName;
						alert(data + " / 인증번호를 발송하였습니다.");
					}
				},
				error : function(){
					alert('error!!!');
				}
			});
		});
		
		$(document).find('#certifiBtn').on('click',function(){
			var inputCode = $('#inputCode').val();
			if(code == inputCode){
				alert("인증이 완료되었습니다.");
				window.location.href = "MSE_NEWPWFORM.do?email="+email+"&name="+name;
			}
			else{
				alert("인증코드가 일치하지 않습니다.");
			}
		});
		
		$(document).find('#cancelBtn').on('click', function(){
			window.close();
		});
		$(document).find('#inputName').keyup(function(event){
			 var kor = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
			 var name = $(this).val();
			 if(kor.test(name)){
			 	alert("한글만 입력 가능합니다.");
			 	$(this).val(name.replace(kor,''));
			 }
		});
	});
</script>
</head>
<body class="sbody">
	<form action="">
		<div class="searchbox">
			<p>이메일</p>
			<input type="email" id="inputEmail" name="" placeholder="E-mail"> 
			<p>이름</p>
			<input type="text" id="inputName" name="" placeholder="Name">
			<br><br>
			<input type="button" class="codebtn" id="sendCodeBtn" name="" value="인증코드 발송">
			<br><br><br>
			<input type="text" id="inputCode" name="" placeholder="인증번호입력">
			<input type="button" class="certifi" id="certifiBtn" name="" value="인증" onclick="">
			<input type="button" class="cancel" id="cancelBtn" name="" value="취소">
		</div>
	</form>
	<%-- <jsp:include page="Header.jsp"/> --%>
</body>
</html>
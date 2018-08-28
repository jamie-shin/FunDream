<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>FunDream_SignIn</title>
	<link rel="stylesheet" type="text/css" href="css/LoginForm.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$(document).find('#setPwd').on('click',function(){
				var openWin = window.open('MSE_SETPWFORM.do', 'setPwd', 'width=320, height=500');
			});
		});
	</script>
	<script type="text/javascript">

function check_onclick(){
	var check_email = document.getElementById("m_email");
	var check_pwd = document.getElementById("m_pwd");

	if(check_email.value==''||check_email.value==null||check_pwd.value==''|| check_pwd.value==null){
		if(check_email.value==''||check_email.value==null){
			alert('이메일을 입력하세요.');
			check_email.focus();
			return false;
		}
		if(check_pwd.value==''|| check_pwd.value==null){
			alert('비밀번호를 입력하세요.');
			check_pwd.focus();
			return false;
		}
	}
	return true;
}
</script>
</head>
<body>
	<div class="loginbox">
		<img src="img/wadiz.jpg" class="logo">
		<h1>펀드림</h1>
		<form action="MIS_LOGIN.do" id="loginForm" onsubmit="return check_onclick()" method="post">
			<p>이메일</p>
			<input type="email" name="m_email" id="m_email" placeholder="E-mail">
			<p>비밀번호</p>
			<input type="password" name="m_pwd" id="m_pwd" placeholder="Password">
			<a id="setPwd" href="">Lost your password?</a><br><br>
			<input type="submit" name="" value="로그인">
			<input type="button" name="" value="회원가입" onclick="location.href='MSE_JOINFORM.do'">
			<input type="button" name="" value="네이버로 로그인">
			<input type="button" name="" value="구글로 로그인">
		</form>
	</div>
	<jsp:include page="Header.jsp"/>
</body>
</html>
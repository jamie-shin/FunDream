<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="css/LoginForm.css">
</head>
<body>



	<div class="loginbox">
		<img src="img/wadiz.jpg" class="logo">
			<h1>펀드림</h1>
			<form action="">

				<p>이메일</p>
				<input type="email" name="" placeholder="E-mail">
				<p>비밀번호</p>
				<input type="password" name="" placeholder="Password">
				<a href="#">Lost your password?</a><br><br>
				<input type="submit" name="" value="로그인">
				<input type="button" name="" value="회원가입" onclick="location.href='MSE_JOINFORM.do'">
				<input type="button" name="" value="네이버로 로그인">
				<input type="button" name="" value="구글로 로그인">

			</form>
	</div>
	<jsp:include page="Header.jsp"/>
</body>
</html>
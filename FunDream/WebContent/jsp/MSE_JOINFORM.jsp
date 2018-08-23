<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/JoinForm.css">
<title>FunDream_Login</title>
</head>
<body class="joinbody">
	<form action="">
		<div class="joinbox">

			<p>이메일</p>
			<input type="email" name="m_email" placeholder="E-mail"> 
			<input type="button" value="이메일 인증" onclick="location.href='MSE_SENDC.do'">
			<p>비밀번호</p>
			<input type="password" name="" placeholder="Password">
			<p>비밀번호 확인</p>
			<input type="password" name="" placeholder="Password Check">
			<p>이름</p>
			<input type="text" name="" placeholder="name">
			<p>연락처</p>
			<select name="">
				<option value="010">010</option>
				<option value="011">011</option>
				<option value="016">016</option>
				<option value="017">017</option>
				<option value="018">018</option>
			</select> 
			<strong>-</strong> <input type="text" name="" style="width: 70px;">
			<strong>-</strong> <input type="text" name="" style="width: 70px;">
			<p>생년월일</p>
			<input type="text" name="" style="width: 60px;" placeholder="yyyy">
			<input type="text" name="" style="width: 60px;" placeholder="MM">
			<input type="text" name="" style="width: 60px;" placeholder="dd">
			<p>성별</p>
			<select name="">
				<option value="">남자</option>
				<option value="">여자</option>
			</select><br>
			<br>
			<p>닉네임</p>
			<small>닉네임을 설정하지 않을경우 이름으로 표시 됩니다.</small> <input type="text" name="" placeholder="nickname">
			<p>프로필 이미지</p>
			<br> <img src="img/wadiz.jpg" class="logo"> <br>
			<br><br><br><br>
			<br>
			<p>회원약관</p>
			<textarea>
				aasdsadasdadsadsadada
				asdasdasdasdasdasdasda
				asdasdasdasdasdasdasda
				asdasdadsadasdasdasd
				sdasdasdasdasda
				asdasdadsadasdasdasd
				dsadasdasdasd
			</textarea>
			<input type="checkbox" name="" id="c1"><label for="c1">상기내용에 동의합니다.</label>
			<br>
			<br>
			<input type="submit" name="" value="회원가입"> 
			<input type="button" name="" value="취소" onclick="">
		</div>
	</form>
	<jsp:include page="Header.jsp"/>
</body>
</html>
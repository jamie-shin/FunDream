<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/JoinForm.css">
<title>FunDream_SignUp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="js/joinform.js"></script>
</head>
<body class="joinbody">
	<form action="MSI_JOIN.do" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
		<input type="hidden" name="m_email" id="m_email" value="">
		<input type="hidden" name="m_pwd" id="m_pwd" value="">
		<input type="hidden" name="m_name" id="m_name" value="">
		<input type="hidden" name="m_phone" id="m_phone" value="">
		<input type="hidden" name="m_birth" id="m_birth" value="">
		<input type="hidden" name="m_gender" id="m_gender" value="">
		<input type="hidden" name="m_nick" id="m_nick" value="">
		<input type="hidden" name="m_img" id="m_img" value="">
		<div class="joinbox">
			<p>이메일</p>
			<input type="email" id="inputEmail" name="" placeholder="E-mail">
			<small id="checkEmail"></small> 
			<input type="button" id="sendCodeBtn" name="" value="이메일 인증"  disabled="disabled">
			<p>비밀번호</p>
			<input type="password" id="inputPwd" name="" placeholder="Password">
			<p>비밀번호 확인</p>
			<input type="password" id="inputPwdCheck" name="" placeholder="Password Check">
			<p>이름</p>
			<input type="text" id="inputName" name="" placeholder="name">
			<p>연락처</p>
			<select id="inputPhone1" name="">
				<option value="010">010</option>
				<option value="011">011</option>
				<option value="016">016</option>
				<option value="017">017</option>
				<option value="018">018</option>
				<option value="019">019</option>
			</select> 
			<strong>-</strong> <input type="number" id="inputPhone2" name="" maxlength="4" style="width: 70px;">
			<strong>-</strong> <input type="number" id="inputPhone3" name="" maxlength="4" style="width: 70px;">
			<p>생년월일</p>
			<input type="number" id="inputBirthYear" name="" maxlength="4" style="width: 60px;" placeholder="yyyy">
			<input type="number" id="inputBirthMonth" name="" maxlength="2" style="width: 60px;" placeholder="MM">
			<input type="number" id="inputBirthDay" name="" maxlength="2" style="width: 60px;" placeholder="dd">
			<img id="calendarBtn" src="img/calendarIcon.jpg" style="width: 40px; height: 40px; padding: 0px">
			<p>성별</p>
			<select id="inputGender" name="">
				<option value="1">남자</option>
				<option value="2">여자</option>
			</select><br>
			<br>
			<p>닉네임</p>
			<small>닉네임을 설정하지 않을경우 이름으로 표시 됩니다.</small>
			<input type="text" id="inputNick" name="" placeholder="nickname">
			<p>이미지 파일</p>
			<br><input type='file' id="imgInp" name="m_img"/><br>
			<img id="blah" src="#" alt="your image" class="logo"/>
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
			<input type="submit" id="signupSubmit" name="" value="회원가입"> 
			<input type="button" id="cancelBtn" name="" value="취소" onclick="location.href='MIE_LOGINFORM.do'">
		</div>
	</form>
	<jsp:include page="Header.jsp"/>
</body>
</html>
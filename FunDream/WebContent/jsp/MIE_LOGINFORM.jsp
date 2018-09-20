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
			
		$(document).find('#m_email').on('change', function(){
			$.ajax({
				url : "MIS_LOGIN.do",
				method : "POST",
				data : {
					m_email: $('#m_email').val(),
					m_pwd: $('#m_pwd').val()
				},
				success:function(data){
					if(data=="1"){
						$("#checkEmail").text("해당 이메일로 등록된 회원이 없습니다.");
					}
					else
						$('#checkEmail').text("");
				}
			});
		});
		$(document).find('#m_pwd').keyup(function(){
			$.ajax({
				url : "MIS_LOGIN.do",
				method : "POST",
				data : {
					m_email: $('#m_email').val(),
					m_pwd: $('#m_pwd').val()
				},
				success:function(data){
					if(data=="5"){
						$("#checkEmail").text("탈퇴 처리된 아이디입니다.");
					}
					else if(data=="6"){
						$("#checkEmail").text("이용 정지된 아이디입니다.");
					}
					else if(data=="3"){
						$("#checkPwd").text("비밀번호를 확인해 주세요.");
					}
					else if(data=="2" || data=="4"){
						$("#submitB").removeAttr("disabled");
						$("#checkPwd").text("");
						
					}
		        }	
			});
		});
		$(document).find('#submit').on('click', function(){
			var m_email = $('#m_email').val();
			var m_pwd = $('#m_pwd').val();
			
			if(m_email==""){
				alert('이메일을 입력하세요.');
				return false;
			}
			if(m_pwd==""){
				alert('비밀번호를 입력하세요.');
				return false;
			}
			
			$('#m_email').val(m_email);
			$('#m_pwd').val(m_pwd);
			return true;
		})
		
	});
</script>

</head>
<body class="MIE-body">
	<div class="loginbox">
		<img src="img/캡처.JPG" class="logo">
		<h1>펀드림</h1>
		<form action="MAIN.do" id="loginForm" method="post">
			<p>이메일</p>
			<input type="email" name="m_email" id="m_email" placeholder="E-mail">
			<small id="checkEmail" style="color : yellow"></small><br>
			<p>비밀번호</p>
			<input type="password" name="m_pwd" id="m_pwd" placeholder="Password">
			<small id="checkPwd" style="color: yellow"></small><br>
			<a id="setPwd" href="">Lost your password?</a><br><br>
			<input type="submit" name="" value="로그인" id="submitB" disabled="disabled" class="MIE-login">
			<input type="button" name="" value="회원가입" onclick="location.href='MSE_JOINFORM.do'" class="MIE-join">
			<input type="button" name="" value="네이버로 로그인" class="naverlogin">
			<input type="button" name="" value="구글로 로그인" class="googlelogin">
		</form>
	</div>
	
</body>
<jsp:include page="Header.jsp"/>
</html>
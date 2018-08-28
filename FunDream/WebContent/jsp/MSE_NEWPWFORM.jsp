<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/SearchPassword.css">
<title>FunDream_Login</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	// 검증 미통과시 오류메세지 alert? 아니면 빨간문구?
	// 비밀번호 검증(8~20자리, 공백불가, 영문&숫자&특수문자조합, 같은 문자 3번 이상 사용불가)
	$(document).find('#inputPwd').on('change',function(){
		var pwd = $('#inputPwd').val();
		var pwdCheck = $('#inputPwdCheck').val();
		
		if(pwdCheck==""){
			var num = pwd.search(/[0-9]/g);
			var eng = pwd.search(/[a-z]/ig);
			var spe = pwd.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

			if(pwd.length < 8 || pwd.length > 20){
			 	alert("8자리 ~ 20자리 이내로 입력해주세요.");
			 	$('#inputPwd').val("");
				return false;
			}
			if(pwdCheck.search(/₩s/) != -1){
			 	alert("비밀번호는 공백없이 입력해주세요.");
			 	$('#inputPwd').val("");
				return false;
			}
			if(num < 0 || eng < 0 || spe < 0){
			 	alert("영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
			 	$('#inputPwd').val("");
				return false;
			}
			if(/(\w)\1\1\1/.test(pwd)){
				alert('444같은 문자를 3번 이상 사용하실 수 없습니다.');
			 	$('#inputPwd').val("");
				return false;
			}
		}
		if(pwd!="" && pwdCheck!="" && pwd!=pwdCheck){
			alert('비밀번호가 일치하지 않습니다.');
		 	$('#inputPwd').val("");
		 	$('#inputPwdCheck').val("");
			return false;
		}
		alert('사용가능한 비밀번호입니다.');
		return true;			
	});
	// 비밀번호 확인 검증(8~20자리, 공백불가, 영문&숫자&특수문자조합, 같은 문자 3번 이상 사용불가)
	$(document).find('#inputPwdCheck').on('change',function(){
		var pwdCheck = $('#inputPwdCheck').val();
		var pwd = $('#inputPwd').val();
		
		if(pwd==""){
			var num_c = pwdCheck.search(/[0-9]/g);
			var eng_c = pwdCheck.search(/[a-z]/ig);
			var spe_c = pwdCheck.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

			if(pwdCheck.length < 8 || pwdCheck.length > 20){
			 	alert("8자리 ~ 20자리 이내로 입력해주세요.");
			 	$('#inputPwdCheck').val("");
				return false;
			}
			if(pwdCheck.search(/₩s/) != -1){
			 	alert("비밀번호는 공백없이 입력해주세요.");
			 	$('#inputPwdCheck').val("");
				return false;
			}
			if(num_c < 0 || eng_c < 0 || spe_c < 0){
			 	alert("영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
			 	$('#inputPwdCheck').val("");
				return false;
			}
			if(/(\w)\1\1\1/.test(pwdCheck)){
				alert('444같은 문자를 3번 이상 사용하실 수 없습니다.');
			 	$('#inputPwdCheck').val("");
				return false;
			}
		}
		if(pwd!="" && pwdCheck!="" && pwd!=pwdCheck){
			alert('비밀번호가 일치하지 않습니다.');
		 	$('#inputPwd').val("");
		 	$('#inputPwdCheck').val("");
			return false;
		}
		alert('사용가능한 비밀번호입니다.');
		return true;			
	});
	
	$(document).find('#certifi').on('click',function(){
		var pwd = $('#inputPwd').val();
		var pwdcheck = $("#inputPwdCheck").val();
		if(pwd==""){
			alert("비밀번호를 입력하세요");
			$("#inputPwd").focus();
			return false;
		}
		else if(pwdcheck==""){
			alert("비밀번호를 입력하세요");
			$("#inputPwdCheck").focus();
			return false;
		}
		else{
			alert("비밀번호가 변경되었습니다");
			return true;
		}
	})
	
	
});
</script>
</head>
<body class="sbody">
	<c:if test="${param.email==null }"> 
	<script>
	window.close();
	</script>
	</c:if>
	<form action="MSU_SETPW.do" method="post">
		<div class="searchbox">
			<p>이메일</p>
			<input type="email" name="email" value="${param.email}" readonly="readonly"> 
			<p>이름</p>
			<input type="text" name="" value="${param.name}" readonly="readonly">
			<p>변경할 비밀번호</p>
			<input type="text" id="inputPwd" name="inputPwd" placeholder="변경할 비밀번호">
			<small>숫자, 영문 조합으로 8자리 이상</small><br><br>
			<p>비밀번호 확인</p>
			<input type="text" id="inputPwdCheck" name="inputPwdCheck" placeholder="비밀번호 확인">

			<input type="submit" class="certifi" id="certifi" name="" value="변경">
			<input type="button" class="cancel" name="" value="취소" onclick="window.close();">
		</div>
	</form>
	<%-- <jsp:include page="Header.jsp"/> --%>
</body>
</html>
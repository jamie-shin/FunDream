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
	<form action="#" id="joinform" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
		<input type="hidden" name="type" id="type" value="member">
		<input type="hidden" name="m_email" id="m_email" value="">
		<input type="hidden" name="m_pwd" id="m_pwd" value="">
		<input type="hidden" name="m_name" id="m_name" value="">
		<input type="hidden" name="m_phone" id="m_phone" value="">
		<input type="hidden" name="m_birth" id="m_birth" value="">
		<input type="hidden" name="m_gender" id="m_gender" value="">
		<input type="hidden" name="m_nick" id="m_nick" value="">
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
			<p>성별</p>
			<select id="inputGender" name="">
				<option value="1">남자</option>
				<option value="2">여자</option>
			</select><br>
			<br>
			<p>닉네임</p>
			<input type="text" id="inputNick" name="" placeholder="nickname">
			<p>이미지 파일</p>
			<br><input type='file' id="imgInp" name="m_img"/><br>
			<img id="blah" src="#" alt="your image" class="logo"/>
			<br><br><br><br>
			<br>
			<p>회원약관</p>
			<textarea readonly="readonly">약관 제1항 
본 약관은 펀드림을 통하여 제공하는 크라우드펀딩 서비스 등 제반 서비스의 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.
				
약관 제2항
본 약관에서 사용하는 용어의 정의는 다음과 같습니다.
서비스 : 회원이 온라인 홈페이지를 통하여 본 약관에 따라 이용할 수 있는 회사가 제공하는 모든 서비스를 의미합니다.
홈페이지 : 본 약관에 따라 회사가 제공하는 서비스가 구현되는 온라인상의 웹페이지를 말합니다.
회원 : 본 약관에 따라 회사와 서비스이용계약을 체결하고 홈페이지를 통하여 서비스를 이용할 수 있는 자격을 부여받은 자를 말합니다.
아이디(ID) : 회원의 식별과 서비스 이용을 위하여 회원이 정하고 회사가 승인하는 문자와 숫자의 조합을 의미합니다.
비밀번호 : 회원이 부여 받은 아이디와 일치되는 회원임을 확인하고 비밀보호를 위해 회원 자신이 정한 문자 또는 숫자의 조합을 의미합니다.
게시물 : 회원이 서비스를 이용함에 있어 홈페이지의 게시판에 게재한 부호ㆍ문자ㆍ음성ㆍ음향ㆍ화상ㆍ동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일과 링크 등을 의미합니다.

약관 제3항
회사가 본 약관에 따라 제공하는 서비스를 이용하기 위하여 회사와 서비스이용계약(이하 “이용계약”)을 체결하여 회원가입에 따른 회원의 자격을 부여받아야 합니다.
서비스를 이용하고자 하는 자(이하 "이용신청자")가 본 약관의 내용에 대하여 동의를 한 다음 회사가 제공하는 양식에 따라 정보입력을 하고 본인확인을 위한 인증절차를 이행하는 방법으로 회원가입신청을 하면 서비스에 대한 이용신청(이하 “이용신청”)이 있는 것으로 보며, 이용신청에 대하여 회사가 승낙함으로써 이용계약이 체결됩니다.
제2항의 회원가입신청 절차의 방법과 내용은 회원이 개인(자연인)인 경우와 법인인 경우에 따라 다를 수 있습니다.
회사는 관계 법령에 따라 이용신청자가 제1항에 따라 입력한 정보에 대한 사실 확인을 위하여 필요한 경우 이용신청자에게 증빙자료의 제출을 요청할 수 있으며, 이용신청자는 이에 따라 증빙자료를 제출하여야 합니다.
회사는 다음 각 호에 해당하는 이용신청에 대하여는 승낙을 하지 않을 수 있습니다.
이용신청자가 이전에 본 약관에 의하여 회원자격을 상실한 적이 있는 경우(회사의 회원 재가입 승낙을 얻은 경우 제외)
이용신청자가 본 약관에 의하여 이전에 회사로부터 서비스 이용제한 조치를 받은 상태에서 이용계약을 해지하고 다시 이용신청을 한 경우
제2항의 이용신청 시 실명이 아니거나 타인의 명의를 이용하여 이용신청을 한 경우
제2항의 이용신청 시 필요한 정보를 입력하지 않거나 허위의 정보를 기재한 경우
제4항에 따라 요청받은 사실확인을 위한 증빙자료를 제출하지 않은 경우
14세 미만 아동이 법정대리인의 동의를 얻지 아니한 경우
사회의 안녕과 질서, 미풍양속을 저해할 우려가 있는 경우
타인의 서비스 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협할 우려가 있는 경우
위법 또는 부당한 목적으로 이용신청을 한 경우 ["회사가 제공하는 서비스와 경쟁관계에 있는 자가 이용신청을 하는 경우" 포함 여부 검토]
본 약관을 위반하며 신청하는 경우
회사는 다음 각 호의 경우에 승낙을 유보할 수 있습니다.
제공하는 서비스 관련 설비의 용량이 부족한 등 여유가 없는 경우
기타 서비스 제공을 위한 재정적, 기술적 문제가 있다고 판단되는 경우
회사는 본 약관 및 개별약관에서 정한 바에 따라 회원별로 서비스의 이용시간, 이용횟수, 메뉴 등을 세분하여 달리 적용할 수 있습니다.
			</textarea>
			<input type="checkbox" name="" id="c1"><label for="c1">상기내용에 동의합니다.</label>
			<br>
			<br>
			<input type="button" class="MSE_JOIN" id="signupSubmit" name="" value="회원가입"> 
			<input type="button" class="MSE_CANCEL" id="cancelBtn" name="" value="취소" onclick="location.href='MIE_LOGINFORM.do'">
		</div>
	</form>
	<jsp:include page="Header.jsp"/>
</body>
</html>
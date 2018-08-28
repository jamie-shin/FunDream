<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="css/ConfirmPass.css">
	<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="js/mainpage.js"></script>
</head>
<body class="checkbody">
<% String m_email = (String)session.getAttribute("m_email"); %>

<form action="MUS_CHECKPW.do">
<div class="checkbox">
<p>본인 확인을 위한 비밀번호 입력</p>
	<input type="hidden" name="m_email" value="<%=m_email%>">
	<input type="password" name="m_pwd_input" placeholder="password">
	<input type="submit" value="확인">
	<input type="button" value="취소" onclick="location.href='MAIN.do'">
</div>
</form>

</div>
<jsp:include page="Header.jsp"/>
</body>
</html>
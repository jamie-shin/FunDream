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
	<script type="text/javascript">
		$(function(){
			$('#checkBtn').on('click', function(){
				var m_email = $('#m_email').val();
				var m_pwd_input = $('#m_pwd_input').val();
				$.ajax({
					url : "MUS_CHECKPW.do",
					data : {m_email : m_email,
							m_pwd_input : m_pwd_input},
					type : "POST",
					success : function(data){
						console.log(data);
						switch(data){
						case "success":
							location.href = "MUE_MODIFYFORM.do?m_email="+m_email;
							break;
						case "fail":
							alert("비밀번호를 확인해주세요.");
							break;
						default:
							alert("비밀번호 확인 실패!");
							break;
						}
					},
					error : function(){
						alert("비밀번호 확인 오류!");
					}
				});
			});
		});	
	</script>
</head>
<body class="checkbody">
<% String m_email = (String)session.getAttribute("m_email"); %>

<div class="checkbox">
<p>본인 확인을 위한 비밀번호 입력</p>
	<input type="hidden" name="m_email" id="m_email" value="<%=m_email%>">
	<input type="password" name="m_pwd_input" id="m_pwd_input" placeholder="password">
	<input type="submit" id="checkBtn" value="확인">
	<input type="button" value="취소" onclick="location.href='MAIN.do'">
</div>

<jsp:include page="Header.jsp"/>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="css/CertifiedEmail.css">
	<title>이메일인증</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$('#checkBtn').on('click', function(){			
				if($('#inputCode').val()==$('#sendCode').val()){
					$(opener.document).find('#inputEmail').attr({'readonly':'readonly'});
					$(opener.document).find('#sendCodeBtn').val("이메일 인증 완료").attr({'disabled':'disabled'});
					alert('인증이 완료되었습니다.');
					window.close();
				}
				else{
					/* $('#inputCode').val()=""; */			
					alert('인증코드가 잘못되었습니다. 다시 입력하세요.');
				}
			});
			$('#cancelBtn').on('click', function(){
				window.close();
			});
		});
	</script>
</head>
<body class="c_body">
	<form action="">
	<input type="hidden" id="sendCode" value="${param.sendCode}">
		<div class="certifiedbox">
			<p><Strong>${param.inputEmail}</Strong>에 인증코드를 발송하였습니다.<br>3분 이내에 인증코드를 입력하세요</p><br>
		<div class="c_timer" id="ViewTimer"></div><br>
			<input type="text" class="c_certifi" id="inputCode" name=""><br>
		<div class="c_ot" id="Overtime"></div><br><br>
			<input type="button" class="c_recertifibtn" name="" value="인증코드 재발송">
			<input type="button" class="c_certifibtn" id="checkBtn" name="" value="인증완료">
			<input type="button" class="c_cancelbtn" id="cancelBtn" name="" value="취소">
		</div>
	</form>
	
	<script language="JavaScript">
		var setTime = 180;
		var msg_timeover = "<font color='red'>입력시간이 경과 되었습니다.<br> 재발송 버튼을 눌러주세요</font>";

		function msg_time() {
			m = Math.floor(setTime / 60) + "분 " + (setTime % 60) + "초";
			var msg = "<font color='red'>" + m + "</font>";
			document.all.ViewTimer.innerHTML = msg;
			setTime--;
			
			if (setTime < 0) {	
				setTime = null;
				document.all.Overtime.innerHTML = msg_timeover;
				document.all.ViewTimer.innerHTML = msg;
			}
		}

		window.onload = function TimerStart(){ tid=setInterval('msg_time()',1000)};
	</script>
</body>
</html>
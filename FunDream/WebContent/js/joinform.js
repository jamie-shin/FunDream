$(function() {
	$(document).find("#sendCodeBtn").on(
			'click',
			function() {
				var openWin = window.open('MSE_SENDC.do?inputEmail='
						+ $('#inputEmail').val(), "authEmail",
						'width=500, height=500');
			});

	$(document)
			.find('#inputEmail')
			.on(
					'change',
					function() {
						var emailVal = $("#inputEmail").val();
						var regExp = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
						if (emailVal.match(regExp) == null) {
							$('#checkEmail').text('올바른 이메일 형식이 아닙니다!');
							$("#inputEmail").val("");
							$("#inputEmail").focus();
						} else {
							$
									.ajax({
										url : "MSS_CHECKM.do",
										method : "post",
										data : {
											inputEmail : $('#inputEmail').val()
										},
										success : function(data) {
											console.log(data);
											if (data == "1") {
												$("#sendCodeBtn").removeAttr(
														"disabled");
												$("#checkEmail").text(
														"사용 가능한 이메일입니다.");
											} else {
												$("#checkEmail").text(
														"이미 가입되어있는 이메일입니다.");
											}
										}
									});
						}
					});

	// 검증 미통과시 오류메세지 alert? 아니면 빨간문구?
	// 비밀번호 검증(8~20자리, 공백불가, 영문&숫자&특수문자조합, 같은 문자 3번 이상 사용불가)
	$(document).find('#inputPwd').on('change', function() {
		var pwd = $('#inputPwd').val();
		var pwdCheck = $('#inputPwdCheck').val();

		if (pwdCheck == "") {
			var num = pwd.search(/[0-9]/g);
			var eng = pwd.search(/[a-z]/ig);
			var spe = pwd.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

			if (pwd.length < 8 || pwd.length > 20) {
				$('#msgPwd').text("8자리 ~ 20자리 이내로 입력해주세요.");
				$('#inputPwd').val("");
				return false;
			}
			if (pwdCheck.search(/₩s/) != -1) {
				$('#msgPwd').text("비밀번호는 공백없이 입력해주세요.");
				$('#inputPwd').val("");
				return false;
			}
			if (num < 0 || eng < 0 || spe < 0) {
				$('#msgPwd').text("영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
				$('#inputPwd').val("");
				return false;
			}
			if (/(\w)\1\1\1/.test(pwd)) {
				$('#msgPwd').text('444같은 문자를 3번 이상 사용하실 수 없습니다.');
				$('#inputPwd').val("");
				return false;
			}
		}
		if (pwd != "" && pwdCheck != "" && pwd != pwdCheck) {
			$('#msgPwd').text('비밀번호가 일치하지 않습니다.');
			$('#inputPwd').val("");
			$('#inputPwdCheck').val("");
			return false;
		}
		$('#msgPwd').text('사용가능한 비밀번호입니다.');
		return true;
	});

	// 비밀번호 확인 검증(8~20자리, 공백불가, 영문&숫자&특수문자조합, 같은 문자 3번 이상 사용불가)
	$(document).find('#inputPwdCheck').on('change', function() {
		var pwdCheck = $('#inputPwdCheck').val();
		var pwd = $('#inputPwd').val();

		if (pwd == "") {
			var num_c = pwdCheck.search(/[0-9]/g);
			var eng_c = pwdCheck.search(/[a-z]/ig);
			var spe_c = pwdCheck.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

			if (pwdCheck.length < 8 || pwdCheck.length > 20) {
				$('#msgCheckPwd').text("8자리 ~ 20자리 이내로 입력해주세요.");
				$('#inputPwdCheck').val("");
				return false;
			}
			if (pwdCheck.search(/₩s/) != -1) {
				$('#msgCheckPwd').text("비밀번호는 공백없이 입력해주세요.");
				$('#inputPwdCheck').val("");
				return false;
			}
			if (num_c < 0 || eng_c < 0 || spe_c < 0) {
				$('#msgCheckPwd').text("영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
				$('#inputPwdCheck').val("");
				return false;
			}
			if (/(\w)\1\1\1/.test(pwdCheck)) {
				$('#msgCheckPwd').text('444같은 문자를 3번 이상 사용하실 수 없습니다.');
				$('#inputPwdCheck').val("");
				return false;
			}
		}
		if (pwd != "" && pwdCheck != "" && pwd != pwdCheck) {
			$('#msgCheckPwd').text('비밀번호가 일치하지 않습니다.');
			$('#inputPwd').val("");
			$('#inputPwdCheck').val("");
			return false;
		}
		$('#msgCheckPwd').text('사용가능한 비밀번호입니다.');
		return true;
	});

	// 이름 검증(한글만 가능, 숫자&영문&특수문자 불가)
	$(document).find('#inputName').keyup(function(event) {
		var kor = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
		var name = $(this).val();
		if (kor.test(name)) {
			$('#msgName').text("한글만 입력 가능합니다.");
			$(this).val(name.replace(kor, ''));
		}
		else{
			$('#msgName').text("");
		}
	});

	// 연락처, 생년월일 숫자 길이 제한
	$(document).find("#inputPhone2").keyup(function(event) {
		var p2 = $(this).val();
		if ($("#inputPhone2").val().length >= 4) {
			if ($(this).val().length > 4) {
				$(this).val(p2.substr(0, 4));
			}
			$("#inputPhone3").focus();
			return false;
		}
	});
	$(document).find("#inputPhone3").keyup(function(event) {
		var p3 = $(this).val();
		if ($("#inputPhone3").val().length >= 4) {
			if ($(this).val().length > 4) {
				$(this).val(p3.substr(0, 4));
			}
			$("#inputBirthYear").focus();
			return false;
		}
	});
	$(document).find("#inputBirthYear").keyup(function(event) {
		if ($("#inputBirthYear").val().length >= 4) {
			if ($(this).val() < 1900 || $(this).val() > 2018) {
				$(this).val("");
				$(this).focus();
				$('#msgBirth').text("잘못된 연도입니다.");
			} else {
				$('#msgBirth').text("");
				$("#inputBirthMonth").focus();
			}
			return false;
		}
	});
	$(document).find("#inputBirthMonth").keyup(function(event) {
		if ($("#inputBirthMonth").val().length >= 2) {
			if ($(this).val() < 1 || $(this).val() > 12) {
				$(this).val("");
				$(this).focus();
				$('#msgBirth').text("잘못된 월입니다.");
			} else {
				$('#msgBirth').text("");
				$("#inputBirthDay").focus();
			}
			return false;
		}
	});
	$(document).find("#inputBirthDay").keyup(function(event) {
		if ($("#inputBirthDay").val().length >= 2) {
			if ($(this).val() < 1 || $(this).val() > 31) {
				$(this).val("");
				$(this).focus();
				$('#msgBirth').text("잘못된 일자입니다.");
			}
			return false;
		}
		else {
			$('#msgBirth').text("");
		}
	});

	// 닉네임 검증(한글&영문&숫자 가능, 특수문자만 불가)
	$(document).find('#inputNick').keyup(function(event) {
		var spec = /[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi;
		nick = $(this).val();
		if (spec.test(nick)) {
			$('#msgNick').text('특수문자는 사용 불가능합니다.');
			$(this).val(nick.replace(spec, ''));
		}
		else{
			$('#msgNick').text("");
		}
	});

	// 회원가입 버튼 클릭 시
	$(document).find('#signupSubmit').on('click', function() {
		var m_id = $('#m_id').val();
		var m_email = $('#inputEmail').val();
		var email_auth = $('#sendCodeBtn').val();
		var m_pwd = $('#inputPwd').val();
		var m_pwdCheck = $('#inptuPwdCheck').val();
		var m_name = $('#inputName').val();
		var phone1 = $('#inputPhone1').val();
		var phone2 = $('#inputPhone2').val();
		var phone3 = $('#inputPhone3').val();
		var m_phone = phone1 + "-" + phone2 + "-" + phone3;
		var birthY = $('#inputBirthYear').val();
		var birthM = $('#inputBirthMonth').val();
		var birthD = $('#inputBirthDay').val();
		var m_birth = birthY + "-" + birthM + "-" + birthD;
		var m_gender = $('#inputGender').val();
		var m_nick = $('#inputNick').val();
		var m_img = $('#inputImg').attr('src');
		var m_agree = $('#c1').val();

		console.log("연락처 : " + m_phone + " / 생일 : " + m_birth);

		if (m_email == "") {
			$('#checkEmail').text('이메일을 입력하세요.');
			return false;
		}
		if (email_auth != "이메일 인증 완료") {
			$('#checkEmail').text('이메일 인증을 완료하세요.');
			return false;
		}
		if (m_pwd == "") {
			$('#msgPwd').text('비밀번호를 입력하세요.');
			return false;
		}
		if (m_pwdCheck == "") {
			$('#msgCheckPwd').text('비밀번호 확인을 입력하세요');
			return false;
		}
		if (m_name == "") {
			$('#msgName').text('이름을 입력하세요.');
			return false;
		}
		if (m_name != "") {
			$('#msgName').text('');
			return false;
		}
		if (phone1 == "" || phone2 == "" || phone3 == "") {
			$('#msgPhone').text('연락처를 입력하세요.');
			return false;
		}
		if (phone1 != "" && phone2 != "" && phone3 != "") {
			$('#msgPhone').text('');
			return false;
		}
		if (birthY == "" || birthM == "" || birthD == "") {
			$('#msgBirth').text('생년월일을 입력하세요.');
			return false;
		}
		if (birthY != "" && birthM != "" && birthD != "") {
			$('#msgBirth').text('');
			return false;
		}
		if (m_gender == "") {
			$('#msgGender').text('성별을 선택하세요.');
			return false;
		}
		if (m_gender != "") {
			$('#msgGender').text('');
			return false;
		}
		if (m_nick == "") {
			$('#msgNick').text('닉네임을 입력하세요.');
			return false;
		}
		if (m_nick != "") {
			$('#msgNick').text('');
			return false;
		}
		// 체크안하고 회원가입 버튼 누를시
		if ($("#c1").prop("checked") == false) {
			$('#msgAgree').text("회원약관 동의에 체크하셔야 회원가입이 가능합니다.");
			return false;
		}
		if ($("#c1").prop("checked") == true) {
			$('#msgAgree').text("");
		}

		$('#m_email').val(m_email);
		$('#m_pwd').val(m_pwd);
		$('#m_name').val(m_name);
		$('#m_phone').val(m_phone);
		$('#m_birth').val(m_birth);
		$('#m_gender').val(m_gender);
		$('#m_nick').val(m_nick);
		
		var joinform = $('#joinform')[0];
		var joinFormData = new FormData(joinform);

		$.ajax({
			url : "MSI_JOIN.do",
			type : "POST",
			data : joinFormData,
			enctype : "multipart/form-data",
			cache : false,
			processData: false,
			contentType: false,
			success : function(data){
				console.log("회원가입 결과 : " + data);
				switch(data){
				case "success" :
					alert("회원가입이 완료되었습니다.");
					location.href = "MIE_LOGINFORM.do";
					break;
				default : 
					alert("이미지 형식이 올바르지 않습니다.");
					break;
				}
			},
			error : function(){
				console.log("회원가입 오류 발생");ㅣ
			}
		});
		
	});
	   //이미지 미리보기
    $(function() {
        $("#imgInp").on('change', function(){
            readURL(this);
        });
    });
    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
                $('#blah').attr('src', e.target.result);
            }
          reader.readAsDataURL(input.files[0]);
        }
    }

});
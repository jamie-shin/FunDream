
$(function(){
    $(document).find("#sendCodeBtn").on('click',function(){
        var openWin = window.open('MSE_SENDC.do?inputEmail='+$('#inputEmail').val(), "authEmail", 'width=500, height=500');
    });
    
    $(document).find('#inputEmail').on('change', function(){
        $.ajax({
            url : "MSS_CHECKM.do",
            method : "post",
            data : {inputEmail : $('#inputEmail').val()},
            success:function(data){
                alert(data);
                if(data=="1"){
                    $("#sendCodeBtn").removeAttr("disabled");
                    $("#checkEmail").text("사용 가능한 이메일입니다.");
                }
                else{
                    $("#checkEmail").text("이미 가입되어있는 이메일입니다.");											
                }
            }
        });
    });
    
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
    
    // 이름 검증(한글만 가능, 숫자&영문&특수문자 불가)
    $(document).find('#inputName').keyup(function(event){
            var kor = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
            var name = $(this).val();
            if(kor.test(name)){
            alert("한글만 입력 가능합니다.");
            $(this).val(name.replace(kor,''));
            }
    });
    
    // 연락처, 생년월일 숫자 길이 제한
    $(document).find("#inputPhone2").keyup(function(event){
        var p2 = $(this).val();
        if($("#inputPhone2").val().length >= 4){
            if($(this).val().length > 4){
                $(this).val(p2.substr(0,4));
            }
            $("#inputPhone3").focus();
            return false;
        }
    });
    $(document).find("#inputPhone3").keyup(function(event){
        var p3 = $(this).val();
        if($("#inputPhone3").val().length >= 4){
            if($(this).val().length > 4){
                $(this).val(p3.substr(0,4));
            }
            $("#inputBirthYear").focus();
            return false;
        }
    });
    $(document).find("#inputBirthYear").keyup(function(event){
        if($("#inputBirthYear").val().length >= 4){
            if($(this).val() < 1900 || $(this).val() > 2018){
                $(this).val("");
                $(this).focus();
                alert("잘못된 연도입니다.");
            }
            else{
                $("#inputBirthMonth").focus();
            }
            return false;
        }
    });
    $(document).find("#inputBirthMonth").keyup(function(event){
        if($("#inputBirthMonth").val().length >= 2){
            if($(this).val() < 1 || $(this).val() > 12){
                $(this).val("");
                $(this).focus();
                alert("잘못된 월입니다.");
            }
            else{
                $("#inputBirthDay").focus();
            }
            return false;
        }
    });
    $(document).find("#inputBirthDay").keyup(function(event){
        if($("#inputBirthDay").val().length >= 2){
            if($(this).val() < 1 || $(this).val() > 31){
                $(this).val("");
                $(this).focus();
                alert("잘못된 일자입니다.");
            }
            return false;
        }
    });

    // 닉네임 검증(한글&영문&숫자 가능, 특수문자만 불가)
    $(document).find('#inputNick').keyup(function(event){
        var spec = /[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi;
        nick = $(this).val();
        if(spec.test(nick)){
            alert('특수문자는 사용 불가능합니다.');
            $(this).val(nick.replace(spec,''));
        }
    });
    
    // 회원가입 버튼 클릭 시
    $(document).find('#signupSubmit').on('click',function(){
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
        
        alert("연락처 : " + m_phone + " / 생일 : " + m_birth);
        
        if(m_email == ""){
            alert('이메일을 입력하세요.');
            return false;
        }
        if(email_auth != "이메일 인증 완료"){
            alert('이메일 인증을 완료하세요.');
            return false;
        }
        if(m_pwd == ""){
            alert('비밀번호를 입력하세요.');
            return false;
        }
        if(m_pwdCheck == ""){
            alert('비밀번호 확인을 입력하세요');
            return false;
        }
        if(m_name == ""){
            alert('이름을 입력하세요.');
            return false;
        }
        if(phone1 == "" || phone2 == "" || phone3 == ""){
            alert('연락처를 입력하세요.');
            return false;
        }
        if(birthY == "" || birthM == "" || birthD == ""){
            alert('생년월일을 입력하세요.');
            return false;
        }
        if(m_gender == ""){
            alert('성별을 선택하세요.');
            return false;
        }
        if(m_nick == ""){
            alert('닉네임을 입력하세요.');
            return false;
        }
        //체크안하고 회원가입 버튼 누를시
        if($("#c1").prop("checked")==false){
            alert("회원약관 동의에 체크하셔야 회원가입이 가능합니다.");
            return false;
        }
        
        $('#m_email').val(m_email);
        $('#m_pwd').val(m_pwd);
        $('#m_name').val(m_name);
        $('#m_phone').val(m_phone);
        $('#m_birth').val(m_birth);
        $('#m_gender').val(m_gender);
        $('#m_nick').val(m_nick);
        $('#m_img').val(m_img);
        alert('이미지링크 : ' + $('#m_img').val());
        return true;
    });
    
});
$(function(){
	 
    /* 기본정보 탭 관련 */
    
    var today = new Date();
    today.setDate(today.getDate()+6);
    var minYear = today.getYear()+1900;
    var todayMonth = today.getMonth()+1; 
    var minMonth = "";
    if(todayMonth < 10){
    	minMonth = "0" + todayMonth;
    }
    else{
    	minMonth = todayMonth;
    }
    var todayDate = today.getDate();
    var minDate = "";
    if(todayDate < 10){
    	minDate = "0" + todayDate;
    }
    else{
    	minDate = todayDate;
    }
    var mindate = minYear + "-" + minMonth + "-" + minDate;
    
	// 이미지 미리보기
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
    
    // 제목 40자 글자수 제한
	$('#inputName').on('keyup',function(){
		var strVal = $(this).val();
		var strLen = strVal.length;
		var totalByte = 0;
		var len = 0;
		var oneChar = "";
		
		if(staVal = ""){
			$('#countWords').text("0/40");
		}
		
		for(var i = 0; i < strLen; i++){
			oneChar = strVal.charAt(i);
			if(escape(oneChar).length > 4){
				totalByte++;  // totalByte += 2;
			}
			else{
				totalByte++;
			}
			
			if(totalByte <= 40){
				len = i + 1;
			}
			$('#countWords').text(totalByte + "/40");
		}
		
		if(totalByte > 40){
			str2 = strVal.substr(0, len);
			$('#countWords').text("40/40");
			$(this).val(str2);
			alert("40자를 초과할 수 없습니다.");
		}
	});
	
	// 목표금액 입력 시
	$('#inputTarget').keyup(function(){
		var target = $(this).val();
		var wonTarget = target*10000;
		var wonTargetStr = wonTarget.toString();
		var hanA = new Array("", "일", "이", "삼", "사", "오", "육", "칠", "팔", "구", "십");
		var danA = new Array("", "십", "백", "천", "", "십", "백", "천", "", "십", "백", "천", "", "십", "백", "천");
		var strTarget = "";
		if(target <= 0){
			$(this).val("");
			$("#strTarget").text("(0원)");
			alert("마이너스 금액 또는 0원은 입력할 수 없습니다.");
		}
		if(target > 100000){
			$(this).val("");
			$("#strTarget").text("(0원)");
			alert("10억원 이상은 입력할 수 없습니다.");
		}
		if(target > 0 && target <= 100000){
			for(var i = 0; i < wonTargetStr.length; i++){
				var str = "";
				var han = hanA[wonTargetStr.charAt(wonTargetStr.length-(i+1))];
				if(han != ""){
					str += han+danA[i];
				}
				if(i == 4){
					str += "만";
				}
				if(i == 8){
					str += "억";
				}
				if(i == 12){
					str += "조";
				}
				strTarget = str + strTarget;
			}
			if(target > 0){
				strTarget = "(" + strTarget + "원)"; 
			}
		}
		$("#strTarget").text(strTarget);
	});
	
	// 시작일 선택되었을 때
	$(document).find('#inputStartdate').change(function(){
		var val_sdate = $(this).val();
		var val_edate = $('#inputEnddate').val();
		var sdate = val_sdate.split('-');
		var startd = new Date(sdate[0], (sdate[1]-1), sdate[2]);
		if(startd < today){
			alert("오늘 기준으로 7일 이후부터 시작일 설정이 가능합니다.");
			$(this).val(mindate);
		}
		if(val_edate != ""){
			var edate = val_edate.split('-');
			var endd = new Date(edate[0], edate[1], edate[2]);
			if(startd.getTime() >= endd.getTime()){
				alert("시작일은 종료일 이전이어야 합니다.");
				$(this).val(mindate);
				$('#inputEnddate').val("");
				$('#period').text("");
			}
			else{
				var periodms = endd - startd;
				var cDay = 24 * 60 * 60 * 1000;  // 시 * 분 * 초 * 밀리세컨
				var period = periodms/cDay;  // 기간 일수 구하기
				if(period < 14 || period > 90){
					alert("프로젝트 진행은 최소 14일, 최대 90일까지 가능합니다.");
					$('#inputEnddate').val("");
					$('#period').text("");
					return false;
				}
				else{
					$('#period').text("  " + period + "일");
					return true;
				}
			}
		}
	});
	
	// 종료일 선택되었을 때
	$(document).find('#inputEnddate').change(function(){
		var val_edate = $(this).val();
		var val_sdate = $('#inputStartdate').val();
		var edate = val_edate.split('-');
		var endd = new Date(edate[0], (edate[1]-1), edate[2]);
		
		if(val_sdate != ""){
			var sdate = val_sdate.split('-');
			var startd = new Date(sdate[0], (sdate[1]-1), sdate[2]);
			if(startd.getTime() >= endd.getTime()){
				alert("시작일은 종료일 이전이어야 합니다.");
				$('#inputStartdate').val("");
				$(this).val("");
				$('#period').text("");
			}
			else{
				var periodms = endd - startd;
				var cDay = 24 * 60 * 60 * 1000;  // 시 * 분 * 초 * 밀리세컨
				var period = periodms/cDay;  // 기간 일수 구하기
				if(period < 14 || period > 90){
					alert("프로젝트 진행은 최소 14일, 최대 90일까지 가능합니다.");
					$(this).val("");
					$('#period').text("");
					return false;
				}
				else{
					$('#period').text("  " + period + "일");
					return true;
				}
			}
		}
	});
	
	// 임시저장 버튼 클릭 시
	$('#saveBtn1').on('click', function(){
		var form = $('#basicInfoForm')[0];
		var formData = new FormData(form);
		$.ajax({
			url : "JBU_UPDATE.do",
			type: "POST",
			enctype: 'multipart/form-data',
			data : formData,
			processData: false,
	        contentType: false,
	        cache: false,
			success : function(data){
				if(data == 'success'){
					alert("기본정보가 저장되었습니다.");
					$(document).find('#item02').attr('checked', true);
				}
				if(data == 'fail'){
					alert("기본정보가 저장되지 않았습니다.");
				}
			},
			error : function(){
				console.log("오류!");
			}
		});
	});
	
	// 메인으로 버튼 클릭 시
	$('#mainBtn1').on('click', function(){
		var conf = confirm("저장하시려면 확인, 저장하지 않고 메인화면으로 이동하시려면 취소를 선택하세요.");
		if(conf == true){
			var form = $('#basicInfoForm')[0];
			var formData = new FormData(form);
			$.ajax({
				url : "JBU_UPDATE.do",
				type: "POST",
				enctype: 'multipart/form-data',
				data : formData,
				processData: false,
		        contentType: false,
		        cache: false,
				success : function(data){
					if(data == 'success'){
						alert("기본정보가 저장되었습니다.");
						location.href="MAIN.do";
					}
					if(data == 'fail'){
						alert("기본정보가 저장되지 않았습니다.");
					}
				},
				error : function(){
					console.log("오류!");
				}
			});
		}
		else{
			alert("기본정보를 저장하지 않고 메인화면으로 이동합니다.")
			location.href="MAIN.do";
		}
	});
	
    /* 기본정보 탭 관련 끝 */
	
	/* 정책확인 탭 관련 */
	
    // 내용 1000자 글자수 제한
	$('#inputPolicy').on('keyup',function(){
		var pStrVal = $(this).val();
		var pStrLen = pStrVal.length;
		var pTotalByte = 0;
		var pLen = 0;
		var pOneChar = "";
		
		if(pStaVal = ""){
			$('#policyWords').text("0/1000");
		}
		
		for(var i = 0; i < pStrLen; i++){
			pOneChar = pStrVal.charAt(i);
			if(escape(pOneChar).length > 4){
				pTotalByte++;  // totalByte += 2;
			}
			else{
				pTotalByte++;
			}
			
			if(pTotalByte <= 1000){
				pLen = i + 1;
			}
			$('#policyWords').text(pTotalByte + "/1000");
		}
		
		if(pTotalByte > 1000){
			pStr2 = pStrVal.substr(0, pLen);
			$('#policyWords').text("1000/1000");
			$(this).val(pStr2);
			alert("1000자를 초과할 수 없습니다.");
		}
	});
	
	// 프로젝트 정책확인 정보 수정 (임시저장 버튼 클릭 시)
	$(document).find('#saveBtn2').on('click', function(){
		var p_index = $(document).find('#p_index').val();
		var m_id = $(document).find('#m_id').val();
		var policy_value = $('#inputPolicy').val();
		policy_value = policy_value.replace(/(?:\r\n|\r|\n)/g, '<br/>');
		$.ajax({
			url : "JPU_UPDATE.do",
			type : "post",
			data : {p_policy : policy_value,
					p_index : p_index},
			success : function(data){
				console.log(data);
				if(data == 'success'){
					policy_value = policy_value.split('<br/>').join("\r\n");
					$(document).find('#inputPolicy').val(policy_value);
					alert("정책확인 정보가 저장되었습니다.");
					$('#item03tab').trigger('click');
				}
				else{
					console.log('저장 실패!');
				}
			},
			error : function(){
				console.log("error!!!!!");
			}
		});
	});
	
	/* 정책확인 탭 관련 끝 */

	/* 스토리 탭 관련 */
	
	// 스토리 멤버 생성 및 버튼 생성
	$(document).find('#addStoryMemberBtn').on('click', function(){
		var pro_index = $('#p_index').val();
		var searchStoryMember = $('#searchStoryMember').val();
		$.ajax({
			url : "JSI.do", 
			type : "post",
			data : {p_index : pro_index,
					email : searchStoryMember},
			success : function(data){
				if(data != "null" && data != "exist"){
					alert("검색 결과 : " + data);
					$(document).find('#storyMemberList').append("<button class='storyMember' value='" + searchStoryMember + "'>" + data + "</button>");
					$('#searchStoryMember').val("");
				}
				else if(data == "exist"){
					alert("이미 등록된 스토리멤버입니다.");
				}
				else{
					alert("검색 결과 해당 회원 없음!");
				}
			},
			error : function(){
				console.log("스토리 멤버 찾기 에러!");
			}
		});
	});
	
	// 스토리 멤버 버튼 클릭 시 해당 스토리 멤버 삭제
	$(document).find('#storyMemberList').on('click', '.storyMember', function(){
		var deleteP_index = $('#p_index').val();
		var delete_storyMember = $(this);
		var deleteEmail = delete_storyMember.val();
		$.ajax({
			url : "JSD.do",
			type : "post",
			data : {email : deleteEmail,
					p_index : deleteP_index},
			success : function(data){
				if(data == "success"){
					alert(deleteEmail + " : 성공적으로 스토리멤버를 삭제하였습니다.");
					delete_storyMember.remove();
				}
				else{
					console.log("스토리멤버 삭제 실패!");
				}
			},
			error : function(){
				console.log("스토리 멤버 삭제 오류!");
			}
		});
	});
	
	// 임시 저장 버튼 클릭 시
	$(document).find('#saveBtn3').on('click', function(){
		alert("스토리가 저장되었습니다.");
		$('#item04tab').trigger('click');
	});
	
	/* 스토리 탭 관련 끝 */
	
	/* 승인요청 */
	
	$(document).find('#submitProject').on('click', function(){
		/* 기본정보 */
		var p_index = $('#p_index').val();
		var m_id = $('#m_id').val();
		var p_img = $('#blah').attr('src');
		var ct_index = $('#inputCtIndex').val();
		var p_name = $('#inputName').val();
		var p_type = $('[name=p_type]').val();
		var p_target = $('#inputTarget').val();
		var p_startdate = $('#inputStartdate').val();
		var p_enddate = $('#inputEnddate').val();
		var p_age = $('#inputAge').val();
		
		if(p_img == "") {
			alert("프로젝트 메인 이미지를 등록하세요.");
			return false;
		}
		if(ct_index == ""){
			alert("프로젝트 카테고리를 선택하세요.");
			return false;
		}
		if(p_name == ""){
			alert("프로젝트명을 입력하세요.");
			return false;
		}
		if(p_type == ""){
			alert("프로젝트 성공 조건을 선택하세요.");
			return false;
		}
		if(p_target == ""){
			alert("프로젝트 목표 금액을 입력하세요.");
			return false;
		}
		if(p_startdate == ""){
			alert("프로젝트 시작일을 선택하세요.");
			return false;
		}
		if(p_enddate == ""){
			alert("프로젝트 종료일을 선택하세요.");
			return false;
		}
		
		var basicform = $('#basicInfoForm')[0];
		var basicformData = new FormData(basicform);
		var basicResult = "";
		var policyResult = "";
		var savedBasic = $.ajax({
			url : "JBU_UPDATE.do",
			type: "POST",
			enctype: 'multipart/form-data',
			data : basicformData,
			processData: false,
			contentType: false,
			cache: false,
			error : function(){
				console.log("기본정보 저장 오류!");
			}
		});
	
		/* 정책확인 */
		var p_policy = $('#inputPolicy').val();
		if(p_policy == ""){
			alert("프로젝트의 교환/환불/AS정책을 입력하세요.");
			return false;
		}
		
		
		/* 스토리 */
		var p_contents = "12345";  // 스토리 어떻게 가져와야 하나요...?
		if(p_contents == ""){
			alert("프로젝트 스토리를 작성하세요.");
			return false;
		}
		
		var storyResult = "";
		if(p_contents != ""){
			
		}
		var savedPolicy = $.ajax({
			url : "JPU_UPDATE.do",
			type : "post",
			data : {p_policy : p_policy,
				p_index : p_index},
				error : function(){
					console.log("정책 저장 오류!!!!!!");
				}
		});
		
		/* 리워드 */
		var savedRewList = $('[name=r_index]').val();
		var rewardResult = "";
		if(savedRewList == ""){
			var rewardConf = confirm("리워드를 등록하지 않고 승인요청을 진행하시겠습니까?");
			switch(rewardConf){
			case false:
				$('#item04tab').trigger('click');
				break;
			case true:
				rewardResult = "success";
				break;
			}
		}
		if(savedRewList != ""){
			rewardResult = "success";
		}
		console.log("rewardResult : " + rewardResult);
		
		/* 모든 데이터 DB저장 후 승인 요청 실행 */
		savedBasic.done(function(data){
			basicResult = data;
			console.log("basicResult : " + basicResult);
			savedPolicy.done(function(data2){
				policyResult = data;
				console.log("policyResult : " + policyResult);
				if(basicResult == "success" && policyResult == "success" && rewardResult == "success"){
					$.ajax({
						url : "JJU.do",
						data : {p_index : p_index,
							p_approval : 1},
							success : function(data){
								switch(data){
								case "success":
									alert("승인 요청되었습니다.");
									console.log("approve result : " +  data);
									location.href = "MJS.do";
									break;
								default :
									console.log("승인요청 실패!");
									break;
								}
							},
							error : function(){
								console.log("승인요청 오류!");
							}
					});
				}
				else{
					console.log("결과 : success 안되서 승인요청 실패함...");
				}
			});
		});
	});	
	
	/* 승인요청 끝 */
	
});
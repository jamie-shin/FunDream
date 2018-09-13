<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addProject</title>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js"></script>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.js"></script>
	<script src="js/makeProject.js"></script>
	<link rel="stylesheet" type="text/css" href="css/addProject.css">
	<!-- <script src="js/summernote-ko-KR.js"></script> -->

<script type="text/javascript">
	$(function(){
		var docu = $(document);
		$('#addReward').on('click', function(){
			$('#reward').append(
				`
				<div id="setReward"> 
					<div class='ap-reward' id="rewardBar">
						<h2 id="rTitle">리워드</h2>
						<button class='ap-reward-deletebtn' id="r_deletebtn"> X </button>
					</div>
					<div class='menu' id='ap-reward-container'>
					<form id="rewardInfoForm" method="post" enctype="multipart/form-data" accept-charset="UTF-8" action="">
						<input type="hidden" id="p_index" name="p_index" value="${param.p_index}">
						<input type="hidden" id="r_index" name="r_index">
						<input type="hidden" id="r_start" name="r_start">
						
						<h3>리워드 이미지</h3>
						<div class='ap-contents-box'>
							<span>
							<input type='file' id="r_img" name='r_img' class='ap-reward-img-addbtn'/><img src='#' class='ap-reward-img' id='blah2'  alt="이미지를 선택하세요">
							</span>
						</div>
						
						<h3>리워드명</h3>
						<input type='text' id="inputR_name" name='r_name' class='ap-reward-name'>
						
						<h3>금액</h3>
						<div class="jji-fee"><input type='number' id="r_price" name='r_price' class='ap-reward-price'><span class="ap-span">&emsp;원</span></div>
						
						<h3>카테고리</h3>
						<select id="ct_index" name='ct_index' class='ap-reward-sel-category'>
							<c:forEach items="${rCategoryList}" var="category">
								<option value="${category.ct_index}">${category.ct_name}</option>		
							</c:forEach>
						</select>
						
						<h3>상세설명</h3>
						<textarea id="r_contents" name='r_contents' class='ap-reward-ta1'></textarea>
						
						<h3>옵션조건</h3>
						<input type='checkbox' id="optCheck" class='ap-reward-checkbox'>옵션 입력이 필요한 리워드 입니다.<br>
						<textarea name='r_option' id="r_option" class='ap-reward-ta2' style='display:none;' placeholder='옵션 내용을 입력해주세요.'></textarea>
						
						<h3>배송조건</h3>
						<label><input type='radio' class='ap-reward-radio' id="r_delN" name='delivery' value='0'/>배송정보 불필요</label>
						<label><input type='radio' class='ap-reward-radio' id="r_delY" name='delivery'/>배송정보 필요</label><br>
						<span id='del' style='display: none;'><p>배송비</p><input type='text' name='r_del' class='ap-reward-delpay' id='input_del' />원</span>
						
						<h3>제한수량</h3>
						<label for='r_amtN'>
						<input type='radio' class='ap-reward-radio' id='r_amtN' name='re-num' checked /> 제한없음</label>
						<label for='r_amtY' id="amt">
						<input type='radio' class='ap-reward-radio' name='re-num' id='r_amtY' />리워드를
						<input type='text' name='r_amt' id='input_amt' class='ap-reward-amt' disabled='true'>개로 제한합니다.</label>
						
						<h3>발송시작일</h3>
						<select id="delyear" name="delyear" class='ap-reward-delyear'>
							<option value='2018'>2018년</option>
							<option value='2019'>2019년</option>
							<option value='2020'>2020년</option>
						</select>
						<select id="delmonth" name="delmonth" class='ap-reward-delmonth'>
							<c:forEach begin="1" end="12" varStatus="s">
								<option value='${s.count}'>${s.count}월</option>
							</c:forEach>
						</select>
						<select id="delday" name="delday" class='ap-reward-delday'>
							<option value='1'>초(1~10)</option>
							<option value='11'>중순(11~20)</option>
							<option value='21'>말(21~말일)</option>
						</select>
						<br> <br> <br>
						<button id="r_insertbtn" class='ap-reward-savebtn'>저장</button>
					</form>
					</div>
				</div>
				`
			);
		});
		
		// 리워드 바 선택 시
		$(document).on('click', "[id=rewardBar]", function() {
			$(this).removeAttr('style');
			$(this).siblings('[class=menu]').not($(this).next('[class=menu]').slideToggle("slow")); // 현재 선택한 항목 다음의 하위 항목을 제외한 모든 항목을 축소합니다.
		});
		
		// 리워드 옵션 체크 시
		$(document).on('click', "[id=optCheck]", function() {
			$(this).siblings('#r_option').slideToggle();
		});
		
		// 리워드 배송 선택 시
	 	$(document).on('click', "[id^=r_del]", function() {
			var del_id = $(this).attr('id');
			alert(del_id);
			switch(del_id){
			case 'r_delY' :
				$(this).parent().siblings('#del').show();
				$(this).parent().siblings('#del').children('#input_del').val("");
				break;
			case 'r_delN' :
				$(this).parent().siblings('#del').hide();
				$(this).parent().siblings('#del').children('#input_del').val("0");
				break;
			}
		});

		// 리워드 제한 수량 선택 시
		$(document).on('click', "[id^=r_amt]", function(){
			var amt_id = $(this).attr('id');
			alert(amt_id);
			if(amt_id == "r_amtY"){
				$(this).siblings('#input_amt').attr('disabled', false);
				$(this).siblings('#input_amt').focus();
			}
			if(amt_id == "r_amtN"){
				$(this).parent().siblings('#amt').children('#input_amt').attr('disabled', true);
				$(this).parent().siblings('#amt').children('#input_amt').val("");
			}
		});
		
		// 리워드 생성
	 	$(document).on('click', "[id=r_insertbtn]", function(e){
	 		var form = $(this).parent('#rewardInfoForm')[0];
	 		var formData = new FormData(form);

	 		var r_index = "";
			var p_index = $(this).siblings('#p_index').val();
			var r_name = $(this).siblings('#inputR_name').val();
			if(r_name == "") alert("리워드명을 입력하세요.");
			var r_price = $(this).siblings('#r_price').val();
			if(r_price == "" || r_price == 0) alert("리워드 금액을 입력하세요.");
			var ct_index = $(this).siblings('#ct_index').val();
			if(ct_index == "") alert("리워드 카테고리를 선택하세요.");
			var r_contents = $(this).siblings('#r_contents').val();
			if(r_contents == "") alert("리워드 상세설명을 입력하세요.");
			
	 		var delYear = $(this).siblings('#delyear').val();
	 		if(delYear == "") alert("발송 시작 연도를 선택하세요.");
			var delMonth = $(this).siblings('#delmonth').val();
			if(delMonth == "") alert("방송 시작 월을 선택하세요.");
			var delDay = $(this).siblings('#delday').val();
			if(delDay == "") alert("발송 시작 일을 선택하세요.");
			$(this).siblings("#r_start").val(r_start);
			var r_start = delYear+'-'+delMonth+'-'+delDay;
		
			$(this).parent().parent().siblings('#rewardBar').children("#rTitle").text(r_name);
			var aaa = $(this).parent().parent().siblings('#rewardBar').children("#rTitle").text();
	 		alert("^^* " + aaa);
	 		
	 		var element = $(this);
	 		var r_index_element = $(this).siblings('#r_index');
	 		
	 		$.ajax({
				url: 'JRI_INSERT.do',
				type: "POST",
				enctype: 'multipart/form-data',
				data : formData,
				processData: false,
		        contentType: false,
		        cache: false,
				success: function(data){
					// 리워드 생성 성공 시 리워드 인덱스 리턴
					if(data != "0"){
						element.val(data);
						element.append(`<button id="r_update" class='ap-reward-savebtn'>수정</button>`);
						r_index_element.val(data);
						alert(data + " 리워드가 저장되었습니다.");
						docu.find('#item04').attr('checked', 'checked');
						element.hide();
					}
					else{
						alert("리워드 저장 실패!");
					}
				},
				error: function(){
					alert('리워드 저장 에러');
				}
			});
			e.preventDefault();
	 		$('[class=menu]').slideUp();
		});
	 	
		// 리워드 삭제
	    $(document).on('click', "[id=r_deletebtn]", function(){
	        var delete_index = $(this).parent().siblings('#ap-reward-container').children("#rewardInfoForm").children('#r_index').val();
	        var r_del_con = confirm("선택한 리워드를 삭제하시겠습니까?");
	        var head = $(this).parent();
	        if(delete_index != ""){
		        if (r_del_con == true){
		           $.ajax({
		              url: 'JRD_DELETE.do',
		              data: {r_index : delete_index},
		              type: "post",
		              success: function(data){
			               if(data == "success"){
			            	   alert("리워드가 삭제되었습니다.");
					           head.next('[class^=menu]').remove();
					           head.remove(); //id=reward   
			               }
			               else{
			            	   alert("리워드 삭제를 실패하였습니다.");
			               }
		              },
		              error: function(){
		                 alert('리워드 삭제 에러!');
		              }
		           });
		        }
	        }
	        else{
	        	if(r_del_con == true){
            	   alert("리워드가 삭제되었습니다.");
		           head.next('[class^=menu]').remove();
		           head.remove(); //id=reward   
	        	}
	        }
	     });
	    
		// 리워드 수정
	    $(document).on('click', "[id=r_updatebtn]", function(e){
			var form = $(this).parent('#rewardInfoForm')[0];
			var formData = new FormData(form);

			var r_index = "";
			var p_index = $(this).siblings('#p_index').val();
			var r_name = $(this).siblings('#inputR_name').val();
			if(r_name == "") alert("리워드명을 입력하세요.");
			var r_price = $(this).siblings('#r_price').val();
			if(r_price == "" || r_price == 0) alert("리워드 금액을 입력하세요.");
			var ct_index = $(this).siblings('#ct_index').val();
			if(ct_index == "") alert("리워드 카테고리를 선택하세요.");
			var r_contents = $(this).siblings('#r_contents').val();
			if(r_contents == "") alert("리워드 상세설명을 입력하세요.");
			
			var delYear = $(this).siblings('#delyear').val();
			if(delYear == "") alert("발송 시작 연도를 선택하세요.");
			var delMonth = $(this).siblings('#delmonth').val();
			if(delMonth == "") alert("방송 시작 월을 선택하세요.");
			var delDay = $(this).siblings('#delday').val();
			if(delDay == "") alert("발송 시작 일을 선택하세요.");
			$(this).siblings("#r_start").val(r_start);
			var r_start = delYear+'-'+delMonth+'-'+delDay;
			
			$(this).parent().parent().siblings('#rewardBar').children("#rTitle").text(r_name);
			var aaa = $(this).parent().parent().siblings('#rewardBar').children("#rTitle").text();
			alert("^^* " + aaa);
			
			var element = $(this);
			var r_index_element = $(this).siblings('#r_index');
			
			$.ajax({
				url: 'JRU_MODIFIED.do',
				type: "POST",
				enctype: 'multipart/form-data',
				data : formData,
				processData: false,
				contentType: false,
				cache: false,
				success: function(data){
					alert("리워드 수정 결과 : " +data);
					switch(data){
					case "success":
						alert(r_index_element + " 리워드가 저장되었습니다.");
						docu.find('#item04').attr('checked', 'checked');
						element.hide();
						break;
					case "fail":
						alert("리워드 저장 실패!");
						break;
					}
				},
				error: function(){
					alert('리워드 저장 에러');
				}
			});
			e.preventDefault();
			$(this).parent().parent('[class=menu]').slideUp();
		});
	 
		//이미지 미리보기
	    $(document).on('change',"#r_img", function(){
	        readURL1(this);
	    });
		
	});

	function readURL1(input) {
	    if (input.files && input.files[0]) {
	    var reader = new FileReader();
	
	    reader.onload = function (e) {
	            $('#blah2').attr('src', e.target.result);
	        }
	      reader.readAsDataURL(input.files[0]);
	    }
	}
</script>
<script>
$(function() {
    $("#imgInp2").on('change', function(){
        readURL(this);
    });
});
function readURL(input) {
    if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
            $('#blah3').attr('src', e.target.result);
        }
      reader.readAsDataURL(input.files[0]);
    }
}
</script>
</head>

<body>
	<div class="ap-container">
		<input id="item01" type="radio" class="ap-radio-tab" name="tab" checked="checked">
		<input id="item02" type="radio" class="ap-radio-tab" name="tab">
		<input id="item03" type="radio" class="ap-radio-tab" name="tab">
		<input id="item04" type="radio" class="ap-radio-tab" name="tab">
		<input type="hidden" id="p_index" name="p_index" value="${p_index}">
		<input type="hidden" id="m_id" name="m_id" value="${m_id}">
		<ul class="ap-menu">
			<li><label for="item01">기본정보</label></li>
			<li><label for="item02">정책확인</label></li>
			<li><label for="item03">스토리</label></li>
			<li><label for="item04">리워드</label></li>
		</ul>
		<ul class="ap-contents">
			<!-- 기본정보 -->
			
			<li class="ap-contents-list item01">
			<form id="basicInfoForm" method="post" enctype="multipart/form-data" accept-charset="UTF-8" action="JBU_UPDATE.do">
				<input type="hidden" id="p_index" name="p_index" value="${p_index}">
				<input type="hidden" id="m_id" name="m_id" value="${m_id}">
				<h2>대표 이미지</h2>
				<p class="ap-p">메이커와 리워드가 함께 있거나, 프로젝트의 성격이 한 눈에 드러나는 사진이 좋습니다.</p>
				<div class="ap-contents-box">
					<span>
						<h4 class="ap-image-h4">대표이미지</h4>
						<input type="file" id="imgInp" name="p_mainImg">
						<img id="blah" src="#" alt="이미지를 선택하세요" class="ap-title-img"/>
					</span>
				</div>
				<h2>프로젝트 번호</h2>
				<p class="ap-p">펀드림 담당자와의 소통은 프로젝트 번호로 진행됩니다.</p>
				<textarea class="ap-ta" readonly>
프로젝트 번호   : ${p_index}
프로젝트 url : http://Fundream.kr/web/campaign/detail/${p_index}
* 프로젝트 오픈 이후 위의 url로 진입이 가능합니다.
				</textarea>
				<h2>연락처</h2>
				<p class="ap-p">주요 안내를 받으신 이메일과 휴대폰 번호를 등록해주세요. 정보 변경은 회원정보 설정에서 가능합니다.</p>
				<div class="ap-contents-box">
					<span>
						이메일 <input type="text" id="" class="ap-txtbox" name="" placeholder="${m_email}" readonly>
					</span><br><br>
					<span>핸드폰 <input type="text" id="" class="ap-txtbox" name="" placeholder="${m_phone}" readonly>
					</span>
				</div>
				<h2>카테고리</h2>
				<p class="ap-p">오픈 후, 노출될 카테고리를 선택해주세요</p>
				<div class="ap-contents-box">
					<select name="ct_index" id="inputCtIndex" class="ap-select-category">
						 <option disabled="disabled">카테고리를 선택하세요</option>
						<c:forEach items="${pCategoryList}" var="category">
							<option value="${category.ct_index}" <c:if test="${project.ct_index == category.ct_index}">selected='selected'</c:if>>${category.ct_name}</option>
						</c:forEach>
					</select>
				</div>
				<h2>프로젝트 제목</h2>
				<p class="ap-p">프로젝트 성격과 리워드를 짐작할 수 있게 간결하고 직관적으로 작성해주세요</p>
				<div class="ap-contents-box">
					<input type="text" id="inputName" name="p_name" class="ap-txt-title" value="${project.p_name}" placeholder="예) 더 가벼워진 미래식사, 밀스 라이트"> <small id="countWords">0/40</small>
				</div>
				<h2>프로젝트 성공조건</h2>
				<p class="ap-p">수수료(VAT별도) 조건 없을 시 10%, 목표금액 100% 달성 시 7%가 부과됩니다.</p>
				<div class="ap-contents-box">
					<div class="ap-radios"><!-- radio id값 css에는 영향을 안주니 바꾸셔도됩니다. for와 id만 맞춰주세요 -->
						<input type="radio" name="p_type" id="radio1" value="1" hidden <c:if test="${project.p_type == 1}">checked='checked'</c:if>>
						<label for=radio1></label><!-- radio  -->
						<label for=radio1>조건없음</label>
						<input type="radio" name="p_type" id="radio2" value="2" hidden <c:if test="${project.p_type == 2}">checked='checked'</c:if>>
						<label for=radio2></label>
						<label for=radio2>목표금액 100%이상 달성시</label>
					</div><br>
					<div class="ap-center-box">
						<small class="ap-small">설정한 목표금액 100% 이상 달성시에만 후원금 지급 리워드 배송은 프로젝트 마감일+5 영업일 후부터 가능합니다<br>(마감일+4영업일 간 결제실행)</small>
					</div>
				</div>
				<h2>목표금액</h2>
				<p class="ap-p">최소 목표 금액은 50만원, 목표 최대금액은 10억원 입니다.</p>
				<div class="ap-contents-box">
					<label><input type="number" name="p_target" id="inputTarget" class="ap-txt-pay" value="${project.p_target}">만원</label>
					<small id="strTarget" style="font-weight: bold; align-items: center;">
						<c:if test="${project.p_target == 0}">(0원)</c:if>
					</small>
				</div>
				<h2>프로젝트 기간</h2>
				<p class="ap-p">프로젝트 진행은 최소 14일, 최대 90일까지 가능합니다.</p>
				<div class="ap-contents-box">
					<div class="ap-center-box">
						<small class="ap-small">프로젝트 시작은 오늘기준 7일 이후부터 가능합니다.</small><br>
						<label class="ap-dateSelect" for="inputStartdate"><!-- 달력으로 날짜 입력받는 곳입니다. for와 id값만 맞춰주세요. -->
							<!-- text 불가능할 경우 date로 변경하기 -->
							시작일 <input type="date" class="ap-date" name="p_startdate" id="inputStartdate" value="${sdate}">
						</label>
						<label class="ap-dateSelect" for="inputEnddate">
							종료일 <input type="date" class="ap-date" name="p_enddate" id="inputEnddate" value="${edate}">
						</label>
						<small class="ap-samll" id="period"></small><br>
					</div>
				</div>
				<h2>19세 이상(선택)</h2>
				<div class="ap-wrap"><!-- for와 id값만 맞춰주세요 css는 ap-check/ap-check-label로 유지됩니다.-->
					<input id="inputAge" name="p_age" type="checkbox" class="ap-check" <c:if test="${project.p_age == 2}">checked='checked'</c:if>>
					<label class="ap-check-label" for="inputAge">리워드가 19세 이상 이용 가능한 제품/서비스(주류/티켓 등)인 경우, 체크하세요</label>
				</div><br><br><br>
				<div class="ap-btn-center">
					<input type="button" class="ap-prev-btn" id="mainBtn1" name="" value="메인">
					<input type="button" class="ap-next-btn" id="nextBtn1" name="" value="다음>">
				</div>
			</form>
			</li>
			
			
			<!-- 정책확인 -->
			
			
			<li class="ap-contents-list item02">
				<h2>리워드 제공 지연 관련</h2>
	    		<p class="ap-p">리워드 발송 지연 관련 필수 안내사항 입니다.<br>배송예정일로 부터 최대 30일 이내  리워드 발송이 되지 않는경우 후원자에게 전액 환불 해주어야 합니다.</p>
	  			<textarea class="ap-policy-area1" readonly="readonly">
1. 리워드가 배송 예정일 보다 늦게 발송 되는 경우 이메일로 변경된 리워드 제공일을 알려 드립니다.
2. 배송예정일로 부터 30일 이내 에 리워드 발송이 되지 않을 경우 본인의 계좌로 100% 환불해 드립니다.
	  			</textarea>
	  			<h2>교환/환불/AS정책</h2>
	   		 	<p class="ap-p">펀딩 마감 후의 환불 및 교환 요청은 메이커가 약속하는 정책에 따릅니다.<br> 
후원자에게 약속할 수 있는 정책을 신중하고 명확하게 작성해주세요.<br>
특히 환불은 단순 변심, 환불 조건 등의 다양한 상황을 고려해야 합니다.
 				</p>
	 			<textarea class="ap-policy-area2" id="inputPolicy" name="p_policy" autofocus="autofocus">
	 			<c:if test="${project.p_policy == null}">
- 제품 하자로 인한 교환/수리 시, 발생하는 비용은 전액 메이커가 부담합니다
- 리워드 수령 일 내 동일 증상으로 번 이상 수리 시, 환불 가능합니다.
- 리워드 수령 **일 이내 제품 하자로 인한 교환/수리 문의는 로 신청 가능합니다.
- 제품 하자가 아닌 서포터님 부주의로 인한 제품 손상은 유상수리해 드립니다.
- 교환/환불/AS 요청자 정보와 서포터 정보의 일치 여부 확인 후, 진행됩니다.
 
※교환/환불/AS 불가능한 경우
- 서포터의 책임 있는 사유로 리워드가 멸실/훼손된 경우 (단지 확인을 위한 포장 훼손 제외)
- 서포터의 사용/소비에 의해 리워드의 가치가 감소한 경우
- 시간 경과로 인해 재판매가 곤란할 정도로 리워드의 가치가 상실한 경우
- 서포터의 단순 변심
- 메이커를 통한 교환/환불/AS 접수 절차 없이 임의로 반송한 경우
- 복제가 가능한 리워드의 포장을 훼손한 경우
- 펀딩/판매/생산방식 특성상, 교환/반품 시, 메이커에게 회복할 수 없는 손해가 발생한 경우 (펀딩마감 후, 개별 생산, 맞춤 제작 등)</c:if>
<c:if test="${project.p_policy != null}">${project.p_policy}</c:if></textarea>
	  			<span class="ap-txt-right"><small id="policyWords"><c:if test="${project.p_policy == null}">533/1000</c:if></small></span>
	  			<div class="ap-btn-center">
	  				<input type="button" class="ap-prev-btn" id="preBtn2" name="" value="<이전">
					<input type="button" class="ap-next-btn" id="nextBtn2" name="" value="다음>">
	  			</div>
			</li>
			
			<!-- 스토리  -->
			
			<li class="ap-contents-list item03">
				<h2>스토리 멤버</h2>
				<div class="ap-contents-box" id="storyMemberList">
					<input type="email" class="ap-txt-title" id="searchStoryMember" name="">
					<input type="button" class="ap-SMadd-btn" id="addStoryMemberBtn" value="추가">
					<c:if test="${smList != null}">
						<c:forEach items="${smList}" var="sm">
							<button class='storyMember' value='${sm.m_email}'>${sm.m_nick}</button>
						</c:forEach>
					</c:if>
				</div>
				<h2>프로젝트 상세내용</h2>
				
				<div id="summernote" ></div>
				<script>
					$('#summernote').summernote({
				        tabsize: 2,
				        height: 300,
				        lang: 'ko-KR'
				   	});
				</script>
				
				
				<div class="ap-btn-center">
	  				<input type="button" class="ap-prev-btn" name="" value="<이전">
					<input type="button" class="ap-next-btn" name="" value="다음>">
	  			</div>
			</li>
			
			<!-- 리워드 -->
			
			<li class="ap-contents-list item04">

			<!-- 리워드 아코디언 넣는곳 -->
			<div class="ap-right">
				<button id="addReward" class="ap-reward-addbtn">리워드 추가</button><br>
			</div>
				<input type="hidden" id="num" value="0">
				<div id="reward">
					<c:if test="${rewardList != null}">
						<c:forEach items="${rewardList}" var="rew">
							<div id="setReward"> 
								<div class='ap-reward' id="rewardBar">
									<h2 id="rTitle">${rew.r_name}</h2>
									<button class='ap-reward-deletebtn' id="r_deletebtn"> X </button>
								</div>
								<div class='menu' id='ap-reward-container' style="display: none;">
									<form id="rewardInfoForm" method="post" enctype="multipart/form-data" accept-charset="UTF-8" action="">
										<input type="hidden" id="p_index" name="p_index" value="${rew.p_index}">
										<input type="hidden" id="r_index" name="r_index" value="${rew.r_index}">
										<input type="hidden" id="r_start" name="r_start" value="${rew.r_start}">
										
										<h3>리워드 이미지</h3>
										<div class='ap-contents-box'>
											<span>
												<input type='file' id="imgInp2" name='r_img' class='ap-reward-img-addbtn'/><img src='#' class='ap-reward-img' id='blah3'  alt="이미지를 선택하세요">
											</span>
										</div>
										
										<h3>리워드명</h3>
										<input type='text' id="inputR_name" name='r_name' class='ap-reward-name' value="${rew.r_name}">
										
										<h3>금액</h3>
										<div class="jji-fee"><input type='number' id="r_price" name='r_price' class='ap-reward-price' value="${rew.r_price}"><span class="ap-span">&emsp;원</span></div>
										
										<h3>카테고리</h3>
										<select id="ct_index" name='ct_index' class='ap-reward-sel-category'>
											<c:forEach items="${rCategoryList}" var="category">
												<option value="${category.ct_index}" <c:if test="${category.ct_index == rew.ct_index}">selected='selected'</c:if>>${category.ct_name}</option>		
											</c:forEach>
										</select>
										
										<h3>상세설명</h3>
										<textarea id="r_contents" name='r_contents' class='ap-reward-ta1'>${rew.r_contents}</textarea>
										
										<h3>옵션조건</h3>
										<input type='checkbox' id="optCheck" class='ap-reward-checkbox' <c:if test="${(rew.r_option != '' && rew.r_option != null)}">checked='checked'</c:if>>옵션 입력이 필요한 리워드 입니다.<br>
										<textarea name='r_option' id="r_option" class='ap-reward-ta2' <c:if test="${(rew.r_option == '' || rew.r_option == null)}">style='display:none;'</c:if> placeholder='옵션 내용을 입력해주세요.'>${rew.r_option}</textarea>
										
										<h3>배송조건</h3>
										<label><input type='radio' class='ap-reward-radio' id="r_delN" name='delivery' value='0' <c:if test="${rew.r_del == 0}">checked='checked'</c:if> />배송정보 불필요</label>
										<label><input type='radio' class='ap-reward-radio' id="r_delY" name='delivery' <c:if test="${rew.r_del > 0}">checked='checked'</c:if> />배송정보 필요</label><br>
										<span id='del' <c:if test="${rew.r_del == 0}">style='display:none;'</c:if>><p>배송비</p><input type='number' name='r_del' class='ap-reward-delpay' id='input_del' value="${rew.r_del}" /> 원</span>
										
										<h3>제한수량</h3>
										<label for='r_amtN'>
										<input type='radio' class='ap-reward-radio' id='r_amtN' name='re-num' <c:if test="${(rew.r_amt == 0 || rew.r_amt == '')}">checked='checked'</c:if> /> 제한없음</label>
										<label for='r_amtY' id="amt">
										<input type='radio' class='ap-reward-radio' name='re-num' id='r_amtY' <c:if test="${(rew.r_amt != 0 && rew.r_amt != '')}">checked='checked'</c:if> />리워드를
										<input type='number' name='r_amt' id='input_amt' class='ap-reward-amt' <c:if test="${(rew.r_amt == 0 || rew.r_amt == '')}">disabled='true'</c:if> value="${rew.r_amt}"> 개로 제한합니다.</label>
										
										<h3>발송시작일</h3>
										<select id="delyear" name='delyear' class='ap-reward-delyear'>
											<option value='2018'>2018년</option>
											<option value='2019'>2019년</option>
											<option value='2020'>2020년</option>
										</select>
										<select id="delmonth" name="delmonth" class='ap-reward-delmonth'>
											<c:forEach begin="1" end="12" varStatus="s">
												<option value='${s.count}'>${s.count}월</option>
											</c:forEach>
										</select>
										<select id="delday" name="delday" class='ap-reward-delday'>
											<option value='1'>초(1~10)</option>
											<option value='11'>중순(11~20)</option>
											<option value='21'>말(21~말일)</option>
										</select>
										<br> <br> <br>
										<button id="r_updatebtn" class='ap-reward-savebtn'>수정</button>
									</form>
								</div>
							</div>
						</c:forEach>
					</c:if>
				</div>
				
			<!--  -->
				<div class="ap-btn-center">
	  				<input type="button" class="ap-prev-btn" name="" value="<이전">
	  			</div>
			</li>
		</ul>
	</div>
	
	<jsp:include page="Header.jsp"></jsp:include>
</body>
</html>
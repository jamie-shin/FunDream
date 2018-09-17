<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunDream</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link rel="stylesheet" href="css/project-sponsor.css">
<script type="text/javascript" src="js/project-sponsor.js"></script>
<script>
	$(function() {
		//돌아가기 버튼
		$('#back_btn').on('click',function(){
			history.go(-1);
		});
		//후원하기 버튼
		$('#fund_btn').on('click',function(){
			var data={};
			
			var total = $('#total').val();
			var address_num = $('#spon-address-num').val();
			var address_name= $('#address_name').val();
			var address_phone = $('#inputPhone1').val()+'-'+$('#inputPhone2').val()+'-'+$('#inputPhone3').val();
			var v_add = $('#spon-address').val()+" "+$('#spon-address2').val();
			if(total=='' || total==null || total==0){
				alert("결제할 금액이 없습니다");
				location.go(-1);
			}
			
			if($('#radio1').attr('checked')!='checked' && $('#radio2').attr('checked')!='checked'){
				alert("결제정보가 없습니다");
				location.go(-1);
			}
			//갯수 입력한 리워드 정보
			for(var i=0;i<$('[id^=price]').length;i++){
				if($('#amount'+i).val()!=0 && $('#amount'+i).val()!='' && $('#amount'+i).val()!=null){
					data["r_name"+i]=$('#r_name'+i).html();
					data["r_index"+i]=$('#index'+i).val();
					data["fd_amt"+i]=$('#amount'+i).val();
					data["fd_r_option"+i]=$('#option'+i).val();
					if(address_num=='' || address_name=='' || address_phone=='010--'){
						alert("배송지 정보가 부족합니다");
						location.go(-1);
					}
				}
			} 
			//계좌선택시 계좌 정보
			if($('#radio1').attr('checked')=='checked'){
				if($('#bank_num').val()=='' || $('#bank').val()==''){
					alert("계좌 정보가 없습니다");
					location.go(-1);
				}
				data["b_owner"]=$('#bank_name').val();
				data["b_account"]=$('#bank_num').val();
				data["b_bankname"]=$('#bank').val();
				data["f_payment"]="1";
			}
			//카드선택시 카드정보
			else if($('#radio2').attr('checked')=='checked'){
				if($('#card_num').val()=='' || $('#card_cvc').val()=='' || $('#card_date').val()==''){
					alert("카드 정보가 없습니다");
					location.go(-1);
				}
				data["cd_cardname"]=$('#card').val();
				data["cd_num"]=$('#card_num').val();
				data["cd_cvc"]=$('#card_cvc').val();
				data["cd_valid"]=$('#card_date').val();
				data["f_payment"]="2";
			} 
			//총금액정보
			data["f_price"]=total;
			//배송정보
			data["v_name"]=address_name;
			data["v_phone"]=address_phone;
			data["v_add"]=v_add;
			data["v_postnum"]=address_num;
			data["v_msg"]=$('#v_msg').val();
			
			data["m_id"]=$('#m_id').val();
			data["p_index"]=$('#p_index').val();
			
			console.log("총금액 : "+data["f_price"]);
			$.ajax({
				contentType: 'application/json',
				processData: false,
				url : "JFE_SUPPORT.do",
				type : 'POST',
				data : JSON.stringify(data),
				dataType : 'json',
				success : function(data){
					location.href=data.code;
				},
				error : function(){
					console.log("후원실패");
				}
			});
			
		});
		//총 결제 금액
		 $(document).on('keyup',$("[id^=amount]"),function(){
			var list= new Array();
			var Max_D=0;
			var total =0;
			var price=0;
			var amt=0;
			var sum=0;
			var no_reward = $('#amount').val();
			for(var j=0;j<$("[id^=price]").length;j++){
				price = $('#price'+j).html();
				amt = $('#amount'+j).val();
				total+=price*amt;
			}
			for(var i=0;i<$('[id^=price]').length;i++){
				if($('#amount'+i).val() > Number($('#amt'+i).html())){
					alert("리워드 제한수량을 확인하세요");
					$('#amount'+i).val(0);
					location.go(-1);
				}
				if($('#amount'+i).val()!=0 && $('#amount'+i).val()!='' && $('#amount'+i).val()!=null){
					list.push($('#del_price'+i).html());
				}
				Max_D = Math.max.apply(null,list);
			} 
			 if(total==0 || total=='' || total==null){
				 sum=Number(no_reward);
			 }
			 else{
				sum=total+Number(no_reward)+Number(Max_D);
			 }
			$('#total').val(sum);
		});  
		 
		 //배송받는사람 한글만
		 $(document).find('#address_name').keyup(function(event) {
				var kor = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
				var name = $(this).val();
				if (kor.test(name)) {
					alert("한글만 입력 가능합니다.");
					$(this).val(name.replace(kor, ''));
				}
			});
		 //받는사람 연락처 제한
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
					return false;
				}
			});
			$(document).find("#card_date").keyup(function(event) {
				var cd = $(this).val();
				if ($("#card_date").val().length >= 4) {
					if ($(this).val().length > 4) {
						$(this).val(cd.substr(0, 4));
					}
					return false;
				}
			});
		//라디오 버튼 제한
		$('#ra1').on('click',function(){
			$("#radio1").attr('checked', 'checked');
			$("#radio2").removeAttr('checked');
		});
		$('#ra2').on('click',function(){
			$("#radio2").attr('checked', 'checked');
			$("#radio1").removeAttr('checked');
		});
	});
</script>
</head>
<body class="sponbody">
	<div class="spon-container">
		<div class="spon-project-title"><h1>${project.p_name}</h1></div><br><br>
		<input type="hidden" id="m_id" value="<%=session.getAttribute("m_id")%>">
		<input type="hidden" id="p_index" value="${project.p_index}">
		<div class="JFI-box">
			<h2>리워드</h2><br>
			<div class="spon-project-reward-box">
				<dl class="accordion">
				<c:forEach items="${r_list}" var="r" varStatus="status">
				<input type="hidden" id="index${status.index}" value="${r.r_index}">
					<dt><span id="r_name${status.index}"> ${r.r_name}</span></dt>
						<dd id="dv">
						<div class="spon-project-cards">
							<div class="spon-project-card">
								<div class="spon-project-left">
								<c:if test="${r.r_amt<=-1}">
									<h3>수량<small>(수량 제한 없음)</small></h3>
								</c:if>
								<c:if test="${r.r_amt>-1}">
									<h3>수량<small>(남은수량</small><small><span id="amt${status.index}">${r.r_amt}</span></small><small>개)</small></h3>
								</c:if>
									<span class="spon-project-spantag"><input type="number" class="spon-project-reward-amount" id="amount${status.index}" maxlength="6" name="" value="0"></span>개
								</div>
								<div class="spon-project-right">
								<h3>금액</h3>
									<span class="spon-project-spantag" id="price${status.index}">${r.r_price}</span>원 (배송비 별도)
								</div>
							</div>
							<div class="spon-project-card">
								<div class="spon-project-left">
									<h3>설명</h3>
									<span class="spon-project-spantag">${r.r_contents }</span>
								</div>
								<div class="spon-project-right">
									<h3>배송비</h3>
										<span class="spon-project-spantag" id="del_price${status.index}">${r.r_del}</span>원
								</div>
							</div>
							<div class="spon-project-card">
								<div class="spon-project-left">
									<h3>옵션</h3>
								<c:if test="${r.r_option!=''}">
									<span class="spon-project-spantag"><input type="text" class="spon-project-reward-option" name="" placeholder="ex) 파란색" id="option${status.index}"></span>
								</c:if>
								<c:if test="${r.r_option==''}">
									<span class="spon-project-spantag">없음</span>
								</c:if>
								</div>
								<div class="spon-project-right">
									<h3>발송 예정일</h3>
									<span class="spon-project-spantag"><fmt:formatDate value="${r.r_start}" pattern="yyyy.MM.dd"/>일 경부터 발송예정 </span>
								</div>
							</div>
						</div>
						</dd>
			</c:forEach>
				  	<dt>리워드 없이 후원하기(선택)/추가금액 후원하기</dt>
				  		<dd>
				  			<div class="spon-project-cards">
				  				<div class="spon-project-left">
				  					<span class="spon-project-spantag"><strong>금액 : </strong>
				  					<input type="number" name="" class="spon-project-reward-amount" id="amount"></span>원
				  				</div>
				  			</div>
				  		</dd>
				</dl>
				<br><br>
				<span class="spon-project-spantag"><strong>총 결제하실 금액 : </strong>
				  					<input type="number" name="" class="spon-project-reward-amount" readonly="readonly" id="total" value="0"></span>원<small>&emsp;(배송비 포함금액)</small>
				
			</div><br><br>
			<c:if test="${r_list!='[]' || map.del eq 'no'}">
			<h2>배송지 정보</h2>
				<div class="spon-project-address-left">
					<div class="spon-project-card">
						<div class="spon-project-left"></div>
						<div class="spon-project-right">
							<input type="button" class="spon-new-addressbtn" id="postcodify_search_button" value="주소 검색">
						</div>
					</div>
					<span class="spon-project-spantag">우편번호</span> 
					&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
					<span class="spon-project-spantag">인수자명</span>
					&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
					<span class="spon-project-spantag">받는분 번호</span>
					<br><input type="text" name="" class="postcodify_postcode5" id="spon-address-num" value="" readonly>
					&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
					<input type="text" name="" id="address_name" value="">
					&emsp;&emsp;&emsp;&emsp;
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
					<br><br>
					<span class="spon-project-spantag">주&emsp;&emsp;소</span><br>
					<input type="text" name="" class="postcodify_address" id="spon-address" value="" readonly><br><br>
					<input type="text" name="" class="postcodify_details" id="spon-address2" placeholder="추가 주소를 입력해주세요">
				</div>
			<h2>배송 메세지</h2>
				<div class="spon-project-padding-left">
					<input type="text" name="" class="spon-project-reward-delivery" placeholder="ex)경비실에 맡겨주세요" id="v_msg">
				</div>
			</c:if>
				
			<h2>결제 정보</h2>
				<div class="spon-project-padding-left">
					<div class="spon-project-radios">
						<input type="radio" name="pay-radio" id="radio1" value="1" hidden>
						<label for=radio1 id="ra1"></label>
						<label for=radio1>계좌 이체</label>
						<input type="radio" name="pay-radio" id="radio2" value="2" hidden>
						<label for=radio2 id="ra2"></label>
						<label for=radio2>카드 결제</label>
					</div><br>
					<div class="spon-project-reward-Accpayment" id="a-pay" style="display: none;">
						<select class="spon-select" id="bank">
							<option value="신한은행">신한은행</option>
							<option value="국민은행">국민은행</option>
							<option value="우리은행">우리은행</option>
						</select><br>
						<span class="spon-span">계좌번호
						<input type="text" class="spon-accountnumber" name="" placeholder="ex) 000-000-000000" id="bank_num"></span>&emsp;
						<span for="acname" class="spon-span">예금주명
						<input type="text" class="spon-accountnumber-name" name="" placeholder="ex) 홍길동" id="bank_name"></span>
					</div>
					<div class="spon-project-reward-Cardpayment" id="c-pay" style="display: none;">
						<select class="spon-select" id="card">
							<option value="신한카드">신한카드</option>
							<option value="국민카드">국민카드</option>
							<option value="우리카드">우리카드</option>
						</select><br>
						<span class="spon-span">카드번호
						<input type="text" class="spon-cardnumber" name="" placeholder="ex) 0000-0000-0000-0000" id="card_num"></span>&emsp;
						<span for="acname" class="spon-span">CVC
						<input type="password" class="spon-cardnumber-cvc" name="" placeholder="***" maxlength="3" id="card_cvc"></span>&emsp;
						<span for="acname" class="spon-span">유효기간
						<input type="number" class="spon-cardnumber-val" name="" placeholder="ex) 0319" maxlength="4" id="card_date"></span>
					</div>
				</div>
			</div>
		<div class="spon-btncenter">
			<input type="button" class="prev-story-btn" id="back_btn" value="돌아가기">
			<input type="button" class="next-spon-btn" id="fund_btn" value="후원하기">
		</div>
	</div>
	<jsp:include page="Header.jsp" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<script> $(function() { $("#postcodify_search_button").postcodifyPopUp(); }); </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunDream</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="css/participatedSpon.css">
<script type="text/javascript" src="js/participatedSpon.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script>
	$(function(){
		//돌아가기 버튼
		$('#back_btn').on('click',function(){
			history.go(-1);
		});
		//스토리 버튼
		$('#detail_btn').on('click',function(){
			var p_index = $('#p_index').val();
			var m_id = $('#m_id').val();
			location.href="JPS_DETAIL.do?p_index="+p_index+"&m_id="+m_id;
		});
		$('#del_btn').on('click',function(){
			var f_index= $('#f_index').val();
			var con= confirm("후원을 정말 취소하시겠습니까?");
			if(con==true){
				location.href="MD_MYFUND.do?f_index="+f_index;
			}
		});
	});
</script>
</head>
<body class="parbody">
	<div class="par-container">
		<div class="par-project-title"><h1>${p_name}</h1></div><br>
		<input type="hidden" id="p_index" value="${p_index}">
		<input type="hidden" id="m_id" value="<%=session.getAttribute("m_id")%>">
		<div class="par-btncenter">
		<c:if test="${fund.f_cancel==1 }">
			<input type="button" class="par-sponcancel-btn" id="del_btn" value="후원취소">
		</c:if>
		<c:if test="${fund.f_cancel==2 }">
			<h3>취소하신 내역입니다</h3>
		</c:if>
		</div>
		<br>
		<c:if test="${test!='[]'}">
		<h2>리워드</h2><br>
		</c:if>
		<div class="par-project-reward-box">
			<dl class="accordion">
				<c:forEach items="${test}" var="t">
					<dt>${t[1].r_name}</dt>
						<dd>
							<div class="par-a-row">
								<div class="par-a-1">
									<h3>수량</h3><br>
									<p class="par-p">${t[0].fd_amt}개</p>
									<br>
									<h3>설명</h3><br>
									<p class="par-p">${t[1].r_contents}</p>
									<br>
									<h3>옵션</h3><br>
									<p class="par-p">${t[0].fd_r_option}</p>
								</div>
								<div class="par-a-2">
									<h3>금액(수량이 1일때)</h3><br>
									<p class="par-p">${t[1].r_price}원</p>
									<br>
									<h3>배송비</h3><br>
									<p class="par-p">${t[1].r_del}원</p>
									<br>
									<h3>발송예정일</h3><br>
									<p class="par-p">${t[1].r_start}경부터 배송시작</p>
								</div>
							</div>
						</dd>
				</c:forEach>
			</dl>
		</div><br><br>
		<input type="hidden" id="f_index" value="${fund.f_index}">
		<h2>총 결제하신 금액(배송료 포함)</h2><br>
		<div class="par-left-tab">
			<p><strong>${fund.f_price}원</strong></p>
		</div>
		<br><br>
		<c:if test="${delivery!=null}">
		<div class="par-a-row">
			<div class="par-a-1">
				<h2>배송지 정보</h2><br>
				<div class="par-left-tab">
					<p><strong>우편번호 : </strong>${delivery.v_postnum} </p>
					<br>
					<p><strong>주소 : </strong>${delivery.v_add} </p>
					<br>
					<p><strong>인수자명 : </strong>${delivery.v_name} </p>
					<br>
					<p><strong>받는분 번호 : </strong>${delivery.v_phone} </p>
				</div>
			</div>
		</c:if>
			<div class="par-a-2">
				<h2>결제 정보</h2><br>
				<div class="par-left-tab">
				<c:if test="${fund.f_payment==1 }">
					<div>
						<h3>계좌이체</h3><br>
						<p><strong>은행명 :</strong> ${bank.b_bankname}</p><br>
						<p><strong>계좌번호 :</strong> ${bank.b_account}</p><br>
						<p><strong>예금주명 :</strong> ${bank.b_owner}</p>
					</div>
				</c:if>
				<c:if test="${fund.f_payment==2 }">
					<div>
					<h3>카드결제</h3><br>
						<p><strong>카드회사 :</strong> ${card.cd_cardname}</p><br>
						<p><strong>카드번호 :</strong> ${card.cd_num}</p>
					</div>
				</c:if>
				</div>
			</div>
		</div><br><br>
		<div class="par-btncenter">
			<input type="button" class="par-story-btn" id="detail_btn" value="스토리로 돌아가기">
			<input type="button" class="par-list-btn" id="back_btn" value="목록으로 돌아가기">
		</div>
	</div>
	<jsp:include page="Header.jsp" />
</body>
</html>
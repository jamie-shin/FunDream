<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/IJS_PROJECTFORM.css">
<script type="text/javascript">
	$(function(){
		$(document).on('click', '#approveBtn', function(){
			var approve_btn = $(this);
			var approve_val = approve_btn.val();
			$.ajax({
				url : "IJU_APPROVE.do",
				data : {p_index : approve_val},
				success : function(data){
					switch(data){
					case "success":
						alert("승인 처리 되었습니다.");
						location.reload();
						break;
					case "fail":
						console.log("승인 처리 실패!");
						break;
					}
				},
				error : function(){
					console.log("승인 처리 오류!");
				}
			});
		});
		
		$(document).on('click', '#rejectBtn', function(){
			var reject_btn = $(this);
			var reject_val = reject_btn.val();
			$.ajax({
				url : "IJU_REJECT.do",
				data : {p_index : reject_val},
				success : function(data){
					switch(data){
					case "success":
						alert("반려 처리 되었습니다.");
						location.reload();
						break;
					case "fail":
						console.log("반려 처리 실패!");
						break;
					}
				},
				error : function(){
					console.log("반려 처리 오류 발생!");
				}
			});
		});
		
		$(document).on('click', '#cancelApproveBtn', function(){
			var cancel_approve_btn = $(this);
			var cancel_approve_val = cancel_approve_btn.val();
			$.ajax({
				url : "IJU_CANCEL.do",
				data : {p_index : cancel_approve_val},
				success : function(data){
					switch(data){
					case "success":
						alert("승인 취소 되었습니다.");
						location.reload();
						break;
					case "fail":
						console.log("승인 취소 실패!");
						break;
					}
				},
				error : function(){
					console.log("승인 취소 오류 발생!");
				}
			});
		});
		
		$(document).on('click', '#cancelRejectBtn', function(){
			var cancel_reject_btn = $(this);
			var cancel_reject_val = cancel_reject_btn.val();
			$.ajax({
				url : "IJU_CANCEL.do",
				data : {p_index : cancel_reject_val},
				success : function(data){
					switch(data){
					case "success":
						alert("반려 취소 되었습니다.");
						location.reload();
						break;
					case "fail":
						console.log("반려 취소 실패!");
						break;
					}
				},
				error : function(){
					console.log("반려 취소 오류 발생!");
				}
			});
		});
		
		$(document).on('click', '#member', function(){
			var m_id = $(this).text();
			location.href = "IMS_DETAILFORM.do?m_id_str=" + m_id;
		});
		
		$(document).on('click', '#project', function(){
			var p_index = $(this).text();
			location.href = "JPS_DETAIL.do?p_index_str=" + p_index;
		});
		
		$(document).on('click', '#projectName', function(){
			var p_index = $(this).parent().siblings('[class=cell]').children('#project').text();
			console.log("p_index : " + p_index);
			location.href = "JPS_DETAIL.do?p_index_str=" + p_index;
		});
		
		$(document).on('click', '#calculateBtn', function(){
			var p_index = $(this).val();
			console.log(p_index);
			location.href = "IJE_FORM.do?p_index_str="+p_index;
		});
	});
</script>
<title>FunDream</title>
</head>
<body>
	<div class="IJS-PF-container">
		<div class="IJS-PF-title">
			<h1>프로젝트</h1>
		</div><br>
		<!-- 승인대기중 -->
		<div class="IJS-PF-subtitle">
			<h2>승인 대기중인 프로젝트</h2>
		</div>
		<div class="wrapper">
			<div class="table">
				<div class="row header">
					<div class="cell">프로젝트 번호</div>
		      		<div class="cell">프로젝트 명</div>
		      		<div class="cell">제작자</div>
		      		<div class="cell">승인신청일</div>
		      		<div class="cell">승인여부</div>
				</div>
				<c:if test="${waitList != ''}">
					<c:forEach items="${waitList}" var="wait">
					    <div class="row">
					    	<div class="cell" data-title="프로젝트 번호" id="sel_index"><a href="#" id="project">${wait.p_index}</a></div>
					    	<div class="cell" data-title="프로젝트 명"><a href="#" id="projectName">${wait.p_name}</a></div>
					      	<div class="cell" data-title="제작자"><a href="#" id="member">${wait.m_id}</a></div>					      	
					      	<div class="cell" data-title="승인신청일">${wait.p_createdate}</div>
					      	<div class="cell" data-title="승인여부">
					    		<button value="${wait.p_index}" id="approveBtn" class="IJS-okbtn">승인</button>
					    		<button value="${wait.p_index}" id="rejectBtn" class="IJS-nobtn">반려</button>
					      	</div>
					    </div>
					</c:forEach>
				</c:if>
		    </div>
		</div>
			
		<!-- 승인완료 -->
		<div class="IJS-PF-subtitle"><h2>승인 완료한 프로젝트</h2></div><br>
		<div class="IJS-PF-subtitle"><strong>프로젝트 시작 전</strong></div>
		<div class="wrapper">
			<div class="table">
				<div class="row header">
					<div class="cell">프로젝트 번호</div>
		      		<div class="cell">프로젝트 명</div>
		      		<div class="cell">제작자</div>
		      		<div class="cell">프로젝트 시작일</div>
		      		<div class="cell">승인여부</div>
				</div>
				<c:if test="${approveListBefore != ''}">
					<c:forEach items="${approveListBefore}" var="before">
					    <div class="row">
					    	<div class="cell" data-title="프로젝트 번호"><a href="#" id="project">${before.p_index}</a></div>
					    	<div class="cell" data-title="프로젝트 명"><a href="#" id="projectName">${before.p_name}</a></div>
					      	<div class="cell" data-title="제작자">	<a href="#" id="member">${before.m_id}</a></div>
					      	<div class="cell" data-title="프로젝트 시작일">${before.p_startdate}</div>
					      	<div class="cell" data-title="승인여부">
					      		<button value="${before.p_index}" id="cancelApproveBtn" class="IJS-okbtn">승인 취소</button>
					      	</div>
					    </div>
					</c:forEach>
				</c:if>
		    </div>
		</div>
		
		<div class="IJS-PF-subtitle"><strong>프로젝트 진행 중</strong></div>
		<div class="wrapper">
			<div class="table">
				<div class="row header">
					<div class="cell">프로젝트 번호</div>
		      		<div class="cell">프로젝트 명</div>
		      		<div class="cell">제작자</div>
		      		<div class="cell">프로젝트 종료일</div>
		      		<div class="cell">승인여부</div>
				</div>
				<c:if test="${approveListProgress != ''}">
					<c:forEach items="${approveListProgress}" var="progress">
					    <div class="row">
					    	<div class="cell" data-title="프로젝트 번호"><a href="#" id="project">${progress.p_index}</a></div>
					    	<div class="cell" data-title="프로젝트 명"><a href="#" id="projectName">${progress.p_name}</a></div>
					      	<div class="cell" data-title="제작자"><a href="#" id="member">${progress.m_id}</a></div>
					      	<div class="cell" data-title="프로젝트 종료일">${progress.p_enddate}</div>
					      	<div class="cell" data-title="승인여부">
					      		<c:if test="${progress.p_approval == 1}">대기</c:if>
					      		<c:if test="${progress.p_approval == 2}">승인 완료</c:if>
					      		<c:if test="${progress.p_approval == 3}">반려</c:if>
					      	</div>
					    </div>
					</c:forEach>
				</c:if>
		    </div>
		</div>
		
		<div class="IJS-PF-subtitle"><h2>승인 반려한 프로젝트</h2></div>
		<div class="wrapper">
			<div class="table">
				<div class="row header">
					<div class="cell">프로젝트 번호</div>
		      		<div class="cell">프로젝트 명</div>
		      		<div class="cell">제작자</div>
		      		<div class="cell">승인신청일</div>
		      		<div class="cell">승인여부</div>
				</div>
				<c:if test="${rejectList != ''}">
					<c:forEach items="${rejectList}" var="reject">
					    <div class="row">
					    	<div class="cell" data-title="프로젝트 번호"><a href="#" id="project">${reject.p_index}</a></div>
					    	<div class="cell" data-title="프로젝트 명"><a href="#" id="projectName">${reject.p_name}</a></div>
					      	<div class="cell" data-title="제작자">	<a href="#" id="member">${reject.m_id}</a></div>
					      	<div class="cell" data-title="승인신청일">${reject.p_createdate}</div>
					      	<div class="cell" data-title="승인여부">
					      		<button value="${reject.p_index}" id="cancelRejectBtn" class="IJS-okbtn">반려 취소</button>
					      	</div>
					    </div>
					</c:forEach>
				</c:if>
		    </div>
		</div>
		
		<div class="IJS-PF-subtitle"><h2>종료된 프로젝트</h2></div><br>
		<div class="IJS-PF-subtitle"><strong>정산 대기 중</strong></div>
		<div class="wrapper">
			<div class="table">
				<div class="row header">
					<div class="cell">프로젝트 번호</div>
		      		<div class="cell">프로젝트 명</div>
		      		<div class="cell">제작자</div>
		      		<div class="cell">프로젝트 종료일</div>
		      		<div class="cell">정산여부</div>
				</div>
				<c:if test="${calculateBeforeList != ''}">
					<c:forEach items="${calculateBeforeList}" var="calculate">
					    <div class="row">
					    	<div class="cell" data-title="프로젝트 번호"><a href="#" id="project">${calculate.p_index}</a></div>
					    	<div class="cell" data-title="프로젝트 명"><a href="#" id="projectName">${calculate.p_name}</a></div>
					      	<div class="cell" data-title="제작자"><a href="#" id="member">${calculate.m_id}</a></div>
					      	<div class="cell" data-title="프로젝트 종료일">${calculate.p_enddate}</div>
					      	<div class="cell" data-title="정산여부">
								<c:if test="${calculate.p_approval == 5}">대기 중 <button id="calculateBtn" value="${calculate.p_index}" class="IJS-okbtn">정산</button></c:if>
								<c:if test="${calculate.p_calculate == -1}">모금 실패</c:if>
								<c:if test="${calculate.p_approval == 6}">정산 완료</c:if>
					      	</div>
					    </div>
					</c:forEach>
				</c:if>
		    </div>
		</div>
		
		<div class="IJS-PF-subtitle"><strong>정산 완료</strong></div>
		<div class="wrapper">
			<div class="table">
				<div class="row header">
					<div class="cell">프로젝트 번호</div>
		      		<div class="cell">프로젝트 명</div>
		      		<div class="cell">제작자</div>
		      		<div class="cell">프로젝트 종료일</div>
		      		<div class="cell">정산여부</div>
				</div>
				<c:if test="${completeList != ''}">
					<c:forEach items="${completeList}" var="complete">
					    <div class="row">
					    	<div class="cell" data-title="프로젝트 번호"><a href="#" id="project">${complete.p_index}</a></div>
					    	<div class="cell" data-title="프로젝트 명"><a href="#" id="projectName">${complete.p_name}</a></div>
					      	<div class="cell" data-title="제작자">	<a href="#" id="member">${complete.m_id}</a></div>
					      	<div class="cell" data-title="프로젝트 종료일">${complete.p_enddate}</div>
					      	<div class="cell" data-title="정산여부">
								<c:if test="${complete.p_approval == 5}">대기 중 <button id="calculateBtn" value="${complete.p_index}" class="IJS-okbtn">정산</button></c:if>
								<c:if test="${complete.p_calculate == -1}">모금 실패</c:if>
								<c:if test="${complete.p_approval == 6}">정산 완료</c:if>
					      	</div>
					    </div>
					</c:forEach>
				</c:if>
		    </div>
		</div>
		<div class="IJS-PF-subtitle"><strong>모금 실패</strong></div>
		<div class="wrapper">
			<div class="table">
				<div class="row header">
					<div class="cell">프로젝트 번호</div>
		      		<div class="cell">프로젝트 명</div>
		      		<div class="cell">제작자</div>
		      		<div class="cell">프로젝트 종료일</div>
		      		<div class="cell">정산여부</div>
				</div>
				<c:if test="${failList != ''}">
					<c:forEach items="${failList}" var="fail">
					    <div class="row">
					    	<div class="cell" data-title="프로젝트 번호"><a href="#" id="project">${fail.p_index}</a></div>
					    	<div class="cell" data-title="프로젝트 명"><a href="#" id="projectName">${fail.p_name}</a></div>
					      	<div class="cell" data-title="제작자"><a href="#" id="member">${fail.m_id}</a></div>
					      	<div class="cell" data-title="프로젝트 종료일">${fail.p_enddate}</div>
					      	<div class="cell" data-title="정산여부">모금 실패</div>
					    </div>
					</c:forEach>
				</c:if>
		    </div>
		</div>
	</div>
	<jsp:include page="Header.jsp" />
</body>
</html>
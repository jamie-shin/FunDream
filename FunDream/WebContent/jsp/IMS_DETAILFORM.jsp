<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/IMS_DETAILFORM.css">
<title>FunDream</title>
<script type="text/javascript">
	$(function(){
		$('#manager_changeBtn').on('click', function(){
			var m_manager = $(this);
			var m_manager_val = m_manager.val();
			var manager = $('#manager');
			var m_id = $('#m_id').text();
			var new_mgr = 0;
			switch(m_manager_val){
			case "1":
				new_mgr = 2;
				break;
			case "2":
				new_mgr = 1;
				break;
			}
			$.ajax({
				url : "IMU_GRANT.do",
				data : {m_id : m_id,
						m_manager : new_mgr},
				success : function(data){
					alert("관리자 변경 성공 : " + data);
					switch(data){
					case 1:
						manager.text('관리자');
						m_manager.val(1).text("관리자 권한 취소");
						break;
					case 2:
						manager.text('일반회원');
						m_manager.val(2).text("관리자 권한 부여");
						break;
					case 0:
						alert("관리자 유형 변경 실패");
						break;
					}
				},
				error : function(){
					alert("관리자 유형 변경 에러");
				}
			});
		});
		
		$("#valid_changeBtn").on('click', function(){
			var m_valid = $(this);
			var m_valid_val = m_valid.val();
			var valid = $('#valid');
			var m_id = $('#m_id').text();
			var new_val = 0;
			switch(m_valid_val){
			case "1":
				new_val = 3;
				break;
			case "2":
				new_val = 1;
				break;
			case "3":
				new_val = 1;
				break;
			}
			alert(new_val);
			$.ajax({
				url : "IMU_SLEEP.do",
				data : {m_id : m_id,
						m_valid : new_val},
				success : function(data){
					alert("회원 유형 변경 성공 : " + data);
					switch(data){
					case 1:
						valid.text('활동 중');
						m_valid.val(1).text("이용 정지 처리");
						break;
					case 2:
						valid.text('탈퇴');
						m_valid.val(2).text("탈퇴 취소");
						break;
					case 3:
						valid.text('이용 정지');
						m_valid.val(3).text("이용 정지 취소");
						break;
					case 0:
						alert("회원 유형 변경 실패!");
						break;
					}
				},
				error : function(){
					alert("관리자 유형 변경 에러");
				}
			});
		});

		$(document).on('click', '#sel_project', function(){
			var p_index = $(this).siblings("#sel_p_index").val();
			location.href = "JPS_DETAIL.do?p_index_str=" + p_index;
		});
		
		$(document).on('click', '#report_ok', function(){
			var c_index = $(this).val();
			$.ajax({
				url : "IMU_REPORTCOMM.do",
				data : {c_index : c_index,
						c_status : 3},
				success : function(data){
					switch(data){
					case "success" :
						alert("댓글 신고 처리가 완료되었습니다.");
						location.reload();
						break;
					case "fail" :
						alert("댓글 신고 처리 실패!");
						break;
					}
				},
				error : function(){
					alert("댓글 신고 처리 오류 발생!!!");
				}
			});
		});
		
		$(document).on('click', '#report_cancel', function(){
			var c_index = $(this).val();
			$.ajax({
				url : "IMU_REPORTCOMM.do",
				data : {c_index : c_index,
						c_status : 4},
				success : function(data){
					switch(data){
					case "success" :
						alert("댓글 신고 처리가 완료되었습니다.");
						location.reload();
						break;
					case "fail" :
						alert("댓글 신고 처리 실패!");
						break;
					}
				},
				error : function(){
					alert("댓글 신고 처리 오류 발생!!!");
				}
			});
		});
		
		$(document).on('click', '#report_re', function(){
			var c_index = $(this).val();
			$.ajax({
				url : "IMU_REPORTCOMM.do",
				data : {c_index : c_index,
						c_status : 2},
				success : function(data){
					switch(data){
					case "success" :
						alert("댓글 신고 처리가 취소되었습니다.");
						location.reload();
						break;
					case "fail" :
						alert("댓글 신고 처리 취소 실패!");
						break;
					}
				},
				error : function(){
					alert("댓글 신고 처리 취소 오류 발생!!!");
				}
			});
		});
	});
</script>
</head>
<body>
	<div class="IMS-DETAIL-container">
		<div class="IMS-DETAIL-title">
			<h1>회원상세</h1>
		</div>
		<br>
		<div class="IMS-DETAIL-status">
			<div class="IMS-status-table">
				<div class="IMS-status-row">
					<div class="IMS-status-cell">
						<p class="IMS-p">회원 아이디</p>
					</div>
					<div class="IMS-status-cell" id="m_id">
						${member.m_id}
					</div>
				</div>
				
				<div class="IMS-status-row">
					<div class="IMS-status-cell">
						<p class="IMS-p">회원 타입</p>
					</div>
					<div class="IMS-status-cell" id="manager">
						<c:if test="${member.m_manager == 1}">관리자</c:if>
						<c:if test="${member.m_manager == 2}">일반회원</c:if>
					</div>
					<div class="IMS-status-cell">
						<c:if test="${member.m_manager == 1}"><button id="manager_changeBtn" value="1" class="IMS-adminbtn">관리자 권한 취소</button></c:if>
						<c:if test="${member.m_manager == 2}"><button id="manager_changeBtn" value="2" class="IMS-adminbtn">관리자 권한 부여</button></c:if>
					</div>
				</div>
				
				<div class="IMS-status-row">
					<div class="IMS-status-cell">
						<p class="IMS-p">회원 상태</p>
					</div>
					<div class="IMS-status-cell" id="valid">
						<c:if test="${member.m_valid == 1}">활동중</c:if>
						<c:if test="${member.m_valid == 2}">탈퇴</c:if>
						<c:if test="${member.m_valid == 3}">이용정지</c:if>
					</div>
					<div class="IMS-status-cell">
						<c:if test="${member.m_valid == 1}"><button type="button" id="valid_changeBtn" value="1" class="IMS-stopbtn">이용 정지 처리</button></c:if>
						<c:if test="${member.m_valid == 2}"><button type="button" id="valid_changeBtn" value="2" class="IMS-stopbtn">탈퇴 취소</button></c:if>
						<c:if test="${member.m_valid == 3}"><button type="button" id="valid_changeBtn" value="3" class="IMS-stopbtn">이용 정지 취소</button></c:if>
					</div>
				</div>
				
				<div class="IMS-status-row">
					<div class="IMS-status-cell">
						<p class="IMS-p">이름(닉네임)</p>
					</div>
					<div class="IMS-status-cell">
						${member.m_name} (
						<c:if test="${member.m_nick == ''}">닉네임 없음</c:if>
						<c:if test="${member.m_nick != ''}">${member.m_nick}</c:if>
						)
					</div>
				</div>
				
				<div class="IMS-status-row">
					<div class="IMS-status-cell">
						<p class="IMS-p">이메일</p>
					</div>
					<div class="IMS-status-cell">
						${member.m_email}
					</div>
				</div>
			</div>
		</div>
		
		<div class="IMS-DETAIL-subtitle">
			<h2>후원내역</h2>
		</div>
		<div class="wrapper">
			<div class="table">
				<div class="row header">
					<div class="cell">프로젝트 명</div>
		      		<div class="cell">후원금</div>
				</div>
				
			    <div class="row">
			    	<div class="cell" data-title="프로젝트 명">
			    		프로젝트1
			      	</div>
			    	<div class="cell" data-title="후원금">
			    		10000
			      	</div>
			    </div>
			    
				<div class="row">
			    	<div class="cell" data-title="프로젝트 명">
			    		<p class="text-p">프로젝트2</p>
			      	</div>
			    	<div class="cell" data-title="후원금">
			    		30000
			      	</div>
			    </div>
			    
			    <div class="row">
			    	<div class="cell" data-title="프로젝트 명">
			    		<p class="text-p">프로젝트3</p>
			      	</div>
			    	<div class="cell" data-title="후원금">
			    		20000
			      	</div>
			    </div>
			    
			    <div class="row">
			    	<div class="cell" data-title="프로젝트 명">
			    		<p class="text-p">프로젝트4</p>
			      	</div>
			    	<div class="cell" data-title="후원금">
			    		50000
			      	</div>
			    </div>
		    </div>
		</div>
		
		<div class="IMS-DETAIL-subtitle">
			<h2>신고내역</h2>
		</div>
		<div class="wrapper">
			<div class="table">
				<div class="row header">
					<div class="cell">프로젝트 명</div>
					<div class="cell">댓글 내용</div>
					<div class="cell">신고 내용</div>
		      		<div class="cell">신고 처리</div>
				</div>
				
				<c:if test="${commentList != null}">
				<c:forEach items="${commentList}" var="comment">
				    <div class="row">
				    	<div class="cell" data-title="프로젝트 명">
				    		<c:forEach items="${allProjectList}" var="project">
					    		<c:if test="${project.p_index == comment.p_index}">
					    			<p class="text-p">${project.p_name}</p>
					    		</c:if>
				    		</c:forEach>
				      	</div>
				      	<div class="cell" data-title="댓글 내용">${comment.c_contents}</div>
				      	<div class="cell" data-title="신고 내용">${comment.c_report}</div>
				    	<div class="cell" data-title="신고 처리">
				    		<c:if test="${comment.c_status == 2}">
				    			<button id="report_ok" value="${comment.c_index}">처리</button>
				    			<button id="report_cancel" value="${comment.c_index}">반려</button>
				    		</c:if>
				    		<c:if test="${comment.c_status == 3}">처리 완료   <button id="report_re" value="${comment.c_index}">취소</button></c:if>
				    		<c:if test="${comment.c_status == 4}">신고 반려   <button id="report_re" value="${comment.c_index}">취소</button></c:if>
				      	</div>
				    </div>
				</c:forEach>
				</c:if>
		    </div>
		</div>
		
		<div class="IMS-DETAIL-subtitle">
			<h2>프로젝트 생성 내역</h2>
		</div>
		<div class="wrapper">
			<div class="table">
			
				<div class="row header">
					<div class="cell">프로젝트 번호</div>
					<div class="cell">프로젝트 명</div>
					<div class="cell">승인여부</div>
		      		<div class="cell">목표액</div>
		      		<div class="cell">모금액</div>
		      		<div class="cell">성공여부</div>
				</div>
			    
			    <c:if test="${projectList != ''}">
			    <c:forEach items="${projectList}" var="project">
					<div class="row">
				    	<div class="cell" data-title="프로젝트 번호">
				    		${project.p_index}
				    	</div>
				    	<div class="cell" data-title="프로젝트 명">
				    		<input type="hidden" id="sel_p_index" value="${project.p_index}">
				    		<p class="text-p" id="sel_project">${project.p_name}</p>
				      	</div>
				    	<div class="cell" data-title="승인여부">
				    	<p class="text-p">
				    		<c:if test="${project.p_approval == 1}">대기</c:if>
				    		<c:if test="${project.p_approval == 2}">완료</c:if>
				    		<c:if test="${project.p_approval == 3}">반려</c:if>
				    		<c:if test="${project.p_approval == 4}">요청 전</c:if>
				    	</p>
				      	</div>
				    	<div class="cell" data-title="목표액">
				    		<p class="text-p">${project.p_target} 만원</p>
				      	</div>
				    	<div class="cell" data-title="모금액">
				    		<p class="text-p">${project.p_status} 만원</p>
				   	   	</div>
				      	<div class="cell" data-title="성공여부">
				      	<p class="text-p">
				    		<c:if test="${project.p_calculate == 0}">펀드 진행 중</c:if>
				    		<c:if test="${project.p_calculate > 0}">정산 완료</c:if>
				    		<c:if test="${project.p_calculate < 0}">모금 실패</c:if>
				    	</p>
				    	</div>
				    </div>
			    </c:forEach>
			    </c:if>
		    </div>
		</div>
		<div class="IMS-btncenter">
			<input type="button" value="돌아가기" class="IMS-prev-btn" onclick="window.history.back();">
		</div>
	</div>
	<jsp:include page="Header.jsp" />
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심 프로젝트</title>
<link rel="stylesheet" href="css/CreatedProject.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){
	$('.like-btn').on('click', function() {
		var m_id =  $(this).siblings('[name=m_id]').val();
		var p_index = $(this).siblings("[name=p_index]").val();
		var p_name = $(this).siblings("[name=p_name]").val();
		var likeBtn = $(this);
		$.ajax({
			url : "MLD_UNLIKE.do",
			type : "POST",
			data : {m_id : m_id,
					p_index : p_index},
			success : function(data){
				switch(data){
				case "insert":
					alert(p_name + "이(가) 관심 프로젝트 등록되었습니다.");
					likeBtn.toggleClass('is-active');
					break;
				case "delete":
					alert(p_name + "이(가) 관심 프로젝트 해제되었습니다.");
					likeBtn.toggleClass('is-active');
					break;
				default :
					console.log("관심 프로젝트 등록/삭제 실패");
					break;
				}
			},
			error : function(){
				console.log("관심 프로젝트 등록/삭제 오류");
			}
		});
	});
});
</script>
</head>
<body>
	<!-- 오늘 날짜 구하기 -->
	<jsp:useBean id="now" class="java.util.Date"/>
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
	<!-- 오늘 날짜 구하기  끝 -->
	
	<div class="cre-container">
	<img src="${loginMember.m_img}" class="user-img">
		<div class="cre-center">
			<label>
				<br><br><br><br><br><br><h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${loginMember.m_name} (${loginMember.m_nick})</h3>
			</label>
		</div>
		<span class="left-subtitle">
			<h4>나의 관심 프로젝트</h4>
		</span>
		<c:if test="${msg != 'noFavorite'}">
			<div class="cards">
				<c:forEach items="${myFavoriteList}" var="project">
					<a class="card" href="#">
						<input type="hidden" id="p_index" name="p_index" value="${project.p_index}">
						<input type="hidden" id="p_approval" name="p_approval" value="${project.p_approval}">
						<span class="card-header" style="background-image: url(${project.p_mainimg});">
							<span class="card-title">
								<h3>[${project.p_index}] ${project.p_name}</h3>
								<!-- <div class="right-al">
									<small>마감</small>
								</div> -->
							</span>
						</span>
						<span class="card-summary">
							프로젝트 - 
							<c:if test="${project.p_approval == 4}">작성 중</c:if>
							<c:if test="${project.p_approval == 1}">승인 대기 중</c:if>
							<fmt:formatDate value="${project.p_startdate}" pattern="yyyy-MM-dd" var="start"/>
							<fmt:formatDate value="${project.p_enddate}" pattern="yyyy-MM-dd" var="end"/>
							<c:if test="${project.p_approval == 2 && start < today}">승인 완료</c:if>
							<c:if test="${project.p_approval == 2 && start >= today && end < today}">진행 중</c:if>
							<c:if test="${project.p_approval == 2 && end >= today}">마감</c:if>
							<c:if test="${project.p_approval == 3}">반려</c:if>
							<br><br>
							<fmt:formatDate pattern="yyyy-MM-dd" value="${project.p_startdate}"/> ~ <fmt:formatDate pattern="yyyy-MM-dd" value="${project.p_enddate}"/>
						</span>
						<!-- 무산과 성공 백그라운드 컬러와 글씨 색상 지정은 여기서  -->
						<c:if test="${(project.p_enddate > today) && (project.p_target <= project.p_status)}">
							<h3 class="card-toggle" style="background:navy; color:white;">성공</h3>
						</c:if>
						<!-- <input type="button" value="정산" class="card-calcul"> -->
						<!-- 프로그레스 바 -->
						<div class="candidatos color">
			    			<div class="parcial">
			        			<div class="info">
			            			<div class="percentagem-num">
			            			<c:if test="${project.p_status != 0}"><fmt:formatNumber pattern="###,###.##" value="${project.p_status / project.p_target * 100}" /></c:if>  
			            			<c:if test="${project.p_status == 0}">0</c:if>
			            			 %</div>
			       				</div>
			        			<div class="progressBar">
			            			<div class="percentagem" style="width: 100%;"></div>
			        			</div>
			    			</div>
						</div>
						<!-- 프로그레스 바 -->
					</a>
					<div class="LIKE-buttons">
						<input type="hidden" value="${project.p_name}" name="p_name">
						<input type="hidden" value="${project.p_index}" name="p_index">
						<input type="hidden" value="${m_id}" name="m_id">
				        <span class="like-btn"></span>
				    </div>
				</c:forEach>
			</div>
		</c:if>
		<c:if test="${msg == 'noFavorite'}">
		<br><br>
			<h2 align="center">등록한 관심 프로젝트가 없습니다.</h2>
		</c:if>
	</div>
	<jsp:include page="Header.jsp"></jsp:include>
</body>
</html>
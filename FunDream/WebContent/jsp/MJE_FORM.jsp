<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 만든 프로젝트</title>
<link rel="stylesheet" href="css/CreatedProject.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(document).find('[class=card]').on('click', function(){
			var p_approval = $(this).children('[name=p_approval]').val();
			var p_index = $(this).children("[name=p_index]").val();
			console.log("p_index: " + p_index + " / p_approval: " + p_approval);
			switch(p_approval){
			case "4":
				alert("프로젝트 수정화면으로 이동합니다.");
				location.href = "JJI_FORM.do?p_index="+p_index;
				break;
			default: 
				alert("프로젝트 상세보기 화면으로 이동합니다.");
				location.href = "JPS_DETAIL.do?p_index="+p_index;
				break;
			}
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
	<img src="${producer.m_img}" class="user-img">
		<div class="cre-center">
			<label>
				<br><br><br><br><br><br><h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${producer.m_name} (${producer.m_nick})</h3>
			</label>
		</div>
		<span class="left-subtitle">
			<h4>내가 만든 프로젝트</h4>
		</span>
		<div class="cards">
			<c:forEach items="${myProjectList}" var="project">
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
		        			<div class="partidas">정산승인대기중</div>
		    			</div>
					</div>
					<!-- 프로그레스 바 -->
				</a>
			</c:forEach>
		</div>
	</div>
	<jsp:include page="Header.jsp"></jsp:include>
</body>
</html>
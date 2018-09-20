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
		$(document).find('[class=card-title]').on('click', function(){
			var p_approval = $(this).parent().siblings('[name=p_approval]').val();
			var p_index = $(this).parent().siblings("[name=p_index]").val();
			console.log("p_index: " + p_index + " / p_approval: " + p_approval);
			switch(p_approval){
			case "3":
				//alert("프로젝트 수정화면으로 이동합니다.");
				location.href = "JJI_FORM.do?p_index="+p_index;
				break;
			case "4":
				//alert("프로젝트 수정화면으로 이동합니다.");
				location.href = "JJI_FORM.do?p_index="+p_index;
				break;
			default: 
				//alert("프로젝트 상세보기 화면으로 이동합니다.");
				location.href = "JPS_DETAIL.do?p_index="+p_index;
				break;
			}
		});
		
		$(document).on('click', '#request', function(){
			var p_index=$(this).siblings('#value').val();
			var reconfirm = confirm("정산 신청 하시겠습니까?");
			if (reconfirm==true){
				location.href="MAE_FORM.do?p_index="+p_index;
			}
		})
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
					<span class="card-header" style="background-image: url('${project.p_mainimg}');">
						<span class="card-title">
							<h3 class="project-title">[${project.p_index}] ${project.p_name}</h3>
								<c:choose>
									<c:when test="${project.p_approval ==4 || project.p_approval ==3 }"><h3>프로젝트 수정하기</h3></c:when>
									<c:otherwise><h3>프로젝트 상세보기</h3></c:otherwise>
								</c:choose>
							<!-- <div class="right-al">
								<small>마감</small>
							</div> -->
						</span>
					</span>
					<span class="card-summary"> 
						<c:if test="${project.p_approval == 4}">작성 중</c:if>
						<c:if test="${project.p_approval == 1}">승인 대기 중</c:if>
						<fmt:formatDate value="${project.p_startdate}" pattern="yyyy-MM-dd" var="start"/>
						<fmt:formatDate value="${project.p_enddate}" pattern="yyyy-MM-dd" var="end"/>
						<c:if test="${project.p_approval == 2 && start > today && end >=today}">승인 완료</c:if>
						<c:if test="${project.p_approval == 2 && start <= today && end > today}">진행 중</c:if>
						<c:if test="${project.p_approval == 2 && end < today}">마감
							<c:if test="${(end < today) && (project.p_target <= project.p_status) && (project.p_approval == 2)}"><input type="hidden" id="value" value="${project.p_index}"><input type="button" id="request" value="정산요청"></c:if>
						</c:if>
						<c:if test="${project.p_approval == 5}">정산 승인 대기 중</c:if>
						<c:if test="${project.p_approval == 6}">정산 완료 </c:if>
						<c:if test="${project.p_approval == 3}">반려</c:if>
						<br><br>
						${start} ~ ${end}
					</span>
					<!-- 무산과 성공 백그라운드 컬러와 글씨 색상 지정은 여기서  -->
					<c:if test="${(end < today) && (project.p_target <= project.p_status) && (project.p_approval == 2 || project.p_approval==5 || project.p_approval ==6)}">
						<h3 class="card-toggle" style="background:white; color:red;">성공</h3>
						
					</c:if>
					<c:if test="${(end < today) && (project.p_target > project.p_status) && (project.p_approval == 2)}">
						<h3 class="card-toggle" style="background:navy; color:white;">무산</h3>
					</c:if>
					<!-- 프로그레스 바 -->
					<div class="candidatos color">
		    			<div class="parcial">
		        			<div class="info">
		            			<div class="percentagem-num">${project.per }%</div>
		       				</div>
		        			<div class="progressBar">
		        				<c:choose>
		        					<c:when test="${project.per<=100 }">
		            					<div class="percentagem" style="width: ${project.per}%;"></div>
		            				</c:when>
		            				<c:when test="${project.per>100 }">
		            					<div class="percentagem" style="width: 100%;"></div>
		            				</c:when>
		            				
		            			</c:choose>
		        			</div>
		        			
		        				<div class="partidas">${project.p_status }</div>
		        				
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
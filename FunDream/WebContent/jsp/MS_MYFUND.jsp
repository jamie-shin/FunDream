<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 후원한 내역</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link rel="stylesheet" href="css/ParticipatingProject.css">
</head>
<body>
	<div class="part-container">
	<img src="${m.m_img}" class="user-img">
		<div class="part-center">
			<label>
				<br><br><br><br><br><br><h3>&nbsp;&emsp;&nbsp;&nbsp;&nbsp;${m.m_nick}/${m.m_name}</h3>
			</label>
		</div>
		<span class="left-subtitle">
			<h4 class="msm_left-h4">내가 후원한 내역</h4>
		</span>
		<div class="cards">
			
		<c:forEach items="${test}" var="t" varStatus="status">
			<a class="card" href="MS_MYFUNDDETAIL.do?f_index=${t[0].f_index}">
				<span class="card-header" style="background-image: url(${t[1].p_mainimg});">
				</span>
				<span class="card-summary">
						<h3>${t[1].p_name}</h3>
				</span>
				<div style="display:none;">
				<fmt:formatDate value="${currTime}" pattern="yyyy-MM-dd HH:mm:ss" />
				<fmt:formatDate value="${t[1].p_enddate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</div>
				<c:if test="${t[1].p_enddate < currTime}">
				<c:choose>
					<c:when test="${t[1].per<100 }">
						<h3 class="card-toggle" style="background:black; color:white">무산</h3></c:when>
					<c:when test="${t[1].per>=100 }">
						<h3 class="card-toggle" style="background:white; color:red">성공</h3></c:when>
				</c:choose>
				</c:if>
				<c:if test="${t[1].gap <=30000}">
					<h3 class="card-toggle" style="background:red; color:white">마감임박</h3>
				</c:if>
				
				<!-- 프로그레스 바 -->
				<div class="candidatos color">
	    			<div class="parcial">
	    			
	    			<div class="info">
            			<div class="percentagem-num">${t[1].per}%</div>
       				</div>
	    			
	    			<div class="progressBar">
	    				<c:choose>
							<c:when test="${t[1].per<=100}">
								<div class="percentagem" style="width: ${t[1].per}%;"></div>
								<!-- %바꾸면 그래프 표시된 바 변경   -->
							</c:when>
							<c:when test="${t[1].per>100 }">
								<div class="percentagem" style="width: 100%;"></div>
								<!-- %바꾸면 그래프 표시된 바 변경   -->
							</c:when>
						</c:choose>
	    			</div>
	        			<div class="partidas">${t[1].p_status}원</div>
	    			</div>
				</div>
				<!-- 프로그레스 바 -->	
				<div class="card-part">
				<c:if test="${t[0].f_cancel==1 }">
					<small>${t[0].f_price}원 후원하셨습니다.</small>
				</c:if>
				<c:if test="${t[0].f_cancel==2 }">
					<small>후원을 취소하셨습니다.</small>
				</c:if>
				</div>
			</a>
		</c:forEach>
		</div>
	</div>
	<jsp:include page="Header.jsp"></jsp:include>
</body>
</html>
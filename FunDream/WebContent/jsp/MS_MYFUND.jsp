<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 참여한 프로젝트</title>
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
			<h4 class="msm_left-h4">내가 참여한 프로젝트</h4>
		</span>
		<div class="cards">
			<a class="card" href="#">
				<span class="card-header" style="background-image: url(img/bg.jpg);">
					<span class="card-title">
						<h3>제목 제목 제목 제목 제목 제목 제목 제목</h3>
					</span>
				</span>
				<span class="card-summary">
					내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
				</span>
				<!-- 무산과 성공 백그라운드 컬러와 글씨 색상 지정은 여기서  -->
				<h3 class="card-toggle" style="background:black; color:white">무산</h3>
				<!-- 프로그레스 바 -->
				<div class="candidatos color">
	    			<div class="parcial">
	        			<div class="info">
	            			<div class="percentagem-num">90%</div>
	       				</div>
	        			<div class="progressBar">
	            			<div class="percentagem" style="width: 90%;"></div>
	        			</div>
	        			<div class="partidas">100,000원</div>
	    			</div>
				</div>
				<!-- 프로그레스 바 -->
				<div class="card-part">
				<small>20000원 후원하셨습니다.</small>
				</div>	
			</a>
		<c:forEach items="${test}" var="t" varStatus="status">
			<a class="card" href="MS_MYFUNDDETAIL.do?f_index=${t[0].f_index}">
				<span class="card-header" style="background-image: url(${t[1].p_mainimg});">
					<span class="card-title">
						<h3>${t[1].p_name}</h3>
					</span>
				</span>
				<span class="card-summary">
					${t[1].p_contents}
				</span>
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
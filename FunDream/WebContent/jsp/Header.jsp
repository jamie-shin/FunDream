<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1.0">
<title>header</title>
<link rel="stylesheet" type="text/css" href="css/Header.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
</head>
<body class="hbody">
	<% String m_img = (String)session.getAttribute("m_img"); %>
	<header>
		<div class="Hlogo"><a href="MAIN.do">FunDream</a></div>
		<nav>
			<ul>
				<li><a href="#">프로젝트</a></li>
				<li class="sub-menu"><a href="#">프레젠테이션</a>
					<ul>
						<li><a href="#">프레젠테이션 일정</a></li>
						<li><a href="#">프레젠테이션 목록</a></li>
					</ul>
				</li>
				<li class="sub-menu"><a href="#">이용안내</a>
					<ul>
						<li><a href="#">공지사항</a></li>
						<li><a href="#">문의사항</a></li>
						<li><a href="#">이용가이드</a></li>
						<li><a href="#">이벤트</a></li>
					</ul>
				</li>
				<c:if test="${(m_manager != 1 && m_email!=null) || (m_email==null)}"><li><a href="#">신규프로젝트신청</a></li></c:if>
				<c:if test="${m_manager == 1 && m_email !=null}"><li><a href="#">관리자 메인</a></li></c:if>
				<li> <c:if test="${m_email==null}"> <a href="MIE_LOGINFORM.do"><img src="img/user.png" style="margin:0; margin-top:8px; padding:0; width:35px; height:35px;"></a></c:if> </li>
				
				<li><c:if test="${m_email!=null}"><img src="${m_img}" style="margin:0; margin-top:8px; padding:0; width:35px; height:35px;">
					<ul>
						<li><a href="MUE_CHECKPW.do">내 정보 수정</a></li>
						<li><a href="#">관심 프로젝트</a></li>
						<li><a href="#">내가 후원한 내역</a></li>
						<li><a href="#">내 프로젝트 관리</a></li>
						<li><a href="MOE.do">로그아웃</a></li>
					</ul>
				</c:if>	
				</li>
				
				<li><div class="search-container">
					<form action="">
						<input type="text" name="" placeholder="Search">
						<button type="submit"><i class="fa fa-search"></i></button>
					</form></div></li>
			</ul>
		</nav>
		<div class="menu-toggle"><i class="fa fa-bars" aria-hidden="true"></i></div>
	</header>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$('.menu-toggle').click(function(){
				$('nav').toggleClass('active')
			})
			$('ul li').click(function(){
				$(this).siblings().removeClass('active');
				$(this).toggleClass('active');
			})
		})
	</script>

</body>
</html>
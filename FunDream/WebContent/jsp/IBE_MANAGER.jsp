<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunDream</title>
<link rel="stylesheet" href="css/admin-main.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(document).find("#member").on('click', function(){
			
		});
		
		$(document).find("#project").on('click', function(){
			
		});
		
		$(document).find("#presentation").on('click', function(){
			
		});
		
		$(document).find("#category").on('click', function(){
			location.href="ICS_LIST.do";
		});
	});
</script>
</head>
<body class="admin-main-body">
	<div class="admin-main-container">
		<div class="admin-main-title"><h1>관리자 페이지</h1></div><br>
		
			<input type="button" class="main-member-btn" id="member" value="회원">
			<input type="button" class="main-project-btn" id="project" value="프로젝트">
			<input type="button" class="main-presentation-btn" id="presentation" value="프레젠테이션">
			<input type="button" class="main-category-btn" id="category" value="카테고리">
			<input type="button" class="main-questions-btn" id="" value="문의사항">
		
	</div>
	<jsp:include page="Header.jsp" />
</body>
</html>


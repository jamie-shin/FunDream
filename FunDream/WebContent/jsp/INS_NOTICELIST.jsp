<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunDream 공지사항</title>
<link rel="stylesheet" href="css/INS-NOTICELIST.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">
	$(function(){
		$(document).on('click', '#sel_notice', function(){
			var an_index = $(this).siblings('#an_index').val();
			location.href = "INS_NOTICEDETAIL.do?an_index="+an_index;
		});
		
		$('#addBtn').on('click', function(){
			location.href = "INE_WRITEFORM.do";
		});
		
		
		
	});
</script>
</head>
<body class="INS-NOTICE-body">
	<div class="INS-NOTICE-container">
		<div class="INS-NOTICE-title"><h1>공지사항</h1></div><br>
			<c:if test="${m_manager == 1}">
			<div class="INS-NOTICE-addbtnright">
				<input type="button" class="INS-NOTICE-addbtn" id="addBtn" value="등록">
			</div>
			</c:if>
			
			<div class="wrapper">
				<div class="table">
					<div class="row header">
						<div class="cell">
			        		제목
			      		</div>
			      		<div class="cell-right">
			        		작성일
			      		</div>
					</div>
					<c:forEach items="${adNoticeList}" var="ad">
					    <div class="row">
					    	<div class="cell" data-title="제목">
					    		<p class="text-p">
					    			<input type="hidden" id="an_index" value="${ad.an_index}">
					    			<a href="#" id="sel_notice">${ad.an_title}</a>
					    		</p>
					      	</div>
					    	<div class="cell-right">
					    		<small><fmt:formatDate pattern="yyyy-MM-dd" value="${ad.an_time}"/></small>
					      	</div>
					    </div>
					</c:forEach>
			    </div>
			</div>
			
			<!-- <div class="INS-NOTICE-morebtncenter">
				<input type="button" class="INS-NOTICE-morebtn" value="더보기">
			</div> -->
		
	</div>
	<jsp:include page="Header.jsp" />
</body>
</html>


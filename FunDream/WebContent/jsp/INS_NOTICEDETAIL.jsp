<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunDream</title>
<link rel="stylesheet" href="css/INS-NOTICEDETAIL.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">
	$(function(){
		$(document).on('click', '#sel_notice', function(){
			var an_index = $(this).siblings('#an_index').val();
			location.href = "INS_NOTICEDETAIL.do?an_index="+an_index;
		});
	});
</script>
</head>
<body class="INS-DETAIL-body">
	<div class="INS-DETAIL-container">
		<div class="INS-DETAIL-title"><h1>${ad.an_title}</h1></div><br>
			
		<div class="INS-DETAIL-contents">${ad.an_contents}</div>
		<br>		
		
		<c:if test="${m_manager == 1}">
		<div class="INS-DETAIL-right">
			<button class="INS-DETAIL-modbtn" id="modifyBtn" value="${ad.an_index}">수정</button>
			<button class="INS-DETAIL-delbtn" id="deleteBtn" value="${ad.an_index}">삭제</button>
		</div><br><br>
		</c:if>
		
		<h2>최신글 목록</h2><br>
		
		<div class="wrapper">
				<div class="table">
					<div class="row header">
						<div class="cell">제목</div>
			      		<div class="cell-right">작성일</div>
					</div>
					<c:forEach items="${adNoticeList}" var="adList">
					    <div class="row">
					    	<div class="cell" data-title="제목">
					    		<p class="text-p">
					    			<input type="hidden" id="an_index" value="${adList.an_index}">
					    			<a href="#" id="sel_notice">${adList.an_title}</a>
					    		</p>
					      	</div>
					    	<div class="cell-right">
					    		<small><fmt:formatDate pattern="yyyy-MM-dd" value="${adList.an_time}"/></small>
					      	</div>
					    </div>
					</c:forEach>
			    </div>
			</div>
			
		<div class="INS-DETAIL-right">
			<input type="button" class="INS-DETAIL-listbtn" value="목록으로"  onclick="location.href='INS_NOTICELIST.do'">
		</div>
			
	</div>
	<jsp:include page="Header.jsp" />
</body>
</html>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(document).find('[id=projectModify]').on('click', function(){
			var p_index = $(this).parent().siblings("#projectIndex").text();
			alert("p_index: " + p_index);
			location.href = "JJI_FORM.do?p_index="+p_index;
		});
	});
</script>
</head>
<body>
	<div style="border: 1px solid black">
	<h1>내 프로젝트 관리</h1>
		<c:forEach items="${myProjectList}" var="project">
			<div style="border : 1px solid red">
				<table>
					<thead>
						<tr>
							<th>프로젝트 번호</th>
							<th>프로젝트명</th>
							<th>목표금액</th>
							<th>시작일</th>
							<th>종료일</th>
							<th>승인여부</th>
							<th>현재 후원 금액</th>
							<th>프로젝트 상세 내용</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="projectIndex">${project.p_index}</td>
							<td><button id="projectModify">${project.p_name}</button></td>
							<td>${project.p_target}</td>
							<td>${project.p_startdate}</td>
							<td>${project.p_enddate}</td>
							<td>
								<c:if test="${project.p_approval == 1}">승인 대기</c:if>
								<c:if test="${project.p_approval == 2}">승인 완료</c:if>
								<c:if test="${project.p_approval == 3}">승인 반려</c:if>
								<c:if test="${project.p_approval == 4}">승인 요청 전</c:if>
							</td>
							<td>${project.p_status}</td>
							<td>${project.p_contents}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</c:forEach>
	</div>

	<jsp:include page="Header.jsp"></jsp:include>
</body>
</html>
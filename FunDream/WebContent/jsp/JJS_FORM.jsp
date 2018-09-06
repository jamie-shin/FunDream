<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Fundream</title>
	<link rel="stylesheet" type="text/css" href="css/projectlist.css">
	<script src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script>
	$(function(){
		$('#moreproject').on('click', function(){
			var num = parseInt($('#num').val());
			num +=1;
			var number = {num : num};
			var list = [];
			var m_id ='${m_id}';
			var m_email = '${m_email}';
 			$.ajax({
				url : "more.do",
				type: 'POST',
				data : number,
				dataType : 'json',
				success : function(data){
					var html='';
					var list = data.p_list;
					for(var i=0;i < list.length;i++){
						if(m_email =='' || m_email==null){
							html += '<a class="card" href="JPS_DETAIL.do?p_index='+list[i].p_index+'")>';
						}
						else{
							html += '<a class="card" href="JPS_DETAIL.do?p_index='+list[i].p_index+'&m_id='+m_id+'")>';
						}
						html += '<span class="card-header" style="background-image: url('+list[i].p_mainimg+');"> </span>';
						html += '<span class="card-summary">';
						html += '<h3>'+list[i].p_name+'</h3>';
						html += '<small class="card-part">00명 참여</small>';
						html += '<div class="candidatos color">';
						html += '<div class="parcial">';
						html += '<div class="info">';
						html += '<div class="percentagem-num">'+list[i].per+'%</div>';
						html += '</div>';
						html += '<div class="progressBar">';
						if(list[i].per<=100){
							html += '<div class="percentagem" style="width: '+list[i].per+'%;"></div>';
						}
						if(list[i].per>100){
							html += '<div class="percentagem" style="width: 100%;"></div>';
						}
						html += '</div>';
						html += '<div class="partidas">'+list[i].p_status+'</div>';
						html += '</div>';
						html += '</div>';
						html += '</a>';
					}
					$('#cards').append(html);
					$('#num').val(num);
					if(data.code == "empty"){
						$('#moreproject').hide();
					}
				},
				error : function(){
					alert("실패");
				}
			}); 
			
		});
	});
</script>
</head>
<body>
<div class="mcontainer">

		<div class="ct-container">
		  <ul>
	        <li><a class="ct-menu" href='JJS_FORM.do<c:if test="${param.keyword != null}">?keyword=${param.keyword}</c:if>'>전체</a>
		  <c:forEach var="ct" items="${cList }" varStatus="status">
	        <li><a style="cursor:pointer" class="ct-menu" id="ctName" href="JJS_FORM.do?ct_index=${ct.ct_index}<c:if test="${param.keyword != null}">&keyword=${param.keyword}</c:if>">${ct.ct_name}</a><input type="hidden" value="${ct.ct_index }" name="ct_index" id="ct_index"></li>
	      </c:forEach>
		  </ul>
		</div>
		<div class="">
			<div class="ct-select">
			  <select class="ct-select-box">
			    <option>최신순</option>
			    <option>마감임박순</option>
			    <option>목표달성율순</option>
			    <option>추천순</option>
			    <option>인기순</option>
			  </select>
	
			</div>
		
			<div class="right-on-page">
			  <input type="checkbox" name="cb" id="cb1" value="1" checked="checked"/>
			  <label for="cb1">진행중</label>
			  <input type="checkbox" name="cb" id="cb2" value="2"/>
			  <label for="cb2">마감</label>
			</div>
		

	<div class="cards" id="cards">
				<c:forEach items="${list}" var="list">
				<c:if test="${m_email !=null }">
					<a class="card"
						href="JPS_DETAIL.do?p_index=${list.p_index}&m_id=${m_id}")>
				</c:if>
				<c:if test="${m_email ==null }">
					<a class="card" href="JPS_DETAIL.do?p_index=${list.p_index}")>
				</c:if>
				<span class="card-header"
					style="background-image: url(${list.p_mainimg});"> </span>
				<span class="card-summary">
					<h3>${list.p_name}</h3>
					<!-- 게시물 제목 -->
				</span>
				<!-- 한줄 내용 입력창 -->
				<small class="card-part">00명 참여</small>
				<!-- 참여자 수  -->
				<!-- 프로그레스 바 -->
				<div class="candidatos color">
					<div class="parcial">
						<div class="info">
							<div class="percentagem-num">${list.per}%</div>
							<!-- 보여지는 퍼센트  -->

						</div>
						<div class="progressBar">
							<!-- 100%를 넘기면 밖으로 나가버리니 넘지않게 할 것 -->
							<c:choose>
								<c:when test="${list.per<=100}">
									<div class="percentagem" style="width: ${list.per}%;"></div>
									<!-- %바꾸면 그래프 표시된 바 변경   -->
								</c:when>
								<c:when test="${list.per>100 }">
									<div class="percentagem" style="width: 100%;"></div>
									<!-- %바꾸면 그래프 표시된 바 변경   -->
								</c:when>
							</c:choose>
						</div>
						<div class="partidas">${list.p_status}</div>
						<!-- 모금된 후원액 -->
					</div>
				</div>
				<!-- 프로그레스 바 -->
				</a>
			</c:forEach>
		</div>
		<button id="moreproject">더보기</button>
		<input type="hidden" id="num" value="0">
	</div>



<jsp:include page="Header.jsp"/>
</body>
</html>
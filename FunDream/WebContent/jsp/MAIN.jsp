<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunDream</title>
<link rel="stylesheet" href="css/mainpage.css">
<link
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="js/mainpage.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.like-btn').on('click', function() {
		var m_id =  $(this).siblings('[name=m_id]').val();
		var p_index = $(this).siblings("[name=p_index]").val();
		var p_name = $(this).siblings("[name=p_name]").val();
		var likeBtn = $(this);
		$.ajax({
			url : "MLD_UNLIKE.do",
			type : "POST",
			data : {m_id : m_id,
					p_index : p_index},
			success : function(data){
				switch(data){
				case "insert":
					alert(p_name + "이(가) 관심 프로젝트 등록되었습니다.");
					likeBtn.toggleClass('is-active');
					break;
				case "delete":
					alert(p_name + "이(가) 관심 프로젝트 해제되었습니다.");
					likeBtn.toggleClass('is-active');
					break;
				default :
					console.log("관심 프로젝트 등록/삭제 실패");
					break;
				}
			},
			error : function(){
				console.log("관심 프로젝트 등록/삭제 오류");
			}
		});
	});
});
</script>
</head>
<body class="mainPage">
	<div class="slideshow">
		<ul class="slider">
			<li>
				<a href="">
					<div class="banner" style="background-image: url('img/애완동물.jpg');"></div>
					<section class="caption">	
						<h1>프로젝트13</h1>
						<!-- 프로젝트 제목  -->
					</section>
				</a>
			</li>
			<li>
				<a href="">
					<div class="banner" style="background-image: url('img/레저.jpg');"></div>
					<section class="caption">
						<h1>프로젝트12</h1>
					</section>
				</a>
			</li>
			<li>
				<a href="">
					<div class="banner" style="background-image: url('img/화장품.jpg');"></div>
					<section class="caption">
						<h1>프로젝트2</h1>
					</section>
				</a>
			</li>
			<li>
				<a href="">
					<div class="banner" style="background-image: url('img/뷰티.jpg');"></div>
					<section class="caption">
						<h1>프로젝트11</h1>
					</section>
				</a>
			</li>
		</ul>
		<ol class="pagination"></ol>

		<div class="left">
			<span class="fa fa-chevron-left"></span>
		</div>

		<div class="right">
			<span class="fa fa-chevron-right"></span>
		</div>
	</div>
	<!-- 여기부터 메인 flex  -->
	<div class="mcontainer">
		<span class="left-subtitle">
			<h2 class="left-h2">마감 임박 프로젝트</h2>
		</span> <span class="right-allview">
			<h5 href="" class="right-h5">
				<a href="JJS_FORM.do?sort=2">전체보기</a>
			</h5>
		</span>
		<!-- 카드 하나당 게시물 한개 -->
		<div class="cards">
			<c:forEach items="${endlist }" var="list">
				<c:if test="${m_email !=null }">
					<a class="card" href="JPS_DETAIL.do?p_index=${list.p_index}&m_id=${m_id}")>
				</c:if>
				<c:if test="${m_email ==null }">
					<a class="card" href="JPS_DETAIL.do?p_index=${list.p_index}")>
				</c:if>
				<span class="card-header" style="background-image: url(''${list.p_mainimg});">
					<!-- 내가 만든 프로젝트 표시하는 card-title -->
					<c:if test="${list.m_id == m_id}">
						<span class="card-title"><h3>내가 만든 프로젝트</h3></span>
					</c:if>
				</span>
				<span class="card-summary">
					<h3>${list.p_name}</h3>
					<!-- 게시물 제목 -->
				</span>
				<!-- 한줄 내용 입력창 -->
				<div class="card-part">
					<small>${list.p_count}명 참여</small>
				</div>
				<!-- 참여자 수  -->
				<input type="hidden" value="${list.gap }">
				<h3 class="card-toggle" style="background:red; color:white" <c:if test="${list.gap >30000 }">hidden='hidden'</c:if>>마감임박</h3>
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
				<div class="LIKE-buttons">
					<input type="hidden" value="${list.p_name}" name="p_name">
					<input type="hidden" value="${list.p_index}" name="p_index">
					<input type="hidden" value="${m_id}" name="m_id">
					<c:if test="${favoriteList != null}">
						<c:forEach items="${favoriteList}" var="fav">
					        <c:if test="${fav.p_index == list.p_index}"><span class="like-btn is-active"></span></c:if>
					        <c:if test="${fav.p_index != list.p_index}"><span class="like-btn"></span></c:if>
						</c:forEach>
					</c:if>
			    </div>
			</c:forEach>
		</div>
	</div>


	<div class="mcontainer">
		<span class="left-subtitle">
			<h2 class="left-h2">신규 프로젝트</h2>
		</span> <span class="right-allview">
			<h5 href="" class="right-h5">
				<a href="JJS_FORM.do?sort=1">전체보기</a>
			</h5>
		</span>
		<div class="cards">
			<c:forEach items="${newlist}" var="list">
				<c:if test="${m_email !=null }">
					<a class="card" href="JPS_DETAIL.do?p_index=${list.p_index}&m_id=${m_id}")>
				</c:if>
				<c:if test="${m_email ==null }">
					<a class="card" href="JPS_DETAIL.do?p_index=${list.p_index}")>
				</c:if>
				<span class="card-header" style="background-image: url(${list.p_mainimg});"> 
					<!-- 내가 만든 프로젝트 표시하는 card-title -->
					<c:if test="${list.m_id == m_id}">
						<span class="card-title"><h3>내가 만든 프로젝트</h3></span>
					</c:if>
				</span>
				<span class="card-summary">
					<h3>${list.p_name}</h3>
				</span>
				<div class="card-part">
				<small>${list.p_count}명 참여</small>
				</div>
				<input type="hidden" value="${list.gap }">
				<h3 class="card-toggle" style="background:red; color:white" <c:if test="${list.gap >30000 }">hidden='hidden'</c:if>>마감임박</h3>
				<!-- 프로그레스 바 -->
				<div class="candidatos color">
					<div class="parcial">
						<div class="info">
							<div class="percentagem-num">${list.per}%</div>
						</div>
						<div class="progressBar">
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
					</div>
				</div>
				<!-- 프로그레스 바 -->
				</a>
				<div class="LIKE-buttons">
					<input type="hidden" value="${list.p_name}" name="p_name">
					<input type="hidden" value="${list.p_index}" name="p_index">
					<input type="hidden" value="${m_id}" name="m_id">
					<c:if test="${favoriteList != null}">
						<c:forEach items="${favoriteList}" var="fav">
					        <c:if test="${fav.p_index == list.p_index}"><span class="like-btn is-active"></span></c:if>
					        <c:if test="${fav.p_index != list.p_index}"><span class="like-btn"></span></c:if>
						</c:forEach>
					</c:if>
			    </div>
			</c:forEach>
		</div>
	</div>

	<div class="mcontainer">
		<span class="left-subtitle">
			<h2 class="left-h2">목표 달성률 높은 프로젝트</h2>
		</span> <span class="right-allview">
			<h5 href="" class="right-h5">
				<a href="JJS_FORM.do?sort=3">전체보기</a>
			</h5>
		</span>
		<div class="cards">
			<c:forEach items="${successlist}" var="list">
				<c:if test="${m_email !=null }">
					<a class="card"
						href="JPS_DETAIL.do?p_index=${list.p_index}&m_id=${m_id}")>
				</c:if>
				<c:if test="${m_email ==null }">
					<a class="card" href="JPS_DETAIL.do?p_index=${list.p_index}")>
				</c:if>
				<span class="card-header" style="background-image: url(${list.p_mainimg});">
					<!-- 내가 만든 프로젝트 표시하는 card-title -->
					<c:if test="${list.m_id == m_id}">
						<span class="card-title"><h3>내가 만든 프로젝트</h3></span>
					</c:if>
				</span>
				<span class="card-summary">
					<h3>${list.p_name}</h3>
				</span>
				<div class="card-part">
				<small>${list.p_count}명 참여</small>
				</div>
				<input type="hidden" value="${list.gap }">
				<h3 class="card-toggle" style="background:red; color:white" <c:if test="${list.gap >30000 }">hidden='hidden'</c:if>>마감임박</h3>
				<!-- 프로그레스 바 -->
				<div class="candidatos color">
					<div class="parcial">
						<div class="info">
							<div class="percentagem-num">${list.per}%</div>
						</div>
						<div class="progressBar">
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
					</div>
				</div>
				<!-- 프로그레스 바 -->
				</a>
				<div class="LIKE-buttons">
					<input type="hidden" value="${list.p_name}" name="p_name">
					<input type="hidden" value="${list.p_index}" name="p_index">
					<input type="hidden" value="${m_id}" name="m_id">
					<c:if test="${favoriteList != null}">
						<c:forEach items="${favoriteList}" var="fav">
					        <c:if test="${fav.p_index == list.p_index}"><span class="like-btn is-active"></span></c:if>
					        <c:if test="${fav.p_index != list.p_index}"><span class="like-btn"></span></c:if>
						</c:forEach>
					</c:if>
			    </div>
			</c:forEach>
		</div>
	</div>
	<jsp:include page="Header.jsp" />
</body>
</html>
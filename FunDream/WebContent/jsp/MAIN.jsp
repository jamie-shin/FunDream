<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunDream</title>
	<link rel="stylesheet" href="css/mainpage.css">
	<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script src="js/mainpage.js"></script>
</head>
<body class="mainPage">
	<div class="slideshow">
		<ul class="slider">
			<li>
				<a href=""><img class="banner" src="img/bg.jpg" alt="1">
				<section class="caption">
					<h1>Lorem ipsum1</h1><!-- 프로젝트 제목  -->
					<p>asdasdsadadsada asdasda asdasdawgs asdqdwda</p><!-- 한줄 설명  -->
				</section></a>
			</li>
			<li>
				<a href=""><img class="banner" src="img/bg.jpg" alt="2">
				<section class="caption">
					<h1>Lorem ipsum2</h1>
					<p>asdasdsadadsada asdasda asdasdawgs asdqdwda</p>
				</section></a>
			</li>
			<li>
				<a href=""><img class="banner" src="img/bg.jpg" alt="3">
				<section class="caption">
					<h1>Lorem ipsum3</h1>
					<p>asdasdsadadsada asdasda asdasdawgs asdqdwda</p>
				</section></a>
			</li>
			<li>
				<a href=""><img class="banner" src="img/bg.jpg" alt="4">
				<section class="caption">
					<h1>Lorem ipsum4</h1>
					<p>asdasdsadadsada asdasda asdasdawgs asdqdwda</p>
				</section></a>
			</li>
		</ul>
		<ol class="pagination">
			
		</ol>

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
	<h2 class="left-h2">추천 프로젝트</h2>
</span>
<span class="right-allview">
	<h5 href="" class="right-h5"><a href="">전체보기</a></h5>
</span>
	<!-- 카드 하나당 게시물 한개 -->
	<div class="cards">
		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3><!-- 게시물 제목 -->
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span><!-- 한줄 내용 입력창 -->
			<small class="card-part">00명 참여</small><!-- 참여자 수  -->
			<!-- 프로그레스 바 -->
			<div class="candidatos color">
    			<div class="parcial">
        			<div class="info">
            			<div class="percentagem-num">20%</div><!-- 보여지는 퍼센트  -->
       				</div>
        			<div class="progressBar"><!-- 100%를 넘기면 밖으로 나가버리니 넘지않게 할 것 -->
            			<div class="percentagem" style="width: 20%;"></div><!-- %바꾸면 그래프 표시된 바 변경   -->
        			</div>
        			<div class="partidas">100,000원</div> <!-- 모금된 후원액 -->
    			</div>
			</div>
			<!-- 프로그레스 바 -->	
		</a>

		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3>
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span>
			<small class="card-part">00명 참여</small>
			<!-- 프로그레스 바 -->
			<div class="candidatos color">
    			<div class="parcial">
        			<div class="info">
            			<div class="percentagem-num">20%</div>
       				</div>
        			<div class="progressBar">
            			<div class="percentagem" style="width: 20%;"></div>
        			</div>
        			<div class="partidas">100,000원</div>
    			</div>
			</div>
			<!-- 프로그레스 바 -->	
		</a>

		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3>
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span>
			<small class="card-part">000명 참여</small>
			<!-- 프로그레스 바 -->
			<div class="candidatos color">
    			<div class="parcial">
        			<div class="info">
            			<div class="percentagem-num">20%</div>
       				</div>
        			<div class="progressBar">
            			<div class="percentagem" style="width: 20%;"></div>
        			</div>
        			<div class="partidas">100,000원</div>
    			</div>
			</div>
			<!-- 프로그레스 바 -->	
		</a>
	</div>
</div>



<div class="mcontainer">
<span class="left-subtitle">
	<h2 class="left-h2">주제별 인기 프로젝트</h2>
</span>
<span class="right-allview">
	<h5 href="" class="right-h5"><a href="">전체보기</a></h5>
</span>
	<div class="cards">

		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3>
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span>
			<small class="card-part">00명 참여</small>
			<!-- 프로그레스 바 -->
			<div class="candidatos color">
    			<div class="parcial">
        			<div class="info">
            			<div class="percentagem-num">40%</div>
       				</div>
        			<div class="progressBar">
            			<div class="percentagem" style="width: 40%;"></div>
        			</div>
        			<div class="partidas">100,000원</div>
    			</div>
			</div>
			<!-- 프로그레스 바 -->	
		</a>

		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3>
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span>
			<small class="card-part">00명 참여</small>
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
		</a>

		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3>
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span>
			<small class="card-part">00명 참여</small>
			<!-- 프로그레스 바 -->
			<div class="candidatos color">
    			<div class="parcial">
        			<div class="info">
            			<div class="percentagem-num">110%</div>
       				</div>
        			<div class="progressBar">
            			<div class="percentagem" style="width: 100%;"></div>
        			</div>
        			<div class="partidas">100,000원</div>
    			</div>
			</div>
			<!-- 프로그레스 바 -->	
		</a>
	</div>
</div>


<div class="mcontainer">
<span class="left-subtitle">
	<h2 class="left-h2">신규 프로젝트</h2>
</span>
<span class="right-allview">
	<h5 href="" class="right-h5"><a href="">전체보기</a></h5>
</span>
	<div class="cards">

		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3>
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span>
			<small class="card-part">00명 참여</small>
			<!-- 프로그레스 바 -->
			<div class="candidatos color">
    			<div class="parcial">
        			<div class="info">
            			<div class="percentagem-num">40%</div>
       				</div>
        			<div class="progressBar">
            			<div class="percentagem" style="width: 40%;"></div>
        			</div>
        			<div class="partidas">100,000원</div>
    			</div>
			</div>
			<!-- 프로그레스 바 -->	
		</a>

		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3>
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span>
			<small class="card-part">00명 참여</small>
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
		</a>

		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3>
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span>
			<small class="card-part">00명 참여</small>
			<!-- 프로그레스 바 -->
			<div class="candidatos color">
    			<div class="parcial">
        			<div class="info">
            			<div class="percentagem-num">110%</div>
       				</div>
        			<div class="progressBar">
            			<div class="percentagem" style="width: 100%;"></div>
        			</div>
        			<div class="partidas">100,000원</div>
    			</div>
			</div>
			<!-- 프로그레스 바 -->	
		</a>
	</div>
</div>

<div class="mcontainer">
<span class="left-subtitle">
	<h2 class="left-h2">마감 임박 프로젝트</h2>
</span>
<span class="right-allview">
	<h5 href="" class="right-h5"><a href="">전체보기</a></h5>
</span>
	<div class="cards">

		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3>
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span>
			<small class="card-part">00명 참여</small>
			<!-- 프로그레스 바 -->
			<div class="candidatos color">
    			<div class="parcial">
        			<div class="info">
            			<div class="percentagem-num">40%</div>
       				</div>
        			<div class="progressBar">
            			<div class="percentagem" style="width: 40%;"></div>
        			</div>
        			<div class="partidas">100,000원</div>
    			</div>
			</div>
			<!-- 프로그레스 바 -->	
		</a>

		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3>
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span>
			<small class="card-part">00명 참여</small>
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
		</a>

		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3>
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span>
			<small class="card-part">00명 참여</small>
			<!-- 프로그레스 바 -->
			<div class="candidatos color">
    			<div class="parcial">
        			<div class="info">
            			<div class="percentagem-num">110%</div>
       				</div>
        			<div class="progressBar">
            			<div class="percentagem" style="width: 100%;"></div>
        			</div>
        			<div class="partidas">100,000원</div>
    			</div>
			</div>
			<!-- 프로그레스 바 -->	
		</a>
	</div>
</div>


<div class="mcontainer">
<span class="left-subtitle">
	<h2 class="left-h2">목표 달성 완료 프로젝트</h2>
</span>
<span class="right-allview">
	<h5 href="" class="right-h5"><a href="">전체보기</a></h5>
</span>
	<div class="cards">

		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3>
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span>
			<small class="card-part">00명 참여</small>
			<!-- 프로그레스 바 -->
			<div class="candidatos color">
    			<div class="parcial">
        			<div class="info">
            			<div class="percentagem-num">40%</div>
       				</div>
        			<div class="progressBar">
            			<div class="percentagem" style="width: 40%;"></div>
        			</div>
        			<div class="partidas">100,000원</div>
    			</div>
			</div>
			<!-- 프로그레스 바 -->	
		</a>

		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3>
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span>
			<small class="card-part">00명 참여</small>
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
		</a>

		<a class="card" href="#">
			<span class="card-header" style="background-image: url(img/bg.jpg);">
				<span class="card-title">
					<h3>제목 제목 제목 제목</h3>
				</span>
			</span>
			<span class="card-summary">
				내요오오오오오오오오오오오오오오오오오오옹내요오오오오오오오오오오오오옹
			</span>
			<small class="card-part">00명 참여</small>
			<!-- 프로그레스 바 -->
			<div class="candidatos color">
    			<div class="parcial">
        			<div class="info">
            			<div class="percentagem-num">110%</div>
       				</div>
        			<div class="progressBar">
            			<div class="percentagem" style="width: 100%;"></div>
        			</div>
        			<div class="partidas">100,000원</div>
    			</div>
			</div>
			<!-- 프로그레스 바 -->	
		</a>
	</div>
</div>
	
	
	
	
	
	<jsp:include page="Header.jsp"/>
</body>
</html>
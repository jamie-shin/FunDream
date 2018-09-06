<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>makeProject</title>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.js"></script>
<link rel="stylesheet" type="text/css" href="css/projectView.css">
<!-- <script type="text/javascript" src="js/projectView.js"></script> -->
<script>
	$(function() {
		//공지사항 등록
		$('#insert_notice').on('click', function() {
			$('#write_notice').show();
			$('#notice').hide();
		});

		$('#return').on('click', function() {
			$('#write_notice').hide();
			$('#notice').show();
		});
		
		//후원자 목록 보기
		$('#sponlistbtn').on('click', function() {
			$('#grape').hide();
			$('#sponlist').show();
		});

		$('#sponprevbtn').on('click', function() {
			$('#grape').show();
			$('#sponlist').hide();
		});
		
		//글자수 카운터
		 $('#inputComment').keyup(function (e){
	        var content = $(this).val();
	        $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
	        $('#counter').html(content.length + '/200');
	     });
	     $('#inputComment').keyup();
	});
</script>
</head>
<body>
	<div class="pv-banner-image"
		style="background-image: url(${project.p_mainimg})">
		<h1 class="pv-banner-text">${project.p_name}${type}</h1>
	</div>

	<!--  -->

	<!--  -->

	<div class="pv-container">
		<div class="pv-main">
			<input id="item01" type="radio" name="tab" checked="checked">
			<input id="item02" type="radio" name="tab"> <input
				id="item03" type="radio" name="tab"> <input id="item04"
				type="radio" name="tab">
			<ul class="pv-menu">
				<li><label for="item01">스토리</label></li>
				<li><label for="item02">교환/환불</label></li>
				<li><label for="item03">커뮤니티</label></li>
				<c:if test="${type eq 'producer' || type eq 'manager'}">
					<li><label for="item04">후원자 목록</label></li>
				</c:if>
			</ul>
			<ul class="pv-contents">

				<!-- 스토리 -->

				<li class="pv-contents-list item01">${project.p_contents}

					<div class="pv-creator-box">
						<div class="pv-creator-box-left">
							<img src="${m.m_img}" class="pv-creator-img">
						</div>
						<div class="pv-creator-box-right">
							<p class="pv-p">
								닉네임 : ${m.m_nick} <br>연락처 : ${m.m_phone}<br>이메일 :
								${m.m_email}
							</p>
						</div>
					</div>
				</li>

				<!-- 정책확인 -->

				<li class="pv-contents-list item02">
					<h2>리워드 제공 지연 관련</h2> <textarea class="pv-policy-area1">
1. 리워드가 배송 예정일 보다 늦게 발송 되는 경우 이메일로 변경된 리워드 제공일을 알려 드립니다.
2. 배송예정일로 부터 30일 이내 에 리워드 발송이 되지 않을 경우 본인의 계좌로 100% 환불해 드립니다.
		  			</textarea>
					<h2>교환/환불/AS정책</h2> <textarea class="pv-policy-area2" readonly> ${project.p_policy}</textarea>
				</li>

				<!-- 커뮤니티  -->

				<li class="pv-contents-list item03">
					<div id="notice">

						<h2>공지사항</h2>
						<div class="pv-notice-right">
							<c:if test="${type eq 'producer'}">
								<input type="button" value="새 공지사항 등록" class="pv-new-noticebtn"
									id="insert_notice">
							</c:if>
						</div>
						<div class="pv-notice-box">
							<div class="pv-notice-menu">
								<div class="pv-notice-tab">
									<input id="pv-notice-one" type="checkbox" name="tabs">
									<label for="pv-notice-one">공지사항1</label>
									<div class="pv-notice-content">
										<div class="pv-notice-topright">2018-08-13 10:51:30</div>
										<div class="pv-notice-btnbox">
											<a class="pv-notice-modbtn">수정</a> <a
												class="pv-notice-delbtn">삭제</a>
										</div>
										<div class="pv-notice-contents">
											asdasdasdasdasdsadas asdsadasdas<br> asdasdasd<br>
											asdsadasdas<br> asdasdasd<br> asdsadasdas<br>
											asdasdasd<br> asdsadasdas<br> asdasdasd<br>
											asdsadasdas<br> asdasdasd<br> asdsadasdas<br>
											asdasdasd<br> asdsadasdas<br> asdasdasd<br>
											asdsadasdas<br> asdasdasd<br> asdsadasdas<br>
											asdasdasd<br> asdsadasdas<br> asdasdasd<br>
											asdsadasdas<br> asdasdasd<br> asdasdas
										</div>
									</div>
								</div>
								<div class="pv-notice-tab">
									<input id="pv-notice-two" type="checkbox" name="tabs">
									<label for="pv-notice-two">공지사항1</label>
									<div class="pv-notice-content">
										<div class="pv-notice-topright">2018-08-13 10:51:30</div>
										<div class="pv-notice-btnbox">
											<a class="pv-notice-modbtn">수정</a> <a
												class="pv-notice-delbtn">삭제</a>
										</div>
										<div class="pv-notice-contents">
											asdasdasdasdasdsadas asdsadasdas<br> asdasdasd<br>
											asdsadasdas<br> asdasdasd<br> asdsadasdas<br>
											asdasdasd<br> asdsadasdas<br> asdasdasd<br>
											asdsadasdas<br> asdasdasd<br> asdsadasdas<br>
											asdasdasd<br> asdsadasdas<br> asdasdasd<br>
											asdsadasdas<br> asdasdasd<br> asdsadasdas<br>
											asdasdasd<br> asdsadasdas<br> asdasdasd<br>
											asdsadasdas<br> asdasdasd<br> asdasdas
										</div>
									</div>
								</div>
								<div class="pv-notice-tab">
									<input id="pv-notice-three" type="checkbox" name="tabs">
									<label for="pv-notice-three">공지사항1</label>
									<div class="pv-notice-content">
										<div class="pv-notice-topright">2018-08-13 10:51:30</div>
										<div class="pv-notice-btnbox">
											<a class="pv-notice-modbtn">수정</a> <a
												class="pv-notice-delbtn">삭제</a>
										</div>
										<div class="pv-notice-contents">
											asdasdasdasdasdsadas asdsadasdas<br> asdasdasd<br>
											asdsadasdas<br> asdasdasd<br> asdsadasdas<br>
											asdasdasd<br> asdsadasdas<br> asdasdasd<br>
											asdsadasdas<br> asdasdasd<br> asdsadasdas<br>
											asdasdasd<br> asdsadasdas<br> asdasdasd<br>
											asdsadasdas<br> asdasdasd<br> asdsadasdas<br>
											asdasdasd<br> asdsadasdas<br> asdasdasd<br>
											asdsadasdas<br> asdasdasd<br> asdasdas
										</div>
									</div>
								</div>

							</div>
						</div>

						<h2>댓글</h2>
						<c:if test="${type eq 'none' || type eq 'normal'}">
						<div class="pv-comment-box">
							<textarea class="pv-comment-textarea" maxlength="200"
								placeholder="저작권 등 다른 사람의 권리를 침해하거나 명예를 훼손하는 게시물은 관련 법률에 의해 제재를 받을 수 있습니다." id="inputComment"></textarea>
							<div class="pv-comment-right">
								<span id="counter">###</span> &emsp;<input type="button" class="pv-comment-addbtn"
									value="입력">
							</div>
						</div>
						</c:if>
						<br> <br>
						<!-- 작성된 댓글들이 들어갈 가장 큰 컨테이너div -->
						<div class="pv-comment-cards">
							<div class="pv-comment-card">
								<!-- 댓글로 작성된 카드 -->
								<div class="pv-comment-card-1">
									<div class="pv-comment-topleft">닉네임</div>
									<div class="pv-comment-topright">2018-08-13 10:51:30</div>
								</div>
								<textarea class="pv-comment-contents">
									asdasdasdasdasdsadas
									asdsadasdas<br>
									asdasdasd<br>
									asdasdas
								</textarea>
								<div class="pv-comment-btnbox">
									<input type="button" class="pv-comment-modbtn" value="수정">
									<input type="button" class="pv-comment-delbtn" value="삭제">
									<c:if test="${type eq 'producer'}">
									<input type="button" class="pv-comment-decbtn" value="신고">
									<input type="button" class="pv-comment-recbtn" value="답글">
									</c:if>
								</div>
							</div>
							<div class="pv-comment-recommentcard">
								<!-- 답글 카드 -->
								<div class="pv-comment-card-1">
									<div class="pv-comment-topleft">└ ${m.m_nick}</div>
									<div class="pv-comment-topright">2018-08-13 10:51:30</div>
								</div>
								<textarea class="pv-comment-contents">
									asdasdasdasdasdsadas
									asdsadasdas<br>
									asdasdasd<br>
									asdasdas
								</textarea>
								<c:if test="${type eq 'producer'}">
								<div class="pv-comment-btnbox">
									<input type="button" class="pv-comment-modbtn" value="수정">
									<input type="button" class="pv-comment-delbtn" value="삭제">
								</div>
								</c:if>
							</div>
						</div>



					</div>
					<div class="pv-creator-notice-crebox" id="write_notice"
						style="display: none;">
						<h2>공지사항 작성</h2>
						<div id="summernote"></div>
						<script>
							$('#summernote').summernote({
								tabsize : 2,
								height : 300
							});
						</script>
						<div class="pv-creator-notice-create">
							<input type="button" value="돌아가기"
								class="pv-creator-notice-createprevbtn" id="return"> <input
								type="button" value="작성" class="pv-creator-notice-createbtn">
						</div>
					</div>


				</li>

				<!-- 제작자용 -->
				<li class="pv-contents-list item04">
					<div id="grape">
						<div class="creator-sponsors1">
							<input type="button" class="pv-sponsors-listbtn"
								value="후원자 목록 상세보기" id="sponlistbtn"> <br> <br>
							<div class="pv-sponsors-tablewrapper">
								<div class="pv-sponsors-table">
									<div class="row header backcolor">
										<div class="cell">총원</div>
										<div class="cell">총금액</div>
									</div>
									<div class="row">
										<div class="cell" data-title="총원">10</div>
										<div class="cell" data-title="총금액">1000000</div>
									</div>
								</div>
							</div>
							<br> <br>

							<!-- 그래프1  -->
							<h2>연령별 신청현황</h2>
							<br>
							<div class="grid">
								<section class="pv-circle-section">
									<svg class="circle-chart" viewbox="0 0 33.83098862 33.83098862"
										width="150" height="150" xmlns="http://www.w3.org/2000/svg">
							      <circle class="circle-chart__background" stroke="#efefef"
											stroke-width="2" fill="none" cx="16.91549431"
											cy="16.91549431" r="15.91549431" />
							      <circle class="circle-chart__circle" stroke="#00acc1"
											stroke-width="2" stroke-dasharray="57,100"
											stroke-linecap="round" fill="none" cx="16.91549431"
											cy="16.91549431" r="15.91549431" />
							      <g class="circle-chart__info">
							        <text class="circle-chart__percent" x="16.91549431"
											y="15.5" alignment-baseline="central" text-anchor="middle"
											font-size="8">남자</text>
							        <text class="circle-chart__subline" x="16.91549431"
											y="20.5" alignment-baseline="central" text-anchor="middle"
											font-size="3">57%</text>
							      </g>
							    </svg>
								</section>
								<section>
									<svg class="circle-chart" viewbox="0 0 33.83098862 33.83098862"
										width="150" height="150" xmlns="http://www.w3.org/2000/svg">
							      <circle class="circle-chart__background" stroke="#efefef"
											stroke-width="2" fill="none" cx="16.91549431"
											cy="16.91549431" r="15.91549431" />
							      <circle class="circle-chart__circle" stroke="#FF7043"
											stroke-width="2" stroke-dasharray="43,100"
											stroke-linecap="round" fill="none" cx="16.91549431"
											cy="16.91549431" r="15.91549431" />
							      <g class="circle-chart__info">
							        <text class="circle-chart__percent" x="16.91549431"
											y="15.5" alignment-baseline="central" text-anchor="middle"
											font-size="8">여자</text>
							        <text class="circle-chart__subline" x="16.91549431"
											y="20.5" alignment-baseline="central" text-anchor="middle"
											font-size="3">43%</text>
							      </g>
							    </svg>
								</section>
							</div>


							<script>
								var total = 312;
								var percentage = function(value) {
									return value * 100 / total;
								};

								console.log(percentage(178) + ",100");
							</script>
							<br>
							<br>
							<!--  -->

							<!-- 그래프2  -->
							<h2>리워드별 신청현황</h2>
							<ul class="skill-list">
								<li class="skill">
									<h5 class="progressbar-count">
										Reward1<br> 23%
									</h5> <progress class="skill-1" max="100" value="23">
										<strong>Skill Level: 50%</strong>
									</progress>
								</li>
								<li class="skill">
									<h5 class="progressbar-count">
										Reward2<br> 123%
									</h5> <progress class="skill-1" max="100" value="123">
										<strong>Skill Level: 50%</strong>
									</progress>
								</li>
							</ul>
							<!--  -->

						</div>
					</div>
					<div id="sponlist" style="display: none">

						<div class="creator-sponsors2">
							<input type="button" class="pv-sponsors-prevbtn" value="< 돌아가기"
								id="sponprevbtn"> <br> <br>
							<div class="pv-sponsors-tablewrapper">
								<div class="pv-sponsors-table">
									<div class="row header backcolor">
										<div class="cell">총원</div>
										<div class="cell">총금액</div>
									</div>
									<div class="row">
										<div class="cell" data-title="총원">10</div>
										<div class="cell" data-title="총금액">1000000</div>
									</div>
								</div>
							</div>
							<br> <br> <br>

							<!-- 배송주소 테이블 -->

							<div class="pv-sponsor-wrapper">
								<div class="sponsors-address-table">

									<div class="row header backcolor">
										<div class="cell">후원자</div>
										<div class="cell">금액</div>
										<div class="cell">리워드</div>
										<div class="cell">옵션</div>
										<div class="cell">배송지</div>
									</div>

									<div class="row">
										<div class="cell" data-title="후원자">후원자1</div>
										<div class="cell" data-title="금액">10000원</div>
										<div class="cell" data-title="리워드">리워드1</div>
										<div class="cell" data-title="옵션">red</div>
										<div class="cell" data-title="배송지">서울시 강남구 테헤란로 10</div>
									</div>

									<div class="row">
										<div class="cell" data-title="후원자">후원자1</div>
										<div class="cell" data-title="금액">10000원</div>
										<div class="cell" data-title="리워드">리워드1</div>
										<div class="cell" data-title="옵션">red</div>
										<div class="cell" data-title="배송지">서울특별시 서초구 강남대로53길 8
											비트아카데미빌딩</div>
									</div>

								</div>
							</div>

							<!-- 여기까지 -->
						</div>
					</div>


				</li>
			</ul>
		</div>


		<!-- 사이드 바 메뉴 -->

		<div class="pv-side">
			<c:if test="${type eq 'none' || type eq 'normal'}">
				<input type="button" value="후원하기" class="pv-reward-btn">
			</c:if>
			<c:if test="${type eq 'producer' || type eq 'manager'}">
			<div style="height:50px; width:100%;">
			</div>
			</c:if>
			<div class="pv-progressbar-box">
				<div class="candidatos color">
					<div class="parcial">
						<div class="info">
							<div class="percentagem-num">${project.per}%</div>
						</div>
						<div class="progressBar">
							<c:choose>
								<c:when test="${project.per<=100}">
									<div class="percentagem" style="width: ${project.per}%;"></div>
									<!-- %바꾸면 그래프 표시된 바 변경   -->
								</c:when>
								<c:when test="${project.per>100 }">
									<div class="percentagem" style="width: 100%;"></div>
									<!-- %바꾸면 그래프 표시된 바 변경   -->
								</c:when>
							</c:choose>
						</div>
						<div class="partidas">${project.p_status}</div>
					</div>
				</div>
			</div>

			<div class="pv-reward-box">
				<div class="reward-menu">
					<div class="reward-tab">
						<input id="reward-one" type="checkbox" name="tabs"> <label
							for="reward-one">리워드1</label>
						<div class="reward-tab-content">
							<div class="reward-tab-imagebox">
								<img src="img/wadiz.jpg" id="" class="reward-tab-img">
							</div>
							<div class="reward-tab-contentsbox">
								<div>
									<span>설명 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
								<div>
									<span>남은수량 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
								<div>
									<span>옵션 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
								<div>
									<span>배송료 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
								<div>
									<span>배송기간 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
							</div>
						</div>
					</div>
					<div class="reward-tab">
						<input id="reward-two" type="checkbox" name="tabs"> <label
							for="reward-two">리워드2</label>
						<div class="reward-tab-content">
							<div class="reward-tab-imagebox">
								<img src="img/wadiz.jpg" id="" class="reward-tab-img">
							</div>
							<div class="reward-tab-contentsbox">
								<div>
									<span>설명 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
								<div>
									<span>남은수량 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
								<div>
									<span>옵션 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
								<div>
									<span>배송료 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
								<div>
									<span>배송기간 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
							</div>
						</div>
					</div>
					<div class="reward-tab">
						<input id="reward-three" type="checkbox" name="tabs"> <label
							for="reward-three">리워드3</label>
						<div class="reward-tab-content">
							<div class="reward-tab-imagebox">
								<img src="img/wadiz.jpg" id="" class="reward-tab-img">
							</div>
							<div class="reward-tab-contentsbox">
								<div>
									<span>설명 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
								<div>
									<span>남은수량 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
								<div>
									<span>옵션 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
								<div>
									<span>배송료 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
								<div>
									<span>배송기간 :</span> ㅁㅇㄴㅁㅇㅁㅁㅇㄹㄴㅇㄹㄴㄹㅇㅁㄻㅇ
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>



		</div>


	</div>
	</div>

	<jsp:include page="Header.jsp"></jsp:include>
</body>
</html>
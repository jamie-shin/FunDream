<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		var key ="<%=request.getParameter("keyword")%>";
		var keyword = "";
		if(key !=null){
			keyword="<%=request.getParameter("keyword")%>";
		}
		var ct_index ="";
		if(<%=request.getParameter("ct_index")%>!=null){
			ct_index="<%=request.getParameter("ct_index")%>";
		}
		var sort = "";
		if(<%=request.getParameter("sort")%>!=null){
			sort="<%=request.getParameter("sort")%>";
		}
		var num = parseInt($('#num').val());
		var option = "";
		
		
		$('#moreproject').on('click', function(){
			if($('#cbcb1').siblings('#cb1').is(':checked')==true){
				option="2";
			}
			else if($('#cbcb2').siblings('#cb2').is(':checked')==true){
				option="1"
			}
			
			num +=1;
			console.log(num +"-"+keyword+"-"+ct_index+"-"+sort);
			var m_id ='${m_id}';
			var m_email = '${m_email}';
			
 			$.ajax({
				url : "more.do",
				type: 'POST',
				data : {num1 : num,
						keyword : keyword,
						option: option,
						sort :sort,
						ct_index1 : ct_index},
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
						if(option=="1"){
							if(list[i].per<100){
								html += '<h3 class="card-toggle" style="background:black; color:white">무산</h3>';
							}
							if(list[i].per>=100){
								html += '<h3 class="card-toggle" style="background:white; color:red">성공</h3>'
							}
						}
						if(sort=='2' && gap > 30000){
							html += '<h3 class="card-toggle" style="background:red; color:white hidden="hidden">마감임박</h3>';
						}
						if(sort=='2' && gap <= 30000){
							html += '<h3 class="card-toggle" style="background:red; color:white>마감임박</h3>';
						}
						
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
					if(option=='2'){$('#cards_on').append(html);}
					if(option=='1'){$('#append').append(html);}
					$('#num').val(num);
					if(data.code == "empty"){
						$('#moreproject').hide();
					}
				},
				error : function(){
					console.log("실패");
				}
			}); 
			
		});
		
		
		$('#sort').on('change', function(){
			var sort = $(this).val();
			var keyword = "<%=request.getParameter("keyword")%>";
			if (keyword == null || keyword =="" || keyword=="null") {
				location.href = "JJS_FORM.do?sort=" + sort ;
			}
			else if(keyword !=null || keyword !="" ){
				location.href="JJS_FORM.do?sort="+sort+"&keyword="+keyword;
			}
		});
		
		$('#cb1').on('change', function(){
			if($('#cbcb1').siblings('#cb1').is(':checked')==true){
				option="2";
			}
			else if($('#cbcb2').siblings('#cb2').is(':checked')==true){
				option="1"
			}
			console.log("옵션:"+option);
			
		
			if(option=='2'){
				$('#all').show();
				$('#cards_on').show();
				$('#append').empty();
			}
			
			else if(option=='1'){
				$('#all').show();
				$('#cards_on').hide();
				$('#append').show();
			}
		});
		
		$('#cb2').on('change', function(){
			if($('#cbcb1').siblings('#cb1').is(':checked')==true){
				option="2";
			}
			else if($('#cbcb2').siblings('#cb2').is(':checked')==true){
				option="1"
			}
			console.log("옵션:"+option);
			
			var html='';
			var m_id ='${m_id}';
			var m_email = '${m_email}';
			if(option =="1"){
				$.ajax({
					url : "more.do",
					type: 'POST',
					data : {option: option,
							num1 : num,
							keyword : keyword,
							sort :sort,
							ct_index1 : ct_index},
					dataType : 'json',
					success : function(data){
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
							if(list[i].per<100){
								html += '<h3 class="card-toggle" style="background:black; color:white">무산</h3>';
							}
							if(list[i].per>=100){
								html += '<h3 class="card-toggle" style="background:white; color:red">성공</h3>'
							}
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
							//html += '</div>';
						}
						$('#append').append(html);
						$('#cards_on').hide();
						$('#num').val(num);
						if(data.code == "empty"){
							$('#moreproject').hide();
						}
					},
					error : function(){
						console.log("실패");
					}
				});
			}
 			else{
				$('#append').hide();
				$('#append').empty();
			} 
		});
	});
</script>
</head>
<body>
<div class="mcontainer">
		<div class="ct-container">
			<div class="JJS-search">
				<c:if test="${param.keyword != null}"><h1>"${param.keyword}" (으)로 검색된 결과 </h1>
				<a href = 'JJS_FORM.do?sort=1'>검색 전으로 돌아가기</a></c:if>
			</div>
		  <ul>
	        <li><a class="ct-menu" href='JJS_FORM.do?sort=${param.sort }<c:if test="${param.keyword != null}">&keyword=${param.keyword}</c:if>'>전체</a>
		  <c:forEach var="ct" items="${cList }" varStatus="status">
	        <li><a style="cursor:pointer" class="ct-menu" id="ctName" href="JJS_FORM.do?sort=${param.sort }&ct_index=${ct.ct_index}<c:if test="${param.keyword != null}">&keyword=${param.keyword}</c:if>">${ct.ct_name}</a><input type="hidden" value="${ct.ct_index }" name="ct_index" id="ct_index"></li>
	      </c:forEach>
		  </ul>
		</div>
		<div class="">
			<div class="ct-select">
			  <select class="ct-select-box" name="sort" id="sort" >
			    <option value="1" <c:if test="${param.sort==1 }">selected</c:if>>최신순</option>
			    <option value="2" <c:if test="${param.sort==2 }">selected</c:if>>마감임박순</option>
			    <option value="3" <c:if test="${param.sort==3 }">selected</c:if>>목표달성율순</option>
			    <!-- <option>추천순</option>
			    <option>인기순</option> -->
			  </select>
	
			</div>
		
			<div class="right-on-page" id="check">
			  <input type="radio" name="cb" id="cb1" checked="checked"/>
			  <label for="cb1" id="cbcb1">진행중</label>
			  <input type="radio" name="cb" id="cb2" />
			  <label for="cb2" id="cbcb2">마감</label>
			</div>
		
	<div id="all">
	
	<div class="cards" id="cards_on">
	
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
				<small class="card-part">${list.p_count}명 참여</small>
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
			</c:forEach>
		</div>
		<div class="cards" id="append"></div>
		</div>
		
		<div class="jjs-morebtn">
			<button id="moreproject" <c:if test="${fn:length(list) <9}">hidden="hidden"</c:if>>더보기</button>
			<!-- 검색후 동적생성된 마감 list를 못 읽어옴 -> 진행중인 리스트 갯수가 9개 미만이면 더보기 버튼이 안나옴 -->
			<input type="hidden" id="num" value="0">
		</div>
	</div>



<jsp:include page="Header.jsp"/>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$(document).find('#search_type').on('change', function(){
			var search_type_val = $(this).val();
			switch(search_type_val){
			case "1":
				$(this).siblings('#sc_vd_type').attr('style', 'display: none;');
				$(this).siblings('#sc_mg_type').removeAttr('style');
				break;
			case "2":
				$(this).siblings('#sc_mg_type').attr('style', 'display: none;');
				$(this).siblings('#sc_vd_type').removeAttr('style');
				break;
			default:
				$(this).siblings('#sc_mg_type').attr('style', 'display: none;');
				$(this).siblings('#sc_vd_type').attr('style', 'display: none;');
				var html = '<div class="row header"><div class="cell">회원아이디</div><div class="cell">회원이름</div>	<div class="cell">회원이메일</div><div class="cell">관리자여부</div><div class="cell">활동여부</div><div class="cell">신고여부</div></div>';
				$.ajax({
					url : "IMS_ALLMEMBERS.do",
					type : "POST",
					dataType : "json",
					success : function(data){
						resultMap = data.resultMap;
						if(resultMap != ""){
							for(var i = 0; i < resultMap.length; i++){
								html += '<div class="row" id="sel_m">';
								html += '<div class="cell" data-title="회원아이디" id="id_cell">';
							   	html += '<p class="text-p" id="m_id">'+ resultMap[i].m_id + '</p>';
							    html += '</div>';	
							    html += '<div class="cell" data-title="회원이름">';
							    html += '<p class="text-p">' + resultMap[i].m_name + '</p>';
							    html += '</div>';
							    html += '<div class="cell" data-title="회원이메일">';
							    html += '<p class="text-p">'+ resultMap[i].m_email + '</p>';
							    html += '</div>';
							    html += '<div class="cell" data-title="관리자여부">';
							    switch(resultMap[i].m_manager){
							    case 1: 
							    	html += 'O';
							    	break;
							    case 2:
							    	html += 'X';
							    	break;
							    }
								html += '</div>';
								html += '<div class="cell" data-title="활동여부">';					      	
							    switch(resultMap[i].m_valid){
							    case 1:
							    	html += '활동중';
							    	break;
							    case 2:
							    	html += '탈퇴';
							    	break;
							    case 3:
							    	html += '이용정지';
							    	break;
							    }
							    html += '</div>';
							    html += '<div class="cell" data-title="신고여부">';  				      	
							    html += '<a href="" class="IMS-bomb"><i class="fa fa-bomb"></i></a><a href="" class="IMS-bomb"><i class="fa fa-bomb"></i></a>';
								html += '</div>';					      		
							    html += '</div>';
							}
						}
						$('#list').empty();
						$('#list').append(html);
					},
					error : function(){
						alert("검색 결과 에러!");
					}
				});
				break;				
			}
		});
		
		$(document).find("#sc_mg_type").on('change', function(){
			var resultMap = "";
			var sc_mg_type = $(this).val();
			var keyword = $('#input_keyword').val();
			var html = '<div class="row header"><div class="cell">회원아이디</div><div class="cell">회원이름</div>	<div class="cell">회원이메일</div><div class="cell">관리자여부</div><div class="cell">활동여부</div><div class="cell">신고여부</div></div>';
			alert("관리자유형 " + sc_mg_type + " : " + keyword);
			
			$.ajax({
				url : "IMS_SEARCH.do",
				type : "POST",
				data : {sc_type : 1,
						sc_detail : sc_mg_type,
						keyword : keyword},
				dataType : "json",
				success : function(data){
					resultMap = data.resultMap;
					if(resultMap != ""){
						for(var i = 0; i < resultMap.length; i++){
							html += '<div class="row" id="sel_m">';
							html += '<div class="cell" data-title="회원아이디" id="id_cell">';
						   	html += '<p class="text-p" id="m_id">'+ resultMap[i].m_id + '</p>';
						    html += '</div>';	
						    html += '<div class="cell" data-title="회원이름">';
						    html += '<p class="text-p">' + resultMap[i].m_name + '</p>';
						    html += '</div>';
						    html += '<div class="cell" data-title="회원이메일">';
						    html += '<p class="text-p">'+ resultMap[i].m_email + '</p>';
						    html += '</div>';
						    html += '<div class="cell" data-title="관리자여부">';
						    switch(resultMap[i].m_manager){
						    case 1: 
						    	html += 'O';
						    	break;
						    case 2:
						    	html += 'X';
						    	break;
						    }
							html += '</div>';
							html += '<div class="cell" data-title="활동여부">';					      	
						    switch(resultMap[i].m_valid){
						    case 1:
						    	html += '활동중';
						    	break;
						    case 2:
						    	html += '탈퇴';
						    	break;
						    case 3:
						    	html += '이용정지';
						    	break;
						    }
						    html += '</div>';
						    html += '<div class="cell" data-title="신고여부">';  				      	
						    html += '<a href="" class="IMS-bomb"><i class="fa fa-bomb"></i></a><a href="" class="IMS-bomb"><i class="fa fa-bomb"></i></a>';
							html += '</div>';					      		
						    html += '</div>';
						}
					}
					$('#list').empty();
					$('#list').append(html);
				},
				error : function(){
					alert("검색 결과 에러!");
				}
			});
		});
		
		$(document).find("#sc_vd_type").on('change', function(){
			var resultMap = "";
			var sc_vd_type = $(this).val();
			var keyword = $('#input_keyword').val();
			var html = '<div class="row header"><div class="cell">회원아이디</div><div class="cell">회원이름</div>	<div class="cell">회원이메일</div><div class="cell">관리자여부</div><div class="cell">활동여부</div><div class="cell">신고여부</div></div>';
			alert("활동유형 " + sc_vd_type + " : " + keyword);
			
			$.ajax({
				url : "IMS_SEARCH.do",
				type : "POST",
				data : {sc_type : 2,
						sc_detail : sc_vd_type,
						keyword : keyword},
				dataType : "json",
				success : function(data){
					resultMap = data.resultMap;
					if(resultMap != ""){
						for(var i = 0; i < resultMap.length; i++){
							html += '<div class="row" id="sel_m">';
							html += '<div class="cell" data-title="회원아이디" id="id_cell">';
						   	html += '<p class="text-p" id="m_id">'+ resultMap[i].m_id + '</p>';
						    html += '</div>';	
						    html += '<div class="cell" data-title="회원이름">';
						    html += '<p class="text-p">' + resultMap[i].m_name + '</p>';
						    html += '</div>';
						    html += '<div class="cell" data-title="회원이메일">';
						    html += '<p class="text-p">'+ resultMap[i].m_email + '</p>';
						    html += '</div>';
						    html += '<div class="cell" data-title="관리자여부">';
						    switch(resultMap[i].m_manager){
						    case 1: 
						    	html += 'O';
						    	break;
						    case 2:
						    	html += 'X';
						    	break;
						    }
							html += '</div>';
							html += '<div class="cell" data-title="활동여부">';					      	
						    switch(resultMap[i].m_valid){
						    case 1:
						    	html += '활동중';
						    	break;
						    case 2:
						    	html += '탈퇴';
						    	break;
						    case 3:
						    	html += '이용정지';
						    	break;
						    }
						    html += '</div>';
						    html += '<div class="cell" data-title="신고여부">';  				      	
						    html += '<a href="" class="IMS-bomb"><i class="fa fa-bomb"></i></a><a href="" class="IMS-bomb"><i class="fa fa-bomb"></i></a>';
							html += '</div>';					      		
						    html += '</div>';
						}
					}
					$('#list').empty();
					$('#list').append(html);
				},
				error : function(){
					alert("검색 결과 에러!");
				}
			});
		});
		
		$(document).find('#searchBtn').on('click', function(){
			var resultMap = "";
			var sc_type = $('#search_type').val();
			var sc_detail = 0;
			switch(sc_type){
			case 1: 			
				sc_detail = $('#sc_mg_type').val();
				break;
			case 2:
				sc_detail = $('#sc_vd_type').val();
				break;
			default:
				sc_type = 0;
				sc_detail = 0;
				break;
			}
			var keyword = $('#input_keyword').val();
			var html = '<div class="row header"><div class="cell">회원아이디</div><div class="cell">회원이름</div>	<div class="cell">회원이메일</div><div class="cell">관리자여부</div><div class="cell">활동여부</div><div class="cell">신고여부</div></div>';
			$.ajax({
				url : "IMS_SEARCH.do",
				type : "POST",
				data : {sc_type : sc_type,
						sc_detail : sc_detail,
						keyword : keyword},
				dataType : "json",
				success : function(data){
					resultMap = data.resultMap;
 					if(resultMap != ""){
						for(var j = 0; j < resultMap.length; j++){
							html += '<div class="row" id="sel_m">';
							html += '<div class="cell" data-title="회원아이디" id="id_cell">';
						   	html += '<p class="text-p" id="m_id">' + resultMap[j].m_id + '</p>';
						    html += '</div>';	
						    html += '<div class="cell" data-title="회원이름">';
						    html += '<p class="text-p">' + resultMap[j].m_name + '</p>';
						    html += '</div>';
						    html += '<div class="cell" data-title="회원이메일">';
						    html += '<p class="text-p">'+ resultMap[j].m_email + '</p>';
						    html += '</div>';
						    html += '<div class="cell" data-title="관리자여부">';
						    switch(resultMap[j].m_manager){
						    case 1: 
						    	html += 'O';
						    	break;
						    case 2:
						    	html += 'X';
						    	break;
						    }
							html += '</div>';
							html += '<div class="cell" data-title="활동여부">';					      	
						    switch(resultMap[j].m_valid){
						    case 1:
						    	html += '활동중';
						    	break;
						    case 2:
						    	html += '탈퇴';
						    	break;
						    case 3:
						    	html += '이용정지';
						    	break;
						    }
						    html += '</div>';
						    html += '<div class="cell" data-title="신고여부">';  				      	
						    html += '<a href="" class="IMS-bomb"><i class="fa fa-bomb"></i></a><a href="" class="IMS-bomb"><i class="fa fa-bomb"></i></a>';
							html += '</div>';					      		
						    html += '</div>';
						} 
 					}
					$('#list').empty();
					$('#list').append(html);
				},
				error : function(){
					alert("키워드 검색 결과 에러!");
				}
			});
		});
		
		$(document).on('click', '[class=row]' ,function(){
			var m_id = $(this).children('#id_cell').children('#m_id').text();
			alert("아이디 : " + m_id);
			location.href = "IMS_DETAILFORM.do?m_id_str=" + m_id;
		});
	});
</script>
<head>
<meta charset="UTF-8">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/IMS_LISTFORM.css">
<title>FunDream</title>
</head>
<body class="IMS-body">
	<div class="IMS-container">
		<div class="IMS-title"><h1>회원목록</h1></div>	<br>
			<div class="IMS-flexbox">
				<div class="IMS-flexbox-left">
					<div class="IMS-searchbox">
						<select class="IMS-searchbox-select" name="search_type" id="search_type">
							<option value="0">전체</option>
							<option value="1">관리자 여부</option>
							<option value="2">활동 여부</option>
						</select>
						<select class="IMS-searchbox-select" name="sc_mg_type" id="sc_mg_type" style="display: none;">
							<option value="1">관리자</option>
							<option value="2">일반회원</option>
						</select>
						<select class="IMS-searchbox-select" name="sc_vd_type" id="sc_vd_type" style="display: none;">
							<option value="1">활동중</option>
							<option value="2">탈퇴</option>
							<option value="3">이용정지</option>
						</select>
					</div>
				</div>
				<div class="IMS-flexbox-right" id="searchBox">
					<span class="IMS-search" id="searchTextBox">
						<input type="text" name="" class="IMS-searchbox-text" placeholder="이메일 또는 이름을 입력하세요." id="input_keyword"><button style="background: none; border: none;" id="searchBtn"><i class="fa fa-search"></i></button>
					</span>
				</div>
			</div>
		<div class="wrapper">
			<div class="table" id="list">
				<div class="row header">
					<div class="cell">회원아이디</div>
		      		<div class="cell">회원이름</div>
					<div class="cell">회원이메일</div>
		      		<div class="cell">관리자여부</div>
		      		<div class="cell">활동여부</div>
		      		<div class="cell">신고여부</div>
				</div>
				
				<c:forEach items="${memberList}" var="member">
				    <div class="row" id="sel_m">
				    	<div class="cell" data-title="회원아이디" id="id_cell">
				    		<p class="text-p" id="m_id">${member.m_id}</p>
				      	</div>
				    	<div class="cell" data-title="회원이름">
				    		<p class="text-p" id="m_id">${member.m_name}</a>
				      	</div>
				    	<div class="cell" data-title="회원이메일">
				    		<p class="text-p">${member.m_email}</p>
				      	</div>
				      	<div class="cell" data-title="관리자여부">
					      	<c:if test="${member.m_manager == 1}">O</c:if>
					      	<c:if test="${member.m_manager == 2}">X</c:if>
				      	</div>
				      	<div class="cell" data-title="활동여부">
				      		<c:if test="${member.m_valid == 1}">활동중</c:if>
				      		<c:if test="${member.m_valid == 2}">탈퇴</c:if>
				      		<c:if test="${member.m_valid == 3}">이용정지</c:if>
				      	</div>
				      	<div class="cell" data-title="신고여부">
				      		<a href="" class="IMS-bomb"><i class="fa fa-bomb"></i></a><a href="" class="IMS-bomb"><i class="fa fa-bomb"></i></a>
				      	</div>
				    </div>
				</c:forEach>
		    </div>
		</div>
		<div class="IMS-btncenter">
			<input type="button" class="IMS-plus-btn" value="더보기">
		</div>
	</div>
	<jsp:include page="Header.jsp" />
</body>
</html>
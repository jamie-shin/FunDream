<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1.0">
<title>header</title>
<link rel="stylesheet" type="text/css" href="css/Header.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<script type="text/javascript">
		var sessionEmail = "<%=session.getAttribute("m_email")%>";
		function checkProject(){
			$.ajax({
				url : "JJS.do",
				data : {m_email : sessionEmail},
				success : function(data){
					console.log(data);
					switch(data){
					case true :
						var moveModiProj = confirm("진행중인 프로젝트가 존재합니다. 새로운 프로젝트를 생성을 원하시면 확인, 진행중인 프로젝트의 수정을 원하시면 취소를 선택하세요.");
						if(moveModiProj == true) location.href = "JJI.do";  // 새로운 프로젝트 생성 선택
						else location.href = "MJS.do";  // 기존 프로젝트 수정 선택
						break;
					case false :
						var createNewProj = confirm("새로운 프로젝트를 생성하시겠습니까?");
						if(createNewProj == true) location.href = "JJI.do";  // 새로운 프로젝트 생성 선택
						break;
					}
				},
				error : function(){
					console.log("에러입니다.");
				}
			});
		}
</script>
<script>
<%=session.getAttribute("keyword")%>
$(function(){
	$(document).find("#submitBtn").on('click', function(){
		var keyword = $("#keyword").val();
		alert(keyword);
		if (keyword==null || keyword ==""){
			alert("입력된 검색어가 없습니다.");
			return false;
		}
		$("#keyword").val(keyword);
		return true;
		
	});
});
</script>
<script type="text/javascript">
	var sessionId = "<%=session.getAttribute("m_id")%>";
	$(function(){
		$.ajax({
			url : "checkProject.do",
			data : {m_id : sessionId},
			success : function(data){
				if(data != "1"){
					$(document).find('#myProject').attr("style", "display: none;");
				}
			}
		});
		$.ajax({
			url : "FundCheck.do",
			data : {m_id : sessionId},
			success : function(data){
				if(data != "have"){
					$(document).find('#myFund').attr("style", "display: none;");
				}
			}
		});
	});
</script>
</head>
<body class="hbody">
	<header class="FD-header">
		<div class="Hlogo"><a href="MAIN.do">FunDream</a></div>
		<nav>
			<ul>
				<li><a href="JJS_FORM.do?sort=1">프로젝트</a></li>
				<li class="sub-menu"><a href="#">이용안내</a>
					<ul>
						<li><a href="#">공지사항</a></li>
						<li><a href="#">문의사항</a></li>
						<li><a href="#">이용가이드</a></li>
						<li><a href="#">이벤트</a></li>
					</ul>
				</li>
				<c:if test="${(m_manager != 1 && m_email!=null)}"><li><a id="createNewProjBtn" onclick="checkProject()">신규프로젝트신청</a></li></c:if> <!-- 0829(주리) - 클릭 경로 / 조건(|| m_email==null 삭제) 수정 및 아이디 추가(0830) -->
				<c:if test="${m_manager == 1 && m_email !=null}"><li><a href="IBE_MANAGER.do">관리자 메인</a></li></c:if>
				<li> <c:if test="${m_email==null}"> <a href="MIE_LOGINFORM.do"><img src="img/user.png" style="margin:0; margin-top:8px; padding:0; width:35px; height:35px;"></a></c:if> </li>
				
				<li><c:if test="${m_email!=null}"><img src="${m_img}" style="margin:0; margin-top:8px; padding:0; width:35px; height:35px; border-radius: 50%">
					<ul>
						<li><a href="MUE_CHECKPW.do">내 정보 수정</a></li>
						<c:if test="${m_manager != 1 && m_email !=null}">
						<li><a href="#">관심 프로젝트</a></li>
						<li id="myFund"><a href="MS_MYFUND.do">내가 후원한 내역</a></li>
						<li id="myProject"><a href="MJS.do">내 프로젝트 관리</a></li>
						</c:if>
						<li><a href="MOE.do">로그아웃</a></li>
					</ul>
				</c:if>	
				</li>
				
				<li><div class="search-container">
					<form action="JJS_FORM.do">
					<input type="hidden" name="sort" value="1">
						<input type="text" name="keyword" id="keyword" placeholder="Search" <c:if test="${param.keyword != null}">value="${param.keyword}"</c:if>>
						<button type="submit" id="submitBtn"><i class="fa fa-search"></i></button>
					</form></div></li>
			</ul>
		</nav>
		<div class="FD-menu-toggle"><i class="fa fa-bars" aria-hidden="true"></i></div>
	</header>
	<script type="text/javascript">
		$(document).ready(function(){
			$('.FD-menu-toggle').click(function(){
				$('nav').toggleClass('active')
			})
			$('ul li').click(function(){
				$(this).siblings().removeClass('active');
				$(this).toggleClass('active');
			})
		})
	</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>makeProject</title>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.js"></script>
<link rel="stylesheet" type="text/css" href="css/projectView.css">
<!-- <script type="text/javascript" src="js/projectView.js"></script> -->
 

<script>
$(function() {
	
	
	var m_id = <%=request.getParameter("m_id")%>;
	var p_index =<%=request.getParameter("p_index")%>;
	
	var type = "";
	var c_index =0;
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
     
     
     //댓글 입력 버튼 클릭시
    $('#inputComment').on('click', function(){
    	type = $(this).siblings('#type').val();
    	if ( type=='none'){
    		if (confirm("로그인이 필요합니다. 로그인페이지로 이동하시겠습니까?")==true){
    			location.href="MIE_LOGINFORM.do";
    		}
    	}
    });
     
    $(document).on('click','#newComment', function(){
    	var contents = $(this).parent().siblings('#inputComment').val();
    	var m_id = <%=request.getParameter("m_id")%>;
    	var p_index =<%=request.getParameter("p_index")%>;
    	alert(contents);
    	if (contents == null || contents==''){
    		alert('입력된 값이 없습니다.');
    	}
    	else{
	    	if(contents !=null || contents!=''){
	    		$.ajax({
	    			url : "JCI_COMMENT.do",
	    			type : "POST",
	    			data : {contents: contents,
	    					m_id : m_id,
	    					p_index : p_index},
	    			success: function(){
	    				alert("댓글이 입력되었습니다. '프로젝트 스토리'로 이동합니다.");
	    				//location.href='JPS_DETAIL.do?p_index='+p_index+'&m_id='+m_id+'#3';
	    				location.reload();
	    			},
	    			error: function(request,status,error){
	    				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    			}
	    		});
	    	}
    	}
    });
    
    $('[id^=updateComment').on('click', function(){
    	var index = $(this).val();
    	console.log("댓글 번호"+index);
    	var html ='';
    	html += '<button class="pv-comment-modbtn" id="updateCommentBtn">저장</button>';
    	$(this).parent().parent().siblings('[id^=comment]').attr('disabled', false);
    	$(this).parent().parent().siblings('[id^=comment]').attr('style', 'border:1px solid darkgray');
    	
    	$(this).parent('#buttonBox').hide();
    	$(this).parent().siblings('#newbutton').append(html);
    	
    });
    
    $(document).on('click', '#updateCommentBtn', function(){
	    var updatedComment=	$(this).parent().parent().siblings('[id^=comment]').val();
    	c_index = $(this).parent().parent().parent().parent().siblings('.commentIndex').val();
    	
    	if (updatedComment == null || updatedComment==''){
    		alert('입력된 값이 없습니다.');
    	}
    	else{
	    	if(updatedComment !=null || updatedComment!=''){
	    		$.ajax({
	    			url : "JCU_COMMENT.do",
	    			type : "POST",
	    			data :{contents : updatedComment,
	    					c_index : c_index},
	    			success: function(){
	    				alert("댓글이 수정되었습니다. '프로젝트 스토리'로 이동합니다.");
	    				location.reload();
	    				
	    			},
	    			error: function(){
	    				console.log("oh no");
	    			}
	    		});
	    	}
    	}
	    			
    });
    
    $('[id^=deleteComment]').on('click', function(){
    	var index = $(this).val();
    	//alert("댓글 번호"+index);
    	
    	if(confirm('댓글을 삭제하시겠습니까?')==true){
    		$.ajax({
    			url : "JCD_COMMENT.do",
    			type : "POST",
    			data : {c_index : index},
    			success: function(){
    				alert("댓글이 삭제되었습니다. '프로젝트 스토리'로 이동합니다.");
    				location.reload();
    			},
    			error: function(){
    				console.log("oh no");
    			}
    		});
    	}
    	
    });
    
    $('[id^=replyContents]').on('click', function(){
    	var html ='';
    	html +='<br><div class="pv-comment-box">';
    	html += '<textarea class="pv-comment-textarea" maxlength="200" id="replyComment"></textarea>';
    	html += '<div class="pv-comment-right">';
    	html += '<input type="button" class="pv-comment-addbtn" id="newReplyComment" value="입력"></div>';
    	html +='</div>';
    	$('#replyBox').append(html);
    	c_index =$(this).siblings('#commentIndex').val();
    });
    
    $(document).on('click','#newReplyComment', function(){
    	var c_re_con = $(this).parent().siblings('#replyComment').val();
    	console.log(c_re_con);
    	c_index =$(this).parent().parent().parent().parent().siblings('.commentIndex').val();
    	console.log(c_index);
    	if (c_re_con == null || c_re_con==''){
    		alert('입력된 값이 없습니다.');
    	}
    	else if(c_re_con !=null || c_re_con!=''){
    		$.ajax({
    			url : "JCI_REPLY.do",
    			type : "POST",
    			data : {c_re_con: c_re_con,
    					c_index: c_index},
    			dataType : 'json',
    			success: function(){
    				alert("답글이 입력되었습니다. '프로젝트 스토리'로 이동합니다.");
    				location.reload();
    			},
    			error: function(){
    				console.log("oh no");
    			}
    		});
    	} 
    });
    
    $('#deleteReply').on('click', function(){
    	var index = $(this).val();
	  	if(confirm('답글을 삭제하시겠습니까?')==true){
	  		$.ajax({
	  			url : "JCD_REPLY.do",
	  			type : "POST",
	  			data : {c_index : index},
	  			success: function(){
	  				alert("답글이 삭제되었습니다. '프로젝트 스토리'로 이동합니다.");
	  				location.reload();
				},
				error: function(){
					console.log("oh no");
				}
	  		});
	  	}
  	});
    
    $('#updateReply').on('click', function(){
    	var index = $(this).val();
    	var html ='';
    	html += '<button class="pv-comment-modbtn" id="replyUpdateBtn">저장</button>';
    	$(this).parent().parent().siblings('[id^=reply]').attr('disabled', false);
    	$(this).parent().parent().siblings('[id^=reply]').attr('style', 'border:1px solid darkgray');
    	
    	$(this).parent('#buttonBoxR').hide();
    	$(this).parent().siblings('#newbuttonR').append(html);
    });
    
    $(document).on('click', '#replyUpdateBtn', function(){
    	console.log('수정버튼');
    	var updatedReply = $(this).parent().parent().siblings('[id^=reply]').val();
    	var c_index = $(this).parent().parent().parent().parent().siblings('.commentIndex').val();
    	$.ajax({
    		url: "JCU_REPLY.do",
    		type : "POST",
    		data:{c_re_con: updatedReply,
    			c_index: c_index},
    			success: function(){
	  				alert("답글이 수정되었습니다. '프로젝트 스토리'로 이동합니다.");
	  				location.reload();
				},
				error: function(){
					console.log("oh no");
				}
    	});
    });
    
    //후원하기 버튼 누를시
    $('#FundBtn').on('click',function(){
	   	var data ={};
	   	var type = "${type}";
	   	data["p_index"]=$('#p_index').val();
	   	data["m_id"]=$('#m_id').val();
	   	var p_index = $('#p_index').val();
	   	if(type=='none'){
	   		var con = confirm("로그인이 필요합니다. 로그인창으로 이동하시겠습니까?");
	   		if(con==true){
	   			location.href="MIE_LOGINFORM.do";
	   		}
	   	}
	   	else{
	   		$.ajax({
	   			contentType: 'application/json',
				processData: false,
				url : "checkFund.do",
				type : 'POST',
				data : JSON.stringify(data),
				dataType : 'json',
				success : function(data){
					console.log(data.msg);
					if(data.msg=="able"){
						location.href="JFI_FORM.do?p_index="+p_index;
					}
					else if(data.msg=="unable"){
			    		var con2= confirm("이미 이 프로젝트에 후원하셨습니다. 후원목록으로 이동하시겠습니까?");
						if(con2==true){
							location.href="MS_MYFUND.do";
						}
					}
				},
				error : function(){
					console.log("실패");
				}
	   		});
	   	}
    });
	
    $('#item04').on('click',function(){
    	var total = 0;
    	var per=0;
    	for(var i=0;i<$("[id^=amt]").length;i++){
    		total += Number($('#amt'+i).html());
    	}
    	for(var i=0;i<$("[id^=amt]").length;i++){
    		 per= Number($('#amt'+i).html())/total*100;
    		 $('#per'+i).val(per.toFixed(1));
    		 $('#v_per'+i).html(per.toFixed(1));
    	}
    });
});
</script>
</head>
<body>
	<div class="pv-banner-image"
		style="background-image: url(${project.p_mainimg})">
		<h1 class="pv-banner-text">${project.p_name}${type}</h1>
	</div>

	<input type="hidden" id="m_id" value="<%=session.getAttribute("m_id")%>">
	<input type="hidden" id="p_index" value="${project.p_index}">

	<div class="pv-container">
		<div class="pv-main">
			<input id="item01" type="radio" name="tab" checked="checked" >
			<input id="item02" type="radio" name="tab" >
			<input id="item03" type="radio" name="tab" >
			<input id="item04" type="radio" name="tab">
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

				<li class="pv-contents-list item01">
				<div>프로젝트 진행기간: ${project.p_startdate } ~ ${project.p_enddate }</div>
				<div>${project.p_contents}</div>

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
			<div id="reload">
					<div id="notice">

						<h2>공지사항</h2>
						<div class="pv-notice-right">
						
							<c:if test="${type eq 'producer'}">
								<input type="button" value="새 공지사항 등록" class="pv-new-noticebtn" id="insert_notice">
							</c:if>
						</div>
						<!--  공지사항이 있을때만 보이기 -->
						<c:if test="${notice !=null }">
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
							</div>
						</div>
						</c:if>
						<h2>댓글</h2>
						<c:if test="${type eq 'none' ||type eq 'normal'}"> 
						<div class="pv-comment-box">
							<input type="hidden" value="${type }" id='type'>
							
								<textarea class="pv-comment-textarea" maxlength="200"
								placeholder="저작권 등 다른 사람의 권리를 침해하거나 명예를 훼손하는 게시물은 관련 법률에 의해 제재를 받을 수 있습니다." id="inputComment"></textarea>
							
							<div class="pv-comment-right">
								<span id="counter">###</span> &emsp;<input type="button" class="pv-comment-addbtn" id="newComment"
									value="입력">
							</div>
							
						</div>
						</c:if>
						<br> <br>
						<!-- 작성된 댓글들이 들어갈 가장 큰 컨테이너div -->
					
						<!-- 댓글이 있을때만 보이기-->
						<c:if test="${commentList !=null }">
						<c:forEach var="comment" items="${commentList}" varStatus="status">
						<div class="pv-comment-cards">
						<input type="hidden" value="${comment.c_index}" class="commentIndex">
						<div class="pv-comment-card">
							<!-- 댓글로 작성된 카드 -->
							<div id="replyBox">
								<div class="pv-comment-card-1">
									<div class="pv-comment-topleft" <c:if test="${comment.c_contents=='삭제된 댓글입니다' || comment.c_contents =='관리자에 의해 삭제된 댓글입니다'}">style="display: none"</c:if>>${comment.m_nick}</div>
									<div class="pv-comment-topright" <c:if test="${comment.c_contents=='삭제된 댓글입니다'  || comment.c_contents =='관리자에 의해 삭제된 댓글입니다'}">style="display: none"</c:if>>${comment.c_writedate }</div>
								</div>
								<textarea class="pv-comment-contents" id="comment${comment.c_index}" disabled>${comment.c_contents}</textarea>
								<div class="pv-comment-btnbox">
									<div id='newbutton'></div>
								<div id='buttonBox'>
									<c:if test="${comment.m_id == m_id && comment.c_contents!='삭제된 댓글입니다'  || comment.c_contents =='관리자에 의해 삭제된 댓글입니다'}">
									<button class="pv-comment-modbtn" id="updateComment${comment.c_index}" value="${comment.c_index}">수정</button>
									<button class="pv-comment-delbtn" id="deleteComment${comment.c_index}" value="${comment.c_index}">삭제</button>
									</c:if>
								
									<c:if test="${type eq 'producer'}">
									<button onclick="window.open('http://localhost:8080/FunDream/JCE_REPORTFORM.do?c_index=${comment.c_index}&p_index=${comment.p_index}', 
										'댓글 신고하기', 'width=500, height=420')" class="pv-comment-decbtn" id="report${comment.c_index}" value="${comment.c_index}" 
										<c:if test="${comment.c_status!=1 }">hidden='hidden'</c:if>>신고
									</button>
									</c:if>
									<c:if test="${type eq 'producer' || type eq 'manager' }">
									<button <c:if test="${comment.c_re_con !=null }">hidden="hidden"</c:if> class="pv-comment-recbtn" id="replyContents${comment.c_index}" value="${comment.c_index}" <c:if test="${comment.c_status!=1 }">hidden='hidden'</c:if>>답글</button>
									<c:if test="${comment.c_status ==2 }"><small >관리자에게 신고된 댓글</small></c:if>
									<c:if test="${comment.c_status ==3 }"><small >신고처리 완료</small></c:if>
									</c:if>
								</div>
							</div>
						</div>
							
							
							<!--답글이 있을때만 보이기  -->
							
							<div class="pv-comment-recommentcard" <c:if test="${comment.c_re_con == null || comment.c_re_con == '' }">style="display:none"</c:if>>
								<!-- 답글 카드 -->
									<div class="pv-comment-card-1">
										<div class="pv-comment-topleft">└ ${m.m_nick}</div>
										<div class="pv-comment-topright">${comment.c_re_writedate}</div>
									</div>
									<textarea class="pv-comment-contents" disabled id="reply${comment.c_index}">${comment.c_re_con }</textarea>
									<c:if test="${type eq 'producer'}">
									<div class="pv-comment-btnbox">
										<div id='newbuttonR'></div>
										<div id='buttonBoxR'>
										<button  class="pv-comment-modbtn" id="updateReply" value="${comment.c_index }">수정</button>
										<button class="pv-comment-delbtn" id="deleteReply" value="${comment.c_index }">삭제</button>
									</div>
									</div>
									</c:if>
							</div>
							
						</div>
						</div>
						</c:forEach>
						</c:if>
					


					</div>
					<div class="pv-creator-notice-crebox" id="write_notice" style="display: none;">
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
										<div class="cell" data-title="총원">${fund_pop}</div>
										<div class="cell" data-title="총금액">${total_fund}원</div>
									</div>
								</div>
							</div>
							<br> <br>

							<!-- 그래프1  -->
							<h2>성별 신청현황</h2>
							<br>
							<div class="grid">
								<section class="pv-circle-section">
									<svg class="circle-chart" viewbox="0 0 33.83098862 33.83098862"
										width="150" height="150" xmlns="http://www.w3.org/2000/svg">
							      <circle class="circle-chart__background" stroke="#efefef"
											stroke-width="2" fill="none" cx="16.91549431"
											cy="16.91549431" r="15.91549431" />
							      <circle class="circle-chart__circle" stroke="#00acc1"
											stroke-width="2" stroke-dasharray='${param_per["m_per"]},100'
											stroke-linecap="round" fill="none" cx="16.91549431"
											cy="16.91549431" r="15.91549431" />
							      <g class="circle-chart__info">
							        <text class="circle-chart__percent" x="16.91549431"
											y="15.5" alignment-baseline="central" text-anchor="middle"
											font-size="8">남자</text>
							        <text class="circle-chart__subline" x="16.91549431"
											y="20.5" alignment-baseline="central" text-anchor="middle"
											font-size="3">${param_per["m_per"]} %</text>
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
											stroke-width="2" stroke-dasharray='${param_per["f_per"]},100'
											stroke-linecap="round" fill="none" cx="16.91549431"
											cy="16.91549431" r="15.91549431" />
							      <g class="circle-chart__info">
							        <text class="circle-chart__percent" x="16.91549431"
											y="15.5" alignment-baseline="central" text-anchor="middle"
											font-size="8">여자</text>
							        <text class="circle-chart__subline" x="16.91549431"
											y="20.5" alignment-baseline="central" text-anchor="middle"
											font-size="3">${param_per["f_per"]}%</text>
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
								<c:forEach items="${l}" var="l" varStatus="status">
								<li class="skill">
									<h5 class="progressbar-count">
										${l["r_name"]}<br><span id="amt${status.index}">${l["sum(fd_amt)"]}</span>개<span id="v_per${status.index}"></span>
									</h5> <progress class="skill-1" max="100" id="per${status.index}" value="">
										<strong>Skill Level: 50%</strong>
									</progress>
								</li>
							</c:forEach>
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
										<div class="cell" data-title="총원">${fund_pop}</div>
										<div class="cell" data-title="총금액">${total_fund}원</div>
									</div>
								</div>
							</div>
							<br> <br> <br>

							<!-- 배송주소 테이블 -->

							<div class="pv-sponsor-wrapper">
								<div class="sponsors-address-table">

									<div class="row header backcolor">
										<div class="cell">후원자</div>
										<div class="cell">성별</div>
										<div class="cell">리워드</div>
										<div class="cell">옵션</div>
										<div class="cell">배송지</div>
									</div>

									<!--여길 누르면  -->
								<c:forEach items="${test}" var="t">
									<div class="row">
										<div class="cell" data-title="후원자">${t[0].m_name} / ${t[0].m_nick}</div>
										<div class="cell" data-title="금액"><c:if test="${t[0].m_gender==1}">남자</c:if><c:if test="${t[0].m_gender==2}">여자</c:if> </div>
										<div class="cell" data-title="리워드">${t[0].m_phone}</div>
										<div class="cell" data-title="옵션">${t[0].m_email}</div>
										<div class="cell" data-title="배송지">${t[1].f_price}</div>
									</div>
									
								<!--여길 아코디언으로 하고 싶다  -->
									<!--배송지정보  -->
									<c:if test="${t[2] != null }">
									<div class="row header backcolor">
										<div class="cell">인수자</div>
										<div class="cell">인수자 번호</div>
										<div class="cell">우편번호</div>
										<div class="cell">주소</div>
										<div class="cell">배송옵션</div>
									</div>
									<div class="row">
										<div class="cell" data-title="후원자">${t[2].v_name}</div>
										<div class="cell" data-title="금액">${t[2].v_phone}</div>
										<div class="cell" data-title="리워드">${t[2].v_postnum}</div>
										<div class="cell" data-title="옵션">${t[2].v_add}</div>
										<div class="cell" data-title="배송지">${t[2].v_msg}</div>
									</div>
									</c:if>
									<!--펀드 디테일 정보  -->
									<c:if test="${t[3] != '[]'}">
									<div class="row header backcolor">
										<div class="cell">리워드명</div>
										<div class="cell">개수</div>
										<div class="cell">옵션</div>
									</div>
									<c:forEach items="${t[3]}" var="fd">
									<div class="row">
										<div class="cell" data-title="후원자">${fd.r_name}</div>
										<div class="cell" data-title="금액">${fd.fd_amt}</div>
										<div class="cell" data-title="리워드">${fd.fd_r_option}</div>
									</div>	
									</c:forEach>
									</c:if>
									<br>
									<br>
								</c:forEach>
								<!--여그까지 -->
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
				<input type="button" value="후원하기" class="pv-reward-btn" id="FundBtn">
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
				<c:if test="${reward != null }">
				<c:forEach items="${reward }" var="rew">
					<div class="reward-tab">
						<input id="rewardNum" value="${rew.r_index }">
						<input id="reward${rew.r_index }" type="checkbox" name="tabs"> <label
							for="reward${rew.r_index}">${rew.r_name }</label>
						<div class="reward-tab-content">
							<div class="reward-tab-imagebox">
								<img src="${rew.r_img }" id="" class="reward-tab-img">
							</div>
							<div class="reward-tab-contentsbox">
								<div>
									<span>설명 :</span> ${rew.r_contents }
								</div>
								<div <c:if test="${rew.r_amt<=-1 }">style="display: none;"</c:if>>
									<span>남은수량 :</span> ${rew.r_amt }
								</div>
								<div <c:if test="${rew.r_option== null || rew.r_option=='' }">style="display: none;"</c:if>>
									<span>옵션 :</span> ${rew.r_option }
								</div>
								
								<div <c:if test="${rew.r_del==0 }">style="display: none;"</c:if>>
									<span>배송료 :</span> ${rew.r_del }원
								</div>
								
								<div>
									<span>리워드 제공 예상 날짜 :</span>
									<br><fmt:formatDate value="${rew.r_start}" pattern="yyyy.MM.dd"/>일 경부터 발송 예정
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
				</c:if>	
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="Header.jsp"></jsp:include>
</body>
</html>
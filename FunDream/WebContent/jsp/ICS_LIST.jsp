<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunDream</title>
<link rel="stylesheet" href="css/admin-category.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">
	$(function(){
		// 수정 버튼 클릭 시
		$(document).on('click', '#modifyBtn', function(){
			$(this).parent().siblings('#ct_cell').children('#input_name').removeAttr('disabled').attr('style', 'border: 1px solid black; background: white; padding: 5px; width: 200px;').attr("onfocus", true);
			$(this).attr('style', 'display: none;');
			$(this).siblings('#deleteBtn').attr('style', 'display: none;');
			$(this).siblings('#saveBtn').removeAttr('style');
		});
		
		// 수정 버튼 클릭 후 저장 버튼 클릭 시
		$(document).on('click', '#saveBtn', function(){
			var upd_index = $(this).parent().siblings("#index_cell").children("#index").text();
			var new_name = $(this).parent().siblings('#ct_cell').children('#input_name').val();
			var modify_btn = $(this).siblings('#modifyBtn');
			var delete_btn = $(this).siblings('#deleteBtn');
			var input_name = $(this).parent().siblings('#ct_cell').children('#input_name');
			var save_btn = $(this);
			var upd_confirm = confirm("카테고리 이름을 수정하시겠습니까?");
			switch(upd_confirm){
			case true:
				//alert(upd_index);
				$.ajax({
					url : "ICU.do",
					data : {ct_index : upd_index,
							ct_name : new_name},
					success : function(data){
						switch(data){
						case "true":
							alert(upd_index + "의 카테고리 이름이 " + new_name + "으로 수정되었습니다.");
							input_name.removeAttr('style');
							modify_btn.removeAttr('style');
							delete_btn.removeAttr('style');
							save_btn.attr('style', 'display: none;');
							break;
						case "false":
							console.log("카테고리 이름 수정 실패");
							break;
						}
					},
					error : function(){
						console.log("카테고리 이름 수정 오류");
					}
				});
				break;
			}
		})
		
		// 삭제 버튼 클릭 시
		$(document).on('click', '#deleteBtn', function(){
			var del_confirm = confirm("해당 카테고리를 삭제하시겠습니까?");
			var del_index = $(this).parent().siblings("#index_cell").children("#index").text();
			var del_category = $(this).parent().parent();
			switch(del_confirm){
			case true:
				//alert(del_index);
				$.ajax({
					url : "ICD.do",
					data : {ct_index : del_index},
					success : function(data){
						switch(data){
						case "true":
							alert(del_index + "번의 카테고리 삭제가 완료되었습니다.");
							del_category.remove();
							break;
						case "false":
							console.log(del_index + "삭제 실패!");
							break;
						case "disable":
							alert("프로젝트가 존재하는 카테고리는 삭제가 불가능하고, 수정만 가능합니다.");
							break;
						}
					},
				}); 
				break;
			}
		});
		
		// 추가 버튼 클릭 시
		$(document).on('click', '[id^=addBtn]', function(){
			var add_btn = $(this).attr('id');
			var ct = "";
			switch(add_btn){
			case "addBtnPc":  // 프로젝트 카테고리
				ct = $(document).find("#pcList");
				ct.append(`
					<div class="cell" data-title="번호" id="index_cell">
			    		<a class="index-a" id="index"></a>
			      	</div>
			    	<div class="cell" data-title="카테고리" id="ct_cell">
			        	<input type="text" id="input_name" name="" class="category-name">
			      	</div>
			      	<div class="cell" data-title="수정/삭제" id="btn_cell">
			        	<a class="category-a" id="modifyBtn" style="display: none;">수정</a> <a href="#" class="category-a" id="deleteBtn" style="display: none;">삭제</a>
			      		<button class="category-save-btn" value=1 id="newBtn">저장</button>
			      	</div>
				`);
				break;
			case "addBtnRc":  // 리워드 카테고리
				ct = $(document).find("#rcList");
				ct.append(`
					<div class="cell" data-title="번호" id="index_cell">
			    		<a class="index-a" id="index"></a>
			      	</div>
			    	<div class="cell" data-title="카테고리" id="ct_cell">
			        	<input type="text" id="input_name" name="" class="category-name">
			      	</div>
			      	<div class="cell" data-title="수정/삭제" id="btn_cell">
			        	<a class="category-a" id="modifyBtn" style="display: none;">수정</a> <a href="#" class="category-a" id="deleteBtn" style="display: none;">삭제</a>
			      		<button class="category-save-btn" value=2 id="newBtn">저장</button>
			      	</div>
				`);
				break;
			}
		});
		
		// 새로운 카테고리 저장
		$(document).on('click', '[id^=newBtn]', function(){
			var new_ct_name = $(this).parent().siblings('#ct_cell').children('#input_name').val();
			var new_ct_type = $(this).val();
			var new_ct = $(this);
			$.ajax({
				url : "ICI.do",
				data : {ct_name : new_ct_name,
						ct_type : new_ct_type},
				success : function(data){
					//alert(data);
					if(data > 0){
						new_ct.parent().siblings('#index_cell').children('#index').text(data);
						new_ct.siblings('#modifyBtn').removeAttr('style');
						new_ct.siblings('#deleteBtn').removeAttr('style');
						new_ct.parent().siblings('#ct_cell').children('#input_name').attr('disabled', true);
						new_ct.attr('id', 'saveBtn').attr('style', 'display: none;');
						alert("새로운 카테고리가 저장되었습니다.");
					}
					else if(data == 0){
						console.log("새로운 카테고리 저장 실패!");
					}
					else{
						alert("카테고리명은 10자리 이하로만 입력 가능합니다.");
					}
				},
				error : function(){
					console.log("새로운 카테고리 저장 에러!");
				}
			});
		});
	});
</script>
</head>
<body class="admin-category-body">
	<div class="admin-category-container">
		<div class="admin-category-title"><h1>카테고리 목록</h1></div>
		<div class="project-category-box">
			<div class="category-box">
				<div class="category-box-left">
					<h2>프로젝트 카테고리</h2>
				</div>
				<div class="category-box-right">
					<input type="button" class="category-table1add-btn" value="추가" id="addBtnPc">
				</div>
			</div>
			
			<div class="wrapper">
				<div class="table" id="pcList">
				
					<div class="row header">
						<div class="cell">
			        		번호
			      		</div>
			      		<div class="cell">
			        		카테고리
			      		</div>
			      		<div class="cell">
			        		수정/삭제
			      		</div>
					</div>
					
					<c:forEach items="${pCategoryList}" var="pc">
					    <div class="row">
					    	<div class="cell" data-title="번호" id="index_cell">
					    		<a class="index-a" id="index">${pc.ct_index}</a>
					      	</div>
					    	<div class="cell" data-title="카테고리" id="ct_cell">
					        	<input type="text" id="input_name" name="" class="category-name" value="${pc.ct_name}" disabled="disabled">
					      	</div>
					      	<div class="cell" data-title="수정/삭제" id="btn_cell">
					        	<a class="category-a" id="modifyBtn">수정</a> <a href="#" class="category-a" id="deleteBtn">삭제</a>
					      		<button class="category-save-btn" value="${pc_ct_index}" id="saveBtn" style="display: none;">저장</button>
					      	</div>
					    </div>
					</c:forEach>
	
			    </div>
			</div>
		</div>
		
		<div class="reward-category-box">
			<div class="category-box">
				<div class="category-box-left">
					<h2>리워드 카테고리</h2>
				</div>
				<div class="category-box-right">
					<input type="button" class="category-table1add-btn" value="추가" id="addBtnRc">
				</div>
			</div>
			
			<div class="wrapper">
				<div class="table" id="rcList">
				
					<div class="row header">
						<div class="cell">
			        		번호
			      		</div>
			      		<div class="cell">
			        		카테고리
			      		</div>
			      		<div class="cell">
			        		수정/삭제
			      		</div>
					</div>
					
					<c:forEach items="${rCategoryList}" var="rc">
					    <div class="row">
					    	<div class="cell" data-title="번호" id="index_cell">
					    		<a class="index-a" id="index">${rc.ct_index}</a>
					      	</div>
					    	<div class="cell" data-title="카테고리" id="ct_cell">
					        	<input type="text" id="input_name" name="" class="category-name" value="${rc.ct_name}" disabled="disabled">
					      	</div>
					      	<div class="cell" data-title="수정/삭제" id="btn_cell">
					        	<a href="#" class="category-a" id="modifyBtn">수정</a> <a href="#" class="category-a" id="deleteBtn">삭제</a>
					      		<button class="category-save-btn" value="${rc_ct_index}" id="saveBtn" style="display: none;">저장</button>
					      	</div>
					    </div>
					</c:forEach>
	
			    </div>
			</div>
		</div>
		
	</div>
	<jsp:include page="Header.jsp" />
</body>
</html>


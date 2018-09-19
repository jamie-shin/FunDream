<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/JNE_NOTICEFORM.css">
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.js"></script>
<script type="text/javascript">
/* function submitContents(){
	var contents = $('#summernote').summernote('code');
	$('#result').text(contents);
	
} */

$(function(){
    $("#saveButton").click(function(){
    	//alert("reg")
        //id가 smarteditor인 textarea에 에디터에서 대입
        var contents = $('#summernote').summernote('code');
        var p_index = $('#p_index').val();
        var title = $('#n_title').val();
        var data = {};
        
        if(contents ==null || contents =='' || title==null || title ==''){
        	alert('제목이나 내용이 없습니다. 다시 확인해 주세요.');
        }
        else{
	        data["n_contents"]=contents;
	        data["p_index"]=p_index;
	        data["n_title"]=title;
	        var inCon = confirm("공지사항을 등록하시겠습니까?");
	        if (inCon==true){
	        	
		        $.ajax({
		        	contentType: 'application/json',
					processData: false,
					url: "JNE_NOTICE.do",
					type : 'POST',
					data : JSON.stringify(data),
					dataType : 'json',
					success : function(data){
						opener.parent.location.reload();
						window.close();
					},
					error: function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
		        });  
       	 	}

        }
    });
	
	$('#modifyButton').click(function(){
        //id가 smarteditor인 textarea에 에디터에서 대입
        var contents = $('#summernote').summernote('code');
        var n_index = $('#n_index').val();
        var title = $('#n_title').val();
        var data = {};
        
        if(contents ==null || contents =='' || title==null || title ==''){
        	alert('제목이나 내용이 없습니다. 다시 확인해 주세요.');
        }
        else {
        	data["n_contents"]=contents;
        	data["n_index_str"]=n_index;
  	        data["n_title"]=title;
  	        var inCon = confirm("공지사항을 수정하시겠습니까?");
  	        if (inCon==true){
  	        	
  		        $.ajax({
  		        	contentType: 'application/json',
  					processData: false,
  					url: "JNU_NOTICE.do",
  					type : 'POST',
  					data : JSON.stringify(data),
  					success : function(){
  						opener.parent.location.reload();
  						window.close();
  					},
  					error: function(request,status,error){
  						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
  					}
  		        });  
      	  	}
      
        }
    });
	
	
});

</script>
</head>
<body class="JNE_BODY">
<div class=""><h1>공지사항 등록</h1></div><br>
		<form action="" method="post">
		<input type="hidden" id="n_index" name="n_index" value="${notice.n_index }">
		<input type="hidden" id="p_index" name="p_index" value="<%=request.getParameter("p_index") %>">
		<input type="text" id="n_title" name="n_title" <c:if test="${notice.n_index!=null }">value="${notice.n_title }"</c:if> placeholder="제목입력" class="">
		<textarea id="summernote" name="n_contents"><c:if test="${notice.n_index!=null }">${notice.n_contents }</c:if></textarea>
		<script>
			$('#summernote').summernote({
				tabsize: 2,
			   	height: 300,
			   	focus: true,
			   	callbacks: {
			   		onImageUpload: function(files, editor, welEditable){
			   			for(var i = files.length - 1; i >= 0; i--){
			   				sendFile(files[i], this);
			   			}
			   		}
			   	}
			});
			
			function sendFile(file, el) {
				var form_data = new FormData();
		      	form_data.append('file', file);
		      	$.ajax({
		        	data: form_data,
		        	type: "POST",
		        	url: 'uploadImage.do',
		        	cache: false,
		        	contentType: false,
		        	enctype: 'multipart/form-data',
		        	processData: false,
		        	success: function(img_name) {
		          		$(el).summernote('editor.insertImage', img_name);
		        	}
		      	});
		    }
		</script>
		<br>
		<div class="">
			<div class="">
				<c:if test="${notice.n_index==null }"><input type="button" class="" id="saveButton" value="등록"></c:if>
				<c:if test="${notice.n_index!=null }"><input type="button" class="" id="modifyButton" value="수정"></c:if>
			</div>
		</div>
		</form>
		<!-- <div><textarea id="result"></textarea></div> -->

</body>
</html>
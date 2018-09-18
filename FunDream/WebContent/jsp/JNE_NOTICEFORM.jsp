<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script>
$(function(){
	var n_index = <%=request.getParameter("n_index_str")%>
	//전역변수선언
 	var editor_object = [];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: editor_object,
		elPlaceHolder: "smarteditor",
		sSkinURI: "smarteditor/SmartEditor2Skin.html",
		htParams : {
			// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseToolbar : true,
			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,
			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : false,
			}
	}); 
		
		//전송버튼 클릭이벤트
	    $("#savebutton").click(function(){
	        //id가 smarteditor인 textarea에 에디터에서 대입
	        editor_object.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
	        
	        var data = {};
	        
	        var contents = editor_object.getById['smarteditor'].getIR();
	        var p_index = $('#p_index').val();
	        var title = $('#title').val();
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
		
		$('#motifyButton').click(function(){
	        //id가 smarteditor인 textarea에 에디터에서 대입
	        editor_object.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
	        
	        var data = {};
	        
	        var contents = editor_object.getById['smarteditor'].getIR();
	        var n_index = $('#n_index').val();
	        var title = $('#title').val();
	        if(contents ==null || contents =='' || title==null || title ==''){
	        	alert('제목이나 내용이 없습니다. 다시 확인해 주세요.');
	        }
	        else {
	        	data["n_contents"]=contents;
	        	data["n_index"]=n_index;
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
<body>
<form action="" method="post" id="frm">
	<input type="text" name="title" id="title" placeholder="공지사항 제목 입력" width="400px">
	<input type="hidden" name="p_index" id="p_index" value="<%=request.getParameter("p_index")%>">
    <textarea name="smarteditor" id="smarteditor" rows="10" cols="100" style="width:500px; height:400px;"></textarea>
    <input type="button" id="savebutton" value="작성하기" />
</form>
</body>
</html>
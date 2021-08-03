<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../manager_include/manager_header.jsp" %>
<!-- 모달  -->
<!-- <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script> -->
<script src="../resources/js/sweetalert2.min.js"></script>
<link rel="stylesheet" href="../resources/css/sweetalert2.min.css">
<style>
.btn_del {
    display: block;
    opacity: 0.5;
    background: url(${contextPath}/resources/images/del_square.gif) no-repeat center;
    width: 30px;
    height: 30px;
		
	}
</style>

<script>
$(document).ready(function() {
	$("#btnCancel").click(function() {
		var result = confirm("페이지에서 나가시면 작성하시던 글이 사라집니다.");
		if(result){
		    $(this).attr("href", "/event/managerEvent");
		}else{
		    return false;
		}
	});
});
</script>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">이벤트 글 작성</h1>
	<form role="form" id="frmEventWrite" action="/event/managerEventWriteRun" method="post">
	<input type="text" id="m_no" name="m_no" value="1001">
		<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold green_color">이벤트</h6>
			
		</div>

		<div class="card-body">
			<div class="mb-3">
			    <label for="e_title" class="form-label">제목</label>
			    <input type="text" class="form-control" id="e_title" name="e_title" required>
			  </div>
			  
			  <div class="form-group row">
			  <div class="col-lg-6 col-md-6 mb-3" style="float:left;">
			      <label for="start_date">이벤트 시작일</label>
			      <input type="date" class="form-control" id="start_date" name="start_date" required>
			      
			    </div>
			    <div class="col-lg-6 col-md-6 mb-3">
			      <label for="end_date">이벤트 종료일</label>
			      <input type="date" class="form-control" id="end_date" name="end_date" required>
			      </div>
			    </div>

				<div class="form-group">
					<label for="mainImg_file">이미지</label>

				<div class="divMainImg card-img rounded" style="position: relative;">
						<label for="mainImg_file" id="mainImg_label" style="overflow: hidden; width: 100%; height: 600px; ">
							<img class="card-img rounded" id="previewImg_main"
							src="${contextPath}/resources/images/main_img_btn.jpg"
							style="width: 100%; height: 100%; object-fit: cover; cursor: pointer; border: 1px solid #e1e1e1;">
						</label>
						<input type="file" class="mainImg_file" name="mainImg_file"
							id="mainImg_file" accept=".gif, .jpg, .png"
							onchange="previewMainImg(this);"
							style="display: none; width: 0px; height: 0px; font-size: 0px;" />
						<input type="hidden" name="e_img" id="e_img"  required/>
						<a id="btnDelMainImg" href="javascript:delMainImg()" class="btn_del"
							style="display: none; position: absolute; top: 0; right: 0.1rem;"></a>
				</div>
				
				
				<div class="form-group">
			    <label for="e_content">내용</label>
			    <textarea class="form-control" id="e_content" name="e_content" rows="10"></textarea>
			  </div>
			

		</div>
	</div>

<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-body">
				
			<button id="btnInsert" type="submit" class="btn btn-success green_background">등록</button>	
			<a id="btnCancel" type="button" class="btn btn-danger orange_background">취소</a>	
		
		</div>
	</div>
	</form>
</div>
<!-- /.container-fluid -->

<%@ include file="../manager_include/manager_footer.jsp" %>
<script>
//ajax, 사진넣기
function previewMainImg(targetObj) {
	if (targetObj.files.length == 0){
		// hidden에 값변화 없게하기 (그대로 두기 일단 값 확인해보고)
		// 보여주는건(미리보기) 파일선택취소 누르기전이미지로
		console.log("$('#e_img').val()", $('#e_img').val());
		return false;
	}
	
	var file = targetObj.files[0];
	console.log("파일존재");
	var formData = new FormData();
	formData.append("file", file);
	// sort의 storyImg(Controller의 case문)
	formData.append("sort", "eventImg");
	
	var url = "/eventImg/uploadImage";
	
	$.ajax({
		"processData" : false,
		"contentType" : false,
		"url" : url,
		"method" : "post",
		"data" : formData,
		"success" : function(filePath) {
			console.log("filePath:" + filePath);
			// 1. hidden에 값 넣기
			$("#e_img").val(filePath);
			// 2. 프리뷰이미지 보여주기
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = function(e) {
				$("#previewImg_main").attr("src", e.target.result);
				console.log("$('#e_img').val()", $('#e_img').val());
				$("#btnDelMainImg").show();				
			}
		},
		"error" : function() {
			alert("사진 업로드에 실패하였습니다.");
		},
		"beforeSend" : function() {
			$("#previewImg_main").attr("src", "${contextPath}/resources/images/loading.gif");
		},
		"complete" : function() {
			console.log("로딩끝")
		}
	});
}
	
function delMainImg() {
	console.log("삭제")
	var filePath = $("#e_img").val();
	console.log(filePath);
	var url = "/eventImg/deleteFile?filePath=" + filePath;
	$.get(url, function(rData) {
		if (rData == "success") {
			$("#e_img").val("");
			$("#previewImg_main").attr("src", "${contextPath}/resources/images/main_img_btn.jpg");
			$("#btnDelMainImg").css("display", "none");
		}
	});
}

</script>
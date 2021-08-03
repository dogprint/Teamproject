<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../manager_include/manager_header.jsp" %>
<script>
$(document).ready(function() {
	$("#btnCancel").click(function() {
		var result = confirm("페이지에서 나가시면 작성하시던 글이 사라집니다.");
		if(result){
		    $(this).attr("href", "/event/managerEventContent?e_no=${eventVo.e_no}");
		}else{
		    return false;
		}
	});
});
</script>
<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">이벤트 글 수정</h1>
	<form action="/event/managerEventModifyRun" method="post">
	<input type="text" id="e_no" name="e_no" value="${eventVo.e_no}">
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
			    <input type="text" class="form-control" id="e_title" name="e_title" value="${eventVo.e_title}" required>
			  </div>
			  
			  <div class="form-group row">
			  <div class="col-lg-6 col-md-6 mb-3" style="float:left;">
			      <label for="start_date">이벤트 시작일</label>
			      <input type="date" class="form-control" id="start_date" name="start_date"
			      	value="${eventVo.start_date}" required>
			      
			    </div>
			    <div class="col-lg-6 col-md-6 mb-3">
			      <label for="end_date">이벤트 종료일</label>
			      <input type="date" class="form-control" id="end_date" name="end_date"
			      	value="${eventVo.end_date}" required>
			      </div>
			    </div>
			    
			    <div class="form-group">
					<label for="mainImg_file">이미지</label>

					<div class="divMainImg card-img rounded" style="position: relative;">
						<label for="mainImg_file" id="mainImg_label" style="overflow: hidden;">
							<img class="card-img rounded" id="previewImg_main"
							<c:choose>
							<c:when test="${eventVo.e_img != null}">
								src="/eventImg/displayImage?filePath=${eventVo.e_img}"
							</c:when>
							<c:otherwise>
								src="${contextPath}/resources/images/main_img_btn.jpg"
							</c:otherwise>
							</c:choose>
							style="object-fit: cover; cursor: pointer; border: 1px solid #e1e1e1;">
						</label>
						<input type="file" class="mainImg_file" name="mainImg_file"
							id="mainImg_file" accept=".gif, .jpg, .png"
							onchange="previewMainImg(this);"
							style="display: none; width: 0px; height: 0px; font-size: 0px;" />
						<input type="hidden" name="e_img" id="e_img" />
						<a id="btnDelMainImg" href="javascript:delMainImg()" class="btn_del"
							style="display: none; position: absolute; top: 0; right: 0.1rem;"></a>
				</div>
				
				
			    <div class="form-group">
			    <label for="e_content">내용</label>
			    <textarea class="form-control" id="e_content" name="e_content" rows="10">${eventVo.e_content}</textarea>
			  </div>
			

		</div>
	</div>
	</div>



<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-body">
				
			<button type="submit" class="btn btn-success green_background">수정</button>	
			<a id="btnCancel" type="button" class="btn btn-danger orange_background">취소</a>	
		
		</div>
	</div>
	</form>
</div>
<!-- /.container-fluid -->

<%@ include file="../manager_include/manager_footer.jsp" %>
<script>
function calcFileName(thumbPath) {
	// var rootIndex;
	// const home = 21;
	// const yj = 12;
	// const team;
	var rootIndex = 12;
	// -> /test ~ 이런식으로 대쉬부터 시작하는 값으로 설정해놔야함 ! 
	
	console.log(thumbPath);
	var str = thumbPath.substring(rootIndex);
	var prefix = str.substring(0, str.lastIndexOf("/") + 1);
	console.log(prefix);
	console.log("str", str);
	var thumbName = str.substring(str.lastIndexOf("/") + 1);
	var splits = thumbName.split("_");
	console.log(splits);
	var suffix = "";
	for (var v = 1; v < splits.length; v++) {
		if (v == (splits.length - 1)) {
			suffix += splits[v];
			break;
		}
		suffix += splits[v] + "_";
	}
	var fileName = prefix + suffix;
	
	return fileName;
}
//ajax
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
	formData.append("sort", "eventImg");
	
	var url = "/event/uploadImg";
	
	$.ajax({
		"processData" : false,
		"contentType" : false,
		"url" : url,
		"method" : "post",
		"data" : formData,
		"success" : function(thumbPath) {
			var fileName = calcFileName(thumbPath);
			console.log("fileName:" + fileName);
			// 1. hidden에 값 넣기 
			$("#e_img").val(fileName);
			//2. 프리뷰이미지 보여주기 
			$("#previewImg_main").attr("src", "/event/displayImage?filePath=" + thumbPath);
			console.log("$('#e_img').val()", $('#e_img').val());
			$("#btnDelMainImg").show();
		},
		"error" : function() {
			alert("파일 업로드 실패!");
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
	var fileName = $("#e_img").val();
	console.log(fileName);
	var url = "/event/deleteFile?fileName=" + fileName;
	$.get(url, function(rData) {
		if (rData == "success") {
			$("#e_img").val("");
			$("#previewImg_main").attr("src", "${contextPath}/resources/images/main_img_btn.jpg");
			$("#btnDelMainImg").css("display", "none");
		}
	})
}
function previewMakeStepImg(targetObj, seq) {
	
	var el = document.getElementById("makeSteps["+ (seq - 1) +"].make_step_img");
	if (targetObj.files.length == 0){
		// hidden에 값변화 없게하기 (그대로 두기 일단 값 확인해보고)
		// 보여주는건(미리보기) 파일선택취소 누르기전이미지로 
		console.log("val", $(el).val());
		return false;
	}
	var file = targetObj.files[0];
	console.log("파일존재");
	var formData = new FormData();
	formData.append("file", file);
	formData.append("sort", "stepImg");
	
	var url = "/event/uploadImg";
	
	$.ajax({
		"processData" : false,
		"contentType" : false,
		"url" : url,
		"method" : "post",
		"data" : formData,
		"success" : function(thumbPath) {
			var fileName = calcFileName(thumbPath);
			console.log(fileName);
			// 1. hidden에 값 넣기 
			$(el).val(fileName);
			$(el).attr("data-exist", 1);
			$("#stepBox_" + seq).removeClass("none_img");
			//2. 프리뷰이미지 보여주기 
			$("#previewImg_step_" + seq).attr("src", "/event/displayImage?filePath=" + thumbPath);
			console.log("val", $(el).val());
			$("#btnDelStepImg_" + seq).show();
			
		},
		"error" : function() {
			alert("파일 업로드 실패!");
		},
		"beforeSend" : function() {
			$("#previewImg_step_" + seq).attr("src", "${contextPath}/resources/images/loading.gif");
		}
	});
    
}
function delStepImg(seq) {
	console.log("삭제")
	var el = document.getElementById("makeSteps["+ (seq - 1) +"].make_step_img");
	var fileName = $(el).val();
	console.log(fileName);
	var url = "/event/deleteFile?fileName=" + fileName;
	$.get(url, function(rData) {
		if (rData == "success") {
			$(el).val("");
			$(el).attr("data-exist", 0);
			$("#stepBox_" + seq).addClass("none_img");
			
			$("#previewImg_step_" + seq).attr("src", "${contextPath}/resources/images/preview_img.jpg");
			$("#btnDelStepImg_" + seq).css("display", "none");
// 			console.log($("#previewImg_step_" + seq).parent().parent());
		}
	});
}
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<style>
.btn-cancle {
    padding: 9px 30px;
    font-size: 18px;
    margin: 0 4px;
    border: 1px solid #ccc;
}

.story_write_pic_add {
    width: 140px;
    height: 140px;
    border: 1px solid #ddd;
    background: #f7f7f7;
    color: #ababab;
    margin: 0;
    padding: 0;
    border-radius: 0;
    font-size: 18px;
    vertical-align: top;
}

.btn_del {
    display: block;
    opacity: 0.5;
    background: url(/resources/images/del_square.gif) no-repeat center;
    width: 30px;
    height: 30px;
		
}
</style>
<script>
$(document).ready(function() {	
	$("#frmStory").submit(function() {
		var st_content = $("#st_content").val();
		if (st_content.trim() == "" || st_content == null) {
			console.log("내용입력");
			$("#msg").text("스토리 내용을 입력해 주세요.");
			$("#st_content").focus();
			return false;
		}
		$(this).submit();
	});
});
</script>
<!-- 스토리 수정 폼 -->
<%@ include file="../include/workroomSide.jsp"%>
<!-- 글작성 폼 -->
<div class="col-md-9">
	<div class="checkout__order contact-form">
		<form action="/story/update_run" method="post">
		<div class="row" style="margin-top:10px; justify-content: center;">
			<div class="divCompleteImg" style="margin-right:20px; height: 200px;">
				<label class="storyImg_label" for="story_file" style="border: 1px solid #e1e1e1; width:200px; height:200px; overflow: hidden;">
					<img id="previewImg_story" class="previewImg_compl" 
						src="/story_img/displayImage?filePath=${storyVo.st_img}" style="width:100%; height:100%;  cursor: pointer; object-fit: cover;">
				</label>
				<input type="file" class="story_file" id="story_file" accept=".gif, .jpg, .png" 
				onchange="previewStoryImg(this);" style="display:none;width:0px;height:0px;font-size:0px;">
				<input type="hidden" class="storyImg_hidden" data-exist="0" id="st_img" name="st_img"/>
				<div style="position: relative;bottom: 13rem;">
					<a id="btnDelStoryImg" href="javascript:delStoryImg()" 
						class="btn_del btn_delStoryImg" style="float:right; display:none"></a>
				</div>
			</div>		
		</div>
		<br>
			<div class="col-lg-12 text-center">
				<input type="hidden" name="st_no" value="${storyVo.st_no}" />
				<textarea placeholder="스토리를 작성해 주세요." name="st_content"
					id="st_content">${storyVo.st_content}</textarea>
				<button type="submit" class="site-btn">작성완료</button>
			</div>
		</form>
	</div>
</div>
<div class="col-md-2"></div>
</div>
</div>

<%@ include file="../include/footer.jsp"%>
<script>
//ajax, 사진넣기
function previewStoryImg(targetObj) {
	if (targetObj.files.length == 0){
		// hidden에 값변화 없게하기 (그대로 두기 일단 값 확인해보고)
		// 보여주는건(미리보기) 파일선택취소 누르기전이미지로 
		console.log("$('#st_img').val()", $('#st_img').val());
		return false;
	}
	
	var file = targetObj.files[0];
	console.log("파일존재");
	var formData = new FormData();
	formData.append("file", file);
	// sort의 storyImg(Controller의 case문)
	formData.append("sort", "storyImg");
	
	var url = "/story_img/uploadImage";
	
	$.ajax({
		"processData" : false,
		"contentType" : false,
		"url" : url,
		"method" : "post",
		"data" : formData,
		"success" : function(filePath) {
			console.log("filePath:" + filePath);
			// 1. hidden에 값 넣기 
			$("#st_img").val(filePath);
			// 2. 프리뷰이미지 보여주기 
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = function(e) {
				$("#previewImg_story").attr("src", e.target.result);
				console.log("$('#st_img').val()", $('#st_img').val());
				$("#btnDelStoryImg").show();				
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
	
function delStoryImg() {
	console.log("삭제")
	var filePath = $("#st_img").val();
	console.log(filePath);
	var url = "/story_img/deleteFile?filePath=" + filePath;
	$.get(url, function(rData) {
		if (rData == "success") {
			$("#st_img").val("");
			$("#previewImg_story").attr("src", "${contextPath}/resources/images/preview_img.jpg");
			$("#btnDelStoryImg").css("display", "none");
		}
	})
}

</script>
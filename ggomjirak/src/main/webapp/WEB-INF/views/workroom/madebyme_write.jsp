<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>
<script src="/resources/js/sweetalert2.min.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
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
	$("#hobbyContent").click(function() {
		if (confirm("페이지를 벗어나면 작성하고 있던 글이 사라집니다. 이동하시겠습니까?")) {
			$(this).attr("href", "/hobby/content/${hobbyVo.hobby_no}");
		}
	});
});
</script>
<div class="container-fluid" style="background: #F5F5F5">
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<div class="checkout__order contact-form">
			<div class="container-fluid">
			<div style="text-align: center">
				<h4>MadeByMe</h4>
				<hr>
			</div>
				<div class="row">
					<div class="col-md-2"></div>
					<div class="col-md-8">
							<div class="row">
								<div class="col-md-5" style="height: 167px;">
									<img src="/displayImage?filePath=${hobbyVo.main_img}"
										style="width: 100%; height: 100%; object-fit: cover;">
								</div>
								<div class="col-md-7" style="padding: 0px; margin: auto;">
									<p style="margin: 10px" id="hobby_detail">
										<a href="#" style="font-size:20px; font-weight: bold" id="hobbyContent">
										${hobbyVo.hobby_title}</a><br><br>
										<span>${hobbyVo.hobby_intro}</span>
									</p>
								</div>
							</div>
						</div>
					<div class="col-md-2"></div>
				</div>
				
			</div>
			</div>
			<div class="checkout__order contact-form">
				<form id="frmMbm" action="/mbm/writeRun" method="post">
					<div class="row" style="margin-top: 10px; justify-content: center;">
					<div class="row">
						<div class="col-md-6" style="padding-right: 200px;">
							<div class="divCompleteImg"
							style="margin-right: 20px; height: 200px;">
							<label class="mbmImg_label" for="mbm_file"
								style="border: 1px solid #e1e1e1; width: 200px; height: 200px; overflow: hidden;">
								<img id="previewImg_mbm" class="previewImg_compl"
								src="${contextPath}/resources/images/preview_img.jpg"
								style="width: 100%; height: 100%; cursor: pointer; object-fit: cover;">
							</label> <input type="file" class="mbm_file" id="mbm_file"
								accept=".gif, .jpg, .png" onchange="previewMbmImg(this);"
								style="display: none; width: 0px; height: 0px; font-size: 0px;">
							<input type="hidden" class="mbmImg_hidden" data-exist="0"
								id="mbm_img" name="mbm_img" />
							<div style="position: relative; bottom: 13.3rem;">
								<a id="btnDelMbmImg" href="javascript:delMbmImg()"
									class="btn_del btn_delMbmImg"
									style="float: right; display: none"></a>
							</div>
						</div>
						</div>
						<!-- 난이도바 -->
						<div class="col-md-6" style="padding-right:0px; padding-left:0px;">
						<div class="form-group row">
						    <label for="colFormLabelSm" class="col-sm-4 col-form-label col-form-label-sm" 
						    style="padding-right: 0px; margin-top: 15px;">체감 난이도</label>
						    <div class="col-sm-8">
						      <input style="padding:0px; margin:0px; margin-left:-30px;" class="slider_range" 
							  type="range" value="0" min="0" max="100"></input><br>
							  <span id="slider_value_view" style="text-align: center">0</span>	
						    </div>
						</div>
						</div>
					</div>
					</div>
					<br>
					<div class="col-lg-12 text-center">
						<span id="msg"></span>
						<textarea placeholder="후기를 작성해 주세요." name="mbm_content"
							id="mbm_content"></textarea>
						<button type="button" onclick="doSubmit();" class="site-btn">등록</button>
						<a href="/hobby/content/${hobbyVo.hobby_no}" class="btn-cancle">취소</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="col-md-3"></div>
</div>
<%@ include file="../include/footer.jsp"%>
<script>
function ShowSliderValue(sVal) {
	var obValueView = document.getElementById("slider_value_view");
	obValueView.innerHTML = sVal
}
var RangeSlider = function(){
	var range = $('.slider_range');
    
	range.on('input', function(){		
		ShowSliderValue(this.value);
	});
};

RangeSlider();
</script>
<script>
//ajax, 사진넣기
function previewMbmImg(targetObj) {
	if (targetObj.files.length == 0){
		// hidden에 값변화 없게하기 (그대로 두기 일단 값 확인해보고)
		// 보여주는건(미리보기) 파일선택취소 누르기전이미지로 
		console.log("$('#mbm_img').val()", $('#mbm_img').val());
		return false;
	}
	
	var file = targetObj.files[0];
	console.log("파일존재");
	var formData = new FormData();
	formData.append("file", file);
	// sort의 storyImg(Controller의 case문)
	formData.append("sort", "mbmImg");
	
	var url = "/img/uploadImage";
	
	$.ajax({
		"processData" : false,
		"contentType" : false,
		"url" : url,
		"method" : "post",
		"data" : formData,
		"success" : function(filePath) {
			console.log("filePath:" + filePath);
			// 1. hidden에 값 넣기 
			$("#mbm_img").val(filePath);
			// 2. 프리뷰이미지 보여주기 
			var reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = function(e) {
				$("#previewImg_mbm").attr("src", e.target.result);
				console.log("$('#mbm_img').val()", $('#mbm_img').val());
				$("#btnDelMbmImg").show();				
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
	
// 이미지 삭제
function delMbmImg() {
	console.log("삭제")
	var filePath = $("#mbm_img").val();
	console.log(filePath);
	var url = "/img/deleteFile?filePath=" + filePath;
	$.get(url, function(rData) {
		if (rData == "success") {
			$("#mbm_img").val("");
			$("#previewImg_mbm").attr("src", "${contextPath}/resources/images/preview_img.jpg");
			$("#btnDelMbmImg").css("display", "none");
		}
	})
}

function validate() {
	// 내용 입력 X
	var mbm_content = $("#mbm_content").val();
	if (typeof mbm_content == "undefined" || mbm_content.trim() == "" || mbm_content ==  null) {
		$("#msg").text("스토리 내용을 입력해 주세요.");
		$("#msg").attr("style", "color:#FF5454; font-weight: bold");
		$("#mbm_content").focus();
		return false;
	}
	return true;
}
// 제출(등록)
function doSubmit() {
	valResult = validate();
    if (!valResult) {
        return false;
    } 
    
	Swal.fire({
		text: '등록하시겠습니까?', 
		allowOutsideClick: false,
		iconColor: "#1f5e43",
		icon: 'question', 
		confirmButtonText: "확인",
		confirmButtonColor: "#1f5e43",
		cancelButtonText: "취소",
		showCancelButton: true,
	}).then(function(result) {
		if(result.isConfirmed) {
			 $("#frmMbm").submit();
		} else {
			return false;
		}
	});
    
}

</script>
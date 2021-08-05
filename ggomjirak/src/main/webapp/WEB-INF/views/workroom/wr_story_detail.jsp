<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/workroomSide.jsp"%>
<!-- 스토리 상세 폼 -->
<script>
$(document).ready(function() {
	// 스토리 삭제
// 	$("#storyDel").click(function(e) {
// 		e.preventDefault();
// 		if (confirm("삭제하시겠습니까?")) {
// 			location.href = "/story/delete_run?st_no=${storyVo.st_no}";
// 		}
// 	});
	
	// 댓글 입력 
	$("#btnCommentInsert").click(function() {
		var st_c_content = $("#txtComment").val();
		console.log(txtComment);
		var st_no = parseInt("${storyVo.st_no}");
		console.log(st_no);
		var url = "/st_comment/write";
		var sendData = {
			"st_c_content" : st_c_content,
			"st_no"		   : st_no
		}
		$.post(url, sendData, function(rData) {
			if (rData.success) {
				$("#txtComment").val("");
				$("#commentList").text(" " + rData.commentCount);
				var url = "/st_comment/list";
				var st_no = parseInt("${storyVo.st_no}");
				var sendData = { "st_no" : st_no }
					$.get(url, sendData, function(rData) {
						console.log(rData);
						var commentHtml = "";
						$("#comment").next().remove();
						$.each(rData, function() {
							// 입력했을 때 댓글 새로 로딩
							commentHtml += "<div class='row' style='margin-top: 15px; margin-bottom:15px'>";
							commentHtml += "	<div class='col-md-10'>";
							commentHtml += "		<div class='blog__details__author'>";
							commentHtml += "			<div class='blog__details__author__pic'>";
							commentHtml += "				<a href='/workroom/main/" + this.user_id + "'><img src='/displayImage?filePath=" + this.user_img + "' alt=''></a></div>"
							commentHtml += "					<div class='blog__details__author__text'>";
							commentHtml += "						<h6>" + this.user_nick + " " + changeDateString(this.reg_date) + "</h6>";
							commentHtml += "							<span class='st_c_content'>" + this.st_c_content + "</span></div></div></div>";
							commentHtml += "	<div class='col-md-2'><div style='text-align: right'>";
							commentHtml += "		<a href='#' style='margin-right: 5px; font-size:13px;' id='commentMod'>수정</a>"
							commentHtml += "		<a href='#' style='font-size:13px;' class='commentDel' data-cno=" + this.st_c_no + ">삭제</a></div></div></div>"
							commentHtml += "<div class='row' id='divCommentMod' style='display:none'><div class='col-md-9'>";
							commentHtml += "	<textarea class='form-control' style='width: 100%; resize: none; id='txtCommentMod'>" + this.st_c_content + "</textarea></div>";
							commentHtml += "<div class='col-md-3'>";
							commentHtml += "	<button type='button' class='btn btn-warning btn-sm modRun' data-st_c_no=" + this.st_c_no + ">등록</button><br>";
							commentHtml += "	<button tyle='button' class='btn btn-light btn-sm modCancel'>취소</button></div></div><hr>";
							$("#comment").html(commentHtml);
						});
				});
			}
		});
	});
	
	// 댓글 수정
	$("#comment").on("click", "#commentMod", function(e) {
		e.preventDefault();
		var div = $(this).parent().parent().parent();
		div.next().show();
		// 취소
		$(".modCancel").click(function() {
			console.log("취소클릭함");
			div.next().attr("style", "display:none;");
		});
		// 수정
		$(".modRun").click(function() {
			console.log("클릭");
			var st_c_content = $(this).parent().parent().find("textarea").val();
			var st_c_no = $(this).attr("data-st_c_no");
			console.log(st_c_no);
			var url = "/st_comment/modify";
			var sendData = {
				"st_c_content" 	: st_c_content,
				"st_c_no"		: st_c_no
			}
			console.log(sendData);
			var content = $(this).parent().parent().prev().find("span");
			$.get(url, sendData, function(rData) {
				if (rData == "success") {
					content.text(st_c_content);
					div.next().attr("style", "display:none;");
				}
			});
		});
	});
	
	// 댓글 삭제
	$("#comment").on("click", ".commentDel", function(e) {
		e.preventDefault();
		console.log("삭제");
		// 현재 댓글을 감싸고 있는 div
		var div = $(this).parent().parent().parent();
		// 감싼 div다음 hr
		var hr = div.next().next();
		if (confirm("댓글을 삭제하시겠습니까?")) {
			var url = "/st_comment/delete";
			var st_c_no = $(this).attr("data-cno");
			var st_no = parseInt("${storyVo.st_no}");
			var sendData = {
				"st_no" 	: st_no,
				"st_c_no" 	: st_c_no
			}
			$.get(url, sendData, function(rData) {
				console.log(rData);
				if (rData.success) {
					div.attr("style", "display:none;");
					hr.remove();
					$("#commentList").text(" " + rData.commentCount);
				}
			});
		}
	});
	
	// 답글
	$("#commentReply").click(function(e) {
		e.preventDefault();
// 		console.log("답글클릭함");
// 		$("#span").html("<div class='row'><div class='col-md-10'>" + 
// 		"<textarea class='form-control' style='height:50px; resize:none;'></textarea></div>" + 
// 		"<div class='col-md-2'><button type='button' style='width:50px; height:30px' class='site-btn' id='btnInsert'>입력</button></div></div>");
	});
	
	// 좋아요 유지
	if ("${likeCheck}" == 1) {
		$("#like").attr("class", "fa fa-heart");
	}
	
	// 좋아요
	$("#like").click(function(e) {
		e.preventDefault();
		var url = "/story/like/${storyVo.st_no}";
		$.get(url, function(rData) {
			console.log(rData.likeCount);
			if (rData.like) {
				$("#like").attr("class", "fa fa-heart");
			} else if (rData.cancel) {
				$("#like").attr("class", "fa fa-heart-o");
			}
			$("#like > span").text(rData.likeCount);
		});
	});
	
});
</script>
<!-- 간단 카드 보여주기 -->
<div class="col-md-9">
	<div class="checkout__order">
		<div class="workroom_box row" style="height: 39px;">
			<h4>Story detail</h4>
		</div>
		<hr>
		<div style="text-align: right">
			<p>${storyVo.reg_date}</p>
			<c:if test="${storyVo.mod_date != null}">
				<p style="font-size:13px;">${storyVo.mod_date}(수정 됨)</p>
			</c:if>
		</div>
		<div>
			<c:if test="${storyVo.st_img != null}">
				<img src="/img/displayImage?filePath=${storyVo.st_img}" width="300px" 
				style="display: block; margin: 0px auto; margin-top: 50px">
			</c:if>
		</div>
		<!-- 스토리 전체 내용 -->
		<div style="margin: 50px">
			<p>${storyVo.st_content}</p>
			<hr>
			<div class="row">
				<div class="col-md-9">
					<a class="fa fa-heart-o" href="#" style="margin-right: 5px; color:#FF5454" id="like">
					<span style="color:#666666; margin-left: 5px;">${storyVo.st_like_count}</span></a>
					<button type="button" class="fa fa-comment-o"
						style="border: none; background: none; padding: 0; margin-right: 5px; color: #666666;"
						id="commentList"> ${storyVo.st_c_count}</button>
				</div>
				<div class="col-md-3">
					<div style="text-align: right">
						<a href="/story/update?st_no=${storyVo.st_no}" style="margin-right: 5px">수정</a> 
						<a href="javascript:doDelete();">삭제</a>
					</div>
				</div>
			</div>
			<!-- 댓글작성 -->
			<div class="row" style="margin-top: 30px">
				<div class="col-md-10">
					<textarea class="form-control" style="width: 100%; resize: none;"
						id="txtComment"></textarea>
				</div>
				<div class="col-md-2">
					<button type="button" class="site-btn" id="btnCommentInsert">입력</button>
				</div>
			</div>
			<!-- 댓글 -->
			<div style="margin-top: 30px;">
				<h3>댓글</h3>
				<hr>
				<span id="comment">
					<!-- 댓글목록 -->
					<c:forEach var="commentVo" items="${list}">
					<div class="row" style="margin-top: 15px; margin-bottom:15px">
						<div class="col-md-10">
							<div class="blog__details__author">
								<div class="blog__details__author__pic">
									<a href="/workroom/main/${commentVo.user_id}"><img src="/displayImage?filePath=${commentVo.user_img}" alt=""></a>
								</div>
								<div class="blog__details__author__text">
									<h6>${commentVo.user_nick} ${commentVo.reg_date}</h6>
									<span class="st_c_content">${commentVo.st_c_content}</span>
								</div>
							</div>
						</div>
						<div class="col-md-2">
							<div style="text-align: right">
							<c:if test="${user_id == commentVo.user_id}">
								<a href="#" style="margin-right: 5px; font-size:13px;" id="commentMod" >수정</a> 
								<a href="#" style="font-size:13px;" class="commentDel" data-cno="${commentVo.st_c_no}">삭제</a>
							</c:if>
							</div>
						</div>
					</div>
					<div class="row divCommentMod" style="display:none">
						<div class="col-md-9">
							<textarea class="form-control txtCommentMod" style="width: 100%; resize: none;">${commentVo.st_c_content}</textarea>
						</div>
					<div class="col-md-3">
						<button type="button" class="btn btn-warning btn-sm modRun" data-st_c_no="${commentVo.st_c_no}">등록</button><br>
						<button type="button" class="btn btn-light btn-sm modCancel">취소</button>
					</div>
					</div>
					<hr>
					</c:forEach>
				</span>
			</div>
		</div>
	</div>
</div>
<div class="col-md-2"></div>
</div>
</div>

<%@ include file="../include/footer.jsp"%>

<script>
// 날짜형식 변경(ajax용)
function make2digits(num) {
	if (num < 10) {
		num = "0" + num;
	}
	return num;
}

function changeDateString(timeStamp) {
	var d = new Date(timeStamp);
	var year = d.getFullYear();
	var month = make2digits(d.getMonth() + 1);
	var date = make2digits(d.getDate());
	var hour = make2digits(d.getHours());
	var minute = make2digits(d.getMinutes());
	return year + "-" + month + "-" + date + "  " + hour + ":" + minute;
}

function doDelete() {
	Swal.fire({
		text: '삭제하시겠습니까?', 
		allowOutsideClick: false,
		iconColor: "#1f5e43",
		icon: 'question', 
		confirmButtonText: "확인",
		confirmButtonColor: "#1f5e43",
		cancelButtonText: "취소",
		showCancelButton: true,
	}).then(function(result) {
		if(result.isConfirmed) {
			location.href = "/story/delete_run?st_no=${storyVo.st_no}";
		} 
	});
}
</script>
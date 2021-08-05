<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>
<script src="/resources/js/sweetalert2.min.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script>
$(document).ready(function() {
	
	// 작업실 이름
	// 수정 버튼 클릭 시 텍스트 입력으로 변경(수정버튼 비활성화)
	$("#btnName").click(function() {
		$("#wrName").replaceWith("<input type='text' id='wrName' style='border: 1px solid #E5E8E8; width:400px;' value='${workroomVo.wr_name}'>");
		$("#btnName").attr("style", "margin-left:10px; height:20px; border:none; background:none; padding: 0; display:none");
		$("#btnNameMod").show();
		$("#btnNameCancel").show();
	});
	
	// 수정취소(wrName에 원래상태로 붙여줌)
	$("#btnNameCancel").click(function() {
		$("#wrName").replaceWith("<h4 style='margin-bottom:0px;' id='wrName'>${workroomVo.wr_name}</h4>");
		$("#btnName").show();
		$("#btnNameMod").attr("style", "margin-left:10px; display:none;");
		$("#btnNameCancel").attr("style", "margin-left:10px; display:none;");
		$("#nameWarning").text("");
	});
	
	// 수정실행(완료되면 수정버튼 활성화 / 변경,취소 비활성화)
	$("#btnNameMod").click(function() {
		var inputNameLength = $("#wrName").val().length;
		var wr_name = $("#wrName").val();
		var user_id = "${workroomVo.user_id}";
		var url = "/workroomset/nameSet";
		var sendData = {
			"wr_name" : wr_name,
			"user_id" : user_id
		}
		if (inputNameLength > 25) {
			$("#nameWarning").text("최대 입력길이를 초과하셨습니다.");
		} else {
			$.post(url, sendData, function(rData) {
				console.log(rData);
				if (rData == "nameSuccess") {
					$("#nameWarning").text("");
					$("#wrName").replaceWith("<h4 style='margin-bottom:0px;' id='wrName'>" + wr_name + "</h4>");
					$("#btnName").show();
					$("#btnNameMod").attr("style", "margin-left:10px; display:none;");
					$("#btnNameCancel").attr("style", "margin-left:10px; display:none;");
				}
			});
		}
	});
	
	// 작업실 소개 
	// 수정 버튼 클릭 시 텍스트 입력으로 변경(수정버튼 비활성화)
	$("#btnIntro").click(function() {
		$("#wrIntro").replaceWith("<textarea id='wrIntro' class='form-control'>${workroomVo.wr_intro}</textarea>");
		$("#btnIntro").attr("style", "margin-left:10px; height:20px; border:none; background:none; padding: 0; display:none");
		$("#btnIntroMod").show();
		$("#btnIntroCancel").show();
	});
	
	// 수정취소(wrIntro에 원래상태로 붙여줌)
	$("#btnIntroCancel").click(function() {
		$("#wrIntro").replaceWith("<p id='wrIntro'>${workroomVo.wr_intro}</p>");
		$("#btnIntro").show();
		$("#btnIntroMod").attr("style", "margin-left:10px; display:none;");
		$("#btnIntroCancel").attr("style", "margin-left:10px; display:none;");
		$("#introWarning").text("");
	});
	
	// 수정실행(완료되면 수정버튼 활성화 / 변경,취소 비활성화)
	$("#btnIntroMod").click(function() {
		var inputIntroLength = $("#wrIntro").val().length;
		var wr_intro = $("#wrIntro").val();
		var user_id = "${workroomVo.user_id}";
		var url = "/workroomset/introSet";
		var sendData = {
			"wr_intro" 	: wr_intro,
			"user_id"	: user_id
		}
		if (inputIntroLength > 250) {
			$("#introWarning").text("최대 입력길이를 초과하셨습니다.");
		} else {
			$.post(url, sendData, function(rData){
				console.log(rData);
				if (rData == "introSuccess") {
					$("#introWarning").text("");
					$("#wrIntro").replaceWith("<p id='wrIntro'>" + wr_intro + "</p>");
					$("#btnIntro").show();
					$("#btnIntroMod").attr("style", "margin-left:10px; display:none;");
					$("#btnIntroCancel").attr("style", "margin-left:10px; display:none;");
				}
			});
		}
	});
	
	// 언팔로우
	$(".unfollow").click(function() {
		var that = $(this);
		var user_id = $(this).parent().parent().parent().find("span").attr("data-id");
		var url = "/workroom/follow/" + user_id;
		console.log(url);
		$.get(url, function(rData) {
			if (rData.unFollow) {
				that.replaceWith("<button type='button' class='btn btn-primary follow'>팔로우</button>");
			}
		});
	});
	
	// 언팔로우 후 다시 팔로우
	$(".divUnfollow").on("click", ".follow", function() {
		var that = $(this);
		var user_id = $(this).parent().parent().parent().find("span").attr("data-id");
		var url = "/workroom/follow/" + user_id;
		console.log(url);
		$.get(url, function(rData) {
			if (rData.follow) {
				that.replaceWith("<button type='button' class='btn btn-outline-primary unfollow'>언팔로우</button>");
			}
		});
	});
	
});
</script>
<div class="container-fluid" style="background: #F5F5F5">
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<div style="text-align: center; margin-top: 12px;">
				<h2 style="font-weight: 700">내 작업실 설정<a href="/workroom/main/${page_id}" class="fa fa-home" style="font-size:30px; margin-left:10px;"></a></h2>
			</div>
			<div class="checkout__order">
				<div class="workroom_box row">
					<h4 style="margin-bottom: 0px;" id="wrName">${workroomVo.wr_name}</h4>
					<button type="button" id="btnName" class="fa fa-pencil" style="margin-left:10px; height:20px; border:none; background:none; padding: 0;"></button>
					<button type="button" class="btn btn-primary btn-sm" id="btnNameMod" style="margin-left:10px; display:none;">변경</button>
					<button type="button" class="btn btn-warning btn-sm" id="btnNameCancel" style="margin-left:10px; display:none;">취소</button>
					<span id="nameWarning" style="margin-left:10px; color:#E14F4F; font-size:15px;"></span>
				</div>
					<hr>
				<div class="workroom_box row">
					<p id="wrIntro">${workroomVo.wr_intro}</p>
					<button type="button" class="fa fa-pencil" id="btnIntro" style="margin-left:10px; height:20px; border:none; background:none; padding: 0;"></button>
					<button type="button" class="btn btn-primary btn-sm" id="btnIntroMod" style="margin-left:10px; display:none;">변경</button>
					<button type="button" class="btn btn-warning btn-sm" id="btnIntroCancel" style="margin-left:10px; display:none;">취소</button>
					<span id="introWarning" style="margin-left:10px; color:#E14F4F; font-size:15px;"></span>
				</div>
			</div>
			<div class="checkout__order">
				<div class="workroom_box">
					<h4>작업실 공개 여부</h4>
				</div>
				<div class="workroom_box">
					<hr>
					<div class="custom-control custom-switch">
					  <input type="checkbox" class="custom-control-input" id="customSwitch1">
					  <label class="custom-control-label" for="customSwitch1">공개</label>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="checkout__order">
						<div class="workroom_box">
							<h4>팔로잉 목록</h4>
						</div>
						<div class="workroom_box">
							<hr>
								<c:forEach var="followVo" items="${followingList}">
								<div class="row" style="margin-top: 15px; margin-bottom:15px">
									<div class="col-md-8">
										<div class="blog__details__author">
											<div class="blog__details__author__pic">
												<a href="#"><img src="/displayImage?filePath=${followVo.user_img}" alt=""></a>
											</div>
											<div class="blog__details__author__text">
												<span data-id="${followVo.following}">${followVo.user_nick}</span>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div style="text-align: right" class="divUnfollow">
											<button type="button" class="btn btn-outline-primary unfollow">언팔로우</button> 
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="checkout__order">
						<div class="workroom_box">
							<h4>좋아요 목록</h4>
						</div>
						<div class="workroom_box">
							<hr>
							<c:forEach var="likeBmVo" items="${likeList}">
								<div class="row" style="margin-top: 15px; margin-bottom:15px">
									<div class="col-md-7">
										<div>
											<a href="/hobby/content/${likeBmVo.hobby_no}" style="font-weight: bold">[${likeBmVo.hobby_title}]</a> 
										</div>
									</div>
									<div class="col-md-5">
										<div class="blog__details__author">
											<div class="blog__details__author__pic">
												<a href="#"><img src="/displayImage?filePath=${likeBmVo.user_img}" alt=""></a>
											</div>
											<div class="blog__details__author__text">
												<span>${likeBmVo.user_nick}</span>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
			<div class="col-md-3"></div>
		</div>
	<%@ include file="../include/footer.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 모달  -->
<script src="/resources/js/sweetalert2.min.js"></script>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css">
<script>
$(document).ready(function() {
	$("#btnStSearch").click(function() {
		var keyword = $("#txtStSearch").val();
		console.log(txtStSearch);	
		location.href = "/workroom/search/${page_id}?keyword=" + keyword;
	});
	
	if ("${checkFollow}" == 1) {
		$("#follow").attr({
			"class" : "btn btn-outline-warning",
			style : "color:#F39C12"
		});
		$("#follow").text("언팔로우");
	}
	
	$("#follow").click(function() {
		var url = "/workroom/follow/${memberInfo.user_id}";
		$.get(url, function(rData) {
			console.log(rData);
			// 팔로우
			if (rData.follow) {
				$("#follow").attr({
					"class" : "btn btn-outline-warning",
					style : "color:#F39C12"
				});
				$("#follow").text("언팔로우");
			} else if (rData.unFollow) {
				$("#follow").attr({
					"class" : "btn green_background white_color",
					style : "color:white"
				});
				$("#follow").text("팔로우");
			}
			$("#follower_cnt").text(rData.countFollow);
		});
	});
	
	
});
</script>
<div class="container-fluid" style="background: #F5F5F5">
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<div class="row">
				<div class="col-md-3">
					<div class="checkout__order">
						<!-- 유저 카드 프로필 -->
						<div class="box" style="margin: 12px auto;">
							<a href="/workroom/main/${page_id}"><img class="profile" src="/displayImage?filePath=${memberInfo.user_img}"
								alt="profile image" style="width: 100%; text-align: center"></a>
						</div>
						<div class="card-body">
							<div style="display: flex; justify-content: center;">
							<h4 class="text-center" style="display:inline;">${memberInfo.user_nick}</h4>
							</div>
							<p class="text-center" style="font-size:12px; margin-top:-20px">${memberInfo.name}</p>
							<!-- memberInfo에서 받아오면 카테고리 코드로 나와서 workroomVo에서 받아옴 -->
							<p class="card-text text-center" style="font-size:13px;"> 
							<c:choose>
								<c:when test="${workroomVo.cate_no1 ne '선택안함'}">
								${workroomVo.cate_no1}
								</c:when>
								<c:when test="${workroomVo.cate_no2 ne '선택안함'}">
								${workroomVo.cate_no2}
								</c:when>
								<c:when test="${workroomVo.cate_no3 ne '선택안함'}">
								    ${workroomVo.cate_no3} 
								</c:when>
							</c:choose>
							</p>
							<div style="text-align: center;">
								<div style="display: inline-block;">
									<p style="margin-bottom: -5px">팔로워</p>
									<p style="text-align: center" id="follower_cnt">${memberInfo.follower_cnt}</p>
								</div>
								<div style="display: inline-block;">
									<p style="margin: -2px">
										<img src="/resources/img/test/minus.png" height="25px">
									</p>
									<p>
										<img src="/resources/img/test/minus.png" height="25px">
									</p>
								</div>
								<div style="display: inline-block;">
									<p style="margin-bottom: -5px">팔로잉</p>
									<p style="text-align: center">${memberInfo.following_cnt}</p>
								</div>
							</div>
							<div style="text-align: center;">
							<c:choose>
								<c:when test="${user_id == page_id}">
									<a href="/workroomset/main" class="site-btn">작업실 설정</a>
								</c:when>
								<c:when test="${user_id != null}">
									<button type="button" id="follow" class="btn green_background white_color">팔로우</button>
									<a href="/message/sendMessage" class="btn green_background white_color">쪽지</a>
								</c:when>
							</c:choose> 
							</div>
						</div>

					</div>
					<!-- 카테고리 -->
					<div class="checkout__order">
						<div class="blog__sidebar__item" style="margin-left: 40px;">
							<ul>
								<li><a href="#">소개</a></li>
								<li><a href="#hobby">꼼지락</a></li>
								<li><a href="#story">Story</a></li>
								<li><a href="#mbm">MadeByMe</a></li>
								<li><a href="#bookmark">북마크</a></li>
							</ul>
						</div>
					</div>
					<div>
						<input type="text"
							style="border: 1px solid #E5E8E8; height: 30px;" id="txtStSearch">
						<button type="button" class="fa fa-search" 
						style="border:none; background:none; padding: 0;" id="btnStSearch"></button>
					</div>
				</div>
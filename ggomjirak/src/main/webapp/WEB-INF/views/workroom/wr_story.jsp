<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/workroomSide.jsp"%>
<style>
.oooo {
	overflow: hidden;
	display: -webkit-box;
	-webkit-line-clamp: 4;
	-webkit-box-orient: vertical;
}
</style>
<script>
$(document).ready(function() {
	// 좋아요 유지
// 	if ("${likeCheck}" == 1) {
// 		$("#like").attr("class", "fa fa-heart");
// 	}
	
// 	$.each("${likeCheck}", function() {
// 		console.log("${likeCheck}");
// 	});
	
// 	$.each(function() {
// 		var st_no = $(".like").attr("data-st_no");
// 		console.log(st_no);
// 	});

// 	var url = "/story/like/" + st_no;
	
	
	// 좋아요
	$(".like").click(function(e) {
		e.preventDefault();
		var st_no = $(this).attr("data-st_no");
		var url = "/story/like/" + st_no;
		console.log(url);
// 		$.get(url, function(rData) {
// 			console.log(rData.likeCount);
// 			if (rData.like) {
// 				$("#like").attr("class", "fa fa-heart like");
// 			} else if (rData.cancel) {
// 				$("#like").attr("class", "fa fa-heart-o like");
// 			}
// 			$("#like > span").text(rData.likeCount);
// 		});
	});
});
</script>
<!-- 간단 카드 보여주기 -->
<div class="col-md-9">
	<div class="checkout__order">
		<div class="workroom_box row" style="height: 39px;">
			<h4>Story detail</h4>
			<c:if test="${user_id == page_id}">
				<a href="/story/write" class="fa fa-pencil" style="margin-top: 5px; margin-left: 10px;"></a>
			</c:if>
		</div>
		<div class="workroom_box">
			<hr>
			<div class="container-fluid">
				<c:forEach var="storyVo" items="${list}">
					<div class="row">
						<div class="col-md-9" style="padding: 0px; margin: auto;">
							<p style="font-size: 14px; margin: 10px" id="story_detail">
								<a href="/story/detail/${page_id}?st_no=${storyVo.st_no}" class="oooo">
									${storyVo.st_content}</a><br> 
									<a class="fa fa-heart-o like" href="#" style="margin-right: 5px" data-st_no="${storyVo.st_no}">
									${storyVo.st_like_count}</a> 
									<a class="fa fa-comment-o" href="/story/detail/${page_id}?st_no=${storyVo.st_no}">
									${storyVo.st_c_count}</a>
							</p>
						</div>
						<div class="col-md-3" style="height:167px;">
							<c:if test="${storyVo.st_img != null}">
								<img src="/img/displayImage?filePath=${storyVo.st_img}"
								style="width: 100%; height: 100%; object-fit:cover;">
							</c:if>
						</div>
					</div>
					<hr>
				</c:forEach>
			</div>
		</div>
		<!-- 페이징 -->
		<div class="product__pagination justify-content-center"
			style="display: flex;">
			<c:if test="${storyPagingDto.startPage != 1}">
				<a href="/story/list/${page_id}?page=${storyPagingDto.startPage - 1}&perPage=${storyPagingDto.perPage}">
					<i class="fa fa-long-arrow-left"></i>
				</a>
			</c:if>
			<c:forEach var="v" begin="${storyPagingDto.startPage}" end="${storyPagingDto.endPage}">
				<a 
					<c:choose>
						<c:when test="${v == storyPagingDto.page}">
							class="green_background" style="color: white;"
					 	</c:when>
					 	<c:otherwise>
					 		class="page-item"
						</c:otherwise>
					</c:choose>
				href="/story/list/${page_id}?page=${v}&perPage=${storyPagingDto.perPage}">${v}</a>
			</c:forEach>
			<c:if test="${storyPagingDto.endPage < storyPagingDto.totalPage}">
				<a href="/story/list/${page_id}?page=${storyPagingDto.endPage + 1}&perPage=${storyPagingDto.perPage}">
					<i class="fa fa-long-arrow-right"></i>
				</a>
			</c:if>
		</div>
	</div>
</div>
</div>
<div class="col-md-2"></div>
</div>
</div>

<%@ include file="../include/footer.jsp"%>
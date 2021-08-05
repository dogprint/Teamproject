<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/workroomSide.jsp"%>
<!-- 간단 카드 보여주기 -->
<script>	
$(document).ready(function() {
	$("#pagination > a").click(function(e) {
		e.preventDefault(); // 페이지 이동 막기
		// a태그의 속성값 중 href를 들고와서 page로 설정
		var page = $(this).attr("href");
		console.log(page);
		$("#frmPaging").find("[name=page]").val(page);
		$("#frmPaging").submit();
	});
});
	
</script>
<div class="col-md-9">
<!-- 페이지용 form -->
<form id="frmPaging" action="/workroom/search/${pagingDto.user_id}" method="get">
	<input type="hidden" name="page" value="${pagingDto.page}"/>
	<input type="hidden" name="perPage" value="${pagingDto.perPage}"/>
	<input type="hidden" name="keyword" value="${pagingDto.keyword}"/>
</form>
	<!-- 검색결과 -->
	<h3 class="text-center">${keyword}의검색결과 입니다.</h3>
	<div class="checkout__order" id="hobby">
		<div class="workroom_box row" style="height: 39px;">
			<h4>취미</h4>
		</div>
		<hr>
		<div class="row featured__filter">
		<c:forEach var="hobbyVo" items="${searchHobbyList}">
			<div class="col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
				<div class="featured__item">
					<div class="featured__item__pic set-bg"
						data-setbg="/displayImage?filePath=${hobbyVo.user_img}">
						<ul class="featured__item__pic__hover">
							<li><a href="#"><i class="fa fa-heart"></i></a></li>
							<li><a href="#"><i class="fa fa-retweet"></i></a></li>
							<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
						</ul>
					</div>
					<div class="featured__item__text">
						<h6>
							<a href="#">${hobbyVo.hobby_title}</a>
						</h6>
					</div>
				</div>
			</div>
			</c:forEach>
		</div>
	</div>
	<!-- 스토리 -->
	<div class="checkout__order" id="story">
		<div class="workroom_box row" style="height: 39px;">
			<h4>Story</h4>
		</div>
		<hr>
		<div class="container-fluid">
			<c:forEach var="storyVo" items="${searchStoryList}">
				<div class="row">
					<div class="col-md-10" style="padding: 0px; margin: auto;">
						<p style="font-size: 14px; margin: 10px" class="story_detail">
							<a href="/story/detail?st_no=${storyVo.st_no}">${storyVo.st_content}</a><br> 
							<a class="fa fa-heart-o" href="#" style="margin-right: 5px"> ${storyVo.st_like_count}</a>
							<a class="fa fa-comment-o" href="/story/detail?st_no=${storyVo.st_no}"> ${storyVo.st_c_count}</a>
						</p>
					</div>
					<div class="col-md-2" style="padding: 0px;">
						<c:if test="${storyVo.st_img != null}">
							<img src="/displayImage?filePath=${storyVo.st_img}" width="100px">
						</c:if>
					</div>
				</div>
				<hr>
			</c:forEach>
		</div>
	</div>
	<!-- 페이징 -->
	<div class="product__pagination justify-content-center" id="pagination" style="display: flex;">
			<!-- 이전페이지(<-) -->
			<c:if test="${pagingDto.startPage != 1}">
				<a href="${pagingDto.startPage - 1}">
					<i class="fa fa-long-arrow-left"></i>
				</a>
			</c:if>
			<c:forEach var="v" begin="${pagingDto.startPage}" end="${pagingDto.endPage}">
				<a 
					<c:choose>
						<c:when test="${v == pagingDto.page}">
							class="green_background" style="color: white;"
					 	</c:when>
					 	<c:otherwise>
					 		class="page-item"
						</c:otherwise>
					</c:choose>
				href="${v}">${v}</a> 
				</c:forEach> 
			<!-- 다음페이지(->) -->
			<c:if test="${pagingDto.endPage < pagingDto.totalPage}">
				<a href="${pagingDto.endPage + 1}">
					<i class="fa fa-long-arrow-right"></i>
				</a>
			</c:if>
		</div>
		<!-- 페이징 끝 -->
	<div class="col-md-2"></div>
</div>

<%@ include file="../include/footer.jsp"%>
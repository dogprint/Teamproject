<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/workroomSide.jsp" %>
<script>
$(document).ready(function() {
	$(".pagination > a").click(function(e) {
		e.preventDefault(); // 페이지 이동 막기
		var page = $(this).attr("href");
		var frmPaging = $("#frmPaging");
		frmPaging.find("[name=page]").val(page);
		frmPaging.submit();
	});

	$(".qCheck > li > a").click(function(e) {
		e.preventDefault();
		var searchType = $(this).text();
		$("#btnOption").text(searchType);
		console.log(searchType);
		console.log(searchType);
		var qCheck = $(this).attr("href");
		
		$("#frmPaging > input[name=qCheck]").val(qCheck);
		$("#frmPaging > input[name=page]").val("1");
		$("#frmPaging").submit();

	});
});
</script>
<form id="frmPaging" action="/workroom/hobby/${page_id}" method="get">
<input type="hidden" name="page" value="${pagingDto.page}"/>
<input type="hidden" name="perPage" value="${pagingDto.perPage}"/>
<input type="hidden" name="endRow" value="${pagingDto.endRow}"/>
<input type="hidden" name="qCheck" value="${pagingDto.qCheck}"/>
</form>
<div class="col-md-9">
	<div class="checkout__order">
		<div class="workroom_box row" style="height: 39px;">
			<h4>취미</h4>
			<ul class="nav nav-pills">
					<li>
					<div class="dropdown">
					  <button id="btnOption" class="form-control btn btn-outline-light green_background dropdown-toggle" 
					  type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
					    <c:choose>
					    <c:when test="${pagingDto.qCheck == 0}">인기 취미</c:when>
					    <c:when test="${pagingDto.qCheck == 1}">최신 취미</c:when>
					    </c:choose>
					  </button>
					  <ul class="qCheck dropdown-menu" aria-labelledby="dropdownMenuButton1">
					    <li><a class="dropdown-item" href="0">인기 취미</a></li>
					    <li><a class="dropdown-item" href="1">최신 취미</a></li>
					  </ul>
					</div>
					</li>
			</ul>
		</div>
		<hr>
		<div class="row featured__filter">
		<c:forEach var="hobbyVo" items="${hobbyList}">
			<div class="col-lg-3 col-md-4 col-sm-6 mix oranges fresh-meat">
				<div class="featured__item">
					<div class="featured__item__pic set-bg"
						data-setbg="/displayImage?filePath=${hobbyVo.main_img}">
						<ul class="featured__item__pic__hover">
							<li><a href="#"><i class="fa fa-heart"></i></a></li>
							<li><a href="#"><i class="fa fa-retweet"></i></a></li>
							<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
						</ul>
					</div>
					<div class="featured__item__text">
						<h6>
							<a href="/hobby/content/${hobbyVo.hobby_no}">${hobbyVo.hobby_title}</a>
						</h6>
					</div>
				</div>
			</div>
			</c:forEach>
			
		</div>
		<div class="product__pagination justify-content-center pagination" style="display: flex;">
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
			<a href="${pagingDto.startPage + 1}">
				<i class="fa fa-long-arrow-right"></i>
			</a>
			</c:if>
		</div>
	</div>
</div>
<div class="col-md-2"></div>
</div>
</div>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="../include/footer.jsp"%>
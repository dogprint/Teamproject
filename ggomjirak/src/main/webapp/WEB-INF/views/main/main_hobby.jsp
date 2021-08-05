<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>
<script>
$(document).ready(function() {
	$(".pagination > a").click(function(e) {
		e.preventDefault(); // 페이지 이동 막기
		var page = $(this).attr("href");
		var frmPaging = $("#frmPaging");
		frmPaging.find("[name=page]").val(page); // page에 페이지 숫자 넣어줌
		console.log(page);
		frmPaging.submit();
		// -> 주소창에 : http://localhost/board/listAll?page=1&perPage=10&searchType=&keyword=
	});
	// 카테고리 검색
	$("#m_cate > li > a").click(function(e) {
		e.preventDefault();
		var cate = $(this).attr("href");
		var parent_cate = $(this).attr("data-cate");
		console.log(cate);
		$("#frmPaging > input[name=parent_cate_no]").val(parent_cate);
		$("#frmPaging > input[name=m_cate_no]").val(cate);
		$("#frmPaging > input[name=page]").val("1");

		$("#frmPaging").submit();

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
<form id="frmPaging" action="/main/mainHobby" method="get">
<input type="hidden" name="page" value="${pagingDto.page}"/>
<input type="hidden" name="perPage" value="${pagingDto.perPage}"/>
<input type="hidden" name="endRow" value="${pagingDto.endRow}"/>
<input type="hidden" name="parent_cate_no" value="${pagingDto.parent_cate_no}"/>
<input type="hidden" name="m_cate_no" value="${pagingDto.m_cate_no}"/>
<input type="hidden" name="qCheck" value="${pagingDto.qCheck}"/>
</form>
<div class="row m_top">
	<div class="col-md-12">
		<div class="row">
			<div class="col-md-1 col-lg-2"></div>
			<div class="col-md-10 col-lg-8">

				<!-- 검색 카테고리 메뉴 -->
				<div class="row">
					<div class="col-md-3 col-lg-2">

						<div class="flex-shrink-0 p-3 bg-white">
							<a href="/main/mainHobby"
								class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
								<svg class="bi me-2" width="30" height="24">
									<use xlink:href="#bootstrap" /></svg> <span class="fs-5 fw-semibold">카테고리</span>
							</a>
							<c:forEach var="bigSort" items="${bigSort}">
								<ul class="list-unstyled ps-0">
									<li class="mb-1">
										<button class="btn btn-toggle align-items-center rounded collapsed"
											data-bs-toggle="collapse" data-bs-target="#home-collapse"
											aria-expanded="false">${bigSort.cate_name}</button>
											
											<c:forEach var="smallSort" items="${smallSort}">
											<c:if test="${bigSort.cate_no == smallSort.parent_cate_no}">
												<!-- class="collapse show" 하위 보이게 하기 -->
												<div 
												<c:choose>
												<c:when test="${pagingDto.parent_cate_no == smallSort.parent_cate_no}">
												class="collapse show"
												</c:when>
												<c:otherwise>
											 		class="collapse"
												</c:otherwise>
												</c:choose>
												 id="home-collapse">
													<ul id="m_cate" class="btn-toggle-nav list-unstyled fw-normal pb-1">
														<li><a href="${smallSort.cate_no}" data-cate="${smallSort.parent_cate_no}"
														<c:choose>
														<c:when test="${pagingDto.m_cate_no == smallSort.cate_no}">
														class="link-dark rounded orange_color"
														</c:when>
														<c:otherwise>
														class="link-dark rounded"
														</c:otherwise>
														</c:choose>
														
														>${smallSort.cate_name}</a></li>
													</ul>
												</div>
											</c:if>
										</c:forEach>
										
									</li>


									<li class="border-top my-3"></li>

								</ul>
							</c:forEach>
						</div>

					</div>

					<!-- 검색 카테고리 메뉴 끝-->

					<!-- 검색 결과 -->
					<div class="col-md-9 col-lg-10">

						<ul class="nav nav-pills">
							<li>
							<div class="dropdown">
							  <button id="btnOption" class="form-control btn btn-outline-light green_background dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
							    <c:choose>
							    <c:when test="${pagingDto.qCheck == null}">검색 옵션</c:when>
							    <c:when test="${pagingDto.qCheck == 0}">인기 취미</c:when>
							    <c:when test="${pagingDto.qCheck == 1}">최신 취미</c:when>
							    <c:when test="${pagingDto.qCheck == 2}">이달의 취미</c:when>
							    </c:choose>
							    
							  </button>
							  <ul class="qCheck dropdown-menu" aria-labelledby="dropdownMenuButton1">
							    <li><a class="dropdown-item" href="0">인기 취미</a></li>
							    <li><a class="dropdown-item" href="1">최신 취미</a></li>
							    <li><a class="dropdown-item" href="2">이달의 취미</a></li>
							  </ul>
							</div>
							</li>
							<li class="nav-item dropdown">
								<button type="button"
									class="btn dropdown-toggle btn-outline-light green_background"
									data-bs-toggle="dropdown" href="#" role="button"
									aria-expanded="false">난이도</button>
								<ul class="dropdown-menu">
									<li><a class="dropdown-item" href="#">고급</a></li>
									<li><a class="dropdown-item" href="#">중급</a></li>
									<li><a class="dropdown-item" href="#">초급</a></li>
								</ul>
							</li>
						</ul>
						
						<!-- 취미글 목록 -->

						<div style="overflow: hidden;" class="m_top">
							<c:forEach var="cate" items="${cateHobby}">
								<div class="col-lg-3 col-md-4 col-sm-6" style="float: left;">
									<div class="featured__item">
										<div class="featured__item__pic set-bg"
											data-setbg="/displayImage?filePath=${cate.main_img}">
											<ul class="featured__item__pic__hover">
												<li><a href="#"><i class="fa fa-heart"></i></a></li>
												<li><a href="#"><i class="fa fa-retweet"></i></a></li>
												<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
											</ul>
										</div>
										<div class="featured__item__text">
											<h6>
												<a class="short" href="/hobby/content/${cate.hobby_no}">${cate.hobby_title}</a>
											</h6>
											<h5><a class="short" href="/workroom/main/${cate.user_id}">${cate.user_nick}</a></h5>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
						<!-- 페이징 -->
						<div class="product__pagination justify-content-center pagination"
							style="display: flex">
							<c:if test="${pagingDto.startPage != 1}">
								<a href="${pagingDto.startPage - 1}"><i
									class="fa fa-long-arrow-left"></i></a>
							</c:if>
							<c:forEach var="v" begin="${pagingDto.startPage}"
								end="${pagingDto.endPage}">
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
							<c:if test="${pagingDto.endPage < pagingDto.totalPage}">
								<a href="${pagingDto.endPage + 1}"><i
									class="fa fa-long-arrow-right"></i></a>
							</c:if>
						</div>
						<!-- 페이징 끝 -->
					</div>
				</div>
			</div>
			</div>
			<!-- 검색 결과 끝 -->

			<div class="col-md-1 col-lg-2"></div>
		</div>
	</div>




<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<%@ include file="../include/footer.jsp" %>

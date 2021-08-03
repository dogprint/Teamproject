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
	
});
</script>
<form id="frmPaging" action="/main/mainSearch" method="get">
<input type="hidden" name="page" value="${pagingDto.page}"/>
<input type="hidden" name="perPage" value="${pagingDto.perPage}"/>
<input type="hidden" name="keyword" value="${pagingDto.keyword}"/>
</form>
<div class="row">
	<div class="col-md-12">
		<div class="row">
			<div class="col-md-1 col-lg-2"></div>
			<div class="col-md-10 col-lg-8">

				<!-- 검색 카테고리 메뉴 -->
				<div class="row">
					<div class="col-md-3 col-lg-2">
					
						<nav id="navbar-example3"  style="position: fixed; top: 250px"
							class="navbar navbar-light flex-column align-items-stretch p-3 orange_color">
							<a class="navbar-brand border-bottom orange_color" href="#">검색</a>
							<nav class="nav nav-pills flex-column">
								<a class="nav-link text-gray" href="#item-1">취미</a>
								<a class="nav-link text-gray" href="#item-2">작가</a>
								<a class="nav-link text-gray" href="#item-3">Made by Me</a>
							</nav>
						</nav>
					</div>
					
					<!-- 검색 카테고리 메뉴 끝-->
					
					<!-- 검색 결과 -->
					<div class="col-md-9 col-lg-10">

						

						<div data-bs-spy="scroll" data-bs-target="#navbar-example3"
							data-bs-offset="0" tabindex="0">
							
							<table class="table">
							<thead>
								<tr><th scope="col">검색결과</th></tr>
							</thead>
							
							<tbody>
								<tr>
									<td>
										<div style="overflow:hidden;">
											<h4 id="item-1">취미</h4>
											
											<c:forEach var="hobby" items="${searchHobbyList}">
												<div class="col-lg-3 col-md-4 col-sm-6" style="float:left;">
													<div class="featured__item">
														<div class="featured__item__pic set-bg" data-setbg="/resources/img/featured/feature-1.jpg">
															<ul class="featured__item__pic__hover">
																<li><a href="#"><i class="fa fa-heart"></i></a></li>
																<li><a href="#"><i class="fa fa-retweet"></i></a></li>
																<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
															</ul>
														</div>
														<div class="featured__item__text">
															<h6><a href="#">${hobby.hobby_title}</a></h6>
															<h5>${hobby.user_nick}</h5>
														</div>
													</div>
												</div>
												</c:forEach>
											</div>
							
									</td>
								</tr>
								
								<tr>
									<td>
										<div style="overflow:hidden;">
							<h4 id="item-2">작가</h4>

							<c:forEach var="member" items="${searchMemberList}">
							<div class="col-lg-2 col-md-4 col-sm-6" style="float:left;">
								<div class="featured__item">

									<div class="featured__item__pic set-bg h-50" style="padding: 10px">
										<img src="/resources/img/featured/feature-2.jpg" class="rounded-circle" alt="..." />
										<ul class="featured__item__pic__hover">
											<li><a href="#"><i class="fa fa-heart"></i></a></li>
											<li><a href="#"><i class="fa fa-retweet"></i></a></li>
											<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
										</ul>
									</div>
									<div class="featured__item__text">
										<h6><a href="#">${member.user_nick}</a></h6>
										<h5>${member.name}</h5>
									</div>
								</div>
							</div>
							</c:forEach>
							
							</div>
									</td>
								</tr>
								
								<tr>
									<td>
										<div style="overflow:hidden;">
											<h4 id="item-3">Made by Me</h4>
												<div class="col-lg-3 col-md-4 col-sm-6" style="float:left;">
													<div class="featured__item">
														<div class="featured__item__pic set-bg" data-setbg="/resources/img/featured/feature-1.jpg">
															<ul class="featured__item__pic__hover">
																<li><a href="#"><i class="fa fa-heart"></i></a></li>
																<li><a href="#"><i class="fa fa-retweet"></i></a></li>
																<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
															</ul>
														</div>
														<div class="featured__item__text">
															<h6><a href="#">제목</a></h6>
															<h5>작가</h5>
														</div>
													</div>
												</div>
												
												<div class="col-lg-3 col-md-4 col-sm-6" style="float:left;">
													<div class="featured__item">
														<div class="featured__item__pic set-bg" data-setbg="/resources/img/featured/feature-2.jpg">
															<ul class="featured__item__pic__hover">
																<li><a href="#"><i class="fa fa-heart"></i></a></li>
																<li><a href="#"><i class="fa fa-retweet"></i></a></li>
																<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
															</ul>
														</div>
														<div class="featured__item__text">
															<h6><a href="#">제목</a></h6>
															<h5>작가</h5>
														</div>
													</div>
												</div>
												
												<div class="col-lg-3 col-md-4 col-sm-6" style="float:left;">
													<div class="featured__item">
														<div class="featured__item__pic set-bg" data-setbg="/resources/img/featured/feature-3.jpg">
															<ul class="featured__item__pic__hover">
																<li><a href="#"><i class="fa fa-heart"></i></a></li>
																<li><a href="#"><i class="fa fa-retweet"></i></a></li>
																<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
															</ul>
														</div>
														<div class="featured__item__text">
															<h6><a href="#">제목</a></h6>
															<h5>작가</h5>
														</div>
													</div>
												</div>
												
												<div class="col-lg-3 col-md-4 col-sm-6" style="float:left;">
													<div class="featured__item">
														<div class="featured__item__pic set-bg" data-setbg="/resources/img/featured/feature-4.jpg">
															<ul class="featured__item__pic__hover">
																<li><a href="#"><i class="fa fa-heart"></i></a></li>
																<li><a href="#"><i class="fa fa-retweet"></i></a></li>
																<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
															</ul>
														</div>
														<div class="featured__item__text">
															<h6><a href="#">제목</a></h6>
															<h5>작가</h5>
														</div>
													</div>
												</div>
												
											</div>
									</td>
								</tr>
								
							</tbody>
						</table>

							
						</div>
						<!-- 페이징 -->
						<div class="product__pagination justify-content-center pagination" style="display: flex">
						<c:if test="${pagingDto.startPage != 1}">
		                        <a href="${pagingDto.startPage - 1}"><i class="fa fa-long-arrow-left"></i></a>
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
		                <c:if test="${pagingDto.endPage < pagingDto.totalPage}">
		                        <a href="${pagingDto.endPage + 1}"><i class="fa fa-long-arrow-right"></i></a>
		                </c:if>
		                </div>
		                <!-- 페이징 끝 -->
					</div>
				</div>
			</div>
			<!-- 검색 결과 끝 -->
			

			<div class="col-md-1 col-lg-2"></div>
		</div>
	</div>
	
</div>


<%@ include file="../include/footer.jsp" %>
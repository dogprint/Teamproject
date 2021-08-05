<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>
<style>
.tiledBackground {
  wiedth: 100%;
   height: 400px; 
}
.btn-more {
   padding: 3px 13px;
   font-size: 14px;
   padding-top: 7px;
   margin: 0 4px;
   border: 1px solid #1F5E43;
}
</style>
<!-- 배너 -->
<script>
$(".bookmark").on(click, function(e) {
	e.preventDefault();
	var hobby_no = $(this).attr("href");
	console.log(hobby_no);
	if(loginVo == "") {
		return false;
	}
// 	var url = "/hobby/bookmark/" + hobby_no;
// 	$.get(url, function(rData) {
// 		console.log(rData);
// 		if (rData == "bookmark") {
// 			$(".bookmark > span:first-child").attr({
// 				class : "fa fa-bookmark",
// 				style : "color:#FFC300"
// 			})
// 		} else {
// 			$(".bookmark > span:first-child").attr({
// 				class : "fa fa-bookmark-o",
// 				style : "color:white"
// 			});
// 		}
// 	});

});
</script>
<div class="row">
	<div class="col-md-12" style="padding-bottom: 20px">
	
	<div class="tiledBackground green_background row" style="position: relative;"></div>
	
		<div class="row"  style="position: relative; top: -400px;">
			<div class="col-md-2"></div>
			<div class="col-md-8">
			
							
				<div class="carousel slide" id="carousel-313760">
					<ol class="carousel-indicators" style="bottom: 6rem;">
					<c:forEach var="v" begin="${pagingDto.startPage}" end="${pagingDto.count}">
						<li data-slide-to="${v}" data-target="#carousel-313760"
							<c:if test="${v == pagingDto.page}">
								class="active"
						 	</c:if>
							></li>
					</c:forEach>
					</ol>
					
					<div class="carousel-inner">
					
					<c:forEach var="event" items="${mainEvent}">
						<div 
						<c:choose>
							<c:when test="${pagingDto.page == event.rnum}">
								class="carousel-item active"
						 	</c:when>
						 	<c:otherwise>
						 		class="carousel-item"
							</c:otherwise>
						</c:choose>
						>
							<a href="/main/mainEventContent?e_no=${event.e_no}">
							<img class="d-block w-100" alt="Event Banner"
								src="/eventImg/displayImage?filePath=${event.e_img}" height="500"/></a>
							<div class="carousel-caption">
							<div style="display: flex;" >
								<h4><a href="/main/mainEventContent?e_no=${event.e_no}">${event.e_title}</a></h4>
								<p style="margin-left: auto;">${event.start_date} ~ ${event.end_date}</p>
							</div>
								
							</div>
						</div>
					</c:forEach>
						
						
					</div>
					<a class="carousel-control-prev" href="#carousel-313760"
						data-slide="prev" style="height: 500px"><span class="carousel-control-prev-icon"></span>
						<span class="sr-only">Previous</span></a> <a  style="height: 500px"
						class="carousel-control-next" href="#carousel-313760"
						data-slide="next"><span class="carousel-control-next-icon"></span>
						<span class="sr-only">Next</span></a>
				</div>
				
				
				<c:if test="${user_id != null} && ${cateStrVo.cate_no1 != '선택안함'} && ${cateStrVo.cate_no2 != '선택안함'} && ${cateStrVo.cate_no3 != '선택안함'}">
				<!-- 추천취미 -->
				<div class="row" style="margin-top: 50px">
					<div class="col-md-2">
						<div style="margin-right: 40px">
						<h5>추천취미</h5>
						<p>
						
						<c:if test="${cateStrVo.cate_no1 != '선택안함'}">
							${cateStrVo.cate_no1} <br/>
						</c:if>
						<c:if test="${cateStrVo.cate_no2 != '선택안함'}">
							${cateStrVo.cate_no2} <br/>
						</c:if>
						<c:if test="${cateStrVo.cate_no3 != '선택안함'}">
							${cateStrVo.cate_no3} <br/>
						</c:if>
						</p>
						
						</div>
						
					</div>
					<div class="col-md-10">
						<!-- Categories Section Begin -->
				<section class="categories">

					<div class="container">
						<div class="row">
							<div class="categories__slider owl-carousel">

								<c:forEach var="suggestHobby" items="${suggestHobby}">
								<div class="featured__item">
									<div class="featured__item__pic set-bg hobbyImg" data-setbg="/displayImage?filePath=${suggestHobby.main_img}"
										style="margin-left: 10px; margin-right: 10px">
										<ul class="featured__item__pic__hover">
											<li><a href="#"><i class="fa fa-heart"></i></a></li>
											<li><a href="#"><i class="fa fa-retweet"></i></a></li>
											<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
										</ul>
									</div>
										<div class="featured__item__text">
										<h6><a class="short" href="/hobby/content/${suggestHobby.hobby_no}">${suggestHobby.hobby_title}</a></h6>
										<h5><a class="short" href="/workroom/main/${suggestHobby.user_id}">${suggestHobby.user_nick}</a></h5>
									</div>
								</div>
								</c:forEach>

							</div>
						</div>
					</div>
				</section>
				<!-- Categories Section End -->
					</div>
				</div>
				<!-- 추천취미 끝 -->
				</c:if>
				
				<!-- 인기취미 -->
				<!-- Categories Section Begin -->
				<section class="section-title" style="margin-top: 50px">

				<div style="display: flex;">
						<h5>인기 취미</h5>
						<a href="/main/mainHobby?qCheck=0" type="button" class="btn-more"
						style="margin-left: auto; margin-bottom: 20px">더보기</a>
				</div>
					<div class="container">
						<div class="row">
							<div class="categories__slider owl-carousel">

								<c:forEach var="popular" items="${popularHobby}">
								<div class="featured__item">
									<div class="featured__item__pic set-bg" data-setbg="/displayImage?filePath=${popular.main_img}"
										style="margin-left: 10px; margin-right: 10px">
										<ul class="featured__item__pic__hover">
											<li><a href="#"><i class="fa fa-heart" style="color: red"></i></a></li>
											<li><a href="${popular.hobby_no}" class="bookmark"><i class="fa fa-bookmark" style="color: orange"></i></a></li>
										</ul>
									</div>
										<div class="featured__item__text">
										<h6><a class="short" href="/hobby/content/${popular.hobby_no}">${popular.hobby_title}</a></h6>
										<h5><a class="short" href="/workroom/main/${popular.user_id}">${popular.user_nick}</a></h5>
									</div>
								</div>
								</c:forEach>
								

								
						</div>
					</div>
					</div>
				</section>
				<!-- Categories Section End -->
				<!-- 인기취미 끝 -->
				
				<!-- 작가어워드 -->
				<!-- Featured Section Begin -->
    <section class="featured spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h2>작가 어워드</h2>
                    </div>
                    <div class="featured__controls">
                        <ul>
                            <li class="active" data-filter="*">전체</li>
                            <li data-filter=".grade4">금손</li>
                            <li data-filter=".grade3">은손</li>
                            <li data-filter=".grade2">곰손</li>
                            <li data-filter=".grade1">맨손</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row featured__filter">
            
            <c:forEach var="member1" items="${popularMember1}">
                <div class="col-lg-2 col-md-4 col-sm-6 mix grade${member1.user_grade}">
                    <div class="featured__item">
                    
                        <div class="featured__item__pic set-bg h-50" style="padding: 10px">
                        <a href="/workroom/main/${member1.user_id}"><img src="/displayImage?fileName=${member1.user_img}" class="rounded-circle" alt="profilImage"/></a>
                            <ul class="featured__item__pic__hover">
                                <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                                <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                            </ul>
                        </div>
                        <div class="featured__item__text">
                            <h6><a class="short" href="/workroom/main/${member1.user_id}">${member1.user_nick}</a></h6>
                            <h5>${member1.name}</h5>
                        </div>
                    </div>
                </div>
                </c:forEach>
            <c:forEach var="member2" items="${popularMember2}">
                <div class="col-lg-2 col-md-4 col-sm-6 mix grade${member2.user_grade}">
                    <div class="featured__item">
                    
                        <div class="featured__item__pic set-bg h-50" style="padding: 10px">
                        <img src="/mypage/displayImage?fileName=${member2.user_img}" class="rounded-circle" alt="profilImage"/>
                            <ul class="featured__item__pic__hover">
                                <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                                <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                            </ul>
                        </div>
                        <div class="featured__item__text">
                            <h6><a class="short" href="/workroom/main/${member2.user_id}">${member2.user_nick}</a></h6>
                            <h5>${member2.name}</h5>
                        </div>
                    </div>
                </div>
                </c:forEach>
            <c:forEach var="member3" items="${popularMember3}">
                <div class="col-lg-2 col-md-4 col-sm-6 mix grade${member3.user_grade}">
                    <div class="featured__item">
                    
                        <div class="featured__item__pic set-bg h-50" style="padding: 10px">
                        <a href="/workroom/main/${member3.user_id}"><img src="/displayImage?fileName=${member3.user_img}" class="rounded-circle" alt="profilImage"/></a>
                            <ul class="featured__item__pic__hover">
                                <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                                <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                            </ul>
                        </div>
                        <div class="featured__item__text">
                            <h6><a class="short" href="/workroom/main/${member3.user_id}">${member3.user_nick}</a></h6>
                            <h5>${member3.name}</h5>
                        </div>
                    </div>
                </div>
                </c:forEach>
            <c:forEach var="member4" items="${popularMember4}">
                <div class="col-lg-2 col-md-4 col-sm-6 mix grade${member4.user_grade}">
                    <div class="featured__item">
                    
                        <div class="featured__item__pic set-bg h-50" style="padding: 10px">
                        <a href="/workroom/main/${member4.user_id}"><img src="/mypage/displayImage?fileName=${member4.user_img}" class="rounded-circle" alt="profilImage"/></a>
                            <ul class="featured__item__pic__hover">
                                <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                                <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                            </ul>
                        </div>
                        <div class="featured__item__text">
                            <h6><a class="short" href="/workroom/main/${member4.user_id}">${member4.user_nick}</a></h6>
                            <h5>${member4.name}</h5>
                        </div>
                    </div>
                </div>
                </c:forEach>
                
               
                
            </div>
        </div>
    </section>
    <!-- Featured Section End -->
				<!-- 작가어워드 끝-->
				
			</div>
			
			<div class="col-md-2"></div>
		</div>
	</div>
</div>
<!-- 배너 끝 -->


<!-- 인기 키워드 -->

<div class="row" style="position: relative; top: -400px;">
		<div class="col-md-12">
			<div class="row">
				<div class="col-md-2"> </div>
				<div class="col-md-8">
				<div style="display: flex;">
						<h5>인기 키워드</h5>
						<a href="/main/mainHobby?qCheck=0" type="button" class="btn-more"
						style="margin-left: auto; margin-bottom: 20px">더보기</a>
				</div>
					
					
				</div>
				<div class="col-md-2"></div>
			</div>
			<div class="row green_background">
				<div class="col-md-12">
					<div class="row" style="padding: 20px">
						<div class="col-md-2"></div>
						<div class="col-md-8">
						
						<div>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1</button>
							
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1</button>
							<button type="button" class="rounded-pill btn-light btn green_color" style="margin: 10px">키워드1</button>
						</div>
						
						</div>
						<div class="col-md-2">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<!-- 인기 키워드 끝 -->

<!-- 이달의 취미 -->
<div class="row"  style="position: relative; top: -400px;">
	<div class="col-md-12">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">


				<!-- Categories Section Begin -->
				<section class="categories" style="margin-top: 50px">

					<div style="display: flex;">
						<h5>이달의 취미</h5>
						<a href="/main/mainHobby?qCheck=2" type="button" class="btn-more"
						style="margin-left: auto; margin-bottom: 20px">더보기</a>
					</div>
					<div class="container">
						<div class="row">
							

							<div class="categories__slider owl-carousel">

								<c:forEach var="month" items="${monthHobby}">
								<div class="featured__item">
									<div class="featured__item__pic set-bg" data-setbg="/displayImage?filePath=${month.main_img}"
										style="margin-left: 10px; margin-right: 10px">
										<ul class="featured__item__pic__hover">
											<li><a href="#"><i class="fa fa-heart"></i></a></li>
											<li><a href="#"><i class="fa fa-retweet"></i></a></li>
											<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
										</ul>
									</div>
										<div class="featured__item__text">
										<h6><a class="short" href="/hobby/content/${month.hobby_no}">${month.hobby_title}</a></h6>
										<h5><a class="short" href="/workroom/main/${month.user_id}">${month.user_nick}</a></h5>
									</div>
								</div>
								</c:forEach>

								
							</div>
						</div>
					</div>
				</section>
				<!-- Categories Section End -->
				<!-- 베스트메이드 -->
				<!-- Categories Section Begin -->
				<section class="categories" style="margin-top: 50px">

					<div style="display: flex;">
						<h5>베스트 메이드</h5>
						<a href="/main/mainHobby?qCheck=2" type="button" class="btn-more"
						style="margin-left: auto; margin-bottom: 20px">더보기</a>
					</div>
					<div class="container">
						<div class="row">

							<div class="categories__slider owl-carousel">

								<div class="featured__item">
									<div class="featured__item__pic set-bg" data-setbg="/resources/img/featured/feature-1.jpg"
										style="margin-left: 10px; margin-right: 10px">
										<ul class="featured__item__pic__hover">
											<li><a href="#"><i class="fa fa-heart"></i></a></li>
											<li><a href="#"><i class="fa fa-retweet"></i></a></li>
											<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
										</ul>
									</div>
										<div class="featured__item__text">
										<h6><a href="#">제목1</a></h6>
										<h5>작가1</h5>
									</div>
								</div>

								<div class="featured__item">
									<div class="featured__item__pic set-bg" data-setbg="/resources/img/featured/feature-2.jpg"
										style="margin-left: 10px; margin-right: 10px">
										<ul class="featured__item__pic__hover">
											<li><a href="#"><i class="fa fa-heart"></i></a></li>
											<li><a href="#"><i class="fa fa-retweet"></i></a></li>
											<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
										</ul>
									</div>
										<div class="featured__item__text">
										<h6><a href="#">제목2</a></h6>
										<h5>작가2</h5>
									</div>
								</div>

								<div class="featured__item">
									<div class="featured__item__pic set-bg" data-setbg="/resources/img/featured/feature-3.jpg"
										style="margin-left: 10px; margin-right: 10px">
										<ul class="featured__item__pic__hover">
											<li><a href="#"><i class="fa fa-heart"></i></a></li>
											<li><a href="#"><i class="fa fa-retweet"></i></a></li>
											<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
										</ul>
									</div>
										<div class="featured__item__text">
										<h6><a href="#">제목3</a></h6>
										<h5>작가3</h5>
									</div>
								</div>

								<div class="featured__item">
									<div class="featured__item__pic set-bg" data-setbg="/resources/img/featured/feature-4.jpg"
										style="margin-left: 10px; margin-right: 10px">
										<ul class="featured__item__pic__hover">
											<li><a href="#"><i class="fa fa-heart"></i></a></li>
											<li><a href="#"><i class="fa fa-retweet"></i></a></li>
											<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
										</ul>
									</div>
										<div class="featured__item__text">
										<h6><a href="#">제목4</a></h6>
										<h5>작가4</h5>
									</div>
								</div>

								<div class="featured__item">
									<div class="featured__item__pic set-bg" data-setbg="/resources/img/featured/feature-5.jpg"
										style="margin-left: 10px; margin-right: 10px">
										<ul class="featured__item__pic__hover">
											<li><a href="#"><i class="fa fa-heart"></i></a></li>
											<li><a href="#"><i class="fa fa-retweet"></i></a></li>
											<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
										</ul>
									</div>
										<div class="featured__item__text">
										<h6><a href="#">제목5</a></h6>
										<h5>작가5</h5>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>
				<!-- Categories Section End -->
				<!-- 베스트메이드 끝 -->
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
</div>
<!-- 이달의 취미 끝 -->


</div>			
	<!-- Footer-->
	<footer class="py-5 bg-dark"  style="position: relative; top: -350px;">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2021</p>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
<!-- 	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script> -->
	<!-- Core theme JS-->
	<script src="/resources/js/scripts.js"></script>
	    <!-- Footer Section Begin -->
    <footer class="footer spad" style="position: relative; top: -350px;">
        <div class="container" >
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="footer__about">
                        <div class="footer__about__logo">
                            <a href="./index.html"><img src="/resources/img/logo.png" alt=""></a>
                        </div>
                        <ul>
                            <li>Address: 60-49 Road 11378 New York</li>
                            <li>Phone: +65 11.188.888</li>
                            <li>Email: hello@colorlib.com</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6 offset-lg-1">
                    <div class="footer__widget">
                        <h6>Useful Links</h6>
                        <ul>
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">About Our Shop</a></li>
                            <li><a href="#">Secure Shopping</a></li>
                            <li><a href="#">Delivery infomation</a></li>
                            <li><a href="#">Privacy Policy</a></li>
                            <li><a href="#">Our Sitemap</a></li>
                        </ul>
                        <ul>
                            <li><a href="#">Who We Are</a></li>
                            <li><a href="#">Our Services</a></li>
                            <li><a href="#">Projects</a></li>
                            <li><a href="#">Contact</a></li>
                            <li><a href="#">Innovation</a></li>
                            <li><a href="#">Testimonials</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-12">
                    <div class="footer__widget" >
                        <h6>Join Our Newsletter Now</h6>
                        <p>Get E-mail updates about our latest shop and special offers.</p>
                        <form action="#">
                            <input type="text" placeholder="Enter your mail">
                            <button type="submit" class="site-btn">Subscribe</button>
                        </form>
                        <div class="footer__widget__social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-instagram"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-pinterest"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="footer__copyright">
                        <div class="footer__copyright__text"><p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p></div>
                        <div class="footer__copyright__payment"><img src="/resources/img/payment-item.png" alt=""></div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- Footer Section End -->

    <!-- Js Plugins -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>								
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" ></script>
    <script src="/resources/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/js/bootstrap.min.js"></script>
    <script src="/resources/js/jquery.nice-select.min.js"></script>
    <script src="/resources/js/jquery-ui.min.js"></script>
    <script src="/resources/js/jquery.slicknav.js"></script>
    <script src="/resources/js/mixitup.min.js"></script>
    <script src="/resources/js/owl.carousel.min.js"></script>
    <script src="/resources/js/main.js"></script>


	

</body>
</html>
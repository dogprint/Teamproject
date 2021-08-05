<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/workroomSide.jsp" %>
<!-- 간단 카드 보여주기 -->
<style>
.btn-more {
   padding: 3px 13px;
   font-size: 14px;
   padding-top: 7px;
   margin: 0 4px;
   border: 1px solid #1F5E43;
}

/* 문장 4문장까지 제한 */
.oooo {
	overflow: hidden;
	display: -webkit-box;
	-webkit-line-clamp: 4;
	-webkit-box-orient: vertical;
}

.card {
  background: #fff;
  border-radius: 2px;
  display: inline-block;
  height: 320px;
  margin: 1rem;
  position: relative;
  width: 180px;
  border-radius: 10px;
}

.card-1 {
  box-shadow: 0 1px 1px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.14);
  transition: all 0.3s cubic-bezier(.25,.8,.25,1);
}

.card-1:hover {
  box-shadow: 0 10px 20px rgba(0,0,0,0.10), 0 5px 19px rgba(0,0,0,0.12);
}

</style>
<div class="col-md-9">
	<!-- 소개 -->
	<div class="checkout__order">
		<div class="workroom_box">
			<h4>${workroomVo.wr_name}</h4>
		</div>
		<div class="workroom_box">
			<hr>
			<p>${workroomVo.wr_intro}</p>
		</div>
	</div>
	<!-- 취미 -->
	<div class="checkout__order" id="hobby">
		<div class="workroom_box row" style="height: 39px; display:flex;">
			<h4>취미</h4>
			<c:if test="${user_id == page_id}">
				<a href="/hobby/insert" class="fa fa-pencil" style="margin-top: 5px; margin-left: 10px;"></a>
			</c:if>
			<a href="/workroom/hobby/${page_id}" class="btn-more" style="margin-left:auto; margin-right:30px; height:35px;">더보기</a>
		</div>
		<hr>
			<div class="row">
			<c:choose>
				<c:when test="${hobbyCount > 5}">
					<div class="categories__slider owl-carousel">
					<c:forEach begin="0" end="8" var="hobbyVo" items="${hobbyList}">
						<div class="col-lg-3">
							<div class="categories__item set-bg"
								data-setbg="/displayImage?filePath=${hobbyVo.main_img}">
							</div>
							<div class="product__item__text">
                           		<h6><a href="/hobby/content/${hobbyVo.hobby_no}">${hobbyVo.hobby_title}</a></h6>
                         	</div>
						</div>
					</c:forEach>
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach begin="0" end="3" var="hobbyVo" items="${hobbyList}">
						<div class="col-lg-3">
							<div class="categories__item set-bg"
								data-setbg="/displayImage?filePath=${hobbyVo.main_img}">
							</div>
							<div class="product__item__text">
                           		<h6><a href="/hobby/content/${hobbyVo.hobby_no}">${hobbyVo.hobby_title}</a></h6>
                         	</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
				
			</div>
		</div>
	<!-- 스토리 -->
	<div class="checkout__order" id="story">
		<div class="workroom_box row" style="height: 39px; display:flex;">
				<h4>Story</h4>
				<c:if test="${user_id == page_id}">
					<a href="/story/write" class="fa fa-pencil" style="margin-top: 5px; margin-left: 10px;"></a>
				</c:if>
				<a href="/story/list/${page_id}" class="btn-more" style="margin-left:auto; margin-right:30px; height:35px;">더보기</a>
		</div>
		<div class="workroom_box">
			<hr>
			<div class="container-fluid">
				<c:forEach begin="0" end="2" var="storyVo" items="${storyList}">
					<div class="row">
						<div class="col-md-10" style="padding: 0px; margin: auto;">
							<p style="font-size: 15px; margin: 10px" class="story_detail">
								<a href="/story/detail/${page_id}?st_no=${storyVo.st_no}" class="oooo">${storyVo.st_content}</a><br> 
								<a class="fa fa-heart-o" href="/story/detail/${page_id}?st_no=${storyVo.st_no}" 
									style="margin-right: 5px"> ${storyVo.st_like_count}</a> 
								<a class="fa fa-comment-o" href="/story/detail/${page_id}?st_no=${storyVo.st_no}">
									${storyVo.st_c_count}</a>
							</p>
						</div>
						<div class="col-md-2" style="height:120px;">
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
	</div>
	<!-- mbm -->
	<div class="checkout__order" id="mbm">
		<div class="workroom_box row" style="height: 39px;">
			<h4>MadeByMe</h4>
			<a href="/mbm/write">작성</a>
			<a href="/workroom/mbm/${page_id}">더보기</a>
		</div>
		<hr>
		<div>
			<div class="row">
				<div class="categories__slider owl-carousel">
					<div class="col-lg-3">
						<div class="categories__item set-bg"
							data-setbg="/resources/img/test/sample08.jpg">
							<h5>
								<a href="#">test1</a>
							</h5>
						</div>
					</div>
					<div class="col-lg-3">
						<div class="categories__item set-bg"
							data-setbg="/resources/img/test/sample06.jpg">
							<h5>
								<a href="#">test2</a>
							</h5>
						</div>
					</div>
					<div class="col-lg-3">
						<div class="categories__item set-bg"
							data-setbg="/resources/img/test/sample07.jpg">
							<h5>
								<a href="#">test3</a>
							</h5>
						</div>
					</div>
					<div class="col-lg-3">
						<div class="categories__item set-bg"
							data-setbg="/resources/img/test/sample06.jpg">
							<h5>
								<a href="#">test4</a>
							</h5>
						</div>
					</div>
					<div class="col-lg-3">
						<div class="categories__item set-bg"
							data-setbg="/resources/img/test/sample07.jpg">
							<h5>
								<a href="#">test5</a>
							</h5>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 북마크 -->
	<div class="checkout__order" id="bookmark">
		<div class="workroom_box row" style="height: 39px; display:flex;">
			<h4>북마크</h4>
		</div>
			<hr>
			<div class="row">
			<c:choose>
				<c:when test="${bookmarkCount > 5}">
					<div class="categories__slider owl-carousel">
					<c:forEach begin="0" end="8" var="likebmVo" items="${bmList}">
						<div class="col-lg-3">
						<div class="card card-1">
							<div class="categories__item set-bg" style="border-radius: 10px 10px 0px 0px;"
								data-setbg="/displayImage?filePath=${likebmVo.main_img}">
							</div>
							<div class="product__item__text">
                           		<h6><a href="/hobby/content/${likebmVo.hobby_no}">${likebmVo.hobby_title}</a></h6>
								<div class="blog__details__author__pic row" style="width: 100%; height: 100%; ">
									<a href="/workroom/main/${likebmVo.user_id}" style="margin-left: auto; margin-right: auto;">
									<img src="/displayImage?filePath=${likebmVo.user_img}" style="height: 30px; width: 30px;" alt="">
									<span class="st_c_content" style="font-size:14px; margin-top: 5px; margin-left: 5px;">${likebmVo.user_nick}</span>
									</a>
								</div>
                         	</div>
                         </div>
						</div>
					</c:forEach>
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach begin="0" end="3" var="likebmVo" items="${bmList}">
						<div class="col-lg-3">
						<div class="card card-1">
							<div class="categories__item set-bg" style="border-radius: 10px 10px 0px 0px;"
								data-setbg="/displayImage?filePath=${likebmVo.main_img}">
							</div>
							<div class="product__item__text">
                           		<h6><a href="/hobby/content/${likebmVo.hobby_no}">${likebmVo.hobby_title}</a></h6>
								<div class="blog__details__author__pic row" style="width: 100%; height: 100%; ">
									<a href="/workroom/main/${likebmVo.user_id}" style="margin-left: auto; margin-right: auto;">
									<img src="/displayImage?filePath=${likebmVo.user_img}" style="height: 30px; width: 30px;" alt="">
									<span class="st_c_content" style="font-size:14px; margin-top: 5px; margin-left: 5px;">${likebmVo.user_nick}</span>
									</a>
								</div>
                         	</div>
                         </div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
				
			</div>
	</div>
</div>
</div>
</div>
<c:if test="${msgDelte == 'success'}">
      <script>
      Swal.fire({
         icon : "success",
         title : "삭제 성공",
      }).then(function(){close()});
      </script>
</c:if>
<c:if test="${msgDelte == 'fail'}">
      <script>
      Swal.fire({
         icon : "error",
         title : "삭제 실패",
      }).then(function(){close()});
      </script>
</c:if>
<c:if test="${msgInsert == 'success'}">
      <script>
      Swal.fire({
         icon : "success",
         title : "등록 성공",
      }).then(function(){close()});
      </script>
</c:if>
<c:if test="${msgInsert == 'fail'}">
      <script>
      Swal.fire({
         icon : "error",
         title : "등록 실패",
      }).then(function(){close()});
      </script>
</c:if>
<div class="col-md-2"></div>
</div>
</div>

<%@ include file="../include/footer.jsp"%>
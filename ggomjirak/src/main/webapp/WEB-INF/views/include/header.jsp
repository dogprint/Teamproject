<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">								
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
								
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>								 -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	 -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" ></script> -->

<!-- Google Font -->
<!-- <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet"> -->

<!-- Css Styles -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/elegant-icons.css" type="text/css">
<link rel="stylesheet" href="/resources/css/nice-select.css" type="text/css">
<link rel="stylesheet" href="/resources/css/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="/resources/css/style.css" type="text/css">


<title>Blog Home - Start Bootstrap Template</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/resources/css/styles.css" rel="stylesheet" />
<style>
.green_background {
	background-color: rgb(31, 94, 67);
}
.green_color {
	color:  rgb(31, 94, 67);
}
.white_color {
	color: white;
}
.orange_background {
	background-color:  rgb(231, 112, 92);
}
.orange_color {
	color:  rgb(231, 112, 92);
}
.m_top {
	margin-top: 25px;
}
.m_bottom {
	margin-bottom: 25px;
}
.short {
	overflow: hidden;
	display: -webkit-box;
	-webkit-line-clamp: 1;
	-webkit-box-orient: vertical;
}

</style>
<script>
$(document).ready(function() {
	
	//* 카테고리 부분
	var jsonData = JSON.parse('${cates}');
	var cate1Arr = new Array();
	var cate1Obj = new Object();
	// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
	for(var i = 0; i < jsonData.length; i++) {
	 if(jsonData[i].cate_level == "1") {
	  cate1Obj = new Object();  //초기화
	  cate1Obj.cate_no = jsonData[i].cate_no;
	  cate1Obj.cate_name = jsonData[i].cate_name;
	  cate1Arr.push(cate1Obj);
	 }
	}
	// 1차 분류 셀렉트 박스에 데이터 삽입
	var cate1Select = $("select.cate3")
	for(var i = 0; i < cate1Arr.length; i++) {
		 cate1Select.append("<option id='parent_cate_no' name='parent_cate_no' value='" + cate1Arr[i].cate_no + "'>"
	      + cate1Arr[i].cate_name + "</option>"); 
	}
	$(document).on("change", "select.cate3", function(){
		 var cate2Arr = new Array();
		 var cate2Obj = new Object();
		 // 2차 분류 셀렉트 박스에 삽입할 데이터 준비
		 for(var i = 0; i < jsonData.length; i++) {
		  if(jsonData[i].cate_level == "2") {
		   cate2Obj = new Object();  //초기화
		   cate2Obj.cate_no = jsonData[i].cate_no;
		   cate2Obj.cate_name = jsonData[i].cate_name;
		   cate2Obj.parent_cate_no = jsonData[i].parent_cate_no;
		   cate2Arr.push(cate2Obj);
		  }
		 }
		 var cate2Select = $("div.cate4");
		 cate2Select.children().remove();
		 $("option:selected", this).each(function(){
		  var selectVal = $(this).val();  
		  cate2Select.append("<a class='dropdown-item'>중분류</li>");
		  for(var i = 0; i < cate2Arr.length; i++) {
		   if(selectVal == cate2Arr[i].parent_cate_no) {
		    cate2Select.append("<a class='dropdown-item' value='" + cate2Arr[i].cate_no 
		    	+ "' data-cate='" + cate2Arr[i].parent_cate_no 
		    	+ "' href='/main/mainHobby?parent_cate_no=" + cate2Arr[i].parent_cate_no + "&m_cate_no=" + cate2Arr[i].cate_no + "'>"
		         + cate2Arr[i].cate_name + "</a>");
		   }
		  }
		 });
		
	});

	$("#frmSearch").submit(function() {
		if ($("#keyword").val() == null) {
			return false;
		}
		
	});
	$("#keyword").val("${pagingDto.keyword}");
	
	//* 카테고리 부분
	var MjsonData = JSON.parse('${managerList}');
	var mUserIdArr = new Array();
	var mUserIdObj = new Object();
	// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
	for(var i = 0; i < MjsonData.length; i++) {
		 mUserIdObj = new Object();  //초기화
		 mUserIdObj.user_id = MjsonData[i].user_id;
		 mUserIdArr.push(mUserIdObj);
	}
	var mUserIdLi = $("li.managerP")
	for(var i = 0; i < mUserIdArr.length; i++) {
		if("${user_id}" == MjsonData[i].user_id) {
			console.log(MjsonData[i].user_id);
			mUserIdLi.append("<a class='nav-link flex-item' href='/manager/managerHome'>관리자</a>"); 
		}
		
	}
	
	
});
</script>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">

				<div class="row">
					<div class="col-md-12 green_background">
						<div class="row">
							<div class="col-md-2"></div>
							<div class="col-md-8">
								
								<!-- 메뉴바 -->
								<nav class="navbar navbar-expand-lg navbar-dark">
								<button class="navbar-toggler" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#navbarSupportedContent"
									aria-controls="navbarSupportedContent" aria-expanded="false"
									aria-label="Toggle navigation">
									<span class="navbar-toggler-icon"></span>
								</button>
								  
									<div class="collapse navbar-collapse" id="navbarSupportedContent">
									  	<ul class="navbar-nav mr-auto color_white">
									    	<li class="nav-item"><a class="nav-link float-right" href="/main/mainHome">홈</a></li>
											<li class="nav-item"><a class="nav-link float-right" href="/main/mainHobby">취미</a></li>
											<li class="nav-item"><a class="nav-link float-right" href="/main/mainEvent">이벤트</a></li>
											<li class="nav-item"><a class="nav-link float-right" href="/main/mainAboutUs">소개</a></li>
								  		</ul>
								    
								    <ul class="nav navbar-nav navbar-right">
										<li class="nav-item managerP"></li>
								    	
								    	<c:if test="${user_id != null}">
										<li class="nav-item"><a class="nav-link flex-item" href="/workroom/main/${user_id}">내 작업실</a></li>
										</c:if>
										<c:if test="${user_id == null}">
										<li class="nav-item"><a class="nav-link" href="/mypage/login">로그인</a></li>
										</c:if>
										<c:if test="${user_id != null}">
										<li class="nav-item"><a class="nav-link flex-item" href="/hobby/insert">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
										  <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
										</svg>
										</a></li>
										<li class="nav-item dropdown">
										
										<div class="dropdown">
										<a class="nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bell-fill" viewBox="0 0 16 16">
											  <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>
											</svg>
										</a>
									    <div class="dropdown-menu">
									      <a class="dropdown-item" href="/mypage/infoForm">마이페이지</a>
										    <a class="dropdown-item" href="#">알림내용</a>
										    <a class="dropdown-item" href="#">알림내용</a>
										    <a class="dropdown-item" href="#">알림내용</a>
										    <a class="dropdown-item" href="#">알림내용</a>
										    <a class="dropdown-item" href="#">알림내용</a>
										    <a class="dropdown-item" href="#">알림내용</a>
										    <hr class="dropdown-divider">
										    <a class="dropdown-item" href="#">알림함</a>
									    </div>
									    </div>
										
										</li>
										
										<li class="nav-item dropdown ml-md-auto">
										
										<div class="dropdown">
										<a class="nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
											<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
													fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
												<path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" />
											</svg>
										</a>
									    <div class="dropdown-menu">
									      <a class="dropdown-item" href="/mypage/infoForm">마이페이지</a>
										    <a class="dropdown-item" href="/message/messageListReceive">쪽지함</a>
										    <a class="dropdown-item" href="/cs_center/consultQs">1:1문의</a>
										    <hr class="dropdown-divider">
										    <a class="dropdown-item" href="/mypage/logout">로그아웃</a>
									    </div>
									    </div>
										</li>
										</c:if>
									</ul>
								  </div>
								</nav>
								<!-- 메뉴바 끝 -->
								
								<!-- 로고 -->
								<header class="py-3 mb-4">
								  <div class="container d-flex flex-wrap justify-content-center">
								  
								    <a href="/main/mainHome" class="d-flex align-items-center mb-3 mb-lg-0 me-lg-auto text-dark text-decoration-none">
								      <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
								      <img src="/resources/img/logo06.png" class="rounded mx-auto" alt="..." >
								    </a>
								  </div>
								</header>
								<!-- 로고 끝 -->

								<!-- 검색 -->
								
								<form id="frmSearch" action="/main/mainSearch" method="get" class="needs-validation" novalidate>
								<div class="form-row">
							    
							    <div class="col-lg-2 col-md-3 mb-3">
<!-- 							      <label for="validationCustom04">대분류</label> -->
							      <select style="height: 38px; padding-top: 2px !important; text-align-last: center; text-align: center;" class="cate3 form-control btn btn-outline-light green_background white_color shadow bg-body rounded" id="validationCustom04" required>
							        <option selected disabled value="">카테고리</option>
							      </select>
							      <div class="invalid-feedback">
							      </div>
							    </div>
							    <div class="col-lg-2 col-md-3 mb-3">
									<div class="dropdown">
									  <button class="form-control btn btn-outline-light green_background shadow bg-body rounded dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									    카테고리
									  </button>
									  <div class="cate4 dropdown-menu" aria-labelledby="dropdownMenuButton">
									    <a class="dropdown-item" href="#">중분류</a>
									    
									  </div>
									</div>
							      <div class="invalid-feedback">
							      </div>
							    </div>
							    <div class="col-lg-8 col-md-6 mb-3">
							      <div class="input-group mb-3">
									  <input id="keyword" name="keyword" type="text" class="form-control shadow bg-body rounded" placeholder="나의 취미를 찾아보세요" aria-label="Recipient's username" aria-describedby="button-addon2">
									  <div class="input-group-append">
									    <button type="submit" class="btn btn-outline-light shadow bg-body rounded" id="btnSearch">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
											fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
										  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
										</svg>검색</button>
									  </div>
									</div>
							      <div class="invalid-feedback">
							      </div>
							    </div>
							  </div>
							  </form>
								</div>
								<!-- 검색 끝 -->
								
								
								</div>
								<div class="col-md-2"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
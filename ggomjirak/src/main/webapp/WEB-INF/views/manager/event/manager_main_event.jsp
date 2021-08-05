<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../manager_include/manager_header.jsp" %>
<script>
$(document).ready(function() {
	
	$(".pagination > li > a").click(function(e) {
		e.preventDefault(); // 페이지 이동 막기
		var page = $(this).attr("href");
		var frmPaging = $("#frmPaging");
		frmPaging.find("[name=page]").val(page); // page에 페이지 숫자 넣어줌
		console.log(page);
		frmPaging.submit();
		// -> 주소창에 : http://localhost/board/listAll?page=1&perPage=10&searchType=&keyword=
	});
	

	$(".btnCancel").click(function(e) {
		e.preventDefault
		var result = confirm("이벤트 베너 목록에서 삭제하시겠습니까?");
		if(result){
			var e_no = $(this).attr("data-eno");
			console.log(e_no);
		    $(this).attr("href", "/event/managerMainEventDeleteRun?e_no=" + e_no);
		}else{
		    return false;
		}
	});
	// 카테고리 검색
	$(".qCheck > li > a").click(function(e) {
		e.preventDefault();
		var qCheck = $(this).attr("href");
		var searchType = $("#frmPaging > input[name=searchType]").val();
		
		$("#frmPaging > input[name=qCheck]").val(qCheck);
		
		$("#frmPaging > input[name=page]").val("1");
		$("#frmPaging > input[name=searchType]").val(searchType);

		$("#frmPaging").submit();

	});
	// 검색 옵션 선택
	$(".searchType").click(function(e) {
		e.preventDefault();
		var searchType = $(this).attr("href");
		$("#frmPaging > input[name=searchType]").val(searchType);
		$("#btnSearchType").text($(this).text());
	});
	
	// 검색
	$("#btnSearch").click(function() {
		var searchType = $("#frmPaging > input[name=searchType]").val();
		if (searchType == "") {
			alert("검색 옵션을 선택해 주세요.");
			return;
		}
		
		var keyword = $("#txtSearch").val().trim();
		if ($("#txtSearch").val().trim() == "") {
			alert("검색어를 입력해 주세요.");
			return;
		}
		
		$("#frmPaging > input[name=keyword]").val(keyword);
		$("#frmPaging > input[name=page]").val("1");
		$("#frmPaging > input[name=searchType]").val(searchType);
		$("#frmPaging").submit();
	});
});
</script>
<form id="frmPaging" action="/event/managerMainEvent" method="get">
<input type="hidden" name="page" value="${pagingDto.page}"/>
<input type="hidden" name="perPage" value="${pagingDto.perPage}"/>
<input type="hidden" name="endRow" value="${pagingDto.endRow}"/>
<input type="hidden" name="qCheck" value="${pagingDto.qCheck}"/>
<input type="hidden" name="searchType" value="${pagingDto.searchType}"/>
<input type="hidden" name="keyword" value="${pagingDto.keyword}"/>
</form>
<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">이벤트 베너</h1>
	<div class="card shadow mb-4">
		<div class="card-body">
		
			<!-- 검색 -->
			<div class="form-row">
		    <div class="col-lg-2 col-md-3 mb-3">	    		  
				  <button class="form-control btn btn-success green_background dropdown-toggle" type="button"
						id="btnSearchType" data-toggle="dropdown">
							<c:if test='${pagingDto.searchType == null}'>옵션선택</c:if>
							<c:if test='${pagingDto.searchType == ""}'>옵션선택</c:if>
							<c:if test='${pagingDto.searchType == "t"}'>제목</c:if>
							<c:if test='${pagingDto.searchType == "u"}'>작성자</c:if>
							<c:if test='${pagingDto.searchType == "tu"}'>제목 + 작성자</c:if>
						
						</button> 				
						
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						<a class="dropdown-item searchType" href="t">제목</a> 
						<a class="dropdown-item searchType" href="u">작성자</a> 
						<a class="dropdown-item searchType" href="tu">제목 + 작성자</a> 
					</div>
		      <div class="invalid-feedback">
		      </div>
		    </div>
		    <div class="col-lg-10 col-md-9 mb-9">
		      <div class="input-group">
					<input type="text" class="form-control bg-light border-0"
						placeholder="검색어를 입력하세요" aria-label="Search"
						aria-describedby="basic-addon2" id="txtSearch" value="${pagingDto.keyword}">
					<div class="input-group-append">
						<button class="btn btn-success green_background white_color" type="button" id="btnSearch">
							<i class="fas fa-search fa-sm"></i>
						</button>
					</div>
				</div>
			      <div class="invalid-feedback">
			      </div>
			    </div>
			  </div>
			<!-- 검색 끝 -->
			
		</div>
	</div>

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold green_color" style="float:left;">이벤트 배너</h6>

		</div>
		
		<div class="card-body">
		
		<ul class="nav nav-tabs qCheck">
			<li class="nav-item"><a 
				<c:choose>
					<c:when test="${pagingDto.qCheck == 0}"> class="orange_color nav-link active" </c:when>
					<c:otherwise> class="green_color nav-link" </c:otherwise>
				</c:choose>
			href="0">전체 베너</a></li>
			<li class="nav-item"><a 
			<c:choose>
					<c:when test="${pagingDto.qCheck == 1}"> class="orange_color nav-link active" </c:when>
					<c:otherwise> class="green_color nav-link" </c:otherwise>
				</c:choose>
			href="1">진행중인 베너</a></li>
			<li class="nav-item"><a
			<c:choose>
					<c:when test="${pagingDto.qCheck == 2}"> class="orange_color nav-link active" </c:when>
					<c:otherwise> class="green_color nav-link" </c:otherwise>
				</c:choose>
			href="2">종료된 베너</a></li>
			
		</ul>
		
		<table class="table" id="eventTable">
		  <thead>
		    <tr>
		      <th scope="col">글 번호</th>
		      <th scope="col">작성자</th>
		      <th scope="col">제목</th>
		      <th scope="col">시작일</th>
		      <th scope="col">종료일</th>
		      <th scope="col">작성일</th>
		      <th scope="col">수정일</th>
		      <th scope="col">첨부파일</th>
		      <th scope="col">등록 취소</th>
		    </tr>
		  </thead>
		  <tbody>
		    
		 	<c:forEach var="event" items="${mainEvent}">
		    <tr>
		      <td scope="row">${event.e_no}</td>
		      <td>${event.user_id}</td>
		      <td><a href="/event/managerEventContent?e_no=${event.e_no}">${event.e_title}</a></td>
		      <td>${event.start_date}</td>
		      <td>${event.end_date}</td>
		      <td>${event.reg_date}</td>
		      <td>${event.mod_date}</td>
		      <td>${event.e_img}</td>
		      <td>
		      	<a data-eno="${event.e_no}" type="button" class="btn btn-danger orange_background btnCancel">취소</a>
		      </td>
		    </tr>
		    </c:forEach>
		  </tbody>
		</table>
		
		</div>
		
	</div>
	<!-- 페이징 -->
	<div class="row  text-center">
		<div class="col-md-12">
			<nav class="pagination justify-content-center">
				<ul class="pagination">
				<c:if test="${pagingDto.startPage != 1}">
					<li class="page-item"><a class="page-link" href="${pagingDto.startPage - 1}">&laquo;</a></li>
				</c:if>
				
				<c:forEach var="v" begin="${pagingDto.startPage}" end="${pagingDto.endPage}">
					<li
						<c:choose>
							<c:when test="${v == pagingDto.page}">
								class="page-item active"
						 	</c:when>
						 	<c:otherwise>
						 		class="page-item"
							</c:otherwise>
						</c:choose>
							><a class="page-link" href="${v}">${v}</a></li>
				</c:forEach>
				
				<c:if test="${pagingDto.endPage < pagingDto.totalPage}">
					<li class="page-item"><a class="page-link" href="${pagingDto.endPage + 1}">&raquo;</a></li>
				</c:if>
				</ul>
			</nav>
		</div>
	</div>
	<!-- // 페이징 -->
		
		
</div>
<!-- /.container-fluid -->


<%@ include file="../manager_include/manager_footer.jsp" %>
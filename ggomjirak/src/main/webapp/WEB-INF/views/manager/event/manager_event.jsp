<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../manager_include/manager_header.jsp" %>
<script>
$(document).ready(function() {
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth() + 1; //January is 0!
	var yyyy = today.getFullYear();
	if (dd < 10) {
	  dd = '0' + dd;
	}
	if (mm < 10) {
	  mm = '0' + mm;
	}
	var today = yyyy + '-' + mm + '-' + dd;
	console.log(today);
	$("#frmPaging > input[name=today]").val(today);
	
	$(".pagination > li > a").click(function(e) {
		e.preventDefault(); // 페이지 이동 막기
		var page = $(this).attr("href");
		var frmPaging = $("#frmPaging");
		frmPaging.find("[name=page]").val(page); // page에 페이지 숫자 넣어줌
		
		frmPaging.submit();
		// -> 주소창에 : http://localhost/board/listAll?page=1&perPage=10&searchType=&keyword=
	});
	$(".qCheck > li > a").click(function(e) {
		e.preventDefault();
		
		var qCheck = $(this).attr("href");
		var searchType = $("#frmPaging > input[name=searchType]").val();
		var keyword = $("#txtSearch").val().trim();
		
		$("#frmPaging > input[name=qCheck]").val(qCheck);
		
		$("#frmPaging > input[name=page]").val("1");
		
		$("#frmPaging > input[name=today]").val(today);
		$("#frmPaging > input[name=searchType]").val(searchType);
		$("#frmPaging > input[name=keyword]").val(keyword);

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
		$("#frmPaging > input[name=today]").val(today);
		$("#frmPaging").submit();
	});
	

	
});
</script>
<form id="frmPaging" action="/event/managerEvent" method="get">
<input type="hidden" name="page" value="${pagingDto.page}"/>
<input type="hidden" name="perPage" value="${pagingDto.perPage}"/>
<input type="hidden" name="endRow" value="${pagingDto.endRow}"/>
<input type="hidden" name="qCheck" value="${pagingDto.qCheck}"/>
<input type="hidden" name="today" value="${pagingDto.today}"/>
<input type="hidden" name="searchType" value="${pagingDto.searchType}"/>
<input type="hidden" name="keyword" value="${pagingDto.keyword}"/>
</form>
<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">이벤트</h1>
	<div class="card shadow mb-4">
		<div class="card-body">
		
			<!-- 검색 -->
			<div class="form-row">
		    <div class="col-lg-2 col-md-3 mb-3">	    		  
				  <button class="form-control btn btn-success green_background dropdown-toggle" type="button"
						id="btnSearchType" data-toggle="dropdown">
							<c:if test='${pagingDto.searchType == null}'>옵션 선택</c:if>
							<c:if test='${pagingDto.searchType == ""}'>옵션 선택</c:if>
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
			<h6 class="m-0 font-weight-bold green_color" style="float:left;">이벤트</h6>
			
			<a href="/event/managerEventWrite" type="button" class="btn btn-sm btn-success green_background float-right">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
			  <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
			</svg>
			글쓰기</a>
					
		</div>
		
		<div class="card-body">
		
		<ul class="nav nav-tabs qCheck">
			<li class="nav-item"><a 
				<c:choose>
					<c:when test="${pagingDto.qCheck == 0}"> class="orange_color nav-link active" </c:when>
					<c:otherwise> class="green_color nav-link" </c:otherwise>
				</c:choose>
			href="0">전체 이벤트</a></li>
			<li class="nav-item"><a 
			<c:choose>
					<c:when test="${pagingDto.qCheck == 1}"> class="orange_color nav-link active" </c:when>
					<c:otherwise> class="green_color nav-link" </c:otherwise>
				</c:choose>
			href="1">진행중인 이벤트</a></li>
			<li class="nav-item"><a
			<c:choose>
					<c:when test="${pagingDto.qCheck == 2}"> class="orange_color nav-link active" </c:when>
					<c:otherwise> class="green_color nav-link" </c:otherwise>
				</c:choose>
			href="2">종료된 이벤트</a></li>
			<li class="nav-item"><a
			<c:choose>
					<c:when test="${pagingDto.qCheck == 3}"> class="orange_color nav-link active" </c:when>
					<c:otherwise> class="green_color nav-link" </c:otherwise>
				</c:choose>
			href="3">삭제된 이벤트</a></li>
		</ul>
		
		<table class="table" id="eventTable">
		  <thead>
		    <tr>
		      <th scope="col">베너</th>
		      <th scope="col">글 번호</th>
		      <th scope="col">작성자</th>
		      <th scope="col">제목</th>
		      <th scope="col">시작일</th>
		      <th scope="col">종료일</th>
		      <th scope="col">작성일</th>
		      <th scope="col">수정일</th>
		      <th scope="col">첨부파일</th>
		      <th scope="col">삭제일</th>
		    </tr>
		  </thead>
		  <tbody>
		    
		 	<c:forEach var="event" items="${eventListAll}">
		    <tr>
		      <td scope="row">
		      <c:if test="${event.banner != 0}">
		      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="orange_color bi bi-check" viewBox="0 0 16 16">
				  <path d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.267.267 0 0 1 .02-.022z"/>
				</svg>
		      </c:if>
		      </td>
		      <td>${event.e_no}</td>
		      <td>${event.user_id}</td>
		      <td><a href="/event/managerEventContent?e_no=${event.e_no}"
		      <c:choose>
					<c:when test='${event.is_del == "N"}'> class="text-dark font-weight-bold" </c:when>
					<c:otherwise> class="text-muted" </c:otherwise>
				</c:choose>
		      >${event.e_title}</a></td>
		      <td>${event.start_date}</td>
		      <td 
		      <c:choose>
					<c:when test="${event.end_date < pagingDto.today}"> class="orange_color" </c:when>
					<c:otherwise> class="text-dark" </c:otherwise>
				</c:choose>
		      class="orange_color">
		      ${event.end_date}
		      </td>
		      <td>${event.reg_date}</td>
		      <td>${event.mod_date}</td>
		      <td>
		      <c:if test="${event.e_img != null}">
		      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-card-image" viewBox="0 0 16 16">
			  <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
			  <path d="M1.5 2A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13zm13 1a.5.5 0 0 1 .5.5v6l-3.775-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12v.54A.505.505 0 0 1 1 12.5v-9a.5.5 0 0 1 .5-.5h13z"/>
			</svg>
		      </c:if>
		      </td>
		      <td>${event.del_date}</td>
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
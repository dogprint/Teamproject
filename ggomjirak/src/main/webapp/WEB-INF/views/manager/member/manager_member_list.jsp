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
	
	// 검색 옵션 선택
	$(".searchType").click(function(e) {
		e.preventDefault();
		var searchType = $(this).attr("href");
		$("#frmPaging > input[name=searchType]").val(searchType);
		$("#dropdownMenuButton").text($(this).text());
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
		// 제목4검색하고 3페이지 넘어간 후에 제목5 검색했을 때 페이지가 뜨지 않는 경우(제목5의 글 수가 3페이지까지 없는경우)를 대비해 만들어줌
		// 검색버튼 눌렀을 때 1페이지부터 보여주게 함
		$("#frmPaging > input[name=page]").val("1");
		$("#frmPaging").submit();
	});
});
</script>
<form id="frmPaging" action="/manager/managerMemberList" method="get">
<input type="hidden" name="page" value="${pagingDto.page}"/>
<input type="hidden" name="perPage" value="${pagingDto.perPage}"/>
<input type="hidden" name="endRow" value="${pagingDto.endRow}"/>
<input type="hidden" name="searchType" value="${pagingDto.searchType}"/>
<input type="hidden" name="keyword" value="${pagingDto.keyword}"/>
</form>
<!-- Begin Page Content -->
<div class="container-fluid">
	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">회원 가입 정보</h1>
	<div class="card shadow mb-4">
		<div class="card-body">
		
			<!-- 검색 -->
			<div class="input-group">

				<div class="dropdown">
				<button class="btn btn-success green_background dropdown-toggle" type="button"
					id="dropdownMenuButton" data-toggle="dropdown">검색옵션</button> 
					<c:choose>
						<c:when test="${pagingDto.searchType == 'i'}">아이디</c:when>
						<c:when test="${pagingDto.searchType == 'n'}">닉네임</c:when>
						<c:when test="${pagingDto.searchType == 'm'}">이름</c:when>
						<c:when test="${pagingDto.searchType == 'in'}">아이디 + 닉네임</c:when>
						<c:when test="${pagingDto.searchType == 'inm'}">아이디 + 닉네임 + 이름</c:when>
					</c:choose>
					
					
				<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
					<a class="dropdown-item searchType" href="i">아이디</a> 
					<a class="dropdown-item searchType" href="n">닉네임</a> 
					<a class="dropdown-item searchType" href="m">이름</a> 
					<a class="dropdown-item searchType" href="in">아이디 + 닉네임</a> 
					<a class="dropdown-item searchType" href="inm">아이디 + 닉네임 + 이름</a>
				</div>
				<form
					class="d-sm-inline-block form-inline navbar-search">
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
				</form>
			</div>

				
			</div>
			<!-- 검색 끝 -->
			
		</div>
	</div>

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
	
	<div class="card-header py-3" style="overflow: hidden">
			<h6 class="m-0 font-weight-bold green_color" style="float: left;">회원 리스트</h6>
			
			<div class="dropdown">
				<select name="category"
					class="btn btn-outline-light green_background dropdown-toggle"
					data-bs-toggle="dropdown" aria-expanded="false">
					<option class="dropdown-item" value="ca">최신 순</option>
					<option class="dropdown-item" value="1">등급 순</option>
					<option class="dropdown-item" value="3">인기 순</option>
					<option class="dropdown-item" value="4">2</option>
				</select>
				<select name="category" class="btn btn-outline-light green_background dropdown-toggle"
					data-bs-toggle="dropdown" aria-expanded="false">
					<option class="dropdown-item" value="ca">검색 필터</option>
					<option class="dropdown-item" value="1">1</option>
					<option class="dropdown-item" value="2">2</option>
					<option class="dropdown-item" value="3">3</option>
					<option class="dropdown-item" value="4">4</option>
				</select>
			</div>
			
		</div>
	
		
		<div class="card-body">

			<div class="table-responsive">
				<table class="table" id="dataTable" width="100%" cellspacing="0">
					<thead>
						<tr>
							<th>#</th>
							<th>이름</th>
							<th>아이디</th>
							<th>비밀번호</th>
							<th>이메일</th>
							<th>전화번호</th>
							<th>닉네임</th>
							<th>회원가입일</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="member" items="${memberList}">
						<tr>
							<td>${member.rnum}</td>
							<td>${member.user_name}</td>
							<td><a href="/manager/managerMemberContent?user_id=${member.user_id}">${member.user_id}</a></td>
							<td>${member.user_pw}</td>
							<td>${member.user_email}</td>
							<td>${member.user_tel}</td>
							<td>${member.user_nick}</td>
							<td>${member.reg_date}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>
<!--   <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!--   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!--   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
<!-- mypage/alarmSetup.jsp -->
<!-- <title>회원 가입</title>
</head>
<body> -->
${memberVo}
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="row">
				<div class="col-md-2">
					<!-- 전체 페이지에서 왼쪽 패널  -->
				</div>
				<div class="col-md-8">
					<!-- 전체 페이지 메인 패널 -->
					<div class="row">
					<div class="col-md-3">
						<!-- 내부 패널 왼쪽 -->
						<%@ include file="mypage_include/mypage_left.jsp"%>
					</div>
					<div class="col-md-9">
						<!-- 내부 패널 메인 -->
						<br>
						<h3>회원 정보 정보 폼</h3>
						<br>
						<form role="form" id="frmInfo" action="/mypage/modifyForm" method="get" enctype="multipart/form-data">
							<table class="table">
								<thead>
									<tr>
										<th>#</th>
										<th>정보</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><label for="user_id">아이디</label> </td>
										<td>${memberVo.user_id}</td>
									</tr>
<%-- 									<tr>
										<td><label for="user_pw">비밀번호</label> </td>
										<td>${memberVo.user_pw}</td>
									</tr> --%>
									<tr>
										<td><label for="user_name">이름</label> </td>
										<td>${memberVo.user_name}</td>
									</tr>
									<tr>
										<td><label for="user_email">이메일</label> </td>
										<td>${memberVo.user_email}</td>
									</tr>
									<tr>
										<td><label for="user_tel">연락처</label> </td>
										<td>${memberVo.user_tel}</td>
									</tr>
									<tr>
										<td><label for="user_id">관심취미</label> </td>
										<td>${memberVo.cate_etc}</td>
									</tr>
								</tbody>
							</table>
							<br>
							<div class="form-group">
								<button type="submit" class="btn btn-primary">회원정보수정하기</button>
							</div>
						</form>
						</div> <!-- </div class="row"> --> 
					</div> <!-- 내부 패널 메인  끝 -->
				</div> 	<!-- 전체 페이지 메인 패널 끝 -->
				<div class="col-md-2">
					<!-- 전체 페이지 오른쪽 패널 -->
				</div>
			</div> <!-- </div class="row"> -->
		</div> <!-- </div class="col-md-12"> -->
	</div> <!-- </div class="row"> -->
</div> <!-- <div class="container-fluid"> -->
</body>

<%@ include file="../include/footer.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../manager_include/manager_header.jsp" %>
<script>
$(document).ready(function() {
	$("#btnCancel").click(function() {
		var result = confirm("페이지에서 나가시면 작성하시던 글이 사라집니다.");
		if(result){
		    $(this).attr("href", "/ask/managerAskContent?qna_no=${qnaVo.qna_no}");
		}else{
		    return false;
		}
	});
});
</script>
<!-- Begin Page Content -->
<div class="container-fluid">
	<!-- Page Heading -->
	<div style="display: flex;">
		<h1 class="h3 mb-2 text-gray-800">1:1문의 답변</h1>
		<a href="/ask/managerAsk" class="btn btn-success green_background" style="margin-left: auto; margin-bottom: 20px">목록</a>
	</div>


	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold green_color">문의</h6>
		</div>
		<div class="card-body">
		
			<table class="table">
			  <tbody>
			    <tr>
			      <th scope="row">번호</th>
			      <td>${qnaVo.qna_no}</td>
			      <th style="width: 15%; border-left: 1px solid lightgray">회원 아이디</th>
			      <td style="width: 20%">${qnaVo.user_id}</td>
			      <th style="width: 15%; border-left: 1px solid lightgray">작성일</th>
			      <td style="width: 20%">${qnaVo.save_time}</td>
			    </tr>
			    <tr>
			      <th scope="row">문의 유형</th>
			      <td colspan=5 style="width: 90%">${qnaVo.qna_type_nm}</td>
			    </tr>
			    <tr>
			      <th scope="row">제목</th>
			      <td colspan=5 style="width: 90%">${qnaVo.title}</td>
			    </tr>
			    <tr>
			      <th scope="row">내용</th>
			      <td colspan=5 style="width: 90%">${qnaVo.content}</td>
			      
			    </tr>
			  </tbody>
			</table>
		
		</div>
	</div>
	
	
	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold green_color">답변</h6>
		</div>
		<div class="card-body">
			<form action="/ask/managerAskAnswerRun" method="post">
			<input type="hidden" id="a_no" name="a_no" value="${qnaVo.qna_no}">
			<input type="hidden" id="qna_sort_cd" name="qna_sort_cd" value="${qnaVo.qna_sort_cd}">
			<input type="hidden" id="title" name="title" value="${qnaVo.title}">
			<input type="hidden" id="user_id" name="user_id" value="${lo_user_id}">
				<table class="table">
				  <tbody>
				    <tr>
				      <th scope="row">관리자</th>
				      <td style="width: 90%">${lo_user_id}</td>
				    </tr>
				    <tr>
				      <th scope="row">내용</th>
				      <td style="width: 90%">
				      		<textarea class="form-control" id="content" name="content" rows="10"></textarea>
				      </td>
				    </tr>
				  </tbody>
				</table>
				<div style="display: flex;">
					<button type="submit" class="btn btn-success green_background" style="margin-left: auto">답변</button>
					<a id="btnCancel" type="button" class="btn btn-danger orange_background" style="margin-left: 10px">취소</a>
				</div>
				
			</form>
		
		</div>
	</div>

</div>
<!-- /.container-fluid -->


<%@ include file="../manager_include/manager_footer.jsp" %>
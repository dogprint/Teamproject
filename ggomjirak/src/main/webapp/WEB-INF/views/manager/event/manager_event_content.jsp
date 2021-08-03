<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../manager_include/manager_header.jsp" %>
<script>
$(document).ready(function() {
	$("#btnCancel").click(function() {
		var result = confirm("이벤트를 삭제하시겠습니까?");
		if(result){
		    $(this).attr("href", "/event/managerEventDeleteRun?e_no=${eventVo.e_no}");
		}else{
		    return false;
		}
	});
	$("#btnBanner").click(function() {
		if ("${eventVo.is_del}" == "Y") {
			alert("삭제된 글은 베너에 올릴 수 없습니다.");
			return false;
			
		} else if ("${eventVo.e_img}".trim() == "") {
			alert("이미지가 없는 글은 베너에 올릴 수 없습니다.");
			return false;
			
		} else if ("${eventVo.banner}".trim() == "${eventVo.e_no}") {
			alert("이미 베너에 올라간 글입니다.");
			return false;
			
		} else {
			var result = confirm("${eventVo.e_title} 글을 메인 베너로 설정하시겠습니까?");
			if(result){
			    $(this).attr("href", "/event/managerMainEventInsertRun?e_no=${eventVo.e_no}");
			}else{
			    return false;
			}
		}
		
	});
});
</script>
<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">이벤트</h1>
	
	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div
			class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			<h6 class="m-0 font-weight-bold green_color">이벤트 게시글</h6>
			<div class="dropdown no-arrow">
				<a class="dropdown-toggle" href="#" role="button"
					id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <i
					class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
				</a>
				<div
					class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
					aria-labelledby="dropdownMenuLink">
					<div class="dropdown-header">이벤트 설정</div>
					<a class="dropdown-item" href="/event/managerEventModify?e_no=${eventVo.e_no}">이벤트 수정</a>
					<a id="btnCancel" class="dropdown-item">이벤트 삭제</a>
					<div class="dropdown-divider"></div>
					<a id="btnBanner" class="dropdown-item">메인 배너 설정</a>
				</div>
			</div>
		</div>

		<div class="card-body">
			<table class="table table-borderless">
				<thead>
					<tr>
						<th scope="col" colspan="2"><h3>${eventVo.e_title}</h3></th>

					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row">이벤트 진행 기간 : ${eventVo.start_date} ~ ${eventVo.end_date}</th>
						<td class="text-right">작성일 : ${eventVo.reg_date}</td>
					</tr>
					<tr>
						<td colspan="2">
						<c:if test="${eventVo.e_img != null}">
				      	<img src="/eventImg/displayImage?filePath=${eventVo.e_img}"
				      		class="card-img-top rounded mx-auto d-block" alt="EventImage"
							width="1000px" height="800px">
				      </c:if>
				      </td>
					</tr>
					<tr>
						<td colspan="2">${eventVo.e_content}</td>
					</tr>
				</tbody>
			</table>


		</div>
	</div>
	<div class="card shadow mb-4">
		<div class="card-body">

			<a href="/event/managerEvent" type="button" class="btn btn-success green_background">목록</a>

		</div>
	</div>
</div>
<!-- /.container-fluid -->



<%@ include file="../manager_include/manager_footer.jsp" %>
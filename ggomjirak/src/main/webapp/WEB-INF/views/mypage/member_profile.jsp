<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>
<!-- mypage/profileForm.jsp -->
<style>
	#fileDrop{
		width: 80%;
		height: 100px;
		background-color: yellow;
		margin: 20px auto;
		border: 2px dashed blue;
	}
.divUploaded{
	width: 150px;
	height: left;
}
</style>
<script src="/resources/js/ty-script.js"></script>
<script>
$(document).ready(function(){
	var isCheckDupNick = false;
	var checkedNick = "";
	
	// 회원 가입 폼 전송
	$("#frmJoin").submit(function(){
		if(isCheckDupNick == false || $("#user_nick").val() != checkedNick){
			alert("별명을 중복 체크를 해주세요.");
			$("#btnCheckDupNick").focus();
			return false;
		}
	});
	
	// 닉네임 중복 확인 버튼
	$("#btnCheckDupNick").click(function(){
		var url = "/mypage/checkDupNickProfile";
		var user_id = $("#user_id").val();
		var user_nick = $("#user_nick").val();
		var sendData = {
				"user_id" : user_id,
				"user_nick" : user_nick
		};
		$.get(url, sendData, function(rData) {
			console.log(rData);
			if(rData == "true"){
				$("#checkDupNickResult").text("사용 중인 닉네임").css("color", "red");
				isCheckDupNick = false;
			} else {
				$("#checkDupNickResult").text("사용 가능한 닉네임").css("color", "blue");
				isCheckDupNick = false;
			}
			checkedNick = user_nick;
		});
	});
	

	$("#fileDrop").on("dragenter dragover", function(e){
		e.preventDefault();
	});
	
	$("#fileDrop").on("drop", function(e){
		e.preventDefault();
		// 이벤트 확인
		console.log(e);
		var file = e.originalEvent.dataTransfer.files[0];
		console.log(file);
		// 이미지파일(바이너리 파일)
		// <form enctype ="multipart/form-data">
		// 		<input type="file"/>
		// </form>
		var formData = new FormData(); // <form>
		formData.append("file", file); // <input type="file">
									   // -> 선택한 파일 (파일을 선택한 상태)
		// 파일을 비동기 방식으로 전송
		// enctype = "multipart/form-data"
		var url = "/mypage/uploadAjax"; // HomeController > MyPageController
		$.ajax({
			"processData" : false,
			"contentType" : false, 
			"url": url, 
			"method": "post",
			"data": formData,
			"success": function(receivedData){
				console.log(receivedData);
				// split(delim) uuid_origial ??? 
//				var arrStr = receivedData.split("_"); ???
				var fileName = receivedData.substring(
						receivedData.lastIndexOf("_") + 1);
				var cloneDiv = $("#uploadedList").prev().clone();
				var img = cloneDiv.find("img");
				//이미지인 경우
				if(isImage(fileName)){
					//img.attr("src", "http://localhost/mypage/displayImage?fileName=" + receivedData);
					img.attr("src", "/mypage/displayImage?fileName=" + receivedData);
					console.log("receivedData: " + receivedData);
				}
				cloneDiv.find("span").text(fileName);
				cloneDiv.find(".a_times").attr("href", receivedData);
				console.log(cloneDiv);

				$("#uploadedList").append(cloneDiv.show());
			}
		});
	});
	
	// 첨부파일 삭제 링크
	// $(".a_times").click(function() {}); -> 이런 방법으로 사용하면 안 됨
	$("#uploadedList").on("click", ".a_times", function(e){
		e.preventDefault();
		var that = $(this);
		console.log("클릭");
		var fileName = $(this).attr("href");
		console.log(fileName);
		var url = "/deleteFile?fileName=" + fileName;
		$.get(url, function(rData){
			if(rData == "success"){
				that.parent().remove();
			}
		});
	});
	
 	// 폼전송
	$("#frmMemberProfile").submit(function() {
		console.log("폼전송 들어옴...")
		var div = $("#uploadedList .divUploaded");
		$(this).find("[names^=files]").remove();
		div.each(function(index) {
			var fileName = $(this).find(".a_times").attr("href");
			var html = "<input type='hidden' name='files["+index+"]' value='"+fileName+"'/>";
			$("#frmMemberProfile").prepend(html);
		});
		
		// return false;
	});

	//* 카테고리 부분 1st
	var jsonData = JSON.parse('${cates}');
	var category1Arr = new Array();
	var category1Obj = new Object();
	
	// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
	for(var i = 0; i < jsonData.length; i++) {
	 if(jsonData[i].cate_level == "1") {
	  category1Obj = new Object();  //초기화
	  category1Obj.cate_no = jsonData[i].cate_no;
	  category1Obj.cate_name = jsonData[i].cate_name;
	  category1Arr.push(category1Obj);
	 }
	}
	
	// 1차 분류 셀렉트 박스에 데이터 삽입
	var category1Select = $("select.category1")
	for(var i = 0; i < category1Arr.length; i++) {
		 category1Select.append("<option value='" + category1Arr[i].cate_no + "'>"
	      + category1Arr[i].cate_name + "</option>"); 
	}
	
	$(document).on("change", "select.category1", function(){
		 var category2Arr = new Array();
		 var category2Obj = new Object();
		 // 2차 분류 셀렉트 박스에 삽입할 데이터 준비
		 for(var i = 0; i < jsonData.length; i++) {
		  if(jsonData[i].cate_level == "2") {
		   category2Obj = new Object();  //초기화
		   category2Obj.cate_no = jsonData[i].cate_no;
		   category2Obj.cate_name = jsonData[i].cate_name;
		   category2Obj.parent_cate_no = jsonData[i].parent_cate_no;
		   category2Arr.push(category2Obj);
		  }
		 }
		 var category2Select = $("select.category2");
		 category2Select.children().remove();
		 $("option:selected", this).each(function(){
		  var selectVal = $(this).val();  
		  category2Select.append("<option value=''>중분류</option>");
		  for(var i = 0; i < category2Arr.length; i++) {
		   if(selectVal == category2Arr[i].parent_cate_no) {
		    category2Select.append("<option value='" + category2Arr[i].cate_no + "'>"
		         + category2Arr[i].cate_name + "</option>");
		   }
		  }
		});
	});
	
	//* 카테고리 부분 2nd
	var jsonData = JSON.parse('${cates}');
	var category3Arr = new Array();
	var category3Obj = new Object();
	
	// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
	for(var i = 0; i < jsonData.length; i++) {
	 if(jsonData[i].cate_level == "1") {
	  category3Obj = new Object();  //초기화
	  category3Obj.cate_no = jsonData[i].cate_no;
	  category3Obj.cate_name = jsonData[i].cate_name;
	  category3Arr.push(category3Obj);
	 }
	}
	
	// 1차 분류 셀렉트 박스에 데이터 삽입
	var category3Select = $("select.category3")
	for(var i = 0; i < category3Arr.length; i++) {
		 category3Select.append("<option value='" + category3Arr[i].cate_no + "'>"
	      + category3Arr[i].cate_name + "</option>"); 
	}
	
	$(document).on("change", "select.category3", function(){
		 var category4Arr = new Array();
		 var category4Obj = new Object();
		 // 2차 분류 셀렉트 박스에 삽입할 데이터 준비
		 for(var i = 0; i < jsonData.length; i++) {
		  if(jsonData[i].cate_level == "2") {
		   category4Obj = new Object();  //초기화
		   category4Obj.cate_no = jsonData[i].cate_no;
		   category4Obj.cate_name = jsonData[i].cate_name;
		   category4Obj.parent_cate_no = jsonData[i].parent_cate_no;
		   category4Arr.push(category4Obj);
		  }
		 }
		 var category4Select = $("select.category4");
		 category4Select.children().remove();
		 $("option:selected", this).each(function(){
		  var selectVal = $(this).val();  
		  category4Select.append("<option value=''>중분류</option>");
		  for(var i = 0; i < category4Arr.length; i++) {
		   if(selectVal == category4Arr[i].parent_cate_no) {
		    category4Select.append("<option value='" + category4Arr[i].cate_no + "'>"
		         + category4Arr[i].cate_name + "</option>");
		   }
		  }
		});
	});
	
	//* 카테고리 부분 3rd
	var jsonData = JSON.parse('${cates}');
	var category5Arr = new Array();
	var category5Obj = new Object();
	
	// 1차 분류 셀렉트 박스에 삽입할 데이터 준비
	for(var i = 0; i < jsonData.length; i++) {
	 if(jsonData[i].cate_level == "1") {
	  category5Obj = new Object();  //초기화
	  category5Obj.cate_no = jsonData[i].cate_no;
	  category5Obj.cate_name = jsonData[i].cate_name;
	  category5Arr.push(category5Obj);
	 }
	}
	
	// 1차 분류 셀렉트 박스에 데이터 삽입
	var category5Select = $("select.category5")
	for(var i = 0; i < category5Arr.length; i++) {
		 category5Select.append("<option value='" + category5Arr[i].cate_no + "'>"
	      + category5Arr[i].cate_name + "</option>"); 
	}
	
	$(document).on("change", "select.category5", function(){
		 var category6Arr = new Array();
		 var category6Obj = new Object();
		 // 2차 분류 셀렉트 박스에 삽입할 데이터 준비
		 for(var i = 0; i < jsonData.length; i++) {
		  if(jsonData[i].cate_level == "2") {
		   category6Obj = new Object();  //초기화
		   category6Obj.cate_no = jsonData[i].cate_no;
		   category6Obj.cate_name = jsonData[i].cate_name;
		   category6Obj.parent_cate_no = jsonData[i].parent_cate_no;
		   category6Arr.push(category6Obj);
		  }
		 }
		 var category6Select = $("select.category6");
		 category6Select.children().remove();
		 $("option:selected", this).each(function(){
		  var selectVal = $(this).val();  
		  category6Select.append("<option value=''>중분류</option>");
		  for(var i = 0; i < category6Arr.length; i++) {
		   if(selectVal == category6Arr[i].parent_cate_no) {
		    category6Select.append("<option value='" + category6Arr[i].cate_no + "'>"
		         + category6Arr[i].cate_name + "</option>");
		   }
		  }
		});
	});
	
// 	$("select.category2").on('change', function() {
// 		console.log("$(this)");
// 	});
	
	$("#btnProfileSave").click(function(e){
		e.preventDefault();
		var cate2 = $("select.category2").val();
		var cate4 = $("select.category4").val();
		var cate6 = $("select.category6").val();

		$("#frmMemberProfile > input[name=cate_no1]").val(cate2);
		$("#frmMemberProfile > input[name=cate_no2]").val(cate4);
		$("#frmMemberProfile > input[name=cate_no3]").val(cate6);
		$("#frmMemberProfile").submit();
	});
	
});
</script>
<%-- ${memberVo} --%>
<%-- ${cates} --%>
<!-- 파일 업로드 안내 모달-->
<!-- <div class="container-fluid"> -->
<!-- 	<div class="row"> -->
<!-- 		<div class="col-md-12"> -->
<!-- 			<a id="modal-167712" href="#modal-container-167712" role="button" -->
<!-- 				class="btn" data-toggle="modal" style="">Launch demo modal</a> -->

<!-- 			<div class="modal fade" id="modal-container-167712" role="dialog" -->
<!-- 				aria-labelledby="myModalLabel" aria-hidden="true"> -->
<!-- 				<div class="modal-dialog" role="document"> -->
<!-- 					<div class="modal-content"> -->
<!-- 						<div class="modal-header"> -->
<!-- 							<h5 class="modal-title" id="myModalLabel">파일 처리</h5> -->
<!-- 							<button type="button" class="close" data-dismiss="modal"> -->
<!-- 								<span aria-hidden="true">×</span> -->
<!-- 							</button> -->
<!-- 						</div> -->
<!-- 						<div class="modal-body">파일을 업로드하는 중입니다...</div> -->
<!-- 						<div class="modal-footer"> -->
<!-- 							<button type="button" class="btn btn-primary">Save changes</button> -->
<!-- 							<button type="button" class="btn btn-secondary"	data-dismiss="modal">닫기</button> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->
<!-- <head> -->
<!-- <meta charset="UTF-8"> -->
<!-- <title>프로필 정보</title> -->
<!-- </head> -->
<!-- <body> -->
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
						<form role="form" id="frmMemberProfile" action="/mypage/modifyProfileRun" method="post" enctype="multipart/form-data">
							<input type="hidden" id="user_id" name="user_id" value="${memberVo.user_id}"/> 
							<input type="hidden" id="cate_no1" name="cate_no1" value="${memberVo.cate_no1}"/> 
							<input type="hidden" id="cate_no2" name="cate_no2" value="${memberVo.cate_no2}"/> 
							<input type="hidden" id="cate_no3" name="cate_no3" value="${memberVo.cate_no3}"/> 
							
							<div class="form-group">
								<label for="user_nick">닉네임</label> 
								<input type="text" class="form-control" id="user_nick" name="user_nick" 
									value="${memberVo.user_nick}"/> 
								<br/>
								<button type="button" class="btn btn-small btn-danger"
									id="btnCheckDupNick">닉네임 중복 확인</button>
								<span id="checkDupNickResult"></span>
							</div>
							
						<div class="form-group">
							<label for="exampleInputFile">프로필 이미지</label> 
							<%-- <img height = "100" id="user_img" name="user_img" 
							src="http://localhost/mypage/displayImage?fileName=${memberVo.user_img}" class ="img-rounded"/> --%>
							<img height= "100" id="user_img" name="user_img" 
							src="/mypage/displayImage?fileName=${memberVo.user_img}" class ="img-rounded"/>
						</div>
						<!-- 첨부 파일  -->
						<div class="form-group">
							<label for="exampleInputFile">프로필 이미지</label> 
							<!-- <input type="file"/> -->
								<label>첨부할 파일을 드래그 &amp; 드롭하세요.</label>
							<div id="fileDrop"></div>
						</div>
<!-- 						<div class="form-group"> -->

						<!-- 상단 폼전송 클릭에서 맞추는 부분 var div = $("#uploadedList .divUploaded");  -->
						<div style ="display:none" class="divUploaded"> 
							<img height="100" src="/resources/img/default_image.png" class="img-rounded"/><br>
							<br>
								<span>default</span> 
								<a href = "#" class="a_times">&times;</a>
						</div>
						
						
						<div id="uploadedList">
						
						</div>
<!-- 						<div class="sc-1xjzf4m-0 bXMjXX"></div> -->
<!-- 						<div class="sc-1ov8bm8-2 dMXdMC">이미지를 여기로 끌어다 놓거나, 여기를 눌러 파일을 선택하세요.</div> -->
<!-- 						<input type="file" accept="image/*" multiple="" class="sc-5d51x-0 gSOqCo"/></div> -->
						<!-- // 첨부 파일  -->

						<div class="form-group">
							<label for="user_details">부가 정보</label>
						</div>
						<div class="form-group">
							<label for="user_hobbys">관심 취미 선택</label>
						</div>
						<table>
							<tr>
								<td>
									<select	class="category1 form-control btn btn-outline-light green_background shadow bg-body rounded" 
									        style="margin-right: 10px" aria-label="Default select example">
									<option value="${memberVo.parent_cate_no1}" id="parent_cate_no1" >${memberVo.parent_cate_name1}</option>
									</select>
								</td>
								<td>
									<select	class="category2 form-control btn btn-outline-light green_background shadow bg-body rounded" 
									        style="margin-right: 10px" aria-label="Default select example">
									<option value="${memberVo.cate_no1}" >${memberVo.cate_name1}</option>
								    </select>
								</td>
							</tr>
							<tr>
								<td>
									<select	class="category3 form-control btn btn-outline-light green_background shadow bg-body rounded" 
									        style="margin-right: 10px" aria-label="Default select example" >
									<option value="${memberVo.parent_cate_no2}" id="parent_cate_no2">${memberVo.parent_cate_name2}</option>
									</select>
								</td>
								<td>
									<select	class="category4 form-control btn btn-outline-light green_background shadow bg-body rounded" 
									        style="margin-right: 10px" aria-label="Default select example">
									<option value="${memberVo.cate_no2}">${memberVo.cate_name2}</option>
								    </select>
								</td>
							</tr>
							<tr>
								<td>
									<select	class="category5 form-control btn btn-outline-light green_background shadow bg-body rounded" 
									        style="margin-right: 10px" aria-label="Default select example">
									<option value="${memberVo.parent_cate_no3}" id="parent_cate_no3">${memberVo.parent_cate_name3}</option>
									</select>
								</td>
								<td>
									<select	class="category6 form-control btn btn-outline-light green_background shadow bg-body rounded" 
									        style="margin-right: 10px" aria-label="Default select example">
									<option value="${memberVo.cate_no3}">${memberVo.cate_name3}</option>
								    </select>
								</td>
							</tr>
						</table>
							<br>
							<br>
							<div class="form-group">
								<label for="cate_etc">직접 입력</label>
								<input type="text" class="form-control" id="cate_etc" name="cate_etc" value="${memberVo.cate_etc}" />
							</div>

							<br><br>
							
						<!-- 상단 폼전송 클릭에서 맞추는 부분 var div = $("#uploadedList .divUploaded");  -->
						<div style ="display:none" class="divUploaded"> 
							<img height = "100" src="/resources/img/default_image.png"
								class ="img-rounded"/><br>
								<span>default</span> 
								<a href = "#" class="a_times">&times;</a>
						</div>
						
						<div id ="uploadedList">
							
						</div>
						<div style="clear:both;">
							<button type="submit" id="btnProfileSave" class="btn btn-primary">프로필 저장</button>
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
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
				$("#checkDupNickResult").text("사용 중인 별명").css("color", "red");
				isCheckDupNick = false;
			} else {
				$("#checkDupNickResult").text("사용 가능한 별명").css("color", "blue");
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
				// 이미지인 경우
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

// 	var selectBoxChange = function(value){
// 		console.log("값 변경 테스트: " + value);
// 		$("#changeInput").val(value);
	$("#changeTest").change(function(){

		var url = "/mypage/changeCate";
		var parent_cate_no = $(this).val();
		console.log("값 변경 테스트: " + parent_cate_no);
		$("#changeInput").val(parent_cate_no);
		
		var sendData = {
			"parent_cate_no" : parent_cate_no
		};
		
		$.get(url, sendData, function(rData) {
			console.log(rData);
		});
	});
	
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
	var cate1Select = $("select.cate1")
	for(var i = 0; i < cate1Arr.length; i++) {
		 cate1Select.append("<option value='" + cate1Arr[i].cate_no + "'>"
	      + cate1Arr[i].cate_name + "</option>"); 
	}
	$(document).on("change", "select.cate1", function(){
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
		 var cate2Select = $("select.cate2");
		 cate2Select.children().remove();
		 $("option:selected", this).each(function(){
		  var selectVal = $(this).val();  
		  cate2Select.append("<option value=''>중분류</option>");
		  for(var i = 0; i < cate2Arr.length; i++) {
		   if(selectVal == cate2Arr[i].parent_cate_no) {
		    cate2Select.append("<option value='" + cate2Arr[i].cate_no + "'>"
		         + cate2Arr[i].cate_name + "</option>");
		   }
		  }
		 });
	});
	
});
</script>
${memberVo}
<%-- ${cates} --%>
<!-- 파일 업로드 안내 모달-->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<a id="modal-167712" href="#modal-container-167712" role="button"
				class="btn" data-toggle="modal" style="">Launch demo modal</a>

			<div class="modal fade" id="modal-container-167712" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="myModalLabel">파일 처리</h5>
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">파일을 업로드하는 중입니다...</div>
						<div class="modal-footer">
							<!-- <button type="button" class="btn btn-primary">Save changes</button> -->
							<button type="button" class="btn btn-secondary"	data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
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
<%-- 							<input type="text" id="cate_no1" name="cate_no1" value="${memberVo.cate_no1}"/>  --%>
<%-- 							<input type="text" id="cate_no2" name="cate_no2" value="${memberVo.cate_no2}"/>  --%>
<%-- 							<input type="text" id="cate_no3" name="cate_no3" value="${memberVo.cate_no3}"/>  --%>
<%-- 							<input type="text" id="cate_name1" name="cate_name1" value="${memberVo.cate_name1}"/>  --%>
<%-- 							<input type="text" id="cate_name2" name="cate_name2" value="${memberVo.cate_name2}"/>  --%>
<%-- 							<input type="text" id="cate_name3" name="cate_name3" value="${memberVo.cate_name3}"/>  --%>
						<table>
<!-- 							<tr>
								<td>
									<select	class="cate1 form-control btn btn-outline-light green_background shadow bg-body rounded" 
									        style="margin-right: 10px" aria-label="Default select example">
									<option value="">대분류</option>
									</select>
								</td>
								<td>
									<select	class="cate2 form-control btn btn-outline-light green_background shadow bg-body rounded" 
									        style="margin-right: 10px" aria-label="Default select example">
									<option value="">중분류</option>
								    </select>
								</td>
							</tr> -->
							<tr>
								<td>
									<select	class="cate1 form-control btn btn-outline-light green_background shadow bg-body rounded" 
									        style="margin-right: 10px" aria-label="Default select example">
									<option value="" id="">대분류</option>
									</select>
								</td>
								<td>
									<select	class="cate2 form-control btn btn-outline-light green_background shadow bg-body rounded" 
									        style="margin-right: 10px" aria-label="Default select example">
									<option value="${memberVo.cate_no1}" id="cate_no1" name="cate_no1" >${memberVo.cate_name1}</option>
								    </select>
								</td>
							</tr>
							<tr>
								<td>
									<select	class="cate1 form-control btn btn-outline-light green_background shadow bg-body rounded" 
									        style="margin-right: 10px" aria-label="Default select example" >
									<option value="" id="">대분류</option>
									</select>
								</td>
								<td>
									<select	class="cate2 form-control btn btn-outline-light green_background shadow bg-body rounded" 
									        style="margin-right: 10px" aria-label="Default select example">
									<option value="${memberVo.cate_no2}" id="cate_no2" name="cate_no2">${memberVo.cate_name2}</option>
								    </select>
								</td>
							</tr>
							<tr>
								<td>
									<select	class="cate1 form-control btn btn-outline-light green_background shadow bg-body rounded" 
									        style="margin-right: 10px" aria-label="Default select example">
									<option value="" id="">대분류</option>
									</select>
								</td>
								<td>
									<select	class="cate2 form-control btn btn-outline-light green_background shadow bg-body rounded" 
									        style="margin-right: 10px" aria-label="Default select example">
									<option value="${memberVo.cate_no3}" id="cate_no3" name="cate_no3">${memberVo.cate_name3}</option>
								    </select>
								</td>
							</tr>
						</table>
								<!-- <div class="form-group"> -->
<!-- 								<label for="user_details">부가 정보</label> -->
<!-- 							</div> -->
<!-- 							<div class="form-group"> -->
<!-- 								<label for="user_hobbys">관심 취미 선택</label> -->
<!-- 							</div> -->
<!-- 							<table>	 -->
<!-- 							<tr> -->
<!-- 								<td> -->
<!-- 								<input type="text" id ="changeInput"/> -->
<%-- 								<c:if test ="${!empty list1}" > --%>
<!-- 									<select id="changeTest" onchange="selectBoxChange(this.value)"> -->
<!-- 									<select id="changeTest"> -->
<%-- 									<c:forEach var ="list1" items="${list1}"> --%>
<%-- 										<option value="${list1.cate_no}">${list1.cate_name}</option> --%>
<%-- 									</c:forEach> --%>
<!-- 									</select> -->
<%-- 								</c:if>									 --%>
<!-- 									&nbsp;??? -->
<!-- 								</td> -->
								
<!-- 								<td> -->
<%-- <%-- 								<c:if test ="${!empty list2}">										 --%> 
<!-- 									<select name="cate_no1" id="cate_no1"> -->
<%-- 										<c:forEach var ="list2" items="${list2}"> --%>
<%-- 										<option value="${list2.cate_no}">${list2.cate_name}</option> --%>
<%-- 									</c:forEach> --%>
<!-- 									</select> -->
<%-- <%-- 								</c:if> --%> 
<!-- 								</td> -->
<!-- 								<td> -->
<!-- 								<label for="changeInput">대분류에서 선택한 내용 코드</label> -->
							
<!-- 								</td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td> -->
<!-- 									<select name="bigSort2" id="bigSort2"> -->
<!-- 										<option value="bigSort2">대분류</option> -->
<!-- 										<option value="DIY">만들기</option> -->
<!-- 										<option value="painting">그리기</option> -->
<!-- 										<option value="decorating">꾸미기</option> -->
<!-- 									</select> -->
<!-- 								</td> -->
<!-- 								<td>										 -->
<!-- 									<select name="midSort2" id="midSort2"> -->
<!-- 										<option value="midSort2">중분류</option> -->
<!-- 										<option value="DIY">향초</option> -->
<!-- 										<option value="painting">수채화</option> -->
<!-- 										<option value="decorating">다이어리</option> -->
<!-- 									</select> -->
<!-- 								</td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td> -->
<!-- 									<select name="bigSort3" id="bigSort3"> -->
<!-- 										<option value="bigSort3">대분류</option> -->
<!-- 										<option value="DIY">만들기</option> -->
<!-- 										<option value="painting">그리기</option> -->
<!-- 										<option value="decorating">꾸미기</option> -->
<!-- 									</select> -->
<!-- 								</td> -->
<!-- 								<td>										 -->
<!-- 									<select name="midSort3" id="midSort3"> -->
<!-- 										<option value="midSort3">중분류</option> -->
<!-- 										<option value="DIY">향초</option> -->
<!-- 										<option value="painting">수채화</option> -->
<!-- 										<option value="decorating">다이어리</option> -->
<!-- 									</select> -->
<!-- 								</td> -->
<!-- 							</tr> -->
<!-- 							</table> -->
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
							<button type="submit" class="btn btn-primary">프로필 저장</button>
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
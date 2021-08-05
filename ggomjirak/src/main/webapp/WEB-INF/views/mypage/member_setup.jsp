<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>
<!-- mypage/alarmSetup.jsp -->
<!-- <title>설정</title> -->
<!-- </head> -->
<script>
$(document).ready(function(){
	
	//var memberVoOnOff = ${memberVo.onOff}.val();
	//console.log(memberVoOnOff);
	
	var onOff = $("#setup_onOff").val();
	console.log("알림 설정 화면 처음 들어왔을 때 " + onOff);
	
//	$("#radio_1").prop("checked", true);
//	$("#radio_1").attr('checked', 'checked');
	
	if(onOff == "on"){
		$("#on").prop("checked", true);
	} else if(onOff == "off") {
		$("#off").prop("checked", true);
	}
	
	// 설정 완료 버튼 클릭
	$("#btnSetup").click(function() {

// 		if($("#on").checked){
// 			onOff = "on";
// 		} else {
// 			onOff = "off";
// 		}
		
		onOff = $(':radio[name="onOff"]:checked').val();
		console.log("onOff: " + onOff);
		
		var user_id = "${memberVo.user_id}";
		var url = "/mypage/alarmSetUp";
		var sendData = {
			"onOff" : onOff,
			"user_id" : user_id
		}
		$.post(url, sendData, function(rData) {
			console.log(rData);
			if (rData == "success") {
				alert("알림 설정 완료");	
			}
		});
	});
	
});
</script>
${member}
<body>
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
						<form role="form" id="frmMemberSetUp" action="/mypage/alarmSetUpRun" method="post" enctype="multipart/form-data">
						<input type="hidden" id="setup_onOff" value="${memberVo.onOff}"/>
						
							<div class="form-group">
								<label for="onOff">알람 설정</label>
							</div>
							<!-- on off 추가하기 -->
							<input type="radio" id="on" name="onOff" value="on"> on
							<input type="radio" id="off" name="onOff" value="off"> off
							<br><br>
							<div class="form-group">
								<!-- <button type="submit" class="btn btn-primary">설정완료</button> -->
								<button type="button" class="btn btn-primary" id="btnSetup">설정 완료</button>
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
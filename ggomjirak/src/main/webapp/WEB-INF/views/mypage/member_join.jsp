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
<script>

function showErrorMsg(obj, msg) {
    obj.attr("class", "error_next_box");
    obj.html(msg);
    obj.show();
}

// function setFocusToInputObject(obj) {
//     if(submitFlag) {
//         submitFlag = false;
//         obj.focus();
//     }
//}
function checkId(event) {
        if(idFlag) return true;

        var id = $("#id").val();
        var oMsg = $("#idMsg");
        var oInput = $("#id");

        if ( id == "") {
            showErrorMsg(oMsg,"필수 정보입니다.");
            setFocusToInputObject(oInput);
            return false;
        }

        var isID = /^[a-z0-9][a-z0-9_\-]{4,19}$/;
        if (!isID.test(id)) {
            showErrorMsg(oMsg,"5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.");
            setFocusToInputObject(oInput);
            return false;
        }

        idFlag = false;
        $.ajax({
            type:"GET",
            url: "/user2/joinAjax?m=checkId&id=" + id ,
            success : function(data) {
                var result = data.substr(4);

                if (result == "Y") {
                    if (event == "first") {
                        showSuccessMsg(oMsg, "멋진 아이디네요!");
                    } else {
                        hideMsg(oMsg);
                    }
                    idFlag = true;
                } else {
                    showErrorMsg(oMsg, "이미 사용중이거나 탈퇴한 아이디입니다.");
                    setFocusToInputObject(oInput);
                }
            }
        });
        return true;
    }
    
    

$(document).ready(function(){
	var msg = "${msg}";
	if (msg == "success") {
		alert("수정 완료");
	}
	
	var isCheckDupId = false;
	var checkedId = "";
	
	var isCheckDupNick = false;
	var checkedNick = "";
	
	// 회원 가입 폼 전송
	$("#frmJoin").submit(function(){
		if($("#user_id").val() == ""){
			alert("아이디를  입력해주세요.");
			$("#user_id").focus();
			return false;
		}		
			
		if($("#user_pw").val() != $("#user_pw2").val()) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#user_pw").focus();
			return false;
		}
		
		if(isCheckDupId == false || $("#user_id").val() != checkedId){
			alert("아이디 중복 체크를 해주세요.");
			$("#btnCheckDupId").focus();
			return false;
		}
		
		if(isCheckDupNick == false || $("#user_nick").val() != checkedNick){
			alert("별명을 중복 체크를 해주세요.");
			$("#btnCheckDupNick").focus();
			return false;
		}
	});
	
	// 아이디 중복 확인 버튼
	$("#btnCheckDupId").click(function(){
		
		//var oMsg = $("#idMsg");
		if($("#user_id").val() == ""){
			//showErrorMsg(oMsg, "아이디를  입력해주세요.");
			$("#checkDupIdResult").text("아이디를  입력해주세요.").css("color", "red");
			$("#user_id").focus();
			return false;
		}
		
		var url = "/mypage/checkDupId";
		var user_id = $("#user_id").val();
		var sendData = {
				"user_id" : user_id
		};
		$.get(url, sendData, function(rData) {
			console.log(rData);
			if(rData == "true"){
				$("#checkDupIdResult").text("이미 사용중이거나 탈퇴한 아이디입니다.").css("color", "red");
				isCheckDupId = false;
			} else {
				$("#checkDupIdResult").text("멋진 아이디네요!").css("color", "blue");
				isCheckDupId = true;
			}
			checkedId = user_id;
		});
	});
	
	// 닉네임 중복 확인 버튼
	$("#btnCheckDupNick").click(function(){
		
		if($("#user_nick").val() == ""){
			$("#checkDupNickResult").text("닉네임을  입력해주세요.").css("color", "red");
			$("#user_nick").focus();
			return false;
		}
		
		var url = "/mypage/checkDupNick";
		var user_nick = $("#user_nick").val();
		var sendData = {
				"user_nick" : user_nick
		};
		$.get(url, sendData, function(rData) {
			console.log(rData);
			if(rData == "true"){
				$("#checkDupNickResult").text("이미 사용 중인 닉네임입니다.").css("color", "red");
				isCheckDupNick = false;
			} else {
				$("#checkDupNickResult").text("멋진 닉네임이에요!").css("color", "blue");
				isCheckDupNick = true;
			}
			checkedNick = user_nick;
		});
	});
	
	
});
</script>
${list}
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
						<%-- <%@ include file="mypage_include/mypage_left.jsp"%> --%>
					</div>
					<div class="col-md-9">
						<!-- 내부 패널 메인 -->
						<br>
						<h3>회원 가입 폼</h3>
						<br>
						<!-- MyPageController -->
						<form role="form" id="frmJoin" action="/mypage/joinRun" method="post" enctype="multipart/form-data">

<!-- 								<table>
									<tr>
										<th scope="row">아이디 <img
											src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif"
											alt="필수" /></th>
										<td><input id="member_id" name="member_id"
											fw-filter="isFill&isFill&isMin[4]&isMax[16]&isIdentity"
											fw-label="아이디" fw-msg="" class="inputTypeText" placeholder=""
											value="" type="text" /> <span id="idMsg"></span> (영문소문자/숫자,
											4~16자)</td>
									</tr>
									<tr>
										<th scope="row">비밀번호 <img
											src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif"
											alt="필수" /></th>
										<td>
											<div class="eTooltip">
												<input id="passwd" name="passwd"
													fw-filter="isFill&isMin[4]&isMax[16]" fw-label="비밀번호"
													fw-msg="" autocomplete="off" maxlength="16"
													0="disabled" value="" type="password" />
												<div class="ec-base-tooltip typeUpper">
													<div class="content">
														<strong class="txtWarn">※ 비밀번호 입력 조건</strong>
														<ul class="ec-base-help typeDash gBlank10 txtWarn">

															- 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자
															<br> - 입력 가능 특수문자
															<br> &nbsp;&nbsp;&nbsp; ~ ` ! @ # $ % ^ ( ) _ - = {
															} [ ] | ; : < > , . ? /
															<br> - 공백 입력 불가능
														</ul>
													</div>
													<a href="#none" class="btnClose"><img
														src="//img.echosting.cafe24.com/skin/base/common/btn_close_tip.gif"
														alt="닫기" /></a> <span class="edge"></span>
												</div>
											</div> (영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자)
										</td>
									</tr>
									<tr>
										<th scope="row">비밀번호 확인 <img
											src="//img.echosting.cafe24.com/skin/base/common/ico_required.gif"
											alt="필수" /></th>
										<td><input id="user_passwd_confirm"
											name="user_passwd_confirm" fw-filter="isFill&isMatch[passwd]"
											fw-label="비밀번호 확인" fw-msg="비밀번호가 일치하지 않습니다."
											autocomplete="off" maxlength="16" 0="disabled" value=""
											type="password" /> <span id="pwConfirmMsg"></span></td>
									</tr>

								</table> -->




								<div class="form-group">
								<label for="user_info">필수 정보</label>
							</div>
							<div class="form-group">
								<label for="user_id">아이디*</label> 
								<input type="text" class="form-control" id="user_id" name="user_id" /> 
								<br/>
								<button type="button" class="btn btn-small btn-danger" id="btnCheckDupId">아이디 중복 확인</button>
								 <span class="error_next_box" id="idMsg" style="display:none" aria-live="assertive"></span>
								<span id="checkDupIdResult"></span>
							</div>
							<div class="form-group">
								<label for="user_pw">비밀번호*</label> 
								<input type="password" class="form-control" id="user_pw" name="user_pw" required placeholder="비밀번호(영문 숫자 특수문자 2가지 이상 6~15자 이내)" />
							</div>
							<div class="form-group">
								<label for="user_pw2">비밀번호 확인</label>
								<input type="password" class="form-control" id="user_pw2" required  />
							</div>
							<div class="form-group">
								<label for="user_name">이름</label>
								<input type="text" class="form-control" id="user_name" name="user_name" />
							</div>
							<div class="form-group">
								<label for="user_nick">닉네임*</label>
								<input type="text" class="form-control" id="user_nick" name="user_nick" />
								<br>
								<button type="button" class="btn btn-small btn-danger"
									id="btnCheckDupNick">닉네임 중복 확인</button>
								<span id="checkDupNickResult"></span>
							</div>
							<div class="form-group">
								<label for="user_email">이메일*</label>
								<input type="email"	class="form-control" id="user_email" name="user_email" />
							</div>
							<div class="form-group">
								<label for="user_tel">연락처</label>
								<input type="text" class="form-control" id="user_tel" name="user_tel" />
							</div>
							
							<br><br>
							<div class="form-group">
								<button type="submit" class="btn btn-primary">가입완료</button>
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
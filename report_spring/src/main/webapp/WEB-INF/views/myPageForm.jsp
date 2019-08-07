<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 common.jsp 파일 내의 소스를 삽입하기 -->
<%@include file="common.jsp"%>
<%@include file="checkLogin.jsp" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>Accounts - Product Admin Template</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700">
	<!-- https://fonts.google.com/specimen/Roboto -->
	<link rel="stylesheet" href="/ware/resources/css/fontawesome.min.css">
	<!-- https://fontawesome.com/ -->
	<link rel="stylesheet" href="/ware/resources/css/bootstrap.min.css">
	<!-- https://getbootstrap.com/ -->
	<link rel="stylesheet" href="/ware/resources/css/templatemo-style.css">
	<!--
	Product Admin CSS Template
	https://templatemo.com/tm-524-product-admin
	-->
<style>
	html {
		position: relative;
		min-height: 100%;
		margin: 0;
	}

	body {
		min-height: 100%;
	}
</style>
	<script>
		$(document).ready(function () {
			$(".onlynumber").bind("keyup", function () {
				var confirm = $(this).val();
				var num = "";
				var number = "0123456789";
				for (var i = 0; i < confirm.length; i++) {
					var s = confirm.charAt(i);
					if (number.indexOf(s) >= 0) {
						num = num + s;
					}
				}
				$(this).val(num);
			});
		});
		
		//***************************************************************
		// MyPage 유효성 체크
		//***************************************************************
		function checkMyPage() {

			var emp_pwd = $("[name=emp_pwd]").val();
			if (emp_pwd.split(" ").join("") == "") {
				$('.emp_pwd_valid').text("암호를 입력해 주십시오");
				$("[name=emp_pwd]").focus();
				return;
			}else{
				$('.emp_pwd_valid').text("체크");
			}

			var pwd_00 = $("[name=emp_pwd]").val();
			var pwd_01 = $("[name=new_emp_pwd]").val();
			var pwd_02 = $("[name=new_emp_pwd_chk]").val();

			if (pwd_01.split(" ").join("").length > 0) {
				if (pwd_02.split(" ").join("") == "") {
					$('.new_emp_pwd_chk_valid').text("새로운 암호 확인 입력요망");
					$("[name=new_emp_pwd_chk]").focus();
					return;
				} else if (pwd_01 != pwd_02) {
					$('.new_emp_pwd_chk_valid').text("새로운 암호 불일치");
					$("[name=new_emp_pwd_chk]").focus();
					return;
				}else{
					$('.new_emp_pwd_valid').text("체크");
					$('.new_emp_pwd_chk_valid').text("체크");
				}
			} else {
				if (pwd_02.split(" ").join("").length > 0) {
					$('.new_emp_pwd_valid').text("새로운 암호가 입력되지 않았습니다.");
					$("[name=new_emp_pwd]").focus();
					return;
				}
			}

			var emailV = $("[name=email]").val();
			if (emailV.split(" ").join("") != "") {
				var exptext = /^[A-Za-z0-9_\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
				if (!exptext.test(emailV)) {
					$('.email_valid').text("이메일형식이 올바르지 않습니다");
					$("[name=email]").focus();
					return;
				}
				else {
					$('.email_valid').text("체크");
				}
			}
			else {
				$('.email_valid').text("이메일을 입력해 주십시오");
				$("[name=email]").focus();
				return;
			}

			var phone = $("[name=phone_num]").val();
			if (phone.split(" ").join("") == "") {
				$('.phone_num_valid').text("전화번호를 입력해 주십시오");
				$("[name=phone_num]").focus();
				return;
			}
			if( is_pattern("phone_num",/^[0-9]{6,15}$/)==false ){
				$('.phone_num_valid').text("6~15자리의 숫자만 입력 가능합니다");
				$("[name=phone_num]").focus();
				return;
			}else{
				$('.phone_num_valid').text("체크");
			}

			if (confirm("정말 수정 하시겠습니까?") == false) {
				return;
			}

			$.ajax({
				url : "/ware/myPageProc.do",
				type : "post",
				data : $("[name=myPage]").serialize(),
				success : function(myPageCnt) {
					if (myPageCnt == 1) {
						alert("마이페이지 수정 성공!");
						document.gomypage.submit();
					} else if(myPageCnt == -10){
						alert("암호가 일치하지 않습니다.");
					}
					else {
						alert("마이페이지 수정 실패!");
					}
				},
				error : function() {
					alert("서버 접속 실패!");
				}
			});
		}
	</script>
	<style>
		.emp_pwd_valid,
		.new_emp_pwd_valid,
		.new_emp_pwd_chk_valid,
		.email_valid,
		.phone_num_valid {
			text-align: right;
			font-size: 11;
			color: yellow;
			height: 0;
		}
	</style>
</head>

<body id="reportsPage">
	<div class="" id="home">
		<nav class="navbar navbar-expand-xl">
			<div class="container h-100 navbar navbar-expand-xl">
				<a class="navbar-brand" style="height:100%" href="/ware/dashboard.do">
					<!-- <h1 class="tm-site-title mb-0">Product Admin</h1> -->
					<img class="navbar" src="/ware/resources/image/name_black.png">
				</a>
				<button class="navbar-toggler ml-auto mr-0" type="button" data-toggle="collapse"
					data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<i class="fas fa-bars tm-nav-icon"></i>
				</button>

				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav mx-auto h-100">
						<li class="nav-item">
							<a class="nav-link" href="javascript:document.goDashboard.submit();">
								<i class="fas fa-tachometer-alt"></i>
								대시보드
								<span class="sr-only">(current)</span>
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="javascript:document.goBoardListForm.submit();">
								<i class="far fa-comments"></i>
								공지사항
							</a>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
								data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<i class="far fa-file-alt"></i>
								<span>
									보고서결재 <i class="fas fa-angle-down"></i>
								</span>
							</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown" style="width: 100%">
								<a class="dropdown-item" href="javascript:document.goDailyListForm.submit();">일일 보고서</a>
								<a class="dropdown-item" href="javascript:document.goSalesListForm.submit();">영업 보고서</a>
								<a class="dropdown-item" href="javascript:document.goExpenseListForm.submit();">지출
									보고서</a>
							</div>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="javascript:document.goCalendar.submit();">
								<i class="far fa-calendar-alt"></i>
								일정관리
							</a>
						</li>

						<li class="nav-item active">
							<a class="nav-link" href="javascript:document.goMypageForm.submit();">
								<i class="far fa-user"></i>
								내정보
							</a>
						</li>
						<li class="nav-item dropdown" id="hidden_item" hidden>
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
								data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<i class="fas fa-cog"></i>
								<span>
									관리자페이지 <i class="fas fa-angle-down"></i>
								</span>
							</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown" style="width: 100%">
								<a class="dropdown-item" href="javascript:document.goEmployeeListForm.submit();" style="text-align: center">직원 관리</a>
								<a class="dropdown-item" href="javascript:document.goEmployeeListForm_beforeAllow.submit();" style="text-align: center">가입 관리</a>
								
							</div>
						</li>
					</ul>
					<ul class="navbar-nav">
						<li class="nav-item">
							<a class="nav-link d-block" href="/ware/loginForm.do">
								${emp_name} ${emp_jikup}<br><b><i class="fas fa-sign-out-alt"></i> Logout</b>
							</a>
						</li>
					</ul>
				</div>
			</div>

		</nav>

		<div class="container mt-5" style="margin-bottom: 80px">
			<!-- row -->
			<div class="row tm-content-row">
				<div class="tm-block-col tm-col-avatar">
					<div class="tm-bg-primary-dark tm-block tm-block-avatar">
						<h2 class="tm-block-title">내 사진</h2>
						<div class="tm-avatar-container">
							<img src="/ware/resources/emppic/${emp_no}.jpg" alt="Avatar" class="tm-avatar img-fluid mb-4 rounded-circle" style="width:310;height:310;"/>
						</div>
					</div>
				</div>
				<div class="tm-block-col tm-col-account-settings">
					<div class="tm-bg-primary-dark tm-block tm-block-settings">
						<h2 class="tm-block-title">계정 설정</h2>
						<form name="myPage" class="tm-signup-form row">
							<div class="form-group col-lg-6">
								<label for="emp_name">이름</label>
								<input id="emp_name" name="emp_name" type="text" class="form-control validate emp_name" value="${employeeDTO.emp_name}" style="color: black;" readonly/>
							</div>
							<div class="form-group col-lg-6">
								<label for="emp_no">사번</label>
								<input id="emp_no" name="emp_no" type="text" class="form-control validate emp_no" value="${employeeDTO.emp_no}" style="color: black;" readonly/>
							</div>
							<div class="form-group col-lg-6">
								<label for="emp_pwd">암호</label>
								<input id="emp_pwd" name="emp_pwd" type="password" class="form-control validate emp_pwd" placeholder=" 변경전 암호 입력"/>
								<div class=emp_pwd_valid></div>
							</div>
							<div class="form-group col-lg-6">
								<label for="phone_num">전화번호</label>
								<input id="phone_num" name="phone_num" type="tel" class="form-control validate phone_num" value="${employeeDTO.phone_num}"/>
								<div class=phone_num_valid></div>
							</div>
							<div class="form-group col-lg-6">
								<label for="new_emp_pwd">새로운 암호</label>
								<input id="new_emp_pwd" name="new_emp_pwd" type="password" class="form-control validate new_emp_pwd" placeholder=" 변경할 암호 입력"/>
								<div class=new_emp_pwd_valid></div>
							</div>
							<div class="form-group col-lg-6">
								<label for="new_emp_pwd_chk">새로운 암호확인</label>
								<input id="new_emp_pwd_chk" name="new_emp_pwd_chk" type="password" class="form-control validate new_emp_pwd_chk" placeholder=" 변경할 암호 입력 확인"/>
								<div class=new_emp_pwd_chk_valid></div>
							</div>
							<div class="form-group col-lg-6">
								<label for="email">이메일</label>
								<input id="email" name="email" type="email" class="form-control validate email" value="${employeeDTO.email}"/>
								<div class=email_valid></div>
							</div>
							
							<div class="form-group col-lg-6">
								<label class="tm-hide-sm">&nbsp;</label>
								<input type=button class="btn btn-primary btn-block text-uppercase" value="프로필 업데이트" onclick="checkMyPage();">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- <script src="js/jquery-3.3.1.min.js"></script> -->
	<!-- https://jquery.com/download/ -->
	<script src="/ware/resources/js/bootstrap.min.js"></script>
	<!-- https://getbootstrap.com/ -->
	<form name="boardContentForm" method="post" action="/ware/boardContentForm.do">
		<input type="hidden" name="b_no">
	</form>
	<form name="goDashboard" method="post" action="/ware/dashboard.do"></form>
	<form name="gomypage" method=POST action="/ware/myPageForm.do"></form>
	<form name="goBoardRegForm" method="post" action="/ware/boardRegForm.do"></form>

	<form name="goemployeeRegForm" method="post" action="/ware/employeeRegForm.do"></form>
	<form name="goLoginForm" method="post" action="/ware/loginForm.do"></form>
	<form name="goBoardListForm" method="post" action="/ware/boardListForm.do"></form>
	<form name="goExpenseListForm" method="post" action="/ware/expenseListForm.do"></form>
	<form name="goSalesListForm" method="post" action="/ware/salesListForm.do"></form>
	<form name="goDailyListForm" method="post" action="/ware/dailyListForm.do"></form>
	<form name="goCalendar" method="post" action="/ware/calendarForm.do"></form>
	<form name="goMypageForm" method="post" action="/ware/myPageForm.do"></form>
	<form name="goEmployeeListForm" method="post" action="/ware/employeeListForm.do"></form>
	<form name="goEmployeeListForm_beforeAllow" method="post" action="/ware/employeeListForm_beforeAllow.do"></form>
	<footer class="tm-footer row tm-mt-small" style="position:absolute; min-width:100%; left:0; right:0; bottom:0; margin-top: auto;">
		<div class="col-12 font-weight-light">
			<p class="text-center text-white mb-0 px-4 small">
				Copyright &copy; <b>2019</b> All rights reserved.
			</p>
		</div>
	</footer>
</body>

</html>
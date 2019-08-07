<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="common.jsp"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>헬로웍스 - 회원가입</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700" />
	<!-- https://fonts.google.com/specimen/Open+Sans -->
	<link rel="stylesheet" href="/ware/resources/css/fontawesome.min.css" />
	<!-- https://fontawesome.com/ -->
	<link rel="stylesheet" href="/ware/resources/css/bootstrap.min.css" />
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
	// 주민번호 전화번호 길이제한

		$(document).ready(function () {
			$(".jumin_num").attr("maxlength", 13);
			$(".phone_num").attr("maxlength", 15);			
			//===========================================================================
			// 숫자만 입력 유효성(사번, 주민번호, 전화번호)
			//===========================================================================

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
		function checkJoinForm() {

			var emp_name = $("[name=emp_name]").val();
			if (emp_name.split(" ").join("") == "") {
				//alert("이름을 입력해 주십시오");
				$('.emp_name_valid').text("이름을 입력해 주십시오");
				$(".emp_name").focus();
				return;
			}

			if (is_special_name('emp_name')) {
				//alert("이름에는 영대소문자, 한글만 사용가능합니다.");
				$('.emp_name_valid').text("이름에는 영대소문자, 한글만 사용가능합니다");
				$("[name=emp_name]").focus();
				return;
			}
			$('.emp_name_valid').text("체크");
			
			var pwd = $("[name=emp_pwd]").val();
			var check_pwd = $("[name=emp_pwd_chk]").val();
			
			if (pwd.split(" ").join("") == "") {
				$('.emp_pwd_valid').text("비밀번호를 입력해 주십시오.");
				// alert("암호를 입력해 주십시오");
				$("[name=emp_pwd]").val("");
				$("[name=emp_pwd]").focus();
				return;
			}
			else{
				if (check_pwd.split(" ").join("") == "") {
					// alert("비밀번호확인을 입력해 주십시오");
					$('.emp_pwd_valid').text("");
					$('.emp_pwd_chk_valid').text("비밀번호 확인을 입력해 주세요.");
					$("[name=emp_pwd_chk]").focus();
					return;
				} else if (pwd != check_pwd) {
					// alert("비밀번호가 일치하지 않습니다.");
					$('.emp_pwd_valid').text("");
					$('.emp_pwd_chk_valid').text("비밀번호가 일치하지 않습니다.");
					$("[name=emp_pwd_chk]").val("");
					$("[name=emp_pwd_chk]").focus();
					return;
				}
			}
			$('.emp_pwd_valid').text("");
			$('.emp_pwd_chk_valid').text("체크");
			
			var dep_no = $("[name=dep_no]").val();
			if (dep_no.split(" ").join("") == "") {
				$('.dep_no_valid').text("소속부서를 입력해 주십시오");
				//alert("소속부서를 입력해 주십시오");
				$("[name=dep_no]").focus();
				return;
			}
			else { $('.dep_no_valid').text("체크"); }
			var jumin_num = $("[name=jumin_num]").val();
			if (jumin_num.split(" ").join("") == "") {
				$('.jumin_num_valid').text("주민번호를 입력해 주십시오");
				$(".jumin_num").focus();
				return;
			}
			var Val = $(".jumin_num").val();
			var reg_jumin = /^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))[1-4][0-9]{6}$/;
			if (Val.length == 13 && reg_jumin.test(Val)) {
				$('.jumin_num_valid').text("체크");
			}
			else {
				$('.jumin_num_valid').text("주민번호 양식에 맞지 않습니다.");
				$(".jumin_num").focus();
				return;
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
			else {
				if (phone.length < 6) {
					$('.phone_num_valid').text("전화번호 최소 6자리이상");
					$("[name=phone_num]").focus();
					return;
				}
				else {
					$('.phone_num_valid').text("체크");
				}
			}	

			if (confirm("정말 회원가입 하시겠습니까?") == false) {
				return;
			}

			$.ajax({
				url: "/ware/joinProc.do",
				type: "post",
				data: $("[name=joinForm]").serialize(),
				success: function (data) {
					//alert(data);
					var xxx = data + "";
					xxx = xxx.split(" ").join("");
					//alert(xxx);
					var insertEmpCnt = xxx.substr(0, 1);
					//alert(insertEmpCnt);
					var loginEmpNo = xxx.substr(1);
					//alert(loginEmpNo);
					if (insertEmpCnt == 1) {
						alert("회원가입 성공!");
						alert("로그인시 사용할 사원번호는 " + loginEmpNo + "입니다.");
						document.loginForm.submit();
					} else {
						alert("회원가입 실패!");
					}
				},
				error: function () {
					alert("서버 접속 실패!");
				}
			});

		}

		function goLoginForm() {
			document.loginForm.submit();
		}
	</script>
	<style>
		.emp_name_valid,
		.emp_pwd_valid,
		.emp_pwd_chk_valid,
		.dep_no_valid,
		.jumin_num_valid,
		.email_valid,
		.phone_num_valid {
			text-align: right;
			font-size: 11;
			color: yellow;
			height: 0;
		}
	</style>
</head>

<body>
	<div>
		<nav class="navbar navbar-expand-xl">
			<div class="container h-100 navbar navbar-expand-xl">
				<a class="navbar-brand" style="height: 100%" href="#">
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
						<li class="nav-item"><a class="nav-link" href="#"> <i class="fas fa-tachometer-alt"></i> 대시보드
								<span class="sr-only">(current)</span>
							</a></li>
						<li class="nav-item"><a class="nav-link" href="#"> <i class="far fa-comments"></i> 공지사항
							</a></li>
						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
								role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i
									class="far fa-file-alt"></i> <span>
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
						<li class="nav-item"><a class="nav-link" href="#"> <i class="far fa-calendar-alt"></i> 일정관리
							</a></li>

						<li class="nav-item"><a class="nav-link" href="#"> <i class="far fa-user"></i> 내정보
							</a></li>
						<li class="nav-item dropdown" id="hidden_item" hidden><a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
								role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <i
									class="fas fa-cog"></i> <span>
									관리자페이지 <i class="fas fa-angle-down"></i>
								</span>
							</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown" style="width: 100%">
								<a class="dropdown-item" href="javascript:document.goEmployeeListForm.submit();"
									style="text-align: center">직원 관리</a> <a class="dropdown-item"
									href="javascript:document.goEmployeeListForm_beforeAllow.submit();"
									style="text-align: center">가입 관리</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</nav>
	</div>

	<div class="container tm-mt-big tm-mb-big">
		<div class="row">
			<div class="col-12 mx-auto tm-login-col">
				<div class="tm-bg-primary-dark tm-block tm-block-h-auto" style="margin-bottom:80px">
					<div class="row">
						<div class="col-12 text-center">
							<!-- <h2 class="tm-block-title mb-4">Welcome to Dashboard, Login</h2> -->
							<img class="tm-block-title mb-4" width=160 src="/ware/resources/image/name_black.png">
						</div>
					</div>
					<div class="row mt-2">
						<div class="col-12">
							<form name="joinForm" method="post" action="/ware/joinProc.do" class="tm-signup-form row">
								<div class="form-group col-lg-12">
									<label for="username">이름</label> <input name="emp_name" type="text"
										class="form-control validate emp_name" required placeholder=" 이름 입력" />
									<div class=emp_name_valid></div>
								</div>
								<div class="form-group col-lg-6">
									<label for="emp_pwd">비밀번호</label> <input name="emp_pwd" type="password"
										class="form-control validate emp_pwd" required />
									<div class=emp_pwd_valid></div>
								</div>
								<div class="form-group col-lg-6">
									<label for="emp_pwd_chk">비밀번호확인</label> <input name="emp_pwd_chk" type="password"
										class="form-control validate emp_pwd_chk" required />
									<div class=emp_pwd_chk_valid></div>
								</div>
								<div class="form-group col-lg-12">
									<label for="dep_no">소속부서</label> <select name="dep_no"
										class="custom-select tm-select-accounts">
										<option value="">소속부서</option>
										<c:forEach items="${requestScope.depList}" var="dep" varStatus="loopTagStatus">
											<option value="${dep.dep_no}">${dep.dep_name}</option>
										</c:forEach>
									</select>
									<div class=dep_no_valid></div>
								</div>
								<div class="form-group col-lg-12">
									<label for="jumin_num">주민번호</label> <input name="jumin_num" type="text"
									class="form-control validate jumin_num onlynumber" required
									placeholder=" 주민번호 - 없이 입력바람" />
									<div class=jumin_num_valid></div>
								</div>
								<div class="form-group col-lg-12">
									<label for="email">이메일</label> <input name="email" type="text"
									class="form-control validate email" required />
									<div class=email_valid></div>
								</div>
								<div class="form-group col-lg-12">
									<label for="phone_num">전화번호</label> <input name="phone_num" type="text"
									class="form-control validate phone_num onlynumber" required
									placeholder=" - 없이 입력바람" />
									<div class=phone_num_valid></div>
								</div>
							</form>
							<center>
								<table width=100%>
									<tr>
										<td width=45%><span style="cursor: pointer" class="register"
												onclick="checkJoinForm();">
												<button width=100% height=30
													class="btn btn-small btn-primary btn-block text-uppercase">
													가입하기</button>
											</span></td>
										<td width=10%></td>
										<td width=45%><span style="cursor: pointer"
												onclick="document.loginForm.submit();">
												<button height=30
													class="btn btn-small btn-primary btn-block text-uppercase">
													화면 닫기</button>
											</span></td>
									</tr>
								</table>
							</center>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- <script src="/ware/resources/js/jquery-3.3.1.min.js"></script> -->
	<!-- https://jquery.com/download/ -->
	<script src="/ware/resources/js/bootstrap.min.js"></script>
	<!-- https://getbootstrap.com/ -->
	<form name="loginForm" method="post" action="/ware/loginForm.do"></form>
	<footer class="tm-footer row tm-mt-small" style="position:absolute; min-width:100%; left:0; right:0; bottom:0; margin-top: auto;">
		<div class="col-12 font-weight-light">
			<p class="text-center text-white mb-0 px-4 small">
				Copyright &copy; <b>2019</b> All rights reserved.
			</p>
		</div>
	</footer>
</body>

</html>
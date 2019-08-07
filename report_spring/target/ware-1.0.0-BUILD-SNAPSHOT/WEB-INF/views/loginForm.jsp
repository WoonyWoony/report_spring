<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="common.jsp"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>Login Page - Product Admin Template</title>
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
  	<c:if test="${!empty interceptorMSG}">
		<script>
			alert("${interceptorMSG}");
		</script>
	</c:if>
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
		function checkLoginForm() {
			// ------------------------------------
			// 입력된 [아이디]를 가져와 변수에 저장
			// ------------------------------------
			var admin_id = $('.admin_id').val();
			//alert(  $('.admin_id').length ); return

			if (admin_id.split(" ").join("") == "") {
				alert("사번을 입력해 주세요");
				$(".admin_id").val("");
				return; // return은 함수와 객체소유의 메소드에서 나올수있음. 1.함수중단, 2.메소드중단 의미.
			}

			if (!is_number_char("admin_id")) {
				alert("사번은 숫자만 입력 가능합니다.");
				$(".admin_id").val("");
				return;
			}

			// ------------------------------------
			// 입력된 [암호]를 가져와 변수에 저장
			// ------------------------------------
			var pwd = $('.pwd').val();

			if (pwd.split(" ").join("") == "") {
				alert("암호를 입력해 주세요");
				$(".pwd").val("");
				return;
			}
			// ------------------------------------
			// 암호를 입력 안했거나 공백만 있으면 경고하고 암호 입력란을 비운후 함수 중단
			// ------------------------------------

			// ------------------------------------
			// 현재 화면에서 페이지 이동 없이(=비동기 방식으로)
			// 서버쪽의 loginProc.jsp 를 호출하여 HTML 소스를 응답받아 실행하기.
			// ------------------------------------
			$.ajax({
				// 서버쪽 호출 URL 주소
				url: "/ware/loginProc.do"
				// form 태그 안의 데이터 즉 파라미터값을 서버로 보내는 방법 지정
				,
				type: "post"
				// 서버에 보낼 파리미터명과 파라미터값을 설정
				// , data: { 'admin_id': admin_id, 'pwd': pwd }
				// , data: "admin_id=" + admin_id + "&pwd=" + pwd 도 가능
				,
				data: $("[name=loginForm]").serialize() // 윗줄과 동일함 admin_id=아이디&pwd=비번
				// 서버가 응답할 페이지 종류 설정. html 일 경우 생략 가능
				// , dataType: "html"

				// 서버가 응답을 성공적으로 보냈을 경우 실행할 익명함수 설정.
				// 익명함수의 매개변수로는 [서버가 리턴한 값] 이 들어온다.
				,
				success: function (data) {
					// 아이디 존재 개수가 1개면 메시지 띄우고 /ware/boardListForm.do 로이동
					if (data == 1) {
						// location.replace 는 GET 방식으로 이동하는 함수.
						location.replace("/ware/dashboard.do");
						// -----------------------------------------------------
						// 만약 POST 방식으로 "/ware/boardListFrom.do" 로 접근하고싶다면
						// -----------------------------------------------------
						// body 태그 하단에 아래처럼 폼태그를 선언
						// <form name="boardListForm" method="POST" action="/ware/boardListForm.do"></form>
						// document.boardListForm.submit(); 를 사용
						/* document.boardListForm.submit(); */
					} else if (data == 10) {
						alert("가입 대기 상태입니다. 담당자에게 문의하세요.");

					} else if (data == 30) {
						alert("가입 거절 상태입니다. 담당자에게 문의하세요.");
					}
					// 아이디 존재 개수가 1이 아니면 경고하기
					else {
						alert("로그인 실패! 아이디, 암호 재입력 바람!");
						$('.admin_id').val("");
						$(".pwd").val("");
						$(".admin_id").focus();
					}
				}

				// 서버의 응답을 못 받았을 경우 실행할 익명함수 설정.
				,
				error: function () {
					alert("서버 접속 실패!");
				}
			});
		}

		function goJoinForm() {
			document.joinForm.submit();
		}

		function inputLoginData(id,pwd){
			$("[name=admin_id]").val(id);
			$("[name=pwd]").val(pwd);
		}
	</script>
</head>

<body>
	<div>
		<nav class="navbar navbar-expand-xl">
			<div class="container h-100 navbar navbar-expand-xl">
				<a class="navbar-brand" style="height:100%" style="height:100%" href="#">
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
							<a class="nav-link" href="#">
								<i class="fas fa-tachometer-alt"></i> 대시보드
								<span class="sr-only">(current)</span>
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="#">
								<i class="far fa-comments"></i>
								공지사항
							</a>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
								data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<i class="far fa-file-alt"></i>
								<span> 보고서결재 <i class="fas fa-angle-down"></i> </span>
							</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown" style="width: 100%">
								<a class="dropdown-item" href="javascript:document.goDailyListForm.submit();">일일 보고서</a>
								<a class="dropdown-item" href="javascript:document.goSalesListForm.submit();">영업 보고서</a>
								<a class="dropdown-item" href="javascript:document.goExpenseListForm.submit();">지출 보고서</a>
							</div>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="#">
								<i class="far fa-calendar-alt"></i> 일정관리
							</a>
						</li>

						<li class="nav-item">
							<a class="nav-link" href="#">
								<i class="far fa-user"></i> 내정보
							</a>
						</li>
						<li class="nav-item dropdown" id="hidden_item" hidden>
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
								data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<i class="fas fa-cog"></i>
								<span> 관리자페이지 <i class="fas fa-angle-down"></i> </span>
							</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdown" style="width: 100%">
								<a class="dropdown-item" href="javascript:document.goEmployeeListForm.submit();" style="text-align: center">직원 관리</a>
								<a class="dropdown-item" href="javascript:document.goEmployeeListForm_beforeAllow.submit();" style="text-align: center">가입 관리</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
	<div style="position: absolute;" class="ml-6">
		<br><br><br><br>
		<table class="table">
			<tr>
				<th bgcolor="#435c70">직급</th>
				<th bgcolor="#435c70">직원번호</th>
				<th bgcolor="#435c70">비밀번호</th>
			</tr>
			<tr style="cursor: pointer" onclick="inputLoginData('1','a123');">
				<td>관리자</td>
				<td>1</td>
				<td>a123</td>
			</tr>
			<tr style="cursor: pointer" onclick="inputLoginData('1000','a123');">
				<td>사원</td>
				<td>1000</td>
				<td>a123</td>
			</tr>
			<tr style="cursor: pointer" onclick="inputLoginData('1001','a123');">
				<td>대리</td>
				<td>1001</td>
				<td>a123</td>
			</tr>
			<tr style="cursor: pointer" onclick="inputLoginData('1002','a123');">
				<td>팀장</td>
				<td>1002</td>
				<td>a123</td>
			</tr>
			<tr style="cursor: pointer" onclick="inputLoginData('1003','a123');">
				<td>과장</td>
				<td>1003</td>
				<td>a123</td>
			</tr>
			<tr style="cursor: pointer" onclick="inputLoginData('1004','a123');">
				<td>부장</td>
				<td>1004</td>
				<td>a123</td>
			</tr>
			<tr style="cursor: pointer" onclick="inputLoginData('1005','a123');">
				<td>사장</td>
				<td>1005</td>
				<td>a123</td>
			</tr>
		</table>
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
							<form name="loginForm" method="post" action="/ware/loginProc.do" class="tm-login-form">
								<div class="form-group">
									<label for="username">직원번호</label>
									<input name="admin_id" type="text" class="form-control validate admin_id"
										id="username" required />
								</div>
								<div class="form-group mt-3">
									<label for="password">비밀번호</label>
									<input name="pwd" type="password" class="form-control validate pwd" id="password"
										value="" required />
								</div>
							</form>
							<div class="form-group mt-4">
								<button class="btn btn-primary btn-block text-uppercase"
									onclick="checkLoginForm();">
									로그인
								</button>
								<!-- <table width=100%>
									<tr>
										<td width=50%>
											<button class="btn btn-primary btn-block text-uppercase"
												onclick="checkLoginForm();">
												로그인
											</button>
										</td>
										<td width=50%>
											<button class="btn btn-primary btn-block text-uppercase"
												onclick="document.findloginForm.submit();">
												아이디/암호 찾기
											</button>
										</td>
									</tr>
								</table> -->
							</div>
							<button class="mt-5 btn btn-primary btn-block text-uppercase" onclick="goJoinForm();">
								회원가입
							</button>
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
	<form name="joinForm" method="post" action="/ware/joinForm.do"></form>
	<form name="findloginForm" method="post" action="/ware/findloginForm.do"></form>
	<footer class="tm-footer row tm-mt-small" style="position:absolute; min-width:100%; left:0; right:0; bottom:0; margin-top: auto;">
		<div class="col-12 font-weight-light">
			<p class="text-center text-white mb-0 px-4 small">
				Copyright &copy; <b>2019</b> All rights reserved.
			</p>
		</div>
	</footer>
</body>

</html>
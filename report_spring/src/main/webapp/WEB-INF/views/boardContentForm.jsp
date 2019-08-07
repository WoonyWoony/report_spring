<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 common.jsp 파일 내의 소스를 삽입하기 -->
<%@include file="common.jsp"%>
<%@include file="checkLogin.jsp" %>
<c:if test="${empty board}">
	<script>
		alert("게시판 글이 삭제되었음!");
		location.replace("/ware/boardListForm.do");
	</script>
</c:if>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>헬로웍스 - 공지사항</title>
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
			if ("${emp_role}" == "ADMIN") {
				$("#updelicon").removeAttr("style");
			}
		});

		//**************************************************************
		// 게시판 수정 화면으로 이동하는 함수 선언
		//**************************************************************
		function goBoardUpDelForm() {
			document.boardUpDelForm.submit();
		}
	</script>
</head>

<body id="reportsPage">
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
							<a class="nav-link active" href="javascript:document.goBoardListForm.submit();">
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
								<a class="dropdown-item" href="javascript:document.goExpenseListForm.submit();">지출 보고서</a>
							</div>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="javascript:document.goCalendar.submit();">
								<i class="far fa-calendar-alt"></i>
								일정관리
							</a>
						</li>

						<li class="nav-item">
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

		<div class="container mt-5">
			<div class="row tm-content-row">
				<div class="col-12 tm-block-col">
					<div class="tm-bg-primary-dark tm-block tm-block-h-auto tm-block-scroll" style="margin-bottom:80px">
						<h2 class="tm-block-title">공지사항</h2>
						<!--********************************************************************-->
						<!--[1개의 게시판 내용] 출력하고 게시판 등록 화면으로 이동하는 form 태그 선언-->
						<!--********************************************************************-->
						<form class="boardContentForm" name="boardContentForm" method="post" action="/ware/boardRegForm.do">
							<!-- <b class="text-white">[글 상세 보기]</b> -->
							<div style="height:10px"></div>
							<table class="table">
								<tr align="center">
									<th bgcolor="#486177" width=15%>글번호
									<td width=35%>${board.b_no}
									<th bgcolor="#486177" width=15%>조회수
									<td width=35%>${board.readcount}
								<tr align="center">
									<th bgcolor="#486177">작성자
									<td>${board.writer}
									<th bgcolor="#486177">작성일
									<td>${board.reg_date}
								<tr align="center">
									<th bgcolor="#486177">글제목
									<td colspan=3 style="font-weight: 600; font-size: 16px">${board.subject}
								<tr align="center">
									<th bgcolor="#486177">글내용</th>
									<td colspan=3 class="text-white" align="left">
										${board.content}
									</td>
								</tr>
							</table>
							<br> <input type="hidden" name="b_no" value="${board.b_no}">
						</form>
						<center>
							<table>
								<tr>
									<td>
										<span id="updelicon" style="cursor: pointer; display: none;" onclick="goBoardUpDelForm();">
											<button height=30 class="btn btn-small btn-primary btn-block text-uppercase">
												수정/삭제
											</button>
										</span>
									</td>
									<td width=20></td>
									<td>
										<span style="cursor: pointer" onclick="document.goBoardListForm.submit();">
											<button height=30 class="btn btn-small btn-primary btn-block text-uppercase">
												화면 닫기
											</button>
										</span>
									</td>
								</tr>
							</table>
						</center>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- <script src="js/jquery-3.3.1.min.js"></script> -->
	<!-- https://jquery.com/download/ -->
	<script src="/ware/resources/js/bootstrap.min.js"></script>
	<!-- https://getbootstrap.com/ -->
	
	<form name="boardRegForm" method="post" action="/ware/boardRegForm.do">
		<input type="hidden" name="b_no" value="${board.b_no}">
	</form>
	<form name="boardUpDelForm" method="post" action="/ware/boardUpDelForm.do">
		<input type="hidden" name="b_no" value="${board.b_no}">
	</form>
	
	<form name="boardContentForm" method="post" action="/ware/boardContentForm.do">
		<input type="hidden" name="b_no">
	</form>
	<form name="goDashboard" method="post" action="/ware/dashboard.do"></form>
	
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
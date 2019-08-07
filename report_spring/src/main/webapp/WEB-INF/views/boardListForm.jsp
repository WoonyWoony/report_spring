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
			/* setTableTrBgColor2(
				"boardList2", "#1c1cff", "#eeeeee", "#ffffff", "#b3d6ff"
			); */
			if ("${emp_role}" == "ADMIN") {
				$("#boardRegicon").removeAttr("style");
			}

			//=======================================================
			// name = boardRegForm을 가진 form 태그와
			// name = boardContentForm을 가진 form 태그를 안보이게 하기
			// (목적) 체크박스 입력양식 태그를 보이지 않게 하기 위해
			//=======================================================					
			$("[name=boardContentForm]").hide();

			//=======================================================
			// 페이지 번호클릭시 해당
			//=======================================================					
			$("[name=rowCntPerPage]").change(function () {
				goSearch();
				//$(".contactSearch").click();
			});


			//===================================================
			// 페이징 처리 관련 HTML 소스를 class=pagingNumber 가진 태그 안에 삽입하기
			//===================================================
			$(".pagingNumber").html(
				getPagingNumber(
					"${requestScope.boardListAllCnt}"
					, "${sessionScope.boardSearchDTO.selectPageNo}"
					, "${sessionScope.boardSearchDTO.rowCntPerPage}"
					, "10"
					, "goSearch( );"
				)
			);

			//=========================================
			// 검색 조건의 흔적 남기기
			//=========================================
			inputData("keyword1", "${sessionScope.boardSearchDTO.keyword1}");
			inputData("keyword2", "${sessionScope.boardSearchDTO.keyword2}");
			inputData("or_and", "${sessionScope.boardSearchDTO.or_and}");
			<c:forEach items="${sessionScope.boardSearchDTO.date}" var="date">
				inputData("date","${date}");
			</c:forEach >
				inputData("selectPageNo", "${sessionScope.boardSearchDTO.selectPageNo}");
			inputData("rowCntPerPage", "${sessionScope.boardSearchDTO.rowCntPerPage}");


		});

		function goBoardRegForm() {
			//------------------
			// name=boardRegForm을 가진 form 태그안의 action에 설정된 URL로 이동하기
			// 이동 시 form 태그안의 모든 입력 양식이 파라미터값으로 전송된다.
			//------------------
			document.goBoardRegForm.submit();
		}

		function goBoardContentForm(b_no) {
			$("[name='boardContentForm'] [name='b_no']").val(b_no);
			document.boardContentForm.submit();
			// location.replace("/ware/boardContentForm.do")	
		}


		function goSearch() {
			// if (is_special_char("keyword1") || is_special_char("keyword2")) {
			// 	alert("키워드에는 영문, 한글, 숫자, 언더바 만 입력 가능합니다.");
			// 	$(".keyword1,.keyword2").val("");
			// 	return;
			// }
			if (is_empty("keyword1") && is_empty("keyword2") && is_empty("date")) {
				//alert("입력된 검색조건이 모두 없어 모두검색을 실행합니다.");
				// 길이가 없는 문자데이터를 초기화 시키고자 아래를 입력한다.
				$(".keyword1,.keyword2").val("");
			}
			document.boardListForm.submit();
		}

		//***************************
		// 키워드 없이 [게시판 목록화면]으로 이동하는 함수 선언
		//***************************
		function goSearchAll() {
			setEmpty2("[name=keyword1],[name=keyword2],[name=date]");
			inputData("selectPageNo", "1");
			document.boardListForm.submit();
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
							<a class="dropdown-item" href="javascript:document.goEmployeeListForm.submit();"
								style="text-align: center">직원 관리</a>
							<a class="dropdown-item" href="javascript:document.goEmployeeListForm_beforeAllow.submit();"
								style="text-align: center">가입 관리</a>

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
					<center>
						<form name="boardListForm" method="post" action="/ware/boardListForm.do">
							<table class="fontsize text-white" width=100%>
								<tr>
									<td>
										<input type="text" name="keyword1" class="keyword1 form-control"
											style="height: 20" />
									<td width=7></td>
									<td>
										<select name="or_and" style="width:50; height: 37px; padding: 5px"
											class="custom-select">
											<option value="or">or
											<option value="and">and
										</select>
									</td>
									<td>
										<input type="text" name="keyword2" class="keyword2 form-control"
											style="height: 20">
									</td>
									<td>&emsp;<input type="checkbox" name="date" value="오늘">오늘&nbsp;</td>
									<td><input type="checkbox" name="date" value="어제">어제&nbsp;</td>
									<td>
										<span style="cursor: pointer" onclick="goSearch();">
											<!-- <img src="/ware/resources/image/search_white.png" height=30> -->
											<button style="font-size: 13;"
												class="btn btn-small btn-primary btn-block text-uppercase">
												검색
											</button>
										</span>
									</td>
									<td width=10></td>
									<td>
										<span style="cursor: pointer" onclick="goSearchAll();">
											<button style="font-size: 13;"
												class="btn btn-small btn-primary btn-block text-uppercase">
												모두검색
											</button>
										</span>
									</td>
									<td width=10></td>
									<td>
										<select name="rowCntPerPage" style="width:65; height: 30; padding: 5px;"
											class="custom-select">
											<option value="10">10개
											<option value="15">15개
											<option value="20">20개
											<option value="25">25개
											<option value="30">30개
										</select>
									</td>
								</tr>
							</table>
							<input type="hidden" name="selectPageNo">
						</form>

						<table class="table boardList2" width=100%>
							<thead>
								<tr>
									<th style="text-align: center" scope="col">글번호</th>
									<th style="text-align: center" scope="col">제목</th>
									<th style="text-align: center" scope="col">글쓴이</th>
									<th style="text-align: center" scope="col">조회수</th>
									<th style="text-align: center" scope="col">작성일</th>
								</tr>
							</thead>
							<c:forEach items="${requestScope.boardList}" var="board" varStatus="loopTagStatus">
								<tr style="cursor: pointer" onClick="goBoardContentForm(${board.b_no});">
									<td align="center">
										${ boardListAllCnt - ( boardSearchDTO.rowCntPerPage
										*(boardSearchDTO.selectPageNo-1)) - loopTagStatus.index }
									</td>
									<td><span class="dot2">${board.subject}</span></td>
									<td style="text-align: center;">${board.writer}</td>
									<td style="text-align: center;">${board.readcount}</td>
									<td style="text-align: center;">${board.reg_date}</td>
								</tr>
							</c:forEach>
							<c:if test="${boardListAllCnt==0}">
								<tr>
									<td style="text-align: center;" colspan="5">검색된 글이 없습니다.</td>
								</tr>
							</c:if>
						</table>
						<table class="table">
							<tr>
								<td width=33%></td>
								<td width=33% align=center><span class="pagingNumber"></span></td>
								<td width=33% align=right>
									<!-- [검색 총개수]: ${requestScope.boardListAllCnt} -->
									<span id="boardRegicon" style="display: none; cursor: pointer;">
										<button style="max-width: 80px;" height=30
											class="btn btn-small btn-primary btn-block text-uppercase"
											onclick="document.goBoardRegForm.submit();">
											글쓰기
										</button>
									</span>
									<!-- <a id="boardRegicon" style="display: none" href="javascript:goBoardRegForm();">[새글쓰기]</a> -->
								</td>
							</tr>
						</table>
					</center>
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
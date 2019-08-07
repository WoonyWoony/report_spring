<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 common.jsp 파일 내의 소스를 삽입하기 -->
<%@include file="common.jsp"%>
<%@include file="checkLogin.jsp" %>

<c:if test="${emp_role ne 'ADMIN'}">
	<!-- 'sessionScope.' 빼면 먼저 HttpSession에서 찾음 그 다음 HttpServletRequest에서 찾음 키값 중복되지만 않으면 생략해서 씀-->
	<script>
		alert("잘못된 접근입니다.");
		location.replace("/ware/dashboard.do");
		// document.goDashboard.submit();
	</script>
</c:if>

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
			//--------------------------------------
			// 페이징 처리 관련 HTML 소스를 class=pagingNumber 가진 태그 안에 삽입하기
			//--------------------------------------
			$(".pagingNumber").html(
				getPagingNumber(
					"${requestScope.employeeListAllCnt}"							// 검색 결과 총 행 개수
					, "${sessionScope.employeeSearchDTO.selectPageNo}"			// 선택된 현재 페이지 번호
					, "${sessionScope.employeeSearchDTO.rowCntPerPage}"			// 페이지 당 출력행의 개수
					, "10"														// 페이지 당 보여줄 페이지번호 개수
					, "goSearch();"												// 페이지 번호 클릭 후 실행할 자스코드
				)
			);

			//=========================================
			// 검색 조건의 흔적 남기기
			//=========================================
			inputData("keyword", "${sessionScope.employeeSearchDTO.keyword}");
			inputData("dep_no", "${sessionScope.employeeSearchDTO.dep_no}");
			inputData("jikup_code", "${sessionScope.employeeSearchDTO.jikup_code}");
			inputData("selectPageNo", "${sessionScope.employeeSearchDTO.selectPageNo}");
			inputData("rowCntPerPage", "${sessionScope.employeeSearchDTO.rowCntPerPage}");

			inputData("str", "${sessionScope.employeeSearchDTO.str}");
			inputData("sort", "${sessionScope.employeeSearchDTO.sort}");
			inputData("ascDesc", "${sessionScope.employeeSearchDTO.ascDesc}");

			$('.employeeList2 thead:eq(0) tr:eq(0) th:eq(0)').siblings().each(function () {
				// i번째 형재 th 태그 안의 앞,뒤 공백을 제거한 문자열을 얻자
				var str = $.trim($(this).text());
				if (str != "번호") {
					$(this).css("cursor", "pointer");
				}
				if (str == "${employeeSearchDTO.str}") {
					if ("${employeeSearchDTO.ascDesc}" == "asc") {
						$(this).text(str + '▲');
					}
					if ("${employeeSearchDTO.ascDesc}" == "desc") {
						$(this).text(str + '▼');
					}
				}

			});

			// =====================================================
			// =====================================================
			$('.employeeList2 thead:eq(0) tr:eq(0) th:eq(0)').siblings().click(function () {
				// 클릭한 th 태그를 관리하는 JQuery 객체매위주를 얻어 변수에 저장
				var thisThObj = $(this);
				// 내림차순, 오름차순 여부를 저장할 변수선언
				var ascDesc = "";
				// 클릭한 th 형제의 th 태그 안의 문자열에 ▲ , ▼ 제거
				thisThObj.siblings().each(function () {
					// i번째 형재 th 태그 안의 앞,뒤 공백을 제거한 문자열을 얻자
					var str = $.trim($(this).text());
					// ▲ 제거하기
					str = str.split("▲").join("");
					// ▼ 제거하기
					str = str.split("▼").join("");

					$(this).text(str);
				});

				// 클릭한 th안의 문자열 뒤에 ▲ 또는 ▼ 추가하기
				// 클릭한 th안의 문자열을 얻어 저장
				var str = thisThObj.text();
				var str2 = thisThObj.text();
				str2 = str2.split("▲").join("");
				str2 = str2.split("▼").join("");
				$('[name=str]').val(str2);

				// str 변수 안의 문자열에 ▼이 있으면  
				if (str.indexOf('▼') >= 0) {
					// ▼ 을 ▲로 수정하고 오름차순 의미 저장
					str = str.replace('▼', '▲');
					// ▼ 을 ▲로 수정한다는 의미는 오름차순의 의미이므로 변수 ascDesc에 asc 저장
					ascDesc = "asc";
					$('[name=ascDesc]').val(ascDesc);
					// console.log(ascDesc);
				}
				else if (str.indexOf('▲') >= 0) {
					// ▲ 을 ▼로 수정하고 내림차순 의미 저장
					str = str.replace('▲', '▼');
					// ▲ 을 ▼로 수정한다는 의미는 내림차순의 의미이므로 변수 ascDesc에 desc 저장
					ascDesc = "desc";
					$('[name=ascDesc]').val(ascDesc);
					// console.log(ascDesc);
				}
				else {
					str = str + '▲';
					// ▼ 의미는 오름차순의 의미이므로 변수 ascDesc에 asc 저장
					ascDesc = "asc";
					$('[name=ascDesc]').val(ascDesc);
					// console.log(ascDesc);
				}
				// str 안의 데이터를 클릭한 th 안의 문자열로 갱신
				thisThObj.text(str);

				// Array 객체에 각각의 tr을 관리하는 JQuery 객체들을 생성해서 저장.
				// 정렬 대상이 되는 모든 tr 태그를 관리하는 JQuery 객체 생성해 저장
				var allTrObj = $('.employeeList2 tbody:eq(0)').children();
				// Array 객체 생성해 각각의 tr을 관리하는 JQuery 객체들을 Array 객체에 저장
				var trObjs = [];
				allTrObj.each(function () {
					trObjs.push($(this));
				});
				var thIndex = thisThObj.index();
				$('[name=sort]').val(thIndex + 1);
				console.log(thIndex);
				document.employeeSearch.submit();
			});
		});

		function goSearch() {
			if (is_empty("keyword")) {
				$("[name=keyword]").val("");
			}
			document.employeeSearch.submit();
		}

		function employee_register_click() {
			//location.replace("/ware/employeeRegForm.do")   
			//alert("직원등록")
			document.goemployeeRegForm.submit();
		}

		//***********************************************************************
		// [1개의 게시판 내용물]을 보여주는 [게시판 상세 보기 화면]으로 이동하는 함수 선언
		//***********************************************************************
		function goEmployeeUpDelForm(emp_no) {
			$("[name='employeeUpDelForm'] [name='emp_no']").val(emp_no);
			document.employeeUpDelForm.submit();
			// location.replace("/ware/boardContentForm.do")   
		}

		//***************************
		// 키워드 없이 [게시판 목록화면]으로 이동하는 함수 선언
		//***************************
		function goSearchAll() {
			setEmpty2("[name=keyword],[name=jikup_code],[name=dep_no]");
			inputData("selectPageNo", "1");
			document.employeeSearch.submit();
		}
		      
		function setSearch(){
			inputData("keyword", "임은석");
			inputData("dep_no", "1");
			inputData("jikup_code", "1");
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
						<a class="nav-link dropdown-toggle active" href="#" id="navbarDropdown" role="button"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<i class="fas fa-cog"></i>
							<span>
								관리자페이지 <i class="fas fa-angle-down"></i>
							</span>
						</a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown" style="width: 100%">
							<a class="dropdown-item active"
								href="javascript:document.goEmployeeListForm.submit();" style="text-align: center">직원 관리</a>
							<a class="dropdown-item"
								href="javascript:document.goEmployeeListForm_beforeAllow.submit();" style="text-align: center">가입 관리</a>
							
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
					<h2 class="tm-block-title">직원관리</h2>
					<form name="employeeSearch" method="POST" action="/ware/employeeListForm.do">
						<table align="center" class="fontsize text-white" width=90%>
							<tr>
								<td>
									<input type="text" name="keyword" class="form-control" style="height: 20px">
								</td>
								<td>&emsp;
									<select name="dep_no" style="width: 85px; height: 37px; padding: 5px;"
										class="custom-select">
										<option value="">소속부서</option>
										<c:forEach items="${requestScope.depList}" var="dep" varStatus="loopTagStatus">
											<option value="${dep.dep_no}">${dep.dep_name}</option>
										</c:forEach>
									</select>
								</td>
								<td>
									<select name="jikup_code" style="width: 85px; height: 37px; padding: 5px;"
										class="custom-select">
										<option value="">직급</option>
										<c:forEach items="${requestScope.jikupList}" var="jikup"
											varStatus="loopTagStatus">
											<option value="${jikup.jikup_code}">${jikup.jikup_name}</option>
										</c:forEach>
									</select>
								</td>
								<td>
									<input type="button" style="font-size: 13;"
										class="btn btn-small btn-primary btn-block text-uppercase" value="검색"
										onclick="goSearch();">
								</td>
								<td width=10></td>
								<td>
									<input type="button" style="font-size: 13;"
										class="btn btn-small btn-primary btn-block text-uppercase" value="모두검색"
										onclick="goSearchAll();">
								</td>
								<td width=10></td>
								<td>
									<input type="button" style="font-size: 13; min-width: 50;"
										class="btn btn-small btn-primary btn-block text-uppercase" value="등록"
										onclick="employee_register_click();">
								</td>
								<td>
									&emsp;[검색된 총 개수] : ${employeeListAllCnt}
								</td>
								<td>
									<select name="rowCntPerPage" style="width:65; height: 30; padding: 5px;"
										class="custom-select" onchange="goSearch();">
										<option value="10">10
										<option value="15">15
										<option value="20">20
										<option value="25">25
										<option value="30">30
									</select>
								</td>
								<td>
									<input type="button" style="font-size: 13; min-width: 50;"
										class="btn btn-small btn-primary btn-block text-uppercase" value="입력"
										onclick="setSearch();">
								</td>
							</tr>
						</table>

						<input type="hidden" name="selectPageNo">
						<input type="hidden" name="str">
						<input type="hidden" name="sort">
						<input type="hidden" name="ascDesc">
					</form>


					<table class="table employeeList2">
						<thead>
							<tr>
								<th style="text-align: center" scope="col">번호</th>
								<th style="text-align: center" scope="col">사번</th>
								<th style="text-align: center" scope="col">이름</th>
								<th style="text-align: center" scope="col">직급</th>
								<th style="text-align: center" scope="col">부서</th>
								<th style="text-align: center" scope="col">직속상관사번</th>
								<th style="text-align: center" scope="col">직속상관이름</th>
								<th style="text-align: center" scope="col">전화번호</th>
							</tr>
						</thead>
						<c:forEach items="${requestScope.employeeList}" var="employee" varStatus="loopTagStatus">
							<tr style="cursor: pointer" onClick="goEmployeeUpDelForm(${employee.EMP_NO});">
								<td align="center">${employeeListAllCnt + employeeSearchDTO.rowCntPerPage -
									employeeSearchDTO.rowCntPerPage * employeeSearchDTO.selectPageNo -
									loopTagStatus.index}</td>
								<td align="center">${employee.EMP_NO}</td>
								<td style="text-align: center;">${employee.EMP_NAME}</td>
								<td style="text-align: center;">${employee.JIKUP_NAME}</td>
								<td style="text-align: center;">${employee.DEP_NAME}</td>
								<td style="text-align: center;">${employee.MGR_EMP_NO}</td>
								<td style="text-align: center;">${employee.MGR_EMP_NAME}</td>
								<td style="text-align: center;">${employee.PHONE_NUM}</td>
							</tr>
						</c:forEach>
						<c:if test="${employeeListAllCnt==0}">
							<tr>
								<td style="text-align: center;" colspan="8">검색된 직원이 없습니다.</td>
							</tr>
						</c:if>
					</table>
					<table class="table">
						<tr>
							<td width=33%></td>
							<td width=33% align=center><span style="font-size: 16px" class="pagingNumber"></span></td>
							<td width=33% align=right>
								<button style="max-width: 200px; font-size: 16px"
									class="btn btn-small btn-primary btn-block text-uppercase"
									onclick="document.goEmployeeListForm_beforeAllow.submit();">
									가입 관리 페이지 이동
								</button>
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
	<form name="employeeUpDelForm" method="post"
			action="/ware/employeeUpDelForm.do">
			<input type="hidden" name="emp_no">
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
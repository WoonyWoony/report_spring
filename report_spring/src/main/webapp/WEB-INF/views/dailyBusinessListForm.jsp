<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 common.jsp 파일 내의 소스를 삽입하기 -->
<%@include file="common.jsp"%>
<%@include file="checkLogin.jsp" %>

<html>
<Style>
	.asdqwd{
		color:#1ed255;
	}
</Style>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Product Admin - Dashboard HTML Template</title>
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
			$("html, body").animate({ scrollTop: ${ scrollValue } }, "slow");

		$(window).scroll(function () {
			var scrollValue = $(document).scrollTop();
			$('[name=scrollValue]').val(scrollValue);
		});
		//--------------------------------------
		// 페이징 처리 관련 HTML 소스를 class=pagingNumber 가진 태그 안에 삽입하기
		//--------------------------------------
		$(".pagingNumber").html(
			getPagingNumber(
				"${requestScope.dailyListAllCnt}"							// 검색 결과 총 행 개수
				, "${sessionScope.dailyBusiSearchDTO.selectPageNo}"			// 선택된 현재 페이지 번호
				, "${sessionScope.dailyBusiSearchDTO.rowCntPerPage}"		// 페이지 당 출력행의 개수
				, "10"														// 페이지 당 보여줄 페이지번호 개수
				, "goSearch();"												// 페이지 번호 클릭 후 실행할 자스코드
			)
		);

		var evenTrColor = "${evenTrColor}";
		var oddTrColor = "${oddTrColor}";
		var headerColor = "${headerColor}";
		var mouseOverColor = "${mouseOverColor}";


		//--------------------------
		// 검색 조건의 흔적 남기기
		//--------------------------
		inputData("busi_year_min", "${sessionScope.dailyBusiSearchDTO.busi_year_min}");
		inputData("busi_month_min", "${sessionScope.dailyBusiSearchDTO.busi_month_min}");
		inputData("busi_year_max", "${sessionScope.dailyBusiSearchDTO.busi_year_max}");
		inputData("busi_month_max", "${sessionScope.dailyBusiSearchDTO.busi_month_max}");
		inputData("busi_hours_min", "${sessionScope.dailyBusiSearchDTO.busi_hours_min}");
		inputData("busi_minutes_min", "${sessionScope.dailyBusiSearchDTO.busi_minutes_min}");
		inputData("busi_hours_max", "${sessionScope.dailyBusiSearchDTO.busi_hours_max}");
		inputData("busi_minutes_max", "${sessionScope.dailyBusiSearchDTO.busi_minutes_max}");
		<c:forEach items="${sessionScope.dailyBusiSearchDTO.busi_type_code}" var="busi_type_code">
			inputData("busi_type_code","${busi_type_code}");
		</c:forEach >
		<c:forEach items="${sessionScope.dailyBusiSearchDTO.sign_state}" var="sign_state">
			inputData("sign_state","${sign_state}");
		</c:forEach >
		inputData("keyword", "${sessionScope.dailyBusiSearchDTO.keyword}");
		inputData("row", "${sessionScope.dailyBusiSearchDTO.rowCntPerPage}");
		inputData("selectPageNo", "${sessionScope.dailyBusiSearchDTO.selectPageNo}");
		inputData("str", "${sessionScope.dailyBusiSearchDTO.str}");
		inputData("sort", "${sessionScope.dailyBusiSearchDTO.sort}");
		inputData("ascDesc", "${sessionScope.dailyBusiSearchDTO.ascDesc}");



		$('.dailyList thead:eq(0) tr:eq(0) th:eq(0)').siblings().each(function () {
			// i번째 형재 th 태그 안의 앞,뒤 공백을 제거한 문자열을 얻자
			var str = $.trim($(this).text());
			if (str != "번호") {
				$(this).css("cursor", "pointer");
			}
			if (str == "${dailyBusiSearchDTO.str}") {
				if ("${dailyBusiSearchDTO.ascDesc}" == "asc") {
					$(this).text(str + '▲');
				}
				if ("${dailyBusiSearchDTO.ascDesc}" == "desc") {
					$(this).text(str + '▼');
				}
			}

		});

		$('.dailyList thead:eq(0) tr:eq(0) th:eq(0)').siblings().click(function () {
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
			var allTrObj = $('.dailyList tbody:eq(0)').children();
			// Array 객체 생성해 각각의 tr을 관리하는 JQuery 객체들을 Array 객체에 저장
			var trObjs = [];
			allTrObj.each(function () {
				trObjs.push($(this));
			});
			var thIndex = thisThObj.index();
			$('[name=sort]').val(thIndex + 1);
			console.log(thIndex);
			// document.dailyBusiSearchForm.submit();
			goSearch();
		});
			
			
	    });


		function godDailyUpdelForm(REPORT_NO, RETURN_NO) {
			$("[name=dailyBusiUpdelForm] [name=report_no]").val(REPORT_NO);
			$("[name=dailyBusiUpdelForm] [name=return_no]").val(RETURN_NO);
			document.dailyBusiUpdelForm.submit();
		}

		function getToday(val1, val2, val3, val4) {
			var today = new Date();
			var mm = today.getMonth() + 1;
			var yyyy = today.getFullYear();

			if (mm < 10) {
				mm = '0' + mm
			}

			$("[name=" + val1 + "]").val(yyyy);
			$("[name=" + val2 + "]").val(mm);
			$("[name=" + val3 + "]").val(yyyy);
			$("[name=" + val4 + "]").val(mm);
		}

		function getNowtime(val1, val2, val3, val4) {
			var today = new Date();
			var hour = today.getHours();
			var minute = today.getMinutes();

			if (hour < 10) {
				hour = '0' + hour
			} if (minute < 10) {
				minute = '0' + minute
			}

			$("[name=" + val1 + "]").val(hour);
			$("[name=" + val2 + "]").val(minute);
			$("[name=" + val3 + "]").val(hour);
			$("[name=" + val4 + "]").val(minute);
		}

		function goSearch() {
			var row = $("[name=row]").val();
			$("[name=rowCntPerPage]").val(row);
			if (is_empty("keyword")) {
				$("[name=keyword]").val("");
			}
			document.dailyBusiSearchForm.submit();
		}


		function setEmptyAll() {
			document.dailyBusiSearchForm.reset();
		}

		function goSearchAll() {
			document.dailyBusiSearchForm.reset();
			inputData("selectPageNo","1");
			document.dailyBusiSearchForm.submit();
		}


		function setEmpty(val1, val2, val3, val4) {
			setEmpty2("[name=" + val1 + "],[name=" + val2 + "],[name=" + val3 + "],[name=" + val4 + "]");
		}

		// ---------------------------------------------------

		function goDailyBusiRegForm() {
			//location.replace("/ware/dailyBusiRegForm.do");
			document.goBusiRegForm.submit();
		}


		// ---------------------------------------------------
		function chcekBusi_date() {
			var busi_year_min = $('[name=busi_year_min]');
			var busi_month_min = $('[name=busi_month_min]');
			var busi_year_max = $('[name=busi_year_max]');
			var busi_month_max = $('[name=busi_month_max]');
			var busi_hours_min = $('[name=busi_hours_min]');
			var busi_minutes_min = $('[name=busi_minutes_min]');
			var busi_hours_max = $('[name=busi_hours_max]');
			var busi_minutes_max = $('[name=busi_minutes_max]');

			if (busi_year_min.val() == "" && busi_month_min.val() != "") {
				alert("업무 시작 연도를 먼저 선택해 주세요.");
				busi_month_min.val("");
				return;
			}
			if (busi_year_max.val() == "" && busi_month_max.val() != "") {
				alert("업무 끝 연도를 먼저 선택해 주세요.");
				busi_month_max.val("");
				return;
			}

			/*if (busi_year_min.val() == "" && busi_year_max.val() != "") {
				alert("업무 시작 연도를 먼저 선택해 주세요.");
				busi_year_max.val("");
				return;
			}

			if (busi_month_min.val() == "" && busi_month_max.val() != "") {
				alert("업무 시작 달을 먼저 선택해 주세요.");
				busi_month_max.val("");
				return;
			} */

			//--------------------------------------

			if (busi_hours_min.val() == "" && busi_minutes_min.val() != "") {
				alert("업무 시작 시간을 먼저 선택해 주세요.");
				busi_minutes_min.val("");
				return;
			}
			if (busi_hours_max.val() == "" && busi_minutes_max.val() != "") {
				alert("업무 끝 시간을 먼저 선택해 주세요.");
				busi_minutes_max.val("");
				return;
			}

			/*if (busi_hours_min.val() == "" && busi_hours_max.val() != "") {
				alert("업무 시작 시간을 먼저 선택해 주세요.");
				busi_hours_max.val("");
				return;
			}

			if (busi_minutes_min.val() == "" && busi_minutes_max.val() != "") {
				alert("업무 시작 분을 먼저 선택해 주세요.");
				busi_minutes_max.val("");
				return;
			} */

			//--------------------------------------

			if (busi_year_min.val() >= busi_year_max.val()) {
				if (busi_year_min.val() > busi_year_max.val() && busi_year_max.val() != "") {
					alert("올바르지 않은 업무 연도 범위입니다.")
					busi_year_max.val("");
					return;
				}
				if (busi_year_min.val() == busi_year_max.val()) {
					if ((busi_month_min.val() > busi_month_max.val()) && busi_month_max.val() != "") {
						alert("올바르지 않은 업무 달 범위입니다.")
						busi_month_max.val("");
						return;
					}
				}
			}

			if (busi_hours_min.val() >= busi_hours_max.val()) {
				if (busi_hours_min.val() > busi_hours_max.val() && busi_hours_max.val() != "") {
					alert("올바르지 않은 업무 시간 범위입니다.")
					busi_hours_max.val("");
					return;
				}
				if (busi_hours_min.val() == busi_hours_max.val()) {
					if ((busi_minutes_min.val() > busi_minutes_max.val()) && busi_minutes_max.val() != "") {
						alert("올바르지 않은 업무 분 범위입니다.")
						busi_minutes_max.val("");
						return;
					}
				}
			}
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
					<li class="nav-item dropdown active">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<i class="far fa-file-alt"></i>
							<span>
								보고서결재 <i class="fas fa-angle-down"></i>
							</span>
						</a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown" style="width: 100%">
							<a class="dropdown-item active" href="javascript:document.goDailyListForm.submit();">일일 보고서</a>
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
					<h2 class="tm-block-title">일업업무보고서</h2>

					<!--===============================================================================================-->
					<!-- dailyBusinessListForm -->
					<!--===============================================================================================-->
					<form name="dailyBusiSearchForm" method="post" action="/ware/dailyListForm.do">
						<table class="table" style="width: 100%">
							<tr>
								<th bgcolor="#486177">업무일</th>
								<td>
									<select name="busi_year_min" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="">-선택-</option>
										<script>
											for (var i = new Date().getFullYear(); i >= 2000; i--) {
												document.write("<option value=" + i + ">" + i);
											}
										</script>
									</select> 년

									<select name="busi_month_min" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="">-선택-</option>
										<script>
											for (var i = 1; i <= 12; i++) {
												var m = (i < 10) ? "0" + i : i;
												document.write("<option value=" + m + ">" + m);
											}
										</script>
									</select> 월 ~

									<select name="busi_year_max" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="">-선택-</option>
										<script>
											for (var i = new Date().getFullYear(); i >= 2000; i--) {
												document.write("<option value=" + i + ">" + i);
											}
										</script>
									</select> 년
									<select name="busi_month_max" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="">-선택-</option>
										<script>
											for (var i = 1; i <= 12; i++) {
												var m = (i < 10) ? "0" + i : i;
												document.write("<option value=" + m + ">" + m);
											}
										</script>
									</select> 월
									<span style="cursor: pointer"
										onclick="setEmpty('busi_year_min','busi_month_min','busi_year_max','busi_month_max');">&emsp;[비움]&nbsp;</span>
									<span style="cursor: pointer"
										onclick="getToday('busi_year_min','busi_month_min','busi_year_max','busi_month_max');">[오늘로]</span>
								</td>
							</tr>
							<tr>
								<th bgcolor="#486177">업무시간</th>
								<td>
									<select name="busi_hours_min" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="">-선택-</option>
										<script>
											for (var i = 0; i <= 23; i++) {
												if (i < 10) { i = "0" + i; }
												document.write("<option value=" + i + ">" + i);
											}
										</script>
									</select> 시
									<select name="busi_minutes_min" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="">-선택-</option>
										<script>
											for (var i = 0; i <= 59; i++) {
												if (i < 10) { i = "0" + i; }
												document.write("<option value=" + i + ">" + i);
											}
										</script>
									</select> 분 ~
									<select name="busi_hours_max" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="">-선택-</option>
										<script>
											for (var i = 0; i <= 23; i++) {
												if (i < 10) { i = "0" + i; }
												document.write("<option value=" + i + ">" + i);
											}
										</script>
									</select> 시
									<select name="busi_minutes_max" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="">-선택-</option>
										<script>
											for (var i = 0; i <= 59; i++) {
												if (i < 10) { i = "0" + i; }
												document.write("<option value=" + i + ">" + i);
											}
										</script>
									</select> 분

									<span style="cursor: pointer"
										onclick="setEmpty('busi_hours_min','busi_minutes_min','busi_hours_max','busi_minutes_max');">&emsp;[비움]&nbsp;</span>
									<span style="cursor: pointer"
										onclick="getNowtime('busi_hours_min','busi_minutes_min','busi_hours_max','busi_minutes_max');">[오늘로]</span>
								</td>
							</tr>
							<tr>
								<th bgcolor="#486177">업무분야</th>
								<td>
									<input type="checkbox" name="busi_type_code" value="1">행정
									<input type="checkbox" name="busi_type_code" value="2">사무
									<input type="checkbox" name="busi_type_code" value="3">구매
									<input type="checkbox" name="busi_type_code" value="4">접대
									<input type="checkbox" name="busi_type_code" value="5">회계
									<input type="checkbox" name="busi_type_code" value="6">기타
									<span style="cursor: pointer" onclick="setEmpty('busi_type_code');">&emsp;[비움]</span>
								</td>
							</tr>
							<tr>
								<th bgcolor="#486177">결재여부</th>
								<td>
									<input type="checkbox" name="sign_state" value="1">결재완료
									<input type="checkbox" name="sign_state" value="2">결재최종완료
									<input type="checkbox" name="sign_state" value="3">미결재
									<input type="checkbox" name="sign_state" value="4">반려
									<span style="cursor: pointer;" onclick="setEmpty('sign_state');">&emsp;[비움]</span>
								</td>
							</tr>
							<tr>
								<th bgcolor="#486177">키워드</th>
								<td>
									<input type="text" name="keyword" maxlength="20"
										style="background-color: #54657d; color: #fff; border: 0; padding: 19px 18px; border-radius: 0; width:150px;height: 20px;">
									<span style="cursor: pointer" onclick="setEmpty('keyword');">&emsp;[비움]</span>
								</td>
							</tr>
						</table>
						<input type="hidden" name="selectPageNo">
						<input type="hidden" name="rowCntPerPage">
						<input type="hidden" name="str">
						<input type="hidden" name="sort">
						<input type="hidden" name="ascDesc">
						<input type="hidden" name="scrollValue" value="0">
						<br>
					</form>
					<center>
						<table>
							<tr>
								<td>
									<span tyle="cursor: pointer;" onclick="goSearch();">
										<button style="max-width: 80px;"
											class="btn btn-small btn-primary btn-block text-uppercase">
											검색
										</button>
									</span>
								</td>
								<td width=10></td>
								<td>
									<span tyle="cursor: pointer;" onclick="goSearchAll();">
										<button style="max-width: 80px;"
											class="btn btn-small btn-primary btn-block text-uppercase">
											모두검색
										</button>
									</span>
								</td>
								<td width=10></td>
								<td>
									<span tyle="cursor: pointer;" onclick="setEmptyAll();">
										<button style="max-width: 80px;"
											class="btn btn-small btn-primary btn-block text-uppercase">
											초기화
										</button>
									</span>
								</td>
						</table>
					</center>
					<div style="height:80px;"></div>

					<table border="0" class="table" style="width: 100%">
						<tr>
							<td>
								<div style="float: left">
									<span style="cursor: pointer" onclick="document.goBusiRegForm.submit();">
										<button style="max-width: 150px;"
											class="btn btn-small btn-primary btn-block text-uppercase">
											일일업무보고서 등록
										</button>
									</span>
								</div>
							</td>
							<td align=center><span class="pagingNumber"></span>
							<td style="text-align: right;">[검색총개수] : ${dailyListAllCnt}개
								<select name="row" onchange="goSearch();" class="custom-select tm-select-accounts"
									style="width: 50px;height:30px;padding:5px">
									<option value="10">10</option>
									<option value="15">15</option>
									<option value="20">20</option>
									<option value="25">25</option>
									<option value="30">30</option>
								</select>행보기
							</td>
						</tr>
					</table>
					<div style="height:10px"></div>

					<br>
					<table class="table dailyList" style="width: 100%">
						<thead>
							<tr>
								<th style="text-align: center;">번호</th>
								<th style="text-align: center;">작성자</th>
								<th style="text-align: center;">업무분야</th>
								<th style="text-align: center;">업무내용</th>
								<th style="text-align: center;">결재여부</th>
								<th style="text-align: center;">결재/보류일</th>
								<th style="text-align: center;">날짜</th>
							</tr>
						</thead>
						<c:forEach items="${requestScope.dailyList}" var="daily" varStatus="loopTagStatus">
							<tr style="cursor: pointer"
								onclick="godDailyUpdelForm(${daily.REPORT_NO},${daily.RETURN_NO});" align=center>
								<td>${dailyListAllCnt + dailyBusiSearchDTO.rowCntPerPage -
									dailyBusiSearchDTO.rowCntPerPage * dailyBusiSearchDTO.selectPageNo -
									loopTagStatus.index}</td>
								<td>${daily.EMP_NAME} ${daily.EMP_JIKUP}</td>
								<td>${daily.BUSI_TYPE_CODE}</td>
								<td><span class="dot4">${daily.BUSI_CONTENT}</span></td>
								<td>
									<c:if test="${daily.SIGN_NAME eq '반려'}">
										<font style="font-weight: bold; color: #ff715e">
									</c:if>
									<c:if test="${daily.SIGN_NAME eq '미결재'}">
										<font color=yellow style="font-weight: bold">
									</c:if>
									<c:if test="${daily.SIGN_NAME eq '결재최종완료'}">
										<font style="font-weight: bold; color: #1ed255;">
									</c:if>
									${daily.SIGN_NAME}
								</td>
								<td>${daily.SIGN_DATE}</td>
								<td>${daily.BUSI_TIME}</td>
						</c:forEach>
						<c:if test="${dailyListAllCnt==0}">
							<tr>
								<td style="text-align: center;" colspan="7">검색된 글이 없습니다.</td>
							</tr>
						</c:if>
					</table>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>

	<!-- <script src="js/jquery-3.3.1.min.js"></script> -->
	<!-- https://jquery.com/download/ -->
	<script src="/ware/resources/js/bootstrap.min.js"></script>
	<!-- https://getbootstrap.com/ -->
	<form name="dailyBusiUpdelForm" method="post" action="/ware/dailyUpdelForm.do">
		<input type="hidden" name="emp_no" value="${emp_no}">
		<input type="hidden" name="report_no">
		<input type="hidden" name="return_no">
		<input type="hidden" name="loginemp_no" value="${sessionScope.emp_no}">
	</form>

	<form name="goBusiRegForm" method="post" action="/ware/dailyBusiRegForm.do"></form>
	<form name="goDashboard" method="post" action="/ware/dashboard.do"></form>
	<form name="goLoginForm" method="post" action="/ware/loginForm.do"> </form>
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
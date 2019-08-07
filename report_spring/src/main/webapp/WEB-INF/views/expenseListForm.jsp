<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="common.jsp"%>
<%@ include file="checkLogin.jsp"%>
<html>

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

		/* setTableTrBgColor2(
			"expenseList", "#1c1cff", "#eeeeee", "#ffffff", "#b3d6ff"
		); */

		$("[name=expense_price_min]").bind("keyup", function () {
			var money = $(this).val();
			var num = "";
			var number = "0123456789";
			for (var i = 0; i < money.length; i++) {
				var s = money.charAt(i);
				if (number.indexOf(s) >= 0) {
					num = num + s;
				}
			}
			while (num.charAt(0) == "0") {
				num = num.substring(1);
			}
			var result = "";
			var cnt = 0;
			for (var i = num.length - 1; i >= 0; i--) {
				cnt++;
				if (cnt % 3 == 0) {
					result = "," + num.charAt(i) + result;
				}
				else
					result = num.charAt(i) + result;
			}
			if (result.charAt(0) == ",") {
				result = result.substring(1);
			}
			$(this).val(result);

		});

		$("[name=expense_price_max]").bind("keyup", function () {
			var money = $(this).val();
			var num = "";
			var number = "0123456789";
			for (var i = 0; i < money.length; i++) {
				var s = money.charAt(i);
				if (number.indexOf(s) >= 0) {
					num = num + s;
				}
			}
			while (num.charAt(0) == "0") {
				num = num.substring(1);
			}
			var result = "";
			var cnt = 0;
			for (var i = num.length - 1; i >= 0; i--) {
				cnt++;
				if (cnt % 3 == 0) {
					result = "," + num.charAt(i) + result;
				}
				else
					result = num.charAt(i) + result;
			}
			if (result.charAt(0) == ",") {
				result = result.substring(1);
			}
			$(this).val(result);

		});
		//--------------------------------------
		// 페이징 처리 관련 HTML 소스를 class=pagingNumber 가진 태그 안에 삽입하기
		//--------------------------------------
		$(".pagingNumber").html(
			getPagingNumber(
				"${requestScope.expenseListAllCnt}"							// 검색 결과 총 행 개수
				, "${sessionScope.expenseSearchDTO.selectPageNo}"			// 선택된 현재 페이지 번호
				, "${sessionScope.expenseSearchDTO.rowCntPerPage}"		// 페이지 당 출력행의 개수
				, "10"														// 페이지 당 보여줄 페이지번호 개수
				, "goSearch();"												// 페이지 번호 클릭 후 실행할 자스코드
			)
		);

		//--------------------------
		// 검색 조건의 흔적 남기기
		//--------------------------

		inputData("keyword", "${sessionScope.expenseSearchDTO.keyword}");
		inputData("sign_year_min", "${sessionScope.expenseSearchDTO.sign_year_min}");
		inputData("sign_month_min", "${sessionScope.expenseSearchDTO.sign_month_min}");
		inputData("sign_year_max", "${sessionScope.expenseSearchDTO.sign_year_max}");
		inputData("sign_month_max", "${sessionScope.expenseSearchDTO.sign_month_max}");
		inputData("expense_year_min", "${sessionScope.expenseSearchDTO.expense_year_min}");
		inputData("expense_month_min", "${sessionScope.expenseSearchDTO.expense_month_min}");
		inputData("expense_year_max", "${sessionScope.expenseSearchDTO.expense_year_max}");
		inputData("expense_month_max", "${sessionScope.expenseSearchDTO.expense_month_max}");
		<c:forEach items="${sessionScope.expenseSearchDTO.sign_state}" var="sign_state">
			inputData("sign_state","${sign_state}");
		</c:forEach >
		<c:forEach items="${sessionScope.expenseSearchDTO.expense_method}" var="expense_method">
			inputData("expense_method","${expense_method}");
		</c:forEach >
		<c:forEach items="${sessionScope.expenseSearchDTO.expense_field}" var="expense_field">
			inputData("expense_field","${expense_field}");
		</c:forEach >
		inputData("expense_price_min", "${sessionScope.expenseSearchDTO.expense_price_min}");
		inputData("expense_price_max", "${sessionScope.expenseSearchDTO.expense_price_max}");
		inputData("row", "${sessionScope.expenseSearchDTO.rowCntPerPage}");
		inputData("selectPageNo", "${sessionScope.expenseSearchDTO.selectPageNo}");

		inputData("sort", "${ sessionScope.expenseSearchDTO.sort }")
		inputData("ascDesc", "${ sessionScope.expenseSearchDTO.ascDesc }")
		inputData("str", "${ sessionScope.expenseSearchDTO.str }")


		var x = $('[name=expense_price_min]').val();
		var y = $('[name=expense_price_max]').val();
		$('[name=expense_price_min]').val(x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		$('[name=expense_price_max]').val(y.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));





		$('.expenseList thead:eq(0) tr:eq(0) th:eq(0)').siblings().each(function () {
			// i번째 형재 th 태그 안의 앞,뒤 공백을 제거한 문자열을 얻자
			var str = $.trim($(this).text());
			if (str != "번호") {
				$(this).css("cursor", "pointer");
			}
			if (str == "${expenseSearchDTO.str}") {
				if ("${expenseSearchDTO.ascDesc}" == "asc") {
					$(this).text(str + '▲');
				}
				if ("${expenseSearchDTO.ascDesc}" == "desc") {
					$(this).text(str + '▼');
				}
			}
		});

		$('.expenseList thead:eq(0) tr:eq(0) th:eq(0)').siblings().click(function () {
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
			var allTrObj = $('.expenseList tbody:eq(0)').children();
			// Array 객체 생성해 각각의 tr을 관리하는 JQuery 객체들을 Array 객체에 저장
			var trObjs = [];
			allTrObj.each(function () {
				trObjs.push($(this));
			});
			var thIndex = thisThObj.index();
			$('[name=sort]').val(thIndex + 1);
			console.log(thIndex);

			$("[name=expense_price_min]").val($("[name=expense_price_min]").val().split(",").join(""));
			$("[name=expense_price_max]").val($("[name=expense_price_max]").val().split(",").join(""));
			// document.expenseSearchForm.submit();
			goSearch();
		});
        });

		function chcekBusi_date() {
			var sign_year_min = $('[name=sign_year_min]');
			var sign_month_min = $('[name=sign_month_min]');
			var sign_year_max = $('[name=sign_year_max]');
			var sign_month_max = $('[name=sign_month_max]');
			var expense_year_min = $('[name=expense_year_min]');
			var expense_month_min = $('[name=expense_month_min]');
			var expense_year_max = $('[name=expense_year_max]');
			var expense_month_max = $('[name=expense_month_max]');

			if (sign_year_min.val() == "" && sign_month_min.val() != "") {
				alert("결재 시작 연도를 먼저 선택해 주세요.");
				sign_month_min.val("");
				return;
			}
			if (sign_year_max.val() == "" && sign_month_max.val() != "") {
				alert("결재 끝 연도를 먼저 선택해 주세요.");
				sign_month_max.val("");
				return;
			}

			/*if (sign_year_min.val() == "" && sign_year_max.val() != "") {
				alert("결재 시작 연도를 먼저 선택해 주세요.");
				sign_year_max.val("");
				return;
			}

			if (sign_month_min.val() == "" && sign_month_max.val() != "") {
				alert("결재 시작 달을 먼저 선택해 주세요.");
				sign_month_max.val("");
				return;
			}*/

			//--------------------------------------

			if (expense_year_min.val() == "" && expense_month_min.val() != "") {
				alert("지출 시작 연도를 먼저 선택해 주세요.");
				expense_month_min.val("");
				return;
			}
			if (expense_year_max.val() == "" && expense_month_max.val() != "") {
				alert("지출 끝 연도를 먼저 선택해 주세요.");
				expense_month_max.val("");
				return;
			}

			/*if (expense_year_min.val() == "" && expense_year_max.val() != "") {
				alert("지출 시작 연도를 먼저 선택해 주세요.");
				expense_year_max.val("");
				return;
			}

			if (expense_month_min.val() == "" && expense_month_max.val() != "") {
				alert("지출 시작 달을 먼저 선택해 주세요.");
				expense_month_max.val("");
				return;
			}*/

			//--------------------------------------

			if (sign_year_min.val() >= sign_year_max.val()) {
				if (sign_year_min.val() > sign_year_max.val() && sign_year_max.val() != "") {
					alert("올바르지 않은 결재 연도 범위입니다.")
					sign_year_max.val("");
					return;
				}
				if (sign_year_min.val() == sign_year_max.val()) {
					if ((sign_month_min.val() > sign_month_max.val()) && sign_month_max.val() != "") {
						alert("올바르지 않은 결재 달 범위입니다.")
						sign_month_max.val("");
						return;
					}
				}
			}

			if (expense_year_min.val() >= expense_year_max.val()) {
				if (expense_year_min.val() > expense_year_max.val() && expense_year_max.val() != "") {
					alert("올바르지 않은 지출 연도 범위입니다.")
					expense_year_max.val("");
					return;
				}
				if (expense_year_min.val() == expense_year_max.val()) {
					if ((expense_month_min.val() > expense_month_max.val()) && expense_month_max.val() != "") {
						alert("올바르지 않은 지출 달 범위입니다.")
						expense_month_max.val("");
						return;
					}
				}
			}
		}

		//**************************
		// 저장 버트을 누르면 호출되는 함수
		// 입력양식들의 유효성 체크를 한 후 모두 유효성에 합당하면
		// 서버로 전송하는 기능을 가지고 있다.
		//**************************

		function checkForm() {
			alert(1);
		}


		//===========================================================================
		// menubar 페이지 이동하기
		//===========================================================================

		function goLogout() {
			if (confirm("정말 로그아웃 하시겠습니까?") == false) { return; }
			//location.replace("/ware/loginForm.do");
			document.goLoginForm.submit();
		}
		function button1_click() {
			//alert("공지사항");
			//location.replace("/ware/boardListForm.do"); 
			document.goBoardListForm.submit();
		}
		function button2_click() {
			//alert("지출보고서");
			//location.replace("/ware/expenseListForm.do");
			document.goExpenseListForm.submit();
		}
		function button3_click() {
			//alert("영업보고서");
			//location.replace("/ware/salesListForm.do");   
			document.goSalesListForm.submit();
		}
		function button4_click() {
			//alert("일일보고서");
			//location.replace("/ware/dailyListForm.do");   
			document.goDailyListForm.submit();
		}
		function button5_click() {
			//alert("휴가");
			//location.replace("/ware/calendarTest.do");  
			document.goCalendar.submit();
		}
		function button6_click() {
			//alert("마이페이지");
			//location.replace("/ware/myPageForm.do");   
			document.goMypageForm.submit();
		}
		function button7_click() {
			//alert("직원관리");
			//location.replace("/ware/employeeListForm.do");
			document.goEmployeeListForm.submit();
		}

		function goExpenseUpdelForm(REPORT_NO, RETURN_NO) {
			$("[name=expenseUpdelForm] [name=report_no]").val(REPORT_NO);
			$("[name=expenseUpdelForm] [name=return_no]").val(RETURN_NO);
			document.expenseUpdelForm.submit();
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

		function goSearch() {
			var row = $("[name=row]").val();
			$("[name=rowCntPerPage]").val(row);
			$("[name=expense_price_min]").val($("[name=expense_price_min]").val().split(",").join(""));
			$("[name=expense_price_max]").val($("[name=expense_price_max]").val().split(",").join(""));
			if (is_empty("keyword")) {
				$("[name=keyword]").val("");
			}
			document.expenseSearchForm.submit();
		}


		function setEmptyAll() {
			document.expenseSearchForm.reset();
		}

		function goSearchAll() {
			document.expenseSearchForm.reset();
			inputData("selectPageNo","1");
			document.expenseSearchForm.submit();
		}


		function setEmpty(val1, val2, val3, val4) {
			setEmpty2("[name=" + val1 + "],[name=" + val2 + "],[name=" + val3 + "],[name=" + val4 + "]");
		}


		function checkExpensePrice() {
			var expense_price_min = $("[name=expense_price_min]").val();
			expense_price_min = expense_price_min.split(",").join("");
			var expense_price_max = $("[name=expense_price_max]").val();
			expense_price_max = expense_price_max.split(",").join("");
			if (expense_price_min != "" && expense_price_max != "") {
				if (expense_price_min > expense_price_max) {
					alert("지출 검색 범위를 다시 확인해주세요.");
					$("[name=expense_price_min]").val("");
					$("[name=expense_price_max]").val("");
				}
			}
		}
		            
		function setSearch(){       
			inputData("sign_year_min", "2019");
			inputData("sign_month_min", "03");
			inputData("sign_year_max", "2019");
			inputData("sign_month_max", "08");
			inputData("expense_year_min", "2019");
			inputData("expense_month_min", "02");
			inputData("expense_year_max", "2019");
			inputData("expense_month_max", "08");
			inputData("expense_method", "1");
			inputData("expense_method", "3");
			inputData("expense_field", "1");
			inputData("expense_field", "2");
			inputData("expense_field", "4");
			inputData("expense_field", "6");
			inputData("expense_field", "13");
			inputData("expense_price_min", "30000");
			inputData("expense_price_max", "250000");
			inputData("sign_state", "2");
			inputData("sign_state", "4");
			inputData("keyword", "인사부");
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
							<a class="dropdown-item" href="javascript:document.goDailyListForm.submit();">일일 보고서</a>
							<a class="dropdown-item" href="javascript:document.goSalesListForm.submit();">영업 보고서</a>
							<a class="dropdown-item active" href="javascript:document.goExpenseListForm.submit();">지출 보고서</a>
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

	<div class="mt-5 ml-6 mr-6">
		<div class="row tm-content-row">
			<div class="col-12 tm-block-col">
				<div class="tm-bg-primary-dark tm-block tm-block-h-auto tm-block-scroll" style="margin-bottom:80px">
					<h2 class="tm-block-title">지출보고서</h2>
					<!--===============================================================================================-->
					<!-- 공지사항 -->
					<!--===============================================================================================-->
					<form name="expenseSearchForm" method="post" action="/ware/expenseListForm.do">
						<table class="table" name=list style="width:100%">
							<tr>
								<th bgcolor="#486177">결재일
									</td>
								<td>
									<select name="sign_year_min" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="" selected>선택</option>
										<script>
											for (var i = new Date().getFullYear(); i >= 2000; i--) {
												document.write("<option value=" + i + ">" + i);
											}
										</script>
									</select>년 &nbsp; &nbsp;
									<select name="sign_month_min" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="" selected>선택</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
									</select>월 ~ <select name="sign_year_max" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="" selected>선택</option>
										<script>
											for (var i = new Date().getFullYear(); i >= 2000; i--) {
												document.write("<option value=" + i + ">" + i);
											}
										</script>
									</select>년&nbsp; &nbsp;
									<select name="sign_month_max" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="" selected>선택</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
									</select>월
									<span style="cursor: pointer;"
										onclick="setEmpty('sign_year_min','sign_month_min','sign_year_max','sign_month_max');">&emsp;[비움]&nbsp;</span>
									<span style="cursor: pointer;"
										onclick="getToday('sign_year_min','sign_month_min','sign_year_max','sign_month_max');">[오늘로]</span>
								</td>
							</tr>
							<tr>
								<th bgcolor="#486177">지출일
								<td>
									<select name="expense_year_min" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="" selected>선택</option>
										<script>
											for (var i = new Date().getFullYear(); i >= 2000; i--) {
												document.write("<option value=" + i + ">" + i);
											}
										</script>
									</select>년 &nbsp; &nbsp;
									<select name="expense_month_min" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="" selected>선택</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
									</select>월 ~
									<select name="expense_year_max" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="" selected>선택</option>
										<script>
											for (var i = new Date().getFullYear(); i >= 2000; i--) {
												document.write("<option value=" + i + ">" + i);
											}
										</script>
									</select>년 &nbsp; &nbsp;
									<select name="expense_month_max" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="">선택</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
									</select>월
									<span style="cursor: pointer;"
										onclick="setEmpty('expense_year_min','expense_month_min','expense_year_max','expense_month_max');">&emsp;[비움]&nbsp;</span>
									<span style="cursor: pointer;"
										onclick="getToday('expense_year_min','expense_month_min','expense_year_max','expense_month_max');">[오늘로]</span>
								</td>
								</td>
							</tr>
							<tr>
								<th bgcolor="#486177">결재여부
									</td>
								<td>
									<input type="checkbox" name="sign_state" value="1">결재완료
									<input type="checkbox" name="sign_state" value="2">결재최종완료
									<input type="checkbox" name="sign_state" value="3">미결재
									<input type="checkbox" name="sign_state" value="4">반려
									<span style="cursor: pointer;" onclick="setEmpty('sign_state');">&emsp;[비움]</span>

							</tr>
							<tr>
								<th bgcolor="#486177">지출수단
									</td>
								<td>
									<input type="checkbox" name="expense_method" value="1">회사카드
									<input type="checkbox" name="expense_method" value="2">회사현금
									<input type="checkbox" name="expense_method" value="3">개인카드
									<input type="checkbox" name="expense_method" value="4">개인현금
									<span style="cursor: pointer;" onclick="setEmpty('expense_method');">&emsp;[비움]</span>
								</td>
							</tr>
							<tr>
								<th bgcolor="#486177">지출분야
									</td>
								<td>
									<input type="checkbox" name="expense_field" value="1">식대
									<input type="checkbox" name="expense_field" value="2">회식비
									<input type="checkbox" name="expense_field" value="3">접대비
									<input type="checkbox" name="expense_field" value="4">비품
									<input type="checkbox" name="expense_field" value="5">기자재
									<input type="checkbox" name="expense_field" value="6">사무기구
									<input type="checkbox" name="expense_field" value="7">교통비
									<input type="checkbox" name="expense_field" value="8">경조사비
									<input type="checkbox" name="expense_field" value="9">숙박비
									<input type="checkbox" name="expense_field" value="10">의류비
									<input type="checkbox" name="expense_field" value="11">도서비
									<input type="checkbox" name="expense_field" value="12">홍보비
									<input type="checkbox" name="expense_field" value="13">기타
									
									<span style="cursor: pointer;" onclick="setEmpty('expense_field');">&emsp;[비움]</span>
								</td>
							</tr>
							<tr>
								<th bgcolor="#486177">비용
									</td>
								<td>
									<input type="text" name="expense_price_min" onchange="checkExpensePrice();" style="background-color: #54657d;
											color: #fff; border: 0; padding: 19px 18px; border-radius: 0; width:150px;height: 20px;">원
									&nbsp;~
									<input type="text" name="expense_price_max" onchange="checkExpensePrice();" style="background-color: #54657d;
											color: #fff; border: 0; padding: 19px 18px; border-radius: 0; width:150px;height: 20px;">원
									<span style="cursor: pointer;"
										onclick="setEmpty('expense_price_min','expense_price_max');">&emsp;[비움]</span>
							</tr>
							<tr>
								<th bgcolor="#486177">키워드
									</td>
								<td>
									<input type="text" name="keyword" style="background-color: #54657d;
											color: #fff; border: 0; padding: 19px 18px; border-radius: 0; width:150px;height: 20px;">
									<span style="cursor: pointer;" onclick="setEmpty('keyword');">&emsp;[비움]</span>
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
								<td width=10></td>
								<td>
									<span tyle="cursor: pointer;" onclick="setSearch();">
										<button style="max-width: 80px;"
											class="btn btn-small btn-primary btn-block text-uppercase">
											조건입력
										</button>
									</span>
								</td>
						</table>
					</center>
					<div style="height:80px;"></div>

					<table border="0" class="table" style="width:100%">
						<tr>
							<td>
								<div style="float: left">
									<span style="cursor: pointer" onclick="document.goExpenseRegForm.submit();">
										<button style="max-width: 150px;"
											class="btn btn-small btn-primary btn-block text-uppercase">
											지출보고서 등록
										</button>
									</span>
								</div>
							</td>
							<td align=center><span class="pagingNumber"></span>
							<td style="text-align: right;">[검색총개수] : ${expenseListAllCnt}개
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
					<table class="table expenseList" style="width:100%">
						<thead>
							<tr>
								<th style="text-align: center;">번호</th>
								<th style="text-align: center;">작성자</th>
								<th style="text-align: center;">지출제목</th>
								<th style="text-align: center;">지출분야</th>
								<th style="text-align: center;">결재여부</th>
								<th style="text-align: center;">결재/반려일</th>
								<th style="text-align: center;">지출일</th>
								<th style="text-align: center;">비용</th>
								<th style="text-align: center;">지출수단</th>
							</tr>
						</thead>
						<c:forEach items="${requestScope.expenseList}" var="exp" varStatus="loopTagStatus">
							<tr style="cursor: pointer"
								onclick="goExpenseUpdelForm(${exp.REPORT_NO},${exp.RETURN_NO});">
								<td align="center">${expenseListAllCnt + expenseSearchDTO.rowCntPerPage -
									expenseSearchDTO.rowCntPerPage * expenseSearchDTO.selectPageNo -
									loopTagStatus.index}</td>
								<td align="center">${exp.EMP_NAME} ${exp.EMP_JIKUP}</td>
								<td align="center"><span class="dot">${exp.REPORT_NAME}</span></td>
								<td align="center">${exp.EXPENSE_FIELD_NAME}</td>
								<td align="center">
									<c:if test="${exp.SIGN_NAME eq '반려'}">
											<font style="font-weight: bold; color: #ff715e">
									</c:if>
									<c:if test="${exp.SIGN_NAME eq '미결재'}">
										<font color=yellow style="font-weight: bold">
									</c:if>
									<c:if test="${exp.SIGN_NAME eq '결재최종완료'}">
										<font style="font-weight: bold; color: #1ed255;">
									</c:if>
									${exp.SIGN_NAME}
								</td>
								<td align="center">${exp.SIGN_DATE}</td>
								<td align="center">${exp.EXPENSE_DATE}</td>
								<td align="right">${exp.EXPENSE_PRICE}원</td>
								<td align="center">${exp.EXPENSE_METHOD_NAME}</td>
						</c:forEach>
						<c:if test="${expenseListAllCnt==0}">
							<tr>
								<td style="text-align: center;" colspan="9">검색된 글이 없습니다.</td>
							</tr>
						</c:if>

					</table>

					</center>
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
	<form name="expenseUpdelForm" method="post" action="/ware/expenseUpdelForm.do">
		<input type="hidden" name="emp_no" value="${emp_no}">
		<input type="hidden" name="report_no">
		<input type="hidden" name="return_no">
		<input type="hidden" name="loginemp_no" value="${sessionScope.emp_no}">
	</form>


	<form name="goExpenseRegForm" method="post" action="/ware/expenseRegForm.do"> </form>
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
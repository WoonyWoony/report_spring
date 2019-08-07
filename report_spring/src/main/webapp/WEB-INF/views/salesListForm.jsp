<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 common.jsp 파일 내의 소스를 삽입하기 -->
<%@include file="common.jsp"%>
<%@include file="checkLogin.jsp" %>
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

		//--------------------------------------
		// 페이징 처리 관련 HTML 소스를 class=pagingNumber 가진 태그 안에 삽입하기
		//--------------------------------------
		$(".pagingNumber").html(
			getPagingNumber(
				"${requestScope.salesListAllCnt}"							// 검색 결과 총 행 개수
				, "${sessionScope.salesSearchDTO.selectPageNo}"			// 선택된 현재 페이지 번호
				, "${sessionScope.salesSearchDTO.rowCntPerPage}"		// 페이지 당 출력행의 개수
				, "10"														// 페이지 당 보여줄 페이지번호 개수
				, "goSearch();"												// 페이지 번호 클릭 후 실행할 자스코드
			)
		);

		//--------------------------
		// 검색 조건의 흔적 남기기
		//--------------------------

		inputData("keyword", "${sessionScope.salesSearchDTO.keyword}");
		inputData("sign_year_min", "${sessionScope.salesSearchDTO.sign_year_min}");
		inputData("sign_month_min", "${sessionScope.salesSearchDTO.sign_month_min}");
		inputData("sign_year_max", "${sessionScope.salesSearchDTO.sign_year_max}");
		inputData("sign_month_max", "${sessionScope.salesSearchDTO.sign_month_max}");
		inputData("sales_year_min", "${sessionScope.salesSearchDTO.sales_year_min}");
		inputData("sales_month_min", "${sessionScope.salesSearchDTO.sales_month_min}");
		inputData("sales_year_max", "${sessionScope.salesSearchDTO.sales_year_max}");
		inputData("sales_month_max", "${sessionScope.salesSearchDTO.sales_month_max}");
		<c:forEach items="${sessionScope.salesSearchDTO.sign_state}" var="sign_state">
			inputData("sign_state","${sign_state}");
		</c:forEach >
		<c:forEach items="${sessionScope.salesSearchDTO.sales_type}" var="sales_type">
			inputData("sales_type","${sales_type}");
		</c:forEach >
		inputData("row", "${sessionScope.salesSearchDTO.rowCntPerPage}");
		inputData("selectPageNo", "${sessionScope.salesSearchDTO.selectPageNo}");

		inputData("sort", "${ sessionScope.salesSearchDTO.sort }")
		inputData("ascDesc", "${ sessionScope.salesSearchDTO.ascDesc }")
		inputData("str", "${ sessionScope.salesSearchDTO.str }")



		$('.salesList thead:eq(0) tr:eq(0) th:eq(0)').siblings().each(function () {
			// i번째 형재 th 태그 안의 앞,뒤 공백을 제거한 문자열을 얻자
			var str = $.trim($(this).text());
			if (str != "번호") {
				$(this).css("cursor", "pointer");
			}
			if (str == "${salesSearchDTO.str}") {
				if ("${salesSearchDTO.ascDesc}" == "asc") {
					$(this).text(str + '▲');
				}
				if ("${salesSearchDTO.ascDesc}" == "desc") {
					$(this).text(str + '▼');
				}
			}
		});

		$('.salesList thead:eq(0) tr:eq(0) th:eq(0)').siblings().click(function () {
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
			var allTrObj = $('.salesList tbody:eq(0)').children();
			// Array 객체 생성해 각각의 tr을 관리하는 JQuery 객체들을 Array 객체에 저장
			var trObjs = [];
			allTrObj.each(function () {
				trObjs.push($(this));
			});
			var thIndex = thisThObj.index();
			$('[name=sort]').val(thIndex + 1);
			console.log(thIndex);
			// document.salesSearchForm.submit();
			goSearch();
		});
        });

		//**************************
		// 저장 버트을 누르면 호출되는 함수
		// 입력양식들의 유효성 체크를 한 후 모두 유효성에 합당하면
		// 서버로 전송하는 기능을 가지고 있다.
		//**************************


		//===========================================================
		// 폼태그 안의 모든 입력양식의 입력데이터를 없애거나 선택 데이터를 취소해버리는 함수.
		// 즉 초기화 함수
		//===========================================================

		function setEmptyAll() {
			//<방법1>-------------------------------------------------
			// 태그명 form인 요소의 후손중에 checked속성값이true인 요소들을 관리하는 제이쿼리객체메위주로 attr 메소드 호출
			// $("form").find(":checkbox").attr( "checked", false );
			// 태그명 form  후손중에 checkbox radio 아닌 입력양식의(select태그, textarea태그, 입력양식 중 type=text인 태그, 입력양식 중 type =password인 태그) val 지우기
			//$("form").find("select, textarea, :text, :password").val("");// 여기에는 체크박스 를 포함시키면 안된다. (주의)

			//<방법2>-------------------------------------------------
			document.salesSearchForm.reset();
		}

		function goSearchAll() {
			document.salesSearchForm.reset();
			inputData("selectPageNo","1");
			document.salesSearchForm.submit();
		}

		function SalesRegForm() {
			//location.replace("/ware/salesRegForm.do");
			document.goSalesRegForm.submit();
		}
		function goSalesUpdelForm(REPORT_NO, RETURN_NO) {
			$("[name=salesUpdelForm] [name=report_no]").val(REPORT_NO);
			$("[name=salesUpdelForm] [name=return_no]").val(RETURN_NO);
			document.salesUpdelForm.submit();
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
			if (is_empty("keyword")) {
				$("[name=keyword]").val("");
			}
			document.salesSearchForm.submit();
		}


		function setEmpty(val1, val2, val3, val4) {
			setEmpty2("[name=" + val1 + "],[name=" + val2 + "],[name=" + val3 + "],[name=" + val4 + "]");
		}
		// ---------------------------------------------------

		function chcekBusi_date() {
			var sign_year_min = $('[name=sign_year_min]');
			var sign_month_min = $('[name=sign_month_min]');
			var sign_year_max = $('[name=sign_year_max]');
			var sign_month_max = $('[name=sign_month_max]');
			var sales_year_min = $('[name=sales_year_min]');
			var sales_month_min = $('[name=sales_month_min]');
			var sales_year_max = $('[name=sales_year_max]');
			var sales_month_max = $('[name=sales_month_max]');

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

			if (sales_year_min.val() == "" && sales_month_min.val() != "") {
				alert("영업 시작 연도를 먼저 선택해 주세요.");
				sales_month_min.val("");
				return;
			}
			if (sales_year_max.val() == "" && sales_month_max.val() != "") {
				alert("영업 끝 연도를 먼저 선택해 주세요.");
				sales_month_max.val("");
				return;
			}

			/*if (sales_year_min.val() == "" && sales_year_max.val() != "") {
				alert("영업 시작 연도를 먼저 선택해 주세요.");
				sales_year_max.val("");
				return;
			}

			if (sales_month_min.val() == "" && sales_month_max.val() != "") {
				alert("영업 시작 달을 먼저 선택해 주세요.");
				sales_month_max.val("");
				return;
			}*/

			//--------------------------------------

			if (sign_year_min.val() >= sign_year_max.val()) {
				if (sign_year_min.val() > sign_year_max.val() && sign_year_max.val() != "") {
					alert("올바르지 않은 결재 연도 범위입니다.")
					sign_year_max.val("");
					sign_month_max.val("");
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

			if (sales_year_min.val() >= sales_year_max.val()) {
				if (sales_year_min.val() > sales_year_max.val() && sales_year_max.val() != "") {
					alert("올바르지 않은 영업 연도 범위입니다.")
					sales_year_max.val("");
					sales_month_max.val("");
					return;
				}
				if (sales_year_min.val() == sales_year_max.val()) {
					if ((sales_month_min.val() > sales_month_max.val()) && sales_month_max.val() != "") {
						alert("올바르지 않은 영업 달 범위입니다.")
						sales_month_max.val("");
						return;
					}
				}
			}
		}      
		             
		function setSearch(){       
			inputData("sign_year_min", "2019");
			inputData("sign_month_min", "01");
			inputData("sign_year_max", "2019");
			inputData("sign_month_max", "08");
			inputData("sales_year_min", "2019");
			inputData("sales_month_min", "01");
			inputData("sales_year_max", "2019");
			inputData("sales_month_max", "08");
			inputData("sales_type", "1");
			inputData("sales_type", "2");
			inputData("sales_type", "3");
			inputData("sign_state", "2");
			inputData("sign_state", "4");
			inputData("keyword", "거래");
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
							<a class="dropdown-item active" href="javascript:document.goSalesListForm.submit();">영업 보고서</a>
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
					<h2 class="tm-block-title">영업보고서</h2>

					<!--===============================================================================================-->
					<!-- 영업보고서 -->
					<!--===============================================================================================-->
					<form name="salesSearchForm" method="post" action="/ware/salesListForm.do">
						<table class="table" style="width:100%">
							<tr>
								<th bgcolor="#486177">결재일
									</td>
								<td>
									<select name="sign_year_min" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="" selected>-선택-</option>
										<script>
											for (var i = new Date().getFullYear(); i >= 2000; i--) {
												document.write("<option value=" + i + ">" + i);
											}
										</script>
									</select>년 &nbsp; &nbsp;
									<select name="sign_month_min" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:60px;height:30px; padding: 5px">
										<option value="" selected>-선택-</option>
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
									</select>월 ~ <select name="sign_year_max" class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px" onchange="chcekBusi_date();">
										<option value="" selected>-선택-</option>
										<script>
											for (var i = new Date().getFullYear(); i >= 2000; i--) {
												document.write("<option value=" + i + ">" + i);
											}
										</script>
									</select>년&nbsp; &nbsp;
									<select name="sign_month_max" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:60px;height:30px; padding: 5px">
										<option value="" selected>-선택-</option>
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
								<th bgcolor="#486177">영업일
								<td>
									<select name="sales_year_min" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="" selected>-선택-</option>
										<script>
											for (var i = new Date().getFullYear(); i >= 2000; i--) {
												document.write("<option value=" + i + ">" + i);
											}
										</script>
									</select>년 &nbsp; &nbsp;
									<select name="sales_month_min" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:60px;height:30px; padding: 5px">
										<option value="" selected>-선택-</option>
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
									<select name="sales_year_max" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px">
										<option value="" selected>-선택-</option>
										<script>
											for (var i = new Date().getFullYear(); i >= 2000; i--) {
												document.write("<option value=" + i + ">" + i);
											}
										</script>
									</select>년 &nbsp; &nbsp;
									<select name="sales_month_max" onchange="chcekBusi_date();"
										class="custom-select tm-select-accounts"
										style="width:60px;height:30px; padding: 5px">
										<option value="">-선택-</option>
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
										onclick="setEmpty('sales_year_min','sales_month_min','sales_year_max','sales_month_max');">&emsp;[비움]&nbsp;</span>
									<span style="cursor: pointer;"
										onclick="getToday('sales_year_min','sales_month_min','sales_year_max','sales_month_max');">[오늘로]</span>
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
								<th bgcolor="#486177">방문목적
									</td>
								<td>
									<input type="checkbox" name="sales_type" value="1">영업지관리
									<input type="checkbox" name="sales_type" value="2">수금
									<input type="checkbox" name="sales_type" value="3">회의
									<input type="checkbox" name="sales_type" value="4">거래처확보
									<input type="checkbox" name="sales_type" value="5">기타
									
									<span style="cursor: pointer;" onclick="setEmpty('sales_type');">&emsp;[비움]</span></td>
							</tr>

							<tr>
								<th bgcolor="#486177">키워드
									</td>
								<td>
									<input type="text" name="keyword"
										style="background-color: #54657d; color: #fff; border: 0; padding: 19px 18px; border-radius: 0; width:150px;height: 20px;">
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

					<table class="table" style="width:100%">
						<tr>
							<td>
								<div style="float: left">
									<span style="cursor: pointer" onclick="document.goSalesRegForm.submit();">
										<button style="max-width: 150px;"
											class="btn btn-small btn-primary btn-block text-uppercase">
											영업보고서 등록
										</button>
									</span>
								</div>
							</td>
							<td align=center><span class="pagingNumber"></span>
							<td style="text-align: right;">[검색총개수] : ${salesListAllCnt}개
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
					<table class="table salesList" style="width:100%">
						<thead>
							<tr>
								<th style="text-align: center;">번호</th>
								<th style="text-align: center;">작성자</th>
								<th style="text-align: center;">영업제목</th>
								<th style="text-align: center;">방문목적</th>
								<th style="text-align: center;">결재여부</th>
								<th style="text-align: center;">결재/반려일</th>
								<th style="text-align: center;">영업일</th>
							</tr>
						</thead>
						<c:forEach items="${requestScope.salesList}" var="sale" varStatus="loopTagStatus">
							<tr align="center" style="cursor: pointer"
								onclick="goSalesUpdelForm(${sale.REPORT_NO},${sale.RETURN_NO});">
								<td>${salesListAllCnt + salesSearchDTO.rowCntPerPage -
									salesSearchDTO.rowCntPerPage * salesSearchDTO.selectPageNo - loopTagStatus.index}
								</td>
								<td>${sale.EMP_NAME} ${sale.EMP_JIKUP}</td>
								<td><span class="dot4">${sale.REPORT_NAME}</span></td>
								<td>${sale.SALES_TYPE_NAME}</td>
								<td>
									<c:if test="${sale.SIGN_NAME eq '반려'}">
										<font style="font-weight: bold; color: #ff715e">
									</c:if>
									<c:if test="${sale.SIGN_NAME eq '미결재'}">
										<font color=yellow style="font-weight: bold">
									</c:if>
									<c:if test="${sale.SIGN_NAME eq '결재최종완료'}">
										<font style="font-weight: bold; color: #1ed255;">
									</c:if>
									${sale.SIGN_NAME}
								</td>
								<td>${sale.SIGN_DATE}</td>
								<td>${sale.SALES_DATE_START}</td>
						</c:forEach>
						<c:if test="${salesListAllCnt==0}">
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

	<form name="salesUpdelForm" method="post" action="/ware/salesUpdelForm.do">
		<input type="hidden" name="emp_no" value="${emp_no}">
		<input type="hidden" name="report_no">
		<input type="hidden" name="return_no">
		<input type="hidden" name="loginemp_no" value="${sessionScope.emp_no}">
	</form>

	<form name="goDashboard" method="post" action="/ware/dashboard.do"></form>
	<form name="goSalesRegForm" method="post" action="/ware/salesRegForm.do"> </form>

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
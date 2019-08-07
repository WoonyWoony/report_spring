<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="common.jsp"%>
<%@ include file="checkLogin.jsp"%>
<html>
<STYLE>
	.qwldl {
		color: #F7604D;
		color: #4ED6B8;
		color: #A8D582;
		color: #ff9f40;
		color: #ffcd56;
		color: #b1ffff;
		color: #36a2eb;
		color: #9966ff;
		color: #c9cbcf;
		color: #d282d5;
		color: #fff567;
		color: #ffb7db;
		color: #5e9eff;
	}
</STYLE>

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
		$(function () {
			$("html, body").animate({ scrollTop: ${ scrollValue } }, "slow");

			$(window).scroll(function () {
				var scrollValue = $(document).scrollTop();
				$('[name=scrollValue]').val(scrollValue);
			});
			inputData("mySignCount_year", "${sessionScope.dashboardDTO.mySignCount_year}");
			inputData("roundStat_year", "${sessionScope.dashboardDTO.roundStat_year}");
			inputData("roundStat_kinds", "${sessionScope.dashboardDTO.roundStat_kinds}");
			inputData("reportCode", "${sessionScope.dashboardDTO.reportCode}");
			inputData("signCodeCnt_year", "${sessionScope.dashboardDTO.signCodeCnt_year}");
			inputData("signCodeCnt_month", "${sessionScope.dashboardDTO.signCodeCnt_month}");
		});
		function mySignCount() {
			document.mySignCountForm.submit();
		}

		function roundChart() {
			var roundStat_year = $("[name=roundStat_year]").val();
			var roundStat_kinds = $("[name=roundStat_kinds]").val();
			document.mySignCountForm.submit();
		}
		function goSearch(){
			document.mySignCountForm.submit();
		}

		function godDailyUpdelForm(REPORT_NO, RETURN_NO) {
			$("[name=dailyBusiUpdelForm] [name=report_no]").val(REPORT_NO);
			$("[name=dailyBusiUpdelForm] [name=return_no]").val(RETURN_NO);
			document.dailyBusiUpdelForm.submit();
		}

		function goExpenseUpdelForm(REPORT_NO, RETURN_NO) {
			$("[name=expenseUpdelForm] [name=report_no]").val(REPORT_NO);
			$("[name=expenseUpdelForm] [name=return_no]").val(RETURN_NO);
			document.expenseUpdelForm.submit();
		}

		function goSalesUpdelForm(REPORT_NO, RETURN_NO) {
			$("[name=salesUpdelForm] [name=report_no]").val(REPORT_NO);
			$("[name=salesUpdelForm] [name=return_no]").val(RETURN_NO);
			document.salesUpdelForm.submit();
		}
	</script>
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
							<a class="nav-link active" href="javascript:document.goDashboard.submit();">
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
								<a class="dropdown-item"
									href="javascript:document.goEmployeeListForm_beforeAllow.submit();"
									style="text-align: center">가입 관리</a>

							</div>
						</li>
					</ul>
					<ul class="navbar-nav">
						<li class="nav-item">
							<a class="nav-link d-block" href="/ware/loginForm.do">
								${emp_name } ${emp_jikup }<br><b><i class="fas fa-sign-out-alt"></i> Logout</b>
							</a>
						</li>
					</ul>
				</div>
			</div>

		</nav>
		<div class="container" style="margin-bottom: 80px">
			<div class="row">
				<div class="col">
					<p class="text-white mt-5 mb-5">Welcome back, <b>${emp_name } ${emp_jikup }</b></p>
				</div>
			</div>
			<!-- row -->
			<div class="row tm-content-row">
				<div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 tm-block-col">
					<div class="tm-bg-primary-dark tm-block">
						<form name="mySignCountForm" method="POST" action="/ware/dashboard.do">
						<h2 class="tm-block-title">
							보고서 결재횟수
								<select align=right name="mySignCount_year" class="custom-select tm-select-accounts"
									style="float: right; width:70px;height:30px; padding: 5px; font-size: 14px"
									onchange="mySignCount();">
									<script>
										for (var i = new Date().getFullYear(); i > 2010; i--) {
											document.write("<option value=" + i + ">" + i + "년");
										}
									</script>
								</select>

						</h2>
						<canvas id="lineChart"></canvas>
					</div>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 tm-block-col">
					<div class="tm-bg-primary-dark tm-block">
						<h2 class="tm-block-title">
							기안한 보고서 결재상태
							<table align=right>
								<tr>
									<td>
										<select name="reportCode" class="custom-select tm-select-accounts"
											style="width:95px;height:30px; padding: 5px; font-size: 14px" onchange="goSearch();">
											<option value="1">일일보고서</option>
											<option value="2">영업보고서</option>
											<option value="3">지출보고서</option>
										</select>
									</td>
									<td width=3></td>
									<td>
										<select name="signCodeCnt_year" class="custom-select tm-select-accounts"
											style="width:75px;height:30px; padding: 5px; font-size: 14px" onchange="goSearch();">
											<script>
												for (var i = new Date().getFullYear(); i > 2010; i--) {
													document.write("<option value=" + i + ">" + i + "년");
												}
											</script>
										</select>
									</td>
									<td width=3></td>
									<td>
										<select name="signCodeCnt_month" class="custom-select tm-select-accounts"
											style="width:60px;height:30px; padding: 5px; font-size: 14px" onchange="goSearch();">
											<option value=""></option>
											<script>
												for (var i = 1; i <=12; i++) {
													var m = (i < 10) ? "0" + i : i;
													document.write("<option value=" + m + ">" + m + "월");
												}
											</script>
										</select>
									</td>
								</tr>
							</table>
						</h2>
						<canvas id="barChart"></canvas>
					</div>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 tm-block-col">
					<div class="tm-bg-primary-dark tm-block tm-block-taller">
						<h2 class="tm-block-title">
							기안한 보고서 항목별 개수
							<select align=right name="roundStat_year" class="custom-select tm-select-accounts"
								style="float: right; width:70px;height:30px; padding: 5px; font-size: 14px"
								onchange="roundChart();">
								<script>
									for (var i = new Date().getFullYear(); i > 2010; i--) {
										document.write("<option value=" + i + ">" + i + "년");
									}
								</script>
							</select>&nbsp;
							<select align=right name="roundStat_kinds" class="custom-select tm-select-accounts"
								style="float: right; width:90px;height:30px; padding: 5px; font-size: 14px"
								onchange="roundChart();">
								<option value="일일">일일보고서</option>
								<option value="영업">영업보고서</option>
								<option value="지출">지출보고서</option>
							</select>
							<input type="hidden" name="scrollValue" value="0">
							</form>
						</h2>
						<div id="pieChartContainer">
							<canvas id="pieChart" class="chartjs-render-monitor" width="200" height="200"></canvas>
						</div>
					</div>
				</div>
				<div class="col-sm-12 col-md-12 col-lg-6 col-xl-6 tm-block-col">
					<div class="tm-bg-primary-dark tm-block tm-block-taller tm-block-overflow">
						<h2 class="tm-block-title">보고서 결재 요청 목록</h2>
						<div class="tm-notification-items">
						<c:forEach items="${requestScope.beforeSignList}" var="beforeSignList" varStatus="loopTagStatus">
								<div class="media tm-notification-item">
									<div class="tm-gray-circle"><img width=80 height=80 src="/ware/resources/emppic/${beforeSignList.PREV_EMP_NO}.jpg" alt="Avatar Image"
											class="rounded-circle"></div>
									<div class="media-body">
										<p class="mb-2">
											<b>${beforeSignList.PREV_DEP_NAME}</b>의 <b>${beforeSignList.PREV_EMP_NAME} ${beforeSignList.PREV_JIKUP_NAME}</b>이(가)
											<c:if test="${beforeSignList.PREV_REPORT_CODE eq '1'}">
												<a href="javascript:goExpenseUpdelForm(${beforeSignList.PREV_REPORT_NO},${beforeSignList.PREV_RETURN_NO});" class="tm-notification-link">지출 보고서</a>
											</c:if>
											<c:if test="${beforeSignList.PREV_REPORT_CODE eq '2'}">
												<a href="javascript:goSalesUpdelForm(${beforeSignList.PREV_REPORT_NO},${beforeSignList.PREV_RETURN_NO});" class="tm-notification-link">영업 보고서</a>
											</c:if>
											<c:if test="${beforeSignList.PREV_REPORT_CODE eq '3'}">
												<a href="javascript:godDailyUpdelForm(${beforeSignList.PREV_REPORT_NO},${beforeSignList.PREV_RETURN_NO});" class="tm-notification-link">일일 보고서</a>
											</c:if>
											의 <br>결재를 요청하였습니다.
										</p>
										<span class="tm-small tm-text-color-secondary">${beforeSignList.PREV_SIGN_DATE}</span>
									</div>
								</div>
							</c:forEach>
							<c:if test="${empty requestScope.beforeSignList}">
								<div align="center" style="margin-top:25%">
									<h2 class="tm-block-title">결재 요청 목록이 없습니다.</h2>
								</div>
							</c:if>
						</div>
					</div>
				</div>
				<!--                 <div class="col-12 tm-block-col">
			                    <div class="tm-bg-primary-dark tm-block tm-block-taller tm-block-scroll">
			                        <h2 class="tm-block-title">Orders List</h2>
			                        <table class="table">
			                            <thead>
			                                <tr>
			                                    <th scope="col">ORDER NO.</th>
			                                    <th scope="col">STATUS</th>
			                                    <th scope="col">OPERATORS</th>
			                                    <th scope="col">LOCATION</th>
			                                    <th scope="col">DISTANCE</th>
			                                    <th scope="col">START DATE</th>
			                                    <th scope="col">EST DELIVERY DUE</th>
			                                </tr>
			                            </thead>
			                            <tbody>
			                                <tr>
			                                    <th scope="row"><b>#122349</b></th>
			                                    <td>
			                                        <div class="tm-status-circle moving">
			                                        </div>Moving
			                                    </td>
			                                    <td><b>Oliver Trag</b></td>
			                                    <td><b>London, UK</b></td>
			                                    <td><b>485 km</b></td>
			                                    <td>16:00, 12 NOV 2018</td>
			                                    <td>08:00, 18 NOV 2018</td>
			                                </tr>
			                                <tr>
			                                    <th scope="row"><b>#122348</b></th>
			                                    <td>
			                                        <div class="tm-status-circle pending">
			                                        </div>Pending
			                                    </td>
			                                    <td><b>Jacob Miller</b></td>
			                                    <td><b>London, UK</b></td>
			                                    <td><b>360 km</b></td>
			                                    <td>11:00, 10 NOV 2018</td>
			                                    <td>04:00, 14 NOV 2018</td>
			                                </tr>
			                                <tr>
			                                    <th scope="row"><b>#122347</b></th>
			                                    <td>
			                                        <div class="tm-status-circle cancelled">
			                                        </div>Cancelled
			                                    </td>
			                                    <td><b>George Wilson</b></td>
			                                    <td><b>London, UK</b></td>
			                                    <td><b>340 km</b></td>
			                                    <td>12:00, 22 NOV 2018</td>
			                                    <td>06:00, 28 NOV 2018</td>
			                                </tr>
			                                <tr>
			                                    <th scope="row"><b>#122346</b></th>
			                                    <td>
			                                        <div class="tm-status-circle moving">
			                                        </div>Moving
			                                    </td>
			                                    <td><b>William Aung</b></td>
			                                    <td><b>London, UK</b></td>
			                                    <td><b>218 km</b></td>
			                                    <td>15:00, 10 NOV 2018</td>
			                                    <td>09:00, 14 NOV 2018</td>
			                                </tr>
			                                <tr>
			                                    <th scope="row"><b>#122345</b></th>
			                                    <td>
			                                        <div class="tm-status-circle pending">
			                                        </div>Pending
			                                    </td>
			                                    <td><b>Harry Ryan</b></td>
			                                    <td><b>London, UK</b></td>
			                                    <td><b>280 km</b></td>
			                                    <td>15:00, 11 NOV 2018</td>
			                                    <td>09:00, 17 NOV 2018</td>
			                                </tr>
			                                <tr>
			                                    <th scope="row"><b>#122344</b></th>
			                                    <td>
			                                        <div class="tm-status-circle pending">
			                                        </div>Pending
			                                    </td>
			                                    <td><b>Michael Jones</b></td>
			                                    <td><b>London, UK</b></td>
			                                    <td><b>218 km</b></td>
			                                    <td>18:00, 12 OCT 2018</td>
			                                    <td>06:00, 18 OCT 2018</td>
			                                </tr>
			                                <tr>
			                                    <th scope="row"><b>#122343</b></th>
			                                    <td>
			                                        <div class="tm-status-circle moving">
			                                        </div>Moving
			                                    </td>
			                                    <td><b>Timmy Davis</b></td>
			                                    <td><b>London, UK</b></td>
			                                    <td><b>218 km</b></td>
			                                    <td>12:00, 10 OCT 2018</td>
			                                    <td>08:00, 18 OCT 2018</td>
			                                </tr>
			                                <tr>
			                                    <th scope="row"><b>#122342</b></th>
			                                    <td>
			                                        <div class="tm-status-circle moving">
			                                        </div>Moving
			                                    </td>
			                                    <td><b>Oscar Phyo</b></td>
			                                    <td><b>London, UK</b></td>
			                                    <td><b>420 km</b></td>
			                                    <td>15:30, 06 OCT 2018</td>
			                                    <td>09:30, 16 OCT 2018</td>
			                                </tr>
			                                <tr>
			                                    <th scope="row"><b>#122341</b></th>
			                                    <td>
			                                        <div class="tm-status-circle moving">
			                                        </div>Moving
			                                    </td>
			                                    <td><b>Charlie Brown</b></td>
			                                    <td><b>London, UK</b></td>
			                                    <td><b>300 km</b></td>
			                                    <td>11:00, 10 OCT 2018</td>
			                                    <td>03:00, 14 OCT 2018</td>
			                                </tr>
			                                <tr>
			                                    <th scope="row"><b>#122340</b></th>
			                                    <td>
			                                        <div class="tm-status-circle cancelled">
			                                        </div>Cancelled
			                                    </td>
			                                    <td><b>Wilson Cookies</b></td>
			                                    <td><b>London, UK</b></td>
			                                    <td><b>218 km</b></td>
			                                    <td>17:30, 12 OCT 2018</td>
			                                    <td>08:30, 22 OCT 2018</td>
			                                </tr>
			                                <tr>
			                                    <th scope="row"><b>#122339</b></th>
			                                    <td>
			                                        <div class="tm-status-circle moving">
			                                        </div>Moving
			                                    </td>
			                                    <td><b>Richard Clamon</b></td>
			                                    <td><b>London, UK</b></td>
			                                    <td><b>150 km</b></td>
			                                    <td>15:00, 12 OCT 2018</td>
			                                    <td>09:20, 26 OCT 2018</td>
			                                </tr>
			                            </tbody>
			                        </table>
			                    </div>
							</div> -->
			</div>
		</div>
		<footer class="tm-footer row tm-mt-small" style="position:absolute; min-width:100%; left:0; right:0; bottom:0; margin-top: auto;">
			<div class="col-12 font-weight-light">
				<p class="text-center text-white mb-0 px-4 small">
					Copyright &copy; <b>2019</b> All rights reserved.
				</p>
			</div>
		</footer>
	</div>

	<!-- <script src="js/jquery-3.3.1.min.js"></script> -->
	<!-- https://jquery.com/download/ -->
	<script src="/ware/resources/js/moment.min.js"></script>
	<!-- https://momentjs.com/ -->
	<script src="/ware/resources/js/Chart.min.js"></script>
	<!-- http://www.chartjs.org/docs/latest/ -->
	<script src="/ware/resources/js/bootstrap.min.js"></script>
	<!-- https://getbootstrap.com/ -->
	<!-- <script src="/ware/resources/js/tooplate-scripts.js"></script> -->
	<script>
		const width_threshold = 480;

		function drawLineChart() {
			if ($("#lineChart").length) {
				ctxLine = document.getElementById("lineChart").getContext("2d");
				optionsLine = {
					responsive: true,
					tooltips: {
						mode: 'index',
						intersect: false,
					},
					hover: {
						mode: 'nearest',
						intersect: true
					},
					scales: {
						yAxes: [
							{
								scaleLabel: {
									display: true,
									labelString: "횟수"
								}
							}
						]
					}
				};

				// Set aspect ratio based on window width
				optionsLine.maintainAspectRatio =
					$(window).width() < width_threshold ? false : true;

				configLine = {
					type: "line",
					data: {
						labels: [
							"1월",
							"2월",
							"3월",
							"4월",
							"5월",
							"6월",
							"7월",
							"8월",
							"9월",
							"10월",
							"11월",
							"12월",
						],
						datasets: [
							{
								label: "일일보고서",
								data: ${ dailyStatJson },
							fill: false,
							borderColor: "rgb(75, 192, 192)",
							cubicInterpolationMode: "monotone",
							pointRadius: 3
				},
				{
					label: "영업보고서",
						data: ${ saleStatJson },
					fill: false,
						borderColor: "rgba(255,99,132,1)",
							cubicInterpolationMode: "monotone",
								pointRadius: 3
				},
				{
					label: "지출보고서",
						data: ${ expenseStatJson },
					fill: false,
						borderColor: "rgba(153, 102, 255, 1)",
							cubicInterpolationMode: "monotone",
								pointRadius: 3
				}
				]
			},
			options: optionsLine
		};

		lineChart = new Chart(ctxLine, configLine);
		}
		}

		function drawBarChart() {
			if ($("#barChart").length) {
				ctxBar = document.getElementById("barChart").getContext("2d");

				optionsBar = {
					responsive: true,
					scales: {
						xAxes: [
							{
								scaleLabel: {
									display: true,
									labelString: "개수"
								}
							}
						],
						yAxes: [
							{
								barPercentage: 0.2,
								ticks: {
									beginAtZero: true
								},
								scaleLabel: {
									display: true,
									labelString: "결재상태"
								}
							}
						]
					}
				};

				optionsBar.maintainAspectRatio =
					$(window).width() < width_threshold ? false : true;

				/**
				 * COLOR CODES
				 * Red: #F7604D
				 * Aqua: #4ED6B8
				 * Green: #A8D582
				 * Yellow: #D7D768
				 * Purple: #9D66CC
				 * Orange: #DB9C3F
				 * Blue: #3889FC
				 */
				configBar = {
					type: "horizontalBar",
					data: {
						// labels: ["결재완료", "결재최종완료", "미결재", "반려"],
						datasets: [
							{
								data: ${abc0},
								backgroundColor: [
									"#F7604D"
								],
								label: "결재완료",
								borderWidth: 0
							},
							{
								data: ${abc1},
								backgroundColor: [
									"#4ED6B8"
								],
								label: "최종결재완료",
								borderWidth: 0
							},
							{
								data: ${abc2},
								backgroundColor: [
									"#A8D582"
								],
								label: "미결재",
								borderWidth: 0
							},
							{
								data: ${abc3},
								backgroundColor: [
									"#D7D768"
								],
								label: "반려",
								borderWidth: 0
							}
						]
					},
					options: optionsBar
				};

				barChart = new Chart(ctxBar, configBar);
			}
		}

		function drawPieChart() {
			if ($("#pieChart").length) {
				var chartHeight = 300;

				$("#pieChartContainer").css("height", chartHeight + "px");

				ctxPie = document.getElementById("pieChart").getContext("2d");

				optionsPie = {
					responsive: true,
					maintainAspectRatio: false,
					layout: {
						padding: {
							left: 10,
							right: 10,
							top: 10,
							bottom: 10
						}
					},
					legend: {
						position: "top"
					}
				};

				configPie = {
					type: "pie",
					data: {
						datasets: [
							{
								data: ${ roundStatCountJson },
								backgroundColor: ["#F7604D", "#4ED6B8", "#A8D582", "#ff9f40", "#ffcd56", "#b1ffff", "#36a2eb", "#9966ff", "#c9cbcf", "#d282d5", "#fff567", "#ffb7db", "#5e9eff"],
								label: "Storage"
							}
						],
					labels: ${ roundStatNameJson }
			},
			options: optionsPie
		};

		pieChart = new Chart(ctxPie, configPie);
			}
		}

		function updateLineChart() {
			if (lineChart) {
				lineChart.options = optionsLine;
				lineChart.update();
			}
		}

		function updateBarChart() {
			if (barChart) {
				barChart.options = optionsBar;
				barChart.update();
			}
		}

	</script>
	<script>
		Chart.defaults.global.defaultFontColor = 'white';
		let ctxLine,
			ctxBar,
			ctxPie,
			optionsLine,
			optionsBar,
			optionsPie,
			configLine,
			configBar,
			configPie,
			lineChart;
		barChart, pieChart;
		// DOM is ready
		$(function () {
			drawLineChart(); // Line Chart
			drawBarChart(); // Bar Chart
			drawPieChart(); // Pie Chart

			$(window).resize(function () {
				updateLineChart();
				updateBarChart();
			});
		})
	</script>

	<form name="expenseUpdelForm" method="post" action="/ware/expenseUpdelForm.do">
		<input type="hidden" name="emp_no" value="${emp_no}">
		<input type="hidden" name="report_no">
		<input type="hidden" name="return_no">
		<input type="hidden" name="loginemp_no" value="${sessionScope.emp_no}">
	</form>
	<form name="dailyBusiUpdelForm" method="post" action="/ware/dailyUpdelForm.do">
		<input type="hidden" name="emp_no" value="${emp_no}">
		<input type="hidden" name="report_no">
		<input type="hidden" name="return_no">
		<input type="hidden" name="loginemp_no" value="${sessionScope.emp_no}">
	</form>
	<form name="salesUpdelForm" method="post" action="/ware/salesUpdelForm.do">
		<input type="hidden" name="emp_no" value="${emp_no}">
		<input type="hidden" name="report_no">
		<input type="hidden" name="return_no">
		<input type="hidden" name="loginemp_no" value="${sessionScope.emp_no}">
	</form>

	<form name="goemployeeRegForm" method="post" action="/ware/employeeRegForm.do"></form>
	<form name="goLoginForm" method="post" action="/ware/loginForm.do"></form>
	<form name="goDashboard" method="post" action="/ware/dashboard.do"></form>
	<form name="goBoardListForm" method="post" action="/ware/boardListForm.do"></form>
	<form name="goExpenseListForm" method="post" action="/ware/expenseListForm.do"></form>
	<form name="goSalesListForm" method="post" action="/ware/salesListForm.do"></form>
	<form name="goDailyListForm" method="post" action="/ware/dailyListForm.do"></form>
	<form name="goCalendar" method="post" action="/ware/calendarForm.do"></form>
	<form name="goMypageForm" method="post" action="/ware/myPageForm.do"></form>
	<form name="goEmployeeListForm" method="post" action="/ware/employeeListForm.do"></form>
	<form name="goEmployeeListForm_beforeAllow" method="post" action="/ware/employeeListForm_beforeAllow.do"></form>
</body>

</html>
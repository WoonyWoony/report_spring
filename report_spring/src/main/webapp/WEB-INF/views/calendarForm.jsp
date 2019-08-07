<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 common.jsp 파일 내의 소스를 삽입하기 -->
<%@include file="common.jsp"%>
<%@include file="checkLogin.jsp" %>

<link href='/ware/resources/fullcalendar-3.10.0/fullcalendar.css' rel='stylesheet' />
<link href='/ware/resources/fullcalendar-3.10.0/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='/ware/resources/fullcalendar-3.10.0/lib/moment.min.js'></script>
<script src='/ware/resources/fullcalendar-3.10.0/fullcalendar.min.js'></script>
<script src='/ware/resources/fullcalendar-3.10.0/jquery.bpopup.min.js'></script>
<script src='/ware/resources/fullcalendar-3.10.0/gcal.js'></script>
<script src='/ware/resources/fullcalendar-3.10.0/locale/ko.js'></script>

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
			$(window).scroll(function () {
				var scrollValue = $(document).scrollTop();
				$('[name=scrollValue]').val(scrollValue);
			});

			$('#calendar').fullCalendar({
				themeSystem: 'bootstrap4',
				header: {
					left: 'prev,next today',
					center: 'title',
					right: 'month,agendaWeek,agendaDay,listMonth'
				},
				googleCalendarApiKey: 'AIzaSyDcnW6WejpTOCffshGDDb4neIrXVUA1EAE',
				buttonIcons: false, // show the prev/next text
				navLinks: true, // can click day/week names to navigate views
				editable: true,
				eventLimit: true, // allow "more" link when too many events
				eventSources : [
					{
						googleCalendarId : "ko.south_korea#holiday@group.v.calendar.google.com"
						, className : "koHolidays"
						, color : "#ff6666"
						, textColor : "#FFFFFF"
					}
				],
				events: ${ calendarJson },
				eventClick: function (calEvent, jsEvent, view) {
					if (!confirm("일정 '" + calEvent.title + "'을 삭제하시겠습니까?")) {
						return false;
					}
					$.ajax({
						type: 'POST',
						url: "/ware/deleteCalendar.do",
						data: { calendar_id: calEvent.id },
						success: function (data) {
							if (data == 1) {
								alert("일정 삭제 성공!");
								document.a.submit();
							} else if(data == -10){
								alert("공휴일은 삭제가 불가능합니다.");
								document.a.submit();
							} else {
								alert("DB연동 실패로 일정 삭제 실패! 관리자에게 문의 바람!");
							}
						},
						error: function () {
							alert("서버 접속 실패!");
						}
					});
				},
				eventDrop: function (event, delta, revertFunc) {
					$.ajax({
						type: 'POST',
						url: "/ware/updateCalendar.do",
						data: { calendar_id: event.id, calendar_start_date: event.start.format(), calendar_end_date: event.end.format() },
						success: function (data) {
							if (data == 1) {
								document.a.submit();
							} else if(data == -10){
								alert("공휴일은 수정 불가능합니다.");
								document.a.submit();
							} else {
								alert("DB연동 실패로 일정 변경 실패! 관리자에게 문의 바람!");
							}
						},
						error: function () {
							alert("서버 접속 실패!");
						}
					});
				},
				eventResize: function (event, delta, revertFunc) {
					$.ajax({
						type: 'POST',
						url: "/ware/updateCalendar.do",
						data: { calendar_id: event.id, calendar_start_date: event.start.format(), calendar_end_date: event.end.format() },
						success: function (data) {
							if (data == 1) {
								document.a.submit();
							} else if(data == -10){
								alert("공휴일은 수정 불가능합니다.");
								document.a.submit();
							} else {
								alert("DB연동 실패로 일정 변경 실패! 관리자에게 문의 바람!");
							}
						},
						error: function () {
							alert("서버 접속 실패!");
						}
					});
				}
			});

			$("html, body").animate({ scrollTop: ${ scrollValue } }, "slow");
		});

		function addSchedule() {
			var htmlsContents = "";
			htmlsContents += "<div class='tm-bg-primary-dark tm-block tm-block-h-auto'>";
			htmlsContents += "<form name=calendarForm method=POST style='color: #ffffff; font-weight: bold;'>";
			htmlsContents += "<input type='hidden' name=emp_no value='${emp_no}'>";
			htmlsContents += "<div align=center style='font-size:22px; font-weight: bold;'>일정 등록</div>";
			htmlsContents += "<div align=center><span>일정 명칭 <input type='text' name=calendar_title id='calendar_title'></span></div>";
			htmlsContents += "<div align=center><span>시작 날짜 <input type='text' name=calendar_start_date id='calendar_start_date' readonly></span></div>";
			htmlsContents += "<div align=center><span>마침 날짜 <input type='text' name=calendar_end_date id='calendar_end_date' readonly></span></div>";
			htmlsContents += "<div style='height:10px;'></div>";
			htmlsContents += "<div align=center><button style='max-width: 100px;' class='btn btn-small btn-primary btn-block text-uppercase' onclick=\"javascript:saveSchedule();\">저장하기</button></div>";
			htmlsContents += "</form>";
			htmlsContents += "</div>";
			openPopup("", htmlsContents, 360);
			
			inputData("calendar_title", "거래처목록 정리");
			inputData("calendar_start_date", "2019-08-22");
			inputData("calendar_end_date", "2019-08-23");
		}

		function openPopup(subject, contents, widths) {
			$("#alert_subject").html(subject);
			$("#alert_contents").html(contents);
			openMessage("winAlert", widths);
		}

		function saveSchedule() {
			if ($('[name=calendar_title]').val().length == 0) {
				alert("일정 명칭을 입력해 주세요.");
				$("[name=calendar_title]").focus();
				return;
			}
			if ($('[name=calendar_start_date]').val().length == 0) {
				alert("시작 날짜을 입력해 주세요.");
				$("[name=calendar_start_date]").focus();
				return;
			}
			if ($('[name=calendar_end_date]').val().length == 0) {
				alert("마침 날짜을 입력해 주세요.");
				$("[name=calendar_end_date]").focus();
				return;
			}
			$.ajax({
				url: "/ware/calendarProc.do",
				type: "post",
				data: $('[name=calendarForm]').serialize(),
				success: function (data) {
					if (data == 1) {
						alert("일정 등록 성공!");
						document.a.submit();
						// $('#calendar').fullCalendar("refetchEvents");
					} else {
						alert("DB연동 실패로 일정 등록 실패! 관리자에게 문의 바람!");
					}
				},
				error: function () {
					alert("서버 접속 실패!");
				}
			});
		}

		function openMessage(IDS, widths) {
			$('#' + IDS).css("width", widths + "px");
			$('#' + IDS).bPopup({
				easing: 'easeOutBack', //uses jQuery easing plugin
				speed: 450,
				transition: 'slideDown',
				position: [($(window).width() - 400) / 2, ($(window).height()) / 5] //x, y
			});
			$("#calendar_start_date").datepicker({
				dateFormat: 'yy-mm-dd'
			});
			$("#calendar_end_date").datepicker({
				dateFormat: 'yy-mm-dd'
			});
		}

		function closeMessage(IDS) {
			$('#' + IDS).bPopup().close();
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
							<a class="dropdown-item" href="javascript:document.goExpenseListForm.submit();">지출
								보고서</a>
						</div>
					</li>
					<li class="nav-item active">
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
					<h2 class="tm-block-title">일정관리</h2>
					<div style="float: right">
						<input type="button" style="max-height: 34px;"
							class="btn btn-small btn-primary btn-block text-uppercase" value="일정등록"
							onclick="javascript:addSchedule();">
						<!-- <img src="/ware/resources/image/calendar_reg_black.png" width="60" style="cursor: pointer" onclick="javascript:addSchedule();"> -->
					</div>
					<div id='calendar' style="color: #ffffff"></div>
					<div class="box box-success" style="width: 500px; display: none; background-color: white;"
						id="winAlert">
						<div class="box-header width-border" style="background-color: white; padding-left: 15px">
							<h3 class="box-title" id="alert_subject" style="background-color: white"></h3>
						</div>
						<!-- /box-header -->
						<div class="box-body" id="alert_contents" style="font-size: 15px; background-color: white">
						</div>
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
	<form name="a" method="POST" action="/ware/calendarForm.do">
		<input type='hidden' name='scrollValue' value='0'>
	</form>
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
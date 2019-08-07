<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 common.jsp 파일 내의 소스를 삽입하기 -->
<%@include file="common.jsp"%>
<%@include file="checkLogin.jsp" %>
<html>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>헬로웍스 - 일일보고서</title>
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
			$("#boryu_reason").hide();
			if ("${dailyBusiDTO.sign_name}" == "4") {
				if ("${dailyBusiDTO.emp_no}" == "${sessionScope.emp_no}") {
					$("input").removeAttr("readonly");
					$("select").removeAttr("disabled");
					$("textarea").removeAttr("readonly");
					$("span").removeAttr("hidden");
					$("#noNextSigner").hide();
					$("#sign_state_4").hide();
                    $("#sign_state").prop("checked", true);
					$("#empty_button").removeAttr("hidden");
					$("#date_empty").removeAttr("hidden");
					$("#setToday").removeAttr("hidden");
				} else {
					$("#payment_button").hide();
					$("#today").attr('href', '#');
					$(".radiotr").hide();
					$(".nextselecttr").hide();
					$("#donotpayment").text("반려되어 수정이 불가능합니다.");
				}
			} else if ("${dailyBusiDTO.sign_name}" == "1" && "${pickNextEmp.SIGN_NAME}" == "3") {
				if ("${dailyBusiDTO.emp_no}" == "${sessionScope.emp_no}") {
					$("input").removeAttr("readonly");
					$("select").removeAttr("disabled");
					$("textarea").removeAttr("readonly");
					$("span").removeAttr("hidden");
					$("#noNextSigner").hide();
					$("#sign_state_4").hide();
                    $("#sign_state").prop("checked", true);
					$("#empty_button").removeAttr("hidden");
					$("[name=is_update]").val("true");
					$("#date_empty").removeAttr("hidden");
					$("#setToday").removeAttr("hidden");
				} else{
					$("#payment_button").hide();
					$("#today").attr('href', '#');
					$(".radiotr").hide();
					$(".nextselecttr").hide();
					$("#donotpayment").text("결재되어 수정이 불가능합니다.");
				}
			} else if ("${dailyBusiDTO.sign_name}" == "1" && "${pickNextEmp.SIGN_NAME}" != "3") {
				$("#payment_button").hide();
				$("#today").attr('href', '#');
				$(".radiotr").hide();
				$(".nextselecttr").hide();
				$("#donotpayment").text("결재되어 수정이 불가능합니다.");
			} else if ("${dailyBusiDTO.sign_name}" == "2") {
				$("#payment_button").hide();
				$("#today").attr('href', '#');
				$(".radiotr").hide();
				$(".nextselecttr").hide();
                $("#donotpayment").text("결재 최종 완료된 보고서입니다.");
			}


			$("[name=emp_name]").text("${dailyBusiDTO.emp_name}");
			inputData("busi_year_min", "${dailyBusiDTO.busi_year_min}");
			inputData("busi_month_min", "${dailyBusiDTO.busi_month_min }");
			inputData("busi_day_min", "${dailyBusiDTO.busi_day_min}");
			inputData("busi_hours_min", "${dailyBusiDTO.busi_hours_min }");
			inputData("busi_minutes_min", "${dailyBusiDTO.busi_minutes_min}");
			inputData("busi_year_max", "${dailyBusiDTO.busi_year_max}");
			inputData("busi_month_max", "${dailyBusiDTO.busi_month_max }");
			inputData("busi_day_max", "${dailyBusiDTO.busi_day_max}");
			$("#busi_day_max").val("${dailyBusiDTO.busi_day_max}")
			inputData("busi_hours_max", "${dailyBusiDTO.busi_hours_max }");
			inputData("busi_minutes_max", "${dailyBusiDTO.busi_minutes_max }");
			inputData("busi_type_code", "${dailyBusiDTO.busi_type_code }");
			inputData("busi_content", "${dailyBusiDTO.busi_content }");

			console.log(${ pickNextEmp.EMP_NO });
			makeDate(document.getElementById('busi_year_min'), document.getElementById('busi_month_min'), document.getElementById('busi_day_min'));
			makeDate(document.getElementById('busi_year_max'), document.getElementById('busi_month_max'), document.getElementById('busi_day_max'));

			if (${ !empty pickNextEmp.EMP_NO }){
			$('[name=sign_emp_no]').val("${pickNextEmp.EMP_NO}");
			$('select[name=sign_emp_no]').attr("onFocus", 'this.initialSelect = this.selectedIndex;');
			$('select[name=sign_emp_no]').attr("onChange", 'this.selectedIndex = this.initialSelect;');
			$('#noNextSigner').hide();
			$('[name=sign_emp_no]').change(function () {
				alert("이전에 선택했던 다음 결재자만 선택 가능합니다");
			});
		}

		$('[name=noNextSigner]').change(function () {
			if ($('[name=noNextSigner]').is(":checked")) {
				$('select[name=sign_emp_no]').attr("disabled", true);
				$('select[name=sign_emp_no]').hide();
			} else {
				$('select[name=sign_emp_no]').removeAttr("disabled");
				$('select[name=sign_emp_no]').show();
			}
		});
        });



		function showBoryu_reason() {
			$("#boryu_reason").show();
		}
		function hideBoryu_reason() {
			$("#boryu_reason").hide();
		}


		function makeDate(expense_year, expense_month, expense_date) {
			if (expense_year.value != "") {
				if (expense_month.value != "") {
					var before_value = expense_date.value;
					for (; ;) {
						if (expense_date.length > 1) {
							expense_date.removeChild(expense_date[1]);
						} else break;
					}
					if ((expense_month.value == 4 || expense_month.value == 6 || expense_month.value == 9 || expense_month
						.value == 11)) {
						for (var i = 1; i <= 30; i++) {
							var m = (i < 10) ? "0" + i : i;
							var newOption = document.createElement("option");
							newOption.value = m;
							var newContent = document.createTextNode(m);
							newOption.appendChild(newContent);
							expense_date.appendChild(newOption);
						}
						expense_date.value = before_value;
					} else if (!(expense_month.value == 4 || expense_month.value == 6 || expense_month.value == 9 ||
						expense_month
							.value == 11 || expense_month.value == 2)) {
						for (var i = 1; i <= 31; i++) {
							var m = (i < 10) ? "0" + i : i;
							var newOption = document.createElement("option");
							newOption.value = m
							var newContent = document.createTextNode(m);
							newOption.appendChild(newContent);
							expense_date.appendChild(newOption);
						}
						expense_date.value = before_value;
					}
					if (expense_month.value == 2) {
						var isleap = (expense_year.value % 4 == 0 && (expense_year.value % 100 != 0 || expense_year.value %
							400 ==
							0));
						if (isleap) {
							for (var i = 1; i <= 29; i++) {
								var m = (i < 10) ? "0" + i : i;
								var newOption = document.createElement("option");
								newOption.value = m
								var newContent = document.createTextNode(m);
								newOption.appendChild(newContent);
								expense_date.appendChild(newOption);
							}
							expense_date.value = before_value;
						} else {
							for (var i = 1; i <= 28; i++) {
								var m = (i < 10) ? "0" + i : i;
								var newOption = document.createElement("option");
								newOption.value = m
								var newContent = document.createTextNode(m);
								newOption.appendChild(newContent);
								expense_date.appendChild(newOption);
							}
							expense_date.value = before_value;
						}
					}
				}
			} else {
				alert("연도를 먼저 선택하세요.");
				expense_month.value = "";
				return;
			}
		}

		function setEmpty(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10) {
			setEmpty2("[name=" + val1 + "],[name=" + val2 + "],[name=" + val3 + "],[name=" + val4 + "],[name=" + val5 + "],[name=" + val6 + "],[name=" + val7 + "],[name=" + val8 + "],[name=" + val9 + "],[name=" + val10 + "]");
		}

		function setEmptyAll() {
			setEmpty2("[name=busi_type_code],[name=busi_content],[name=busi_minutes_max],[name=busi_hours_max],[name=busi_day_max],[name=busi_month_max],[name=busi_year_max],[name=busi_minutes_min],[name=busi_hours_min],[name=busi_day_min],[name=busi_month_min],[name=busi_year_min]")
		}


		function getToday(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10) {


			var today = new Date();
			var mm = today.getMonth() + 1;
			var yyyy = today.getFullYear();
			var day = today.getDate();
			var hour = today.getHours();
			var minute = today.getMinutes();

			if (mm < 10) {
				mm = '0' + mm
			}
			if (day < 10) {
				day = '0' + day
			}
			if (hour < 10) {
				hour = '0' + hour
			}
			if (minute < 10) {
				minute = '0' + minute
			}


			$("[name=" + val1 + "]").val(yyyy);
			$("[name=" + val2 + "]").val(mm);
			makeDate(document.getElementById('busi_year_min'), document.getElementById('busi_month_min'), document.getElementById('busi_day_min'));
			$("[name=" + val3 + "]").val(day);
			$("[name=" + val4 + "]").val(hour);
			$("[name=" + val5 + "]").val(minute);
			$("[name=" + val6 + "]").val(yyyy);
			$("[name=" + val7 + "]").val(mm);
			makeDate(document.getElementById('busi_year_max'), document.getElementById('busi_month_max'), document.getElementById('busi_day_max'));
			$("[name=" + val8 + "]").val(day);
			$("[name=" + val9 + "]").val(hour);
			$("[name=" + val10 + "]").val(minute);
		}

		function chcekBusi_date() {
			var busi_year_min = $('[name=busi_year_min]');
			var busi_month_min = $('[name=busi_month_min]');
			var busi_day_min = $('[name=busi_day_min]');
			var busi_hours_min = $('[name=busi_hours_min]');
			var busi_minutes_min = $('[name=busi_minutes_min]');
			var busi_year_max = $('[name=busi_year_max]');
			var busi_month_max = $('[name=busi_month_max]');
			var busi_day_max = $('[name=busi_day_max]');
			var busi_hours_max = $('[name=busi_hours_max]');
			var busi_minutes_max = $('[name=busi_minutes_max]');

			//------------------------------------------------------
			var today = new Date();
			var now_mm = today.getMonth() + 1;
			if(now_mm<10){
				now_mm='0'+now_mm;
			}
			var now_yyyy = today.getFullYear();
			var now_day = today.getDate();
			if(now_day<10){
				now_day='0'+now_day;
			}
			var now_hour = today.getHours();
			if(now_hour<10){
				now_hour='0'+now_hour;
			}
			var now_minute = today.getMinutes();
			if(now_minute<10){
				now_minute='0'+now_minute;
			}
			var now_date = now_yyyy+''+now_mm+now_day+now_hour+now_minute;
			var daily_date1 = busi_year_min.val()+busi_month_min.val()+busi_day_min.val()+busi_hours_min.val()+busi_minutes_min.val();
			var daily_date2 = busi_year_max.val()+busi_month_max.val()+busi_day_max.val()+busi_hours_max.val()+busi_minutes_max.val();

			if (busi_year_min.val() == "" && busi_month_min.val() != "") {
                alert("영업 시작 연도를 먼저 선택해 주세요.");
                busi_month_min.val("");
                busi_day_min.val("");
                busi_hours_min.val("");
                busi_minutes_min.val("");
                return;
            }

            if (busi_month_min.val() == "" && busi_day_min.val() != "") {
                alert("영업 시작 달을 먼저 선택해 주세요.");
                busi_day_min.val("");
                busi_hours_min.val("");
                busi_minutes_min.val("");
                return;
            }

            if (busi_day_min.val() == "" && busi_hours_min.val() != "") {
                alert("영업 시작 날을 먼저 선택해 주세요.");
                busi_hours_min.val("");
                busi_minutes_min.val("");
                return;
            }

            if (busi_hours_min.val() == "" && busi_minutes_min.val() != "") {
                alert("영업 시작 시간을 먼저 선택해 주세요.");
                busi_minutes_min.val("");
                return;
            }
            if (busi_year_max.val() == "" && busi_month_max.val() != "") {
                alert("영업 끝 연도를 먼저 선택해 주세요.");
                busi_month_max.val("");
                busi_day_max.val("");
                busi_hours_max.val("");
                busi_minutes_max.val("");
                return;
            }

            if (busi_month_max.val() == "" && busi_day_max.val() != "") {
                alert("영업 끝 달을 먼저 선택해 주세요.");
                busi_day_max.val("");
                busi_hours_max.val("");
                busi_minutes_max.val("");
                return;
            }

            if (busi_day_max.val() == "" && busi_hours_max.val() != "") {
                alert("영업 끝 날을 먼저 선택해 주세요.");
                busi_hours_max.val("");
                busi_minutes_max.val("");
                return;
            }

            if (busi_hours_max.val() == "" && busi_minutes_max.val() != "") {
                alert("영업 끝 시간을 먼저 선택해 주세요.");
                busi_minutes_max.val("");
                return;
            }



			if (busi_year_min.val() == "" && busi_year_max.val() != "") {
				alert("업무 시작 연도를 먼저 선택해 주세요.");
				busi_year_max.val("");
				return;
			}

			if (busi_month_min.val() == "" && busi_month_max.val() != "") {
				alert("업무 시작 달을 먼저 선택해 주세요.");
				busi_month_max.val("");
				return;
			}

			if (busi_day_min.val() == "" && busi_day_max.val() != "") {
				alert("업무 시작 일을 먼저 선택해 주세요.");
				busi_day_max.val("");
				return;
			}

			if (busi_hours_min.val() == "" && busi_hours_max.val() != "") {
				alert("업무 시작 시간을 먼저 선택해 주세요.");
				busi_hours_max.val("");
				return;
			}

			if (busi_minutes_min.val() == "" && busi_minutes_max.val() != "") {
				alert("업무 시작 분을 먼저 선택해 주세요.");
				busi_minutes_max.val("");
				return;
			}

			if(daily_date1>now_date || daily_date2>now_date){
				alert("업무일이 현재 날짜 이후입니다.\n업무일을 다시 확인해주세요.")
				busi_year_min.val("");
				busi_month_min.val("");
				busi_day_min.val("");
				busi_hours_min.val("");
				busi_minutes_min.val("");
				busi_year_max.val("");
				busi_month_max.val("");
				busi_day_max.val("");
				busi_hours_max.val("");
				busi_minutes_max.val("");
			}


			if (busi_year_min.val() >= busi_year_max.val()) {
				if (busi_year_min.val() > busi_year_max.val() && busi_year_max.val() != "") {
					alert("올바르지 않은 업무 년도 범위입니다.")
					busi_year_max.val("");
					busi_month_max.val("");
					busi_day_max.val("");
					busi_hours_max.val("");
					busi_minutes_max.val("");
					return;
				}
				if (busi_year_min.val() == busi_year_max.val()) {
					if ((busi_month_min.val() > busi_month_max.val()) && busi_month_max.val() != "") {
						alert("올바르지 않은 업무 달 범위입니다.")
						busi_month_max.val("");
						busi_day_max.val("");
						busi_hours_max.val("");
						busi_minutes_max.val("");
						return;
					}
					if (busi_month_min.val() == busi_month_max.val()) {
						if (busi_day_min.val() > busi_day_max.val() && busi_day_max.val() != "") {
							alert("올바르지 않은 업무 일 범위입니다.")
							busi_day_max.val("");
							busi_hours_max.val("");
							busi_minutes_max.val("");
							return;
						}
						if (busi_day_min.val() == busi_day_max.val()) {
							if (busi_hours_min.val() > busi_hours_max.val() && busi_hours_max.val() != "") {
								alert("올바르지 않은 업무 시간 범위입니다.")
								busi_hours_max.val("");
								busi_minutes_max.val("");
								return;
							}
							if (busi_hours_min.val() == busi_hours_max.val()) {
								if (busi_minutes_min.val() > busi_minutes_max.val() && busi_minutes_max.val() != "") {
									alert("올바르지 않은 업무 분 범위입니다.")
									busi_minutes_max.val("");
									return;
								}
							}
						}
					}
				}
			}
		}

		function dailyListForm() {
			//location.replace("/ware/dailyListForm.do");
			document.goDailyListForm.submit();
		}


		var doubleSubmitFlag = false;
		function doubleSubmitCheck() {
			if (doubleSubmitFlag) {
				return doubleSubmitFlag;
			} else {
				doubleSubmitFlag = true;
				return false;
			}
		}

		function checkDailyBusiUpdelForm() {
			if (doubleSubmitCheck()) return;
			if (is_empty("busi_type_code")) {
				alert("업무 분야를 선택해 주세요");
				$("[name=busi_type_code]").focus();
				doubleSubmitFlag = false;
				return;
			}
			if (is_empty("busi_content")) {
				alert("업무 내용을 입력해 주세요");
				$("[name=busi_content]").focus();
				doubleSubmitFlag = false;
				return;
			}
			if (is_empty("busi_year_min")) {
				alert("업무 시간 시작 년도를 입력해 주세요");
				$("[name=busi_year_min]").focus();
				doubleSubmitFlag = false;
				return;
			}
			if (is_empty("busi_month_min")) {
				alert("업무 시간 시작 월을 입력해 주세요");
				$("[name=busi_month_min]").focus();
				doubleSubmitFlag = false;
				return;
			}
			if (is_empty("busi_day_min")) {
				alert("업무 시간 시작 일을 입력해 주세요");
				$("[name=busi_day_min]").focus();
				doubleSubmitFlag = false;
				return;
			}
			if (is_empty("busi_hours_min")) {
				alert("업무 시간 시작 시간을 입력해 주세요");
				$("[name=busi_hours_min]").focus();
				doubleSubmitFlag = false;
				return;
			}
			if (is_empty("busi_minutes_min")) {
				alert("업무 시간 시작 분을 입력해 주세요");
				$("[name=busi_minutes_min]").focus();
				doubleSubmitFlag = false;
				return;
			}
			if (is_empty("busi_year_max")) {
				alert("업무 시간 끝 년도를 입력해 주세요");
				$("[name=busi_year_max]").focus();
				doubleSubmitFlag = false;
				return;
			}
			if (is_empty("busi_month_max")) {
				alert("업무 시간 끝 월을 입력해 주세요");
				$("[name=busi_month_max]").focus();
				doubleSubmitFlag = false;
				return;
			}
			if (is_empty("busi_day_max")) {
				alert("업무 시간 끝 일을 입력해 주세요");
				$("[name=busi_day_max]").focus();
				doubleSubmitFlag = false;
				return;
			}
			if (is_empty("busi_hours_max")) {
				alert("업무 시간 끝 시간을 입력해 주세요");
				$("[name=busi_hours_max]").focus();
				doubleSubmitFlag = false;
				return;
			}
			if (is_empty("busi_minutes_max")) {
				alert("업무 시간 끝 분을 입력해 주세요");
				$("[name=busi_minutes_max]").focus();
				doubleSubmitFlag = false;
				return;
			}
			if (is_empty("sign_emp_no")&&is_empty("noNextSigner")) {
				alert("다음 결재자를 입력해 주세요");
				$("[name=sign_emp_no]").focus();
				doubleSubmitFlag = false;
				return;
			}
			// --------------------------------------
			// 이름 패턴지정
			// --------------------------------------
    		/* if (is_pattern("writer", /^[a-zA-Z]{3,10}$/ ) == false && is_pattern("writer", /^[가-힣]{2,10}$/ ) == false) {
    		    alert("영어 또는 한글만 입력 가능");
    		    $("[name=writer]").val("");
    		    return;
    		} */
			//if(doubleSubmitCheck()) return;
			if (confirm("정말 저장하시겠습니까?") != true) {
				doubleSubmitFlag = false;
				return;
			}


			// ==========================================================
			// 현재 화면에서 페이지 이동 없이 서버쪽 "/erp/boardRegProc.do"를 호출하여
			// [게시판 입력 행 적용 개수]가 있는 html 소스를 문자열로 받기
			// ==========================================================
			$.ajax({
				// 서버쪽 호출 URL 주소
				url: "/ware/dailyUpdelProc.do",
				type: "post",
				data: $("[name=dailyUpdelForm").serialize(),
				success: function (data) {
					if (data == 1) {
						alert("일일업무보고서 결재 성공!");
						//location.replace("/ware/dailyListForm.do");
						document.goDailyListForm.submit();
					}else if (data == -10) {
                        alert("이미 결재된 보고서이므로 수정이 불가능합니다");
                    } else {
						alert("DB연동 실패로 사원 정보 등록 실패! 관리자에게 문의 바람!");
					}
				},
				error: function () {
					alert("서버 접속 실패!");
				}
			});
		}
	</script>
	<style>
		.table1 td,
		.table1 th {
			border-top: 1px solid #486177;
			vertical-align: middle;
		}

		.table1-hover tbody tr {
			transition: all 0.2s ease;
		}

		.table1-hover tbody tr:hover {
			color: #a0c0de;
		}

		.table1 {
			border-collapse: collapse !important
		}

		.table1 td,
		.table1 th {
			background-color: #486177 !important
		}

		.table1-bordered td,
		.table1-bordered th {
			border: 1px solid #dee2e6 !important
		}

		.table1-dark {
			color: inherit
		}

		.table1-dark tbody+tbody,
		.table1-dark td,
		.table1-dark th,
		.table1-dark thead th {
			border-color: #dee2e6
		}

		.table1 .thead-dark th {
			color: inherit;
			border-color: #dee2e6
		}
	</style>
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

	<div class="mt-5 ml-6 mr-6">
		<div class="row tm-content-row">
			<div class="mx-auto col-12 tm-block-col">
				<div class="tm-bg-primary-dark tm-block tm-block-h-auto tm-block-scroll" style="margin-bottom:80px">
					<h2 class="tm-block-title">일일업무보고서</h2>
					<!--===============================================================================================-->
					<!-- dailyBusinessSignForm -->
					<!--===============================================================================================-->
					<form name="dailyUpdelForm" method="post" action="">
						<table class="table">
							<tr>
								<th bgcolor="#486177" width=100>작성자</th>
								<td>
									<span name="emp_name"></span>
								</td>
							</tr>
							<tr>
								<th bgcolor="#486177">업무 분야</th>
								<td>
									<select name="busi_type_code" disabled="true"
										class="custom-select tm-select-accounts"
										style="width:80px;height:30px; padding: 5px;font-size:13;">
										<option value="">--선택--</option>
										<option value="1">행정</option>
										<option value="2">사무</option>
										<option value="3">구매</option>
										<option value="4">접대</option>
										<option value="5">회계</option>
										<option value="6">기타</option>
									</select>
								</td>
							</tr>
							<tr>
								<th bgcolor="#486177">업무 내용</th>
								<td>
									<textarea name="busi_content" rows="10" cols="91" style="background-color: #54657d;
									color: #ffffff; border: 0; padding: 15px 10px; border-radius: 0;" readonly></textarea>
								</td>
							</tr>
							<tr>
								<th bgcolor="#486177">시간</th>
								<td>
									<li style="list-style-type: none;float: left;">
										<div>
											<select name="busi_year_min" id="busi_year_min"
												class="custom-select tm-select-accounts"
												style="width:70px;height:30px; padding: 5px;font-size:13;"
												onchange="makeDate(document.getElementById('busi_year_min'),document.getElementById('busi_month_min'),document.getElementById('busi_day_min'));chcekBusi_date();"
												disabled="true">
												<option value=""></option>
												<script>
													for (var i = new Date().getFullYear(); i > 1980; i--) {
														document.write("<option value=" + i + ">" + i);
													}
												</script>
											</select>년
											<select name="busi_month_min" id="busi_month_min"
												class="custom-select tm-select-accounts"
												style="width:50px;height:30px; padding: 5px;font-size:13;"
												onchange="makeDate(document.getElementById('busi_year_min'),document.getElementById('busi_month_min'),document.getElementById('busi_day_min'));chcekBusi_date();"
												disabled="true">
												<option value=""></option>
												<script>
													for (var i = 1; i <= 12; i++) {
														var m = (i < 10) ? "0" + i : i;
														document.write("<option value=" + m + ">" + m);
													}
												</script>
											</select>월
											<select name="busi_day_min" id="busi_day_min"
												class="custom-select tm-select-accounts"
												style="width:50px;height:30px; padding: 5px;font-size:13;" disabled="true"
												onchange="chcekBusi_date();">
												<option value="" id="graduate_date_op"></option>
												<script>
													for (var i = 1; i <= 31; i++) {
														var m = (i < 10) ? "0" + i : i;
														document.write("<option value=" + m + ">" + m);
													}
												</script>
											</select>일
											<select name="busi_hours_min" id="busi_hours_min"
												class="custom-select tm-select-accounts"
												style="width:50px;height:30px; padding: 5px;font-size:13;" disabled="true"
												onchange="chcekBusi_date();">
												<option value=""></option>
												<script>
													for (var i = 1; i <= 24; i++) {
														if (i < 10) {
															i = '0' + i;
														}
														document.write("<option value=" + i + ">" + i);
													}
												</script>
											</select>시
											<select name="busi_minutes_min" id="busi_minutes_min"
												class="custom-select tm-select-accounts"
												style="width:50px;height:30px; padding: 5px;font-size:13;" disabled="true"
												onchange="chcekBusi_date();">
												<option value=""></option>
												<script>
													for (var i = 0; i <= 59; i++) {
														if (i < 10) {
															i = '0' + i;
														}
														document.write("<option value=" + i + ">" + i);
													}
												</script>
											</select>분 &nbsp;부터
											<div style="height:5px"></div>

											<select name="busi_year_max" id="busi_year_max"
												class="custom-select tm-select-accounts"
												style="width:70px;height:30px; padding: 5px;font-size:13;"
												onchange="makeDate(document.getElementById('busi_year_max'),document.getElementById('busi_month_max'),document.getElementById('busi_day_max')); chcekBusi_date();chcekBusi_date();"
												disabled="true">
												<option value=""></option>
												<script>
													for (var i = new Date().getFullYear(); i > 1980; i--) {
														document.write("<option value=" + i + ">" + i);
													}
												</script>
											</select>년
											<select name="busi_month_max" id="busi_month_max"
												class="custom-select tm-select-accounts"
												style="width:50px;height:30px; padding: 5px;font-size:13;"
												onchange="makeDate(document.getElementById('busi_year_max'),document.getElementById('busi_month_max'),document.getElementById('busi_day_max')); chcekBusi_date();"
												disabled="true">
												<option value=""></option>
												<script>
													for (var i = 1; i <= 12; i++) {
														var m = (i < 10) ? "0" + i : i;
														document.write("<option value=" + m + ">" + m);
													}
												</script>
											</select>월
											<select name="busi_day_max" id="busi_day_max"
												class="custom-select tm-select-accounts"
												style="width:50px;height:30px; padding: 5px;font-size:13;" disabled="true"
												onchange="chcekBusi_date();">
												<option value="" id="graduate_date_op"></option>
												<script>
													for (var i = 1; i <= 31; i++) {
														var m = (i < 10) ? "0" + i : i;
														document.write("<option value=" + m + ">" + m);
													}
												</script>
											</select>일
											<select name="busi_hours_max" id="busi_hours_max"
												class="custom-select tm-select-accounts"
												style="width:50px;height:30px; padding: 5px;font-size:13;" disabled="true"
												onchange="chcekBusi_date();">
												<option value=""></option>
												<script>
													for (var i = 1; i <= 24; i++) {
														if (i < 10) {
															i = '0' + i;
														}
														document.write("<option value=" + i + ">" + i);
													}
												</script>
											</select>시
											<select name="busi_minutes_max" id="busi_minutes_max"
												class="custom-select tm-select-accounts"
												style="width:50px;height:30px; padding: 5px;font-size:13;" disabled="true"
												onchange="chcekBusi_date();">
												<option value=""></option>
												<script>
													for (var i = 0; i <= 59; i++) {
														if (i < 10) {
															i = '0' + i;
														}
														document.write("<option value=" + i + ">" + i);
													}
												</script>
											</select>분 &nbsp;까지
										</div>
									</li>
									
									<li style="list-style-type: none;float: left;margin-top: 3%">
										<div style="height:5px; min-width:70%">
												<span style="cursor: pointer" hidden id="setToday"
												onclick="getToday('busi_year_min','busi_month_min','busi_day_min','busi_hours_min','busi_minutes_min','busi_year_max','busi_month_max','busi_day_max','busi_hours_max','busi_minutes_max');">&emsp;[오늘로]</span>
											<span style="cursor: pointer" hidden id="date_empty"
												onclick="setEmpty('busi_year_min','busi_month_min','busi_day_min','busi_hours_min','busi_minutes_min','busi_year_max','busi_month_max','busi_day_max','busi_hours_max','busi_minutes_max');">&nbsp;[비움]</span>
										</div>
									</li>
									<span id="busi_date2" name="busi_date2"></span>
								</td>
							</tr>
							<tr class="radiotr">
								<th bgcolor="#486177">결재/반려</th>
								<td>
									<input type="radio" id="sign_state" name="sign_state" value="1" onclick="hideBoryu_reason();">결재
									<span id="sign_state_4"><input type="radio" name="sign_state" value="4"
											onclick="showBoryu_reason();">반려
										<span id="boryu_reason">(반려사유: <input type="text" name="return_reason"
												placeholder=" 내용을 입력해주세요"> )</span>
									</span>
								</td>
							</tr>
							<tr class="nextselecttr">
								<th bgcolor="#486177">다음 결재자</th>
								<td>
									<select name="sign_emp_no" class="custom-select tm-select-accounts"
										style="width:180px;height:30px; padding: 5px;font-size:13;">
										<option value="">--선택--</option>
										<c:forEach items="${superiorList}" var="sup" varStatus="loopTagStatus">
											<option value="${sup.EMP_NO}">${sup.DEP_NAME} ${sup.JIKUP_NAME}
												${sup.EMP_NAME}</option>
										</c:forEach>
									</select>
									<span id="noNextSigner"><input type="checkbox" name="noNextSigner">다음 결재자 없음</span>
								</td>
							</tr>
							<input type="hidden" name="report_no" value="${dailyBusiDTO.report_no}">
							<input type="hidden" name="emp_no" value="${dailyBusiDTO.emp_no}">
							<input type="hidden" name="return_no" value="${dailyBusiDTO.return_no}">
							<input type="hidden" name="sign_name" value="${dailyBusiDTO.sign_name}">
							<input type="hidden" name="is_update">
					</form>


					<tr>
						<th bgcolor="#486177">결재 내역</th>
						<td>
							<c:set var="index" value="0" />
							<c:set var="end_num" value="${max_return_no - 1}" />
							<c:if test="${end_num < 0}">
								<c:set var="end_num" value="0" />
							</c:if>
							<c:set var="boboout" value="false" />
							<c:forEach begin="0" end="${max_return_no}">
								<c:if test="${not boboout}">
									<table class="table1 text-white" style="width:90%" align="center">
										<tr bgcolor="#486177">
											<th style="text-align: center;font-size:14;width:13%">결재순서</th>
											<th style="text-align: center;font-size:14;width:13%">결재자명</th>
											<th style="text-align: center;font-size:14;width:11%">부서명</th>
											<th style="text-align: center;font-size:14;width:10%">직책</th>
											<th style="text-align: center;font-size:14;width:15%">결재여부</th>
											<th style="text-align: center;font-size:14;width:19%">결재일</th>
											<th style="text-align: center;font-size:14;width:19%">반려사유</th>
										</tr>
										<c:set var="doneLoop" value="false" />
										<c:forEach items="${signList}" var="sign" varStatus="i">
											<c:if test="${not doneLoop}">
												<tr style="text-align: center;font-size:12;">
													<td>${i.count}</td>
													<td>${signList[index].EMP_NAME}</td>
													<td>${signList[index].DEP_NAME}</td>
													<td>${signList[index].JIKUP_NAME}</td>
													<td>${signList[index].SIGN_NAME}</td>
													<td>${signList[index].SIGN_DATE}</td>
													<td>${signList[index].RETURN_RESULT}</td>
												</tr>
												<c:if test="${!empty signList[index-1].RETURN_NO}">
													<c:if
														test="${ signList[index+1].RETURN_NO > signList[index].RETURN_NO}">
														<c:set var="doneLoop" value="true" />
													</c:if>
												</c:if>
												<c:if test="${signList[index].SIGN_NAME eq '미결재'}">
													<c:if
														test="${ signList[index].SIGN_NAME ne signList[index+1].SIGN_NAME }">
														<c:set var="doneLoop" value="true" />
													</c:if>
												</c:if>
												<c:set var="index" value="${index+1}" />
											</c:if>
										</c:forEach>
									</table>
									<br>
									<c:if test="${signList[index].SIGN_NAME eq '반려'}">
										<c:if test="${ signList[index].SIGN_NAME eq signList[index+1].SIGN_NAME }">
											<c:set var="boboout" value="true" />
										</c:if>
									</c:if>
									<c:if test="${signList[index].SIGN_NAME eq '결재최종완료'}">
										<c:if test="${ signList[index].SIGN_NAME eq signList[index+1].SIGN_NAME }">
											<c:set var="boboout" value="true" />
										</c:if>
									</c:if>
								</c:if>
							</c:forEach>
						</td>
					</tr>
					</table>
					<br>
					<center>
						<h3 id="donotpayment" class="tm-site-title"></h3>
						<table>
							<td>
							<td>
								<span tyle="cursor: pointer;">
									<input type="button" style="max-width: 90px;" id="payment_button"
										class="btn btn-small btn-primary btn-block text-uppercase" value="결재/반려"
										onclick="checkDailyBusiUpdelForm();">
								</span>
							</td>
							<td width=5></td>
							<td>
								<span tyle="cursor: pointer;">
									<input type="button" style="max-width: 80px;"
										class="btn btn-small btn-primary btn-block text-uppercase" value="화면닫기"
										onclick="document.goDailyListForm.submit();">
								</span>
							</td>
							<td width=5></td>
							<td>
								<span tyle="cursor: pointer;">
									<input type="button" style="max-width: 80px;" id="empty_button" hidden
										class="btn btn-small btn-primary btn-block text-uppercase" value="초기화"
										onclick="setEmptyAll();">
								</span>
							</td>
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
	<form name="goDashboard" method="post" action="/ware/dashboard.do"></form>
	<form name="goLoginForm" method="post" action="/ware/loginForm.do"> </form>
	<form name="goBoardListForm" method="post" action="/ware/boardListForm.do"></form>
	<form name="goExpenseListForm" method="post" action="/ware/expenseListForm.do"></form>
	<form name="goSalesListForm" method="post" action="/ware/salesListForm.do"></form>
	<form name="goDailyListForm" method="post" action="/ware/dailyListForm.do"></form>
	<form name="goCalendar" method="post" action="/ware/calendarForm.do"></form>
	<form name="goMypageForm" method="post" action="/ware/myPageForm.do"></form>
	<form name="goEmployeeListForm" method="post" action="/ware/employeeListForm.do"></form>
	</center>
	<footer class="tm-footer row tm-mt-small" style="position:absolute; min-width:100%; left:0; right:0; bottom:0; margin-top: auto;">
			<div class="col-12 font-weight-light">
				<p class="text-center text-white mb-0 px-4 small">
					Copyright &copy; <b>2019</b> All rights reserved.
				</p>
			</div>
		</footer>
</body>

</html>
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

        });

        function setEmptyAll() {
            //<방법1>-------------------------------------------------
            // 태그명 form인 요소의 후손중에 checked속성값이true인 요소들을 관리하는 제이쿼리객체메위주로 attr 메소드 호출
            // $("form").find(":checkbox").attr( "checked", false );
            // 태그명 form  후손중에 checkbox radio 아닌 입력양식의(select태그, textarea태그, 입력양식 중 type=text인 태그, 입력양식 중 type =password인 태그) val 지우기
            //$("form").find("select, textarea, :text, :password").val("");// 여기에는 체크박스 를 포함시키면 안된다. (주의)

            //<방법2>-------------------------------------------------
            document.dailyBusiRegForm.reset();
        }

        function makeDate(expense_year, expense_month, expense_day) {
            if (expense_year.value != "") {
                if (expense_month.value != "") {
                    var before_value = expense_day.value;
                    for (; ;) {
                        if (expense_day.length > 1) {
                            expense_day.removeChild(expense_day[1]);
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
                            expense_day.appendChild(newOption);
                        }
                        expense_day.value = before_value;
                    } else if (!(expense_month.value == 4 || expense_month.value == 6 || expense_month.value == 9 ||
                        expense_month
                            .value == 11 || expense_month.value == 2)) {
                        for (var i = 1; i <= 31; i++) {
                            var m = (i < 10) ? "0" + i : i;
                            var newOption = document.createElement("option");
                            newOption.value = m
                            var newContent = document.createTextNode(m);
                            newOption.appendChild(newContent);
                            expense_day.appendChild(newOption);
                        }
                        expense_day.value = before_value;
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
                                expense_day.appendChild(newOption);
                            }
                            expense_day.value = before_value;
                        } else {
                            for (var i = 1; i <= 28; i++) {
                                var m = (i < 10) ? "0" + i : i;
                                var newOption = document.createElement("option");
                                newOption.value = m
                                var newContent = document.createTextNode(m);
                                newOption.appendChild(newContent);
                                expense_day.appendChild(newOption);
                            }
                            expense_day.value = before_value;
                        }
                    }
                }
            } else {
                alert("연도를 먼저 선택하세요.");
                expense_month.value = "";
                return;
            }
        }

        function dailyListForm() {
            // location.replace("/ware/dailyListForm.do");
            document.goDailyListForm.submit();
        }


        function setEmpty(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10) {
            setEmpty2("[name=" + val1 + "],[name=" + val2 + "],[name=" + val3 + "],[name=" + val4 + "],[name=" + val5 + "],[name=" + val6 + "],[name=" + val7 + "],[name=" + val8 + "],[name=" + val9 + "],[name=" + val10 + "]");
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


        var doubleSubmitFlag = false;
        function doubleSubmitCheck() {
            if (doubleSubmitFlag) {
                return doubleSubmitFlag;
            } else {
                doubleSubmitFlag = true;
                return false;
            }
        }

        function checkDailBusiRegForm() {
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
            if (is_empty("sign_emp_no")) {
                alert("다음 결재자를 입력해 주세요");
                $("[name=sign_emp_no]").focus();
                doubleSubmitFlag = false;
                return;
            }
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
                url: "/ware/dailyBusiRegProc.do",
                type: "post",
                data: $("[name=dailyBusiRegForm").serialize(),
                success: function (data) {
                    if (data == 1) {
                        alert("일일보고서 등록 성공!");
                        //location.replace("/ware/dailyListForm.do");
                        document.goDailyListForm.submit();
                    } else {
                        alert("DB연동 실패로 사원 정보 등록 실패! 관리자에게 문의 바람!");
                    }
                },
                error: function () {
                    alert("서버 접속 실패!");
                }
            });
        }

        function setting(){
                 
			inputData("busi_type_code", "2");
			inputData("busi_content", "고객정보관리");
            inputData("sign_emp_no", "1001");
            getToday('busi_year_min','busi_month_min','busi_day_min','busi_hours_min','busi_minutes_min','busi_year_max','busi_month_max','busi_day_max','busi_hours_max','busi_minutes_max');
            
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
            <div class="mx-auto col-12 tm-block-col">
                <div class="tm-bg-primary-dark tm-block tm-block-h-auto tm-block-scroll" style="margin-bottom:80px">
                    <h2 class="tm-block-title">일일업무보고서 등록</h2>

                    <!--===============================================================================================-->
                    <!-- dailyBusinessRegForm -->
                    <!--===============================================================================================-->

                    <form name="dailyBusiRegForm" method="post" action="">
                        <table class="table">
                            <tr>
                                <th bgcolor="#486177">작성자</th>
                                <td>
                                    <span id="emp_name">${emp_name}</span>
                                </td>
                            </tr>
                            <tr>
                                <th bgcolor="#486177">업무 분야</th>
                                <td>
                                    <select name="busi_type_code" class="custom-select tm-select-accounts"
                                        style="width:75px;height:25px; padding: 5px;font-size:13;">
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
                                    <textarea name="busi_content" rows="15" cols="75"
                                        style="background-color: #54657d;
                                    color: #ffffff; border: 0; padding: 15px 10px; border-radius: 0;font-size:12;"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <th bgcolor="#486177">시간</th>
                                <td>
                                    <li style="list-style-type: none;float: left;">
                                        <div>
                                            <select name="busi_year_min" id="busi_year_min"
                                                class="custom-select tm-select-accounts"
                                                style="width:75px;height:25px; padding: 5px;font-size:13;"
                                                onchange="makeDate(document.getElementById('busi_year_min'),document.getElementById('busi_month_min'),document.getElementById('busi_day_min'));chcekBusi_date();">
                                                <option value=""></option>
                                                <script>
                                                    for (var i = new Date().getFullYear(); i > 1980; i--) {
                                                        document.write("<option value=" + i + ">" + i);
                                                    }
                                                </script>
                                            </select>년
                                            <select name="busi_month_min" id="busi_month_min"
                                                class="custom-select tm-select-accounts"
                                                style="width:55px;height:25px; padding: 5px;font-size:13;"
                                                onchange="makeDate(document.getElementById('busi_year_min'),document.getElementById('busi_month_min'),document.getElementById('busi_day_min'));chcekBusi_date();">
                                                <option value=""></option>
                                                <script>
                                                    for (var i = 1; i <= 12; i++) {
                                                        var m = (i < 10) ? "0" + i : i;
                                                        document.write("<option value=" + m + ">" + m);
                                                    }
                                                </script>
                                            </select>월
                                            <select name="busi_day_min" id="busi_day_min" onchange="chcekBusi_date();"
                                                class="custom-select tm-select-accounts"
                                                style="width:55px;height:25px; padding: 5px;font-size:13;">
                                                <option value="" id="graduate_date_op"></option>
                                                <script>
                                                    for (var i = 1; i <= 31; i++) {
                                                        var m = (i < 10) ? "0" + i : i;
                                                        document.write("<option value=" + m + ">" + m);
                                                    }
                                                </script>
                                            </select>일
                                            <select name="busi_hours_min" id="busi_hours_min" onchange="chcekBusi_date();"
                                                class="custom-select tm-select-accounts"
                                                style="width:55px;height:25px; padding: 5px;font-size:13;">
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
                                            <select name="busi_minutes_min" id="busi_minutes_min" onchange="chcekBusi_date();"
                                                class="custom-select tm-select-accounts"
                                                style="width:55px;height:25px; padding: 5px;font-size:13;">
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
                                            <div style="height:5px;"></div>
                                            <select name="busi_year_max" id="busi_year_max"
                                                class="custom-select tm-select-accounts"
                                                style="width:75px;height:25px; padding: 5px;font-size:13;"
                                                onchange="makeDate(document.getElementById('busi_year_max'),document.getElementById('busi_month_max'),document.getElementById('busi_day_max'));chcekBusi_date();">
                                                <option value=""></option>
                                                <script>
                                                    for (var i = new Date().getFullYear(); i > 1980; i--) {
                                                        document.write("<option value=" + i + ">" + i);
                                                    }
                                                </script>
                                            </select>년
                                            <select name="busi_month_max" id="busi_month_max"
                                                class="custom-select tm-select-accounts"
                                                style="width:55px;height:25px; padding: 5px;font-size:13;"
                                                onchange="makeDate(document.getElementById('busi_year_max'),document.getElementById('busi_month_max'),document.getElementById('busi_day_max'));chcekBusi_date();">
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
                                                style="width:55px;height:25px; padding: 5px;font-size:13;"
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
                                                style="width:55px;height:25px; padding: 5px;font-size:13;"
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
                                                style="width:55px;height:25px; padding: 5px;font-size:13;"
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
                                    
                                    <li style="list-style-type: none;float: left;margin-top: 2%">
                                        <div style="height:5px; min-width:70%">
                                                <span style="cursor: pointer"
                                                onclick="getToday('busi_year_min','busi_month_min','busi_day_min','busi_hours_min','busi_minutes_min','busi_year_max','busi_month_max','busi_day_max','busi_hours_max','busi_minutes_max');">&emsp;[오늘로]</span>
                                            <span style="cursor: pointer"
                                                onclick="setEmpty('busi_year_min','busi_month_min','busi_day_min','busi_hours_min','busi_minutes_min','busi_year_max','busi_month_max','busi_day_max','busi_hours_max','busi_minutes_max');">&nbsp;[비움]</span>
                                        </div>
                                    </li>
                                </td>
                            </tr>
                            <!-- <tr>
	                <th bgcolor="#dcdcdc">완료 여부</th>
	                <td>
	                    <input type="checkbox" name="완료" value="1">완료
	                </td>
	            </tr> -->
                            <!-- <tr>
	                <th bgcolor="#dcdcdc">지시 사항</th>
	                <td>
	                </td>
	            </tr> -->
                            <!-- <tr>
                    <th bgcolor="#dcdcdc">결재/반려</th>
                    <td>
                        <input type="radio" name="sign_state" value="1">결재
                        <input type="radio" name="sign_state" value="4">반려
                        (반려사유: <input type="text" name="return_reason" placeholder=" 내용을 입력해주세요"> )
                    </td>
                </tr> -->
                            <input type="hidden" name="sign_state" value="1">

                            <tr>
                                <th bgcolor="#486177">다음 결재자</th>
                                <td>
                                    <select name="sign_emp_no" class="custom-select tm-select-accounts"
                                        style="width:180px;height:25px; padding: 5px;font-size:13;">
                                        <option value="">--선택--</option>
                                        <c:forEach items="${superiorList}" var="sup" varStatus="loopTagStatus">
                                            <option value="${sup.EMP_NO}">${sup.DEP_NAME} ${sup.JIKUP_NAME}
                                                ${sup.EMP_NAME}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                        </table>
                        <!-- hidden 태그들 -->
                        <input type=hidden name="report_no">
                        <input type=hidden name="report_code" value=1>
                        <input type=hidden name="emp_no" value="${emp_no}">
                        <input type=hidden name="sign_cnt"><!-- 필요없음 -->
                        <input type=hidden name="sign_finish_no" value="${report_no}">
                        <input type=hidden name="sign_date"><!-- mapper 에서 sysdate로 대체 -->
                        <input type=hidden name="sign_code"><!-- sign_state 선택 value를 넣기 -->
                        <input type=hidden name="return_no" value="${return_no}">
                    </form>

                    <center>
                        <table>
                            <tr>
                                <td>
                                    <span tyle="cursor: pointer;" onclick="checkDailBusiRegForm();">
                                        <button style="max-width: 80px;"
                                            class="btn btn-small btn-primary btn-block text-uppercase">
                                            등록
                                        </button>
                                    </span>
                                <td width=5></td>
                                <td>
                                    <span tyle="cursor: pointer;" onclick="dailyListForm();">
                                        <button style="max-width: 80px;"
                                            class="btn btn-small btn-primary btn-block text-uppercase">
                                            화면닫기
                                        </button>
                                    </span>
                                <td width=5></td>
                                <td>
                                    <span tyle="cursor: pointer;" onclick="setEmptyAll();">
                                        <button style="max-width: 80px;"
                                            class="btn btn-small btn-primary btn-block text-uppercase">
                                            초기화
                                        </button>
                                    </span>
                                <td width=5></td>
                                <td>
                                    <span tyle="cursor: pointer;" onclick="setting();">
                                        <button style="max-width: 80px;"
                                            class="btn btn-small btn-primary btn-block text-uppercase">
                                            입력
                                        </button>
                                    </span>
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
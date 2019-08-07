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
	<title>헬로웍스 - 영업보고서</title>
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
            $(".onlynumber").bind("keyup", function () {
                var confirm = $(this).val();
                var num = "";
                var number = "0123456789";
                for (var i = 0; i < confirm.length; i++) {
                    var s = confirm.charAt(i);
                    if (number.indexOf(s) >= 0) {
                        num = num + s;
                    }
                }
                $(this).val(num);
            });
        });


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
            document.salesRegForm.reset();
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

        function salesListForm() {
            //location.replace("/ware/salesListForm.do");
            document.goSalesListForm.submit();
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
        function checkSalesRegForm() {
            if (doubleSubmitCheck()) return;
            if (is_empty("report_name")) {
                alert("영업보고서 제목을 입력해 주세요");
                $("[name=report_name]").focus();
                doubleSubmitFlag = false;
                return;
            }

            if (is_empty("sales_type_code")) {
                alert("방문 목적을 선택해 주세요");
                $("[name=sales_type_code]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_company")) {
                alert("만난사람 회사를 입력해 주세요");
                $("[name=sales_company]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_name")) {
                alert("만난사람 이름을 선택해 주세요");
                $("[name=sales_name]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_jikup")) {
                alert("만난사람 직급을 선택해 주세요");
                $("[name=sales_jikup]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_phone")) {
                alert("만난사람 전화번호를 선택해 주세요");
                $("[name=sales_phone]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_year_start")) {
                alert("방문 시간 시작 년도를 입력해 주세요");
                $("[name=sales_year_start]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_month_start")) {
                alert("방문 시간 시작 월을 입력해 주세요");
                $("[name=sales_month_start]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_day_start")) {
                alert("방문 시간 시작 일을 입력해 주세요");
                $("[name=sales_day_start]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_hour_start")) {
                alert("방문 시간 시작 시간을 입력해 주세요");
                $("[name=sales_hour_start]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_minute_start")) {
                alert("방문 시간 시작 분을 입력해 주세요");
                $("[name=sales_minute_start]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_year_end")) {
                alert("방문 시간 끝 년도를 입력해 주세요");
                $("[name=sales_year_end]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_month_end")) {
                alert("방문 시간 끝 월을 입력해 주세요");
                $("[name=sales_month_end]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_day_end")) {
                alert("방문 시간 끝 일을 입력해 주세요");
                $("[name=sales_day_end]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_hour_end")) {
                alert("방문 시간 끝 시간을 입력해 주세요");
                $("[name=sales_hour_end]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_minute_end")) {
                alert("방문 시간 끝 분을 입력해 주세요");
                $("[name=sales_minute_end]").focus();
                doubleSubmitFlag = false;
                return;
            }

            if (is_empty("sales_content")) {
                alert("영업내용을 입력해 주세요");
                $("[name=sales_content]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("sales_result")) {
                alert("영업성과를 입해 주세요");
                $("[name=sales_result]").focus();
                doubleSubmitFlag = false;
                return;
            }

            if (is_empty("sign_emp_no")) {
                alert("다음 결재자를 선택해 주세요");
                $("[name=sign_emp_no]").focus();
                doubleSubmitFlag = false;
                return;
            }
			
			if( is_pattern("report_name",/^[a-zA-Z가-힣0-9\s]{3,}$/)==false){
				alert("제목은 3자리 이상의 영어, 숫자, 한글만 입력 가능합니다");
				$("[name=report_name]").val("");
                doubleSubmitFlag = false;
				return;
			}
			
			if( is_pattern("sales_name",/^[a-zA-Z]{3,10}$/)==false
				&&	
				!is_pattern("sales_name",/^[가-힣]{2,10}$/) ){
				alert("이름은 2~10자리의 영어 또는 한글만 입력 가능합니다");
				$("[name=sales_name]").val("");
                doubleSubmitFlag = false;
				return;
			}
			
			if( is_pattern("sales_jikup",/^[a-zA-Z]{2,10}$/)==false
				&&	
				!is_pattern("sales_jikup",/^[가-힣]{2,10}$/) ){
				alert("직급은 2~10자리의 영어 또는 한글만 입력 가능합니다");
				$("[name=sales_jikup]").val("");
                doubleSubmitFlag = false;
				return;
			}
			
			if( is_pattern("sales_phone",/^[0-9]{6,15}$/)==false){
				alert("전화번호는 6~15자리의 숫자만 입력 가능합니다");
				$("[name=sales_phone]").val("");
                doubleSubmitFlag = false;
				return;
			}

            //if (doubleSubmitCheck()) return;


            if (confirm("정말 저장하시겠습니까?") != true) {
                doubleSubmitFlag = false;
                return;
            }
            console.log($("[name=salesRegForm").serialize());

            // ==========================================================
            // 현재 화면에서 페이지 이동 없이 서버쪽 "/erp/boardRegProc.do"를 호출하여
            // [게시판 입력 행 적용 개수]가 있는 html 소스를 문자열로 받기
            // ==========================================================
            $.ajax({
                // 서버쪽 호출 URL 주소
                url: "/ware/salesRegProc.do",
                type: "post",
                data: $("[name=salesRegForm").serialize(),
                success: function (data) {
                    if (data == 1) {
                        alert("영업보고서 등록 성공!");
                        //location.replace("/ware/salesListForm.do");
                        document.goSalesListForm.submit();
                    } else {
                        alert("DB연동 실패로 영업보고서 등록 실패! 관리자에게 문의 바람!");
                    }
                },
                error: function () {
                    alert("서버 접속 실패!");
                }
            });
        }

        function chcekBusi_date() {
            var sales_year_start = $('[name=sales_year_start]');
            var sales_month_start = $('[name=sales_month_start]');
            var sales_day_start = $('[name=sales_day_start]');
            var sales_hour_start = $('[name=sales_hour_start]');
            var sales_minute_start = $('[name=sales_minute_start]');
            var sales_year_end = $('[name=sales_year_end]');
            var sales_month_end = $('[name=sales_month_end]');
            var sales_day_end = $('[name=sales_day_end]');
            var sales_hour_end = $('[name=sales_hour_end]');
            var sales_minute_end = $('[name=sales_minute_end]');

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
            var sales_date1 = sales_year_start.val()+sales_month_start.val()+sales_day_start.val()+sales_hour_start.val()+sales_minute_start.val();
            var sales_date2 = sales_year_end.val()+sales_month_end.val()+sales_day_end.val()+sales_hour_end.val()+sales_minute_end.val();
            
            if (sales_year_start.val() == "" && sales_month_start.val() != "") {
                alert("영업 시작 연도를 먼저 선택해 주세요.");
                sales_month_start.val("");
                sales_day_start.val("");
                sales_hour_start.val("");
                sales_minute_start.val("");
                return;
            }
            
            if (sales_month_start.val() == "" && sales_day_start.val() != "") {
                alert("영업 시작 달을 먼저 선택해 주세요.");
                sales_day_start.val("");
                sales_hour_start.val("");
                sales_minute_start.val("");
                return;
            }

            if (sales_day_start.val() == "" && sales_hour_start.val() != "") {
                alert("영업 시작 날을 먼저 선택해 주세요.");
                sales_hour_start.val("");
                sales_minute_start.val("");
                return;
            }

            if (sales_hour_start.val() == "" && sales_minute_start.val() != "") {
                alert("영업 시작 시간을 먼저 선택해 주세요.");
                sales_minute_start.val("");
                return;
            }
            if (sales_year_end.val() == "" && sales_month_end.val() != "") {
                alert("영업 끝 연도를 먼저 선택해 주세요.");
                sales_month_end.val("");
                sales_day_end.val("");
                sales_hour_end.val("");
                sales_minute_end.val("");
                return;
            }

            if (sales_month_end.val() == "" && sales_day_end.val() != "") {
                alert("영업 끝 달을 먼저 선택해 주세요.");
                sales_day_end.val("");
                sales_hour_end.val("");
                sales_minute_end.val("");
                return;
            }

            if (sales_day_end.val() == "" && sales_hour_end.val() != "") {
                alert("영업 끝 날을 먼저 선택해 주세요.");
                sales_hour_end.val("");
                sales_minute_end.val("");
                return;
            }

            if (sales_hour_end.val() == "" && sales_minute_end.val() != "") {
                alert("영업 끝 시간을 먼저 선택해 주세요.");
                sales_minute_end.val("");
                return;
            }

            if (sales_year_start.val() == "" && sales_year_end.val() != "") {
                alert("영업 시작 연도를 먼저 선택해 주세요.");
                sales_year_end.val("");
                return;
            }

            if (sales_month_start.val() == "" && sales_month_end.val() != "") {
                alert("영업 시작 달을 먼저 선택해 주세요.");
                sales_month_end.val("");
                return;
            }

            if (sales_day_start.val() == "" && sales_day_end.val() != "") {
                alert("영업 시작 일을 먼저 선택해 주세요.");
                sales_day_end.val("");
                return;
            }

            if (sales_hour_start.val() == "" && sales_hour_end.val() != "") {
                alert("영업 시작 시간을 먼저 선택해 주세요.");
                sales_hour_end.val("");
                return;
            }

            if (sales_minute_start.val() == "" && sales_minute_end.val() != "") {
                alert("영업 시작 분을 먼저 선택해 주세요.");
                sales_minute_end.val("");
                return;
            }

            if(sales_date1>now_date || sales_date2>now_date){
                alert("방문일이 현재 날짜 이후입니다.\n방문일을 다시 확인해주세요.")
                sales_year_start.val("");
                sales_month_start.val("");
                sales_day_start.val("");
                sales_hour_start.val("");
                sales_minute_start.val("");
                sales_year_end.val("");
                sales_month_end.val("");
                sales_day_end.val("");
                sales_hour_end.val("");
                sales_minute_end.val("");
            }
            


            //-------------------------------------------------------
            if (sales_year_start.val() >= sales_year_end.val()) {
                if (sales_year_start.val() > sales_year_end.val() && sales_year_end.val() != "") {
                    alert("올바르지 않은 영업 년도 범위입니다.")
                    sales_year_end.val("");
                    sales_month_end.val("");
                    sales_day_end.val("");
                    sales_hour_end.val("");
                    sales_minute_end.val("");
                    return;
                }
                if (sales_year_start.val() == sales_year_end.val()) {
                    if ((sales_month_start.val() > sales_month_end.val()) && sales_month_end.val() != "") {
                        alert("올바르지 않은 영업 달 범위입니다.")
                        sales_month_end.val("");
                        sales_day_end.val("");
                        sales_hour_end.val("");
                        sales_minute_end.val("");
                        return;
                    }
                    if (sales_month_start.val() == sales_month_end.val()) {
                        if (sales_day_start.val() > sales_day_end.val() && sales_day_end.val() != "") {
                            alert("올바르지 않은 영업 일 범위입니다.")
                            sales_day_end.val("");
                            sales_hour_end.val("");
                            sales_minute_end.val("");
                            return;
                        }
                        if (sales_day_start.val() == sales_day_end.val()) {
                            if (sales_hour_start.val() > sales_hour_end.val() && sales_hour_end.val() != "") {
                                alert("올바르지 않은 영업 시간 범위입니다.")
                                sales_hour_end.val("");
                                sales_minute_end.val("");
                                return;
                            }
                            if (sales_hour_start.val() == sales_hour_end.val()) {
                                if (sales_minute_start.val() > sales_minute_end.val() && sales_minute_end.val() != "") {
                                    alert("올바르지 않은 영업 분 범위입니다.")
                                    sales_minute_end.val("");
                                    return;
                                }
                            }
                        }
                    }
                }
            }
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
            makeDate(document.getElementById('sales_year_start'), document.getElementById('sales_month_start'), document.getElementById('sales_day_start'));
            $("[name=" + val3 + "]").val(day);
            $("[name=" + val4 + "]").val(hour);
            $("[name=" + val5 + "]").val(minute);
            $("[name=" + val6 + "]").val(yyyy);
            $("[name=" + val7 + "]").val(mm);
            makeDate(document.getElementById('sales_year_end'), document.getElementById('sales_month_end'), document.getElementById('sales_day_end'));
            $("[name=" + val8 + "]").val(day);
            $("[name=" + val9 + "]").val(hour);
            $("[name=" + val10 + "]").val(minute);
        }
        function setEmpty(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10) {
            setEmpty2("[name=" + val1 + "],[name=" + val2 + "],[name=" + val3 + "],[name=" + val4 + "],[name=" + val5 + "],[name=" + val6 + "],[name=" + val7 + "],[name=" + val8 + "],[name=" + val9 + "],[name=" + val10 + "]");
        }


    </script>

    <style>
        .table1 td,
        .table1 th {
            border-top: 1px solid #415a70;
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
            <div class="mx-auto col-12 tm-block-col">
                <div class="tm-bg-primary-dark tm-block tm-block-h-auto tm-block-scroll" style="margin-bottom:80px">
                    <h2 class="tm-block-title">영업보고서 등록</h2>

                    <form name="salesRegForm" method="post" action="">
                        <table class="table">
                            <tr>
                                <th bgcolor="#486177">제목</th>
                                <td>
                                    <input type="text" name="report_name" placeholder="영업제목을 입력하세요" maxlength="333"
                                        style="background-color: #54657d;
                                        color: #ffffff; border: 0; padding: 15px 10px; border-radius: 0; width:30%;height: 20px;font-size:12;">
                                </td>
                            </tr>
                            <tr>
                                <th bgcolor="#486177">방문 목적</th>
                                <td>
                                    <select name="sales_type_code" class="custom-select tm-select-accounts"
                                        style="width:90px;height:25px; padding: 5px;font-size:13;">
                                        <option value="">--선택--</option>
                                        <option value=1>영업지관리</option>
                                        <option value=2>수금</option>
                                        <option value=3>회의</option>
                                        <option value=4>거래처확보</option>
                                        <option value=5>기타</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th bgcolor="#486177">만난 사람</th>
                                <td>
                                    <table class="table1 text-white">
                                        <tr bgcolor="#486177">
                                            <th style="text-align: center;font-size: 13">회사이름</th>
                                            <th style="text-align: center;font-size: 13">이름</th>
                                            <th style="text-align: center;font-size: 13">직급</th>
                                            <th style="text-align: center;font-size: 13">전화번호</th>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <input type="text" name="sales_company"
                                                    style="background-color: #54657d;
                                                    color: #ffffff; border: 0; padding: 15px 10px; border-radius: 0; width:100%;height: 20px;font-size:12;">
                                            </td>
                                            <td align="center">
                                                <input type="text" name="sales_name"
                                                    style="background-color: #54657d;
                                                    color: #ffffff; border: 0; padding: 15px 10px; border-radius: 0; width:75%;height: 20px;font-size:12;">
                                            </td>
                                            <td align="center">
                                                <input type="text" name="sales_jikup"
                                                    style="background-color: #54657d;
                                                    color: #ffffff; border: 0; padding: 15px 10px; border-radius: 0; width:75%;height: 20px;font-size:12;">
                                            </td>
                                            <td align="center">
                                                <input type="text" name="sales_phone" class="onlynumber" minlength="6" maxlength="15" placeholder=" - 없이 입력바람"
                                                    style="background-color: #54657d;
                                                    color: #ffffff; border: 0; padding: 15px 10px; border-radius: 0; width:85%;height: 20px;font-size:12;">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <th bgcolor="#486177">방문시간</th>
                                <td>
                                    <li style="list-style-type: none;float: left;">
                                        <div>
                                            <select name="sales_year_start" id="sales_year_start"
                                                class="custom-select tm-select-accounts"
                                                style="width:60px;height:25px; padding: 5px;font-size:13;"
                                                onchange="makeDate(document.getElementById('sales_year_start'),document.getElementById('sales_month_start'),document.getElementById('sales_day_start'));chcekBusi_date();">
                                                <option value=""></option>
                                                <script>
                                                    for (var i = new Date().getFullYear(); i > 1980; i--) {
                                                        document.write("<option value=" + i + ">" + i);
                                                    }
                                                </script>
                                            </select>년
                                            <select name="sales_month_start" id="sales_month_start"
                                                class="custom-select tm-select-accounts"
                                                style="width:45px;height:25px; padding: 5px;font-size:13;"
                                                onchange="makeDate(document.getElementById('sales_year_start'),document.getElementById('sales_month_start'),document.getElementById('sales_day_start'));chcekBusi_date();">
                                                <option value=""></option>
                                                <script>
                                                    for (var i = 1; i <= 12; i++) {
                                                        var m = (i < 10) ? "0" + i : i;
                                                        document.write("<option value=" + m + ">" + m);
                                                    }
                                                </script>
                                            </select>월
                                            <select name="sales_day_start" id="sales_day_start"
                                                class="custom-select tm-select-accounts"
                                                style="width:45px;height:25px; padding: 5px;font-size:13;"
                                                onchange="chcekBusi_date();">
                                                <option value="" id="graduate_date_op"></option>
                                                <script>
                                                    for (var i = 1; i <= 31; i++) {
                                                        var m = (i < 10) ? "0" + i : i;
                                                        document.write("<option value=" + m + ">" + m);
                                                    }
                                                </script>
                                            </select>일
                                            <select name="sales_hour_start" id="sales_hour_start"
                                                class="custom-select tm-select-accounts"
                                                style="width:45px;height:25px; padding: 5px;font-size:13;"
                                                onchange="chcekBusi_date();">
                                                <option value=""></option>
                                                <script>
                                                    for (var i = 0; i <= 24; i++) {
                                                        var m = (i < 10) ? "0" + i : i;
                                                        document.write("<option value=" + m + ">" + m);
                                                    }
                                                </script>
                                            </select>시
                                            <select name="sales_minute_start" id="sales_minute_start"
                                                class="custom-select tm-select-accounts"
                                                style="width:45px;height:25px; padding: 5px;font-size:13;"
                                                onchange="chcekBusi_date();">
                                                <option value=""></option>
                                                <script>
                                                    for (var i = 0; i <= 60; i++) {
                                                        var m = (i < 10) ? "0" + i : i;
                                                        document.write("<option value=" + m + ">" + m);
                                                    }
                                                </script>
                                            </select>분 부터
                                            <br>
                                            <div style="height: 6;"></div>
                                            <select name="sales_year_end" id="sales_year_end"
                                                class="custom-select tm-select-accounts"
                                                style="width:60px;height:25px; padding: 5px;font-size:13;"
                                                onchange="makeDate(document.getElementById('sales_year_end'),document.getElementById('sales_month_end'),document.getElementById('sales_day_end'));chcekBusi_date();">
                                                <option value=""></option>
                                                <script>
                                                    for (var i = new Date().getFullYear(); i > 1980; i--) {
                                                        document.write("<option value=" + i + ">" + i);
                                                    }
                                                </script>
                                            </select>년
                                            <select name="sales_month_end" id="sales_month_end"
                                                class="custom-select tm-select-accounts"
                                                style="width:45px;height:25px; padding: 5px;font-size:13;"
                                                onchange="makeDate(document.getElementById('sales_year_end'),document.getElementById('sales_month_end'),document.getElementById('sales_day_end'));chcekBusi_date();">
                                                <option value=""></option>
                                                <script>
                                                    for (var i = 1; i <= 12; i++) {
                                                        var m = (i < 10) ? "0" + i : i;
                                                        document.write("<option value=" + m + ">" + m);
                                                    }
                                                </script>
                                            </select>월
                                            <select name="sales_day_end" id="sales_day_end"
                                                class="custom-select tm-select-accounts"
                                                style="width:45px;height:25px; padding: 5px;font-size:13;"
                                                onchange="chcekBusi_date();">
                                                <option value="" id="graduate_date_op"></option>
                                                <script>
                                                    for (var i = 1; i <= 31; i++) {
                                                        var m = (i < 10) ? "0" + i : i;
                                                        document.write("<option value=" + m + ">" + m);
                                                    }
                                                </script>
                                            </select>일
                                            <select name="sales_hour_end" id="sales_hour_end"
                                                class="custom-select tm-select-accounts"
                                                style="width:45px;height:25px; padding: 5px;font-size:13;"
                                                onchange="chcekBusi_date();">
                                                <option value=""></option>
                                                <script>
                                                    for (var i = 0; i <= 24; i++) {
                                                        var m = (i < 10) ? "0" + i : i;
                                                        document.write("<option value=" + m + ">" + m);
                                                    }
                                                </script>
                                            </select>시
                                            <select name="sales_minute_end" id="sales_minute_end"
                                                class="custom-select tm-select-accounts"
                                                style="width:45px;height:25px; padding: 5px;font-size:13;"
                                                onchange="chcekBusi_date();">
                                                <option value=""></option>
                                                <script>
                                                    for (var i = 0; i <= 60; i++) {
                                                        var m = (i < 10) ? "0" + i : i;
                                                        document.write("<option value=" + m + ">" + m);
                                                    }
                                                </script>
                                            </select>분 까지
                                        </div>
                                    </li>
                                    <li style="list-style-type: none;float: left;margin-top: 2%;margin-left: 5">
                                        <div style="height:5px; min-width:70%">
                                            <span style="cursor: pointer"
                                                onclick="getToday('sales_year_start','sales_month_start','sales_day_start','sales_hour_start','sales_minute_start','sales_year_end','sales_month_end','sales_day_end','sales_hour_end','sales_minute_end');">[오늘로]</span>
                                            <span style="cursor: pointer"
                                                onclick="setEmpty('sales_year_start','sales_month_start','sales_day_start','sales_hour_start','sales_minute_start','sales_year_end','sales_month_end','sales_day_end','sales_hour_end','sales_minute_end');">[비움]</span>
                                        </div>
                                    </li>
                                </td>
                            </tr>
                            <tr>
                                <th bgcolor="#486177">영업 내용</th>
                                <td>
                                    <textarea cols="80" rows="10" name="sales_content"
                                        style="background-color: #54657d;
                                        color: #ffffff; border: 0; padding: 15px 10px; border-radius: 0;font-size:12;"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <th bgcolor="#486177">영업 성과</th>
                                <td>
                                    <textarea cols="80" rows="10" name="sales_result"
                                        style="background-color: #54657d;
                                        color: #ffffff; border: 0; padding: 15px 10px; border-radius: 0;font-size:12;"></textarea>
                                </td>
                            </tr>
                            <!-- <tr>
                                    <th bgcolor="#486177">결재/반려</th>
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
                        <input type=hidden name="report_code" value=2>
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
                                    <span tyle="cursor: pointer;" onclick="checkSalesRegForm();">
                                        <button style="max-width: 80px;"
                                            class="btn btn-small btn-primary btn-block text-uppercase">
                                            등록
                                        </button>
                                    </span>
                                <td width=5></td>
                                <td>
                                    <span tyle="cursor: pointer;" onclick="salesListForm();">
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
    <footer class="tm-footer row tm-mt-small" style="position:absolute; min-width:100%; left:0; right:0; bottom:0; margin-top: auto;">
        <div class="col-12 font-weight-light">
            <p class="text-center text-white mb-0 px-4 small">
                Copyright &copy; <b>2019</b> All rights reserved.
            </p>
        </div>
    </footer>
    </center>
</body>

</html>
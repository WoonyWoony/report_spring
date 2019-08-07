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
            //===========================================================================
            // 비용 , 유효성
            //===========================================================================
            $("[name=expense_price]").bind("keyup", function () {
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

            //===========================================================================
            // 숫자만 입력 유효성(영수증 번호)
            //===========================================================================
            $("[name=receipt_no]").bind("keyup", function () {
                var receipt_no = $(this).val();
                var num = "";
                var number = "0123456789";
                for (var i = 0; i < receipt_no.length; i++) {
                    var s = receipt_no.charAt(i);
                    if (number.indexOf(s) >= 0) {
                        num = num + s;
                    }
                }
                $(this).val(num);
            });
            $("#boryu_reason").hide();
            if ("${expenseDTO.sign_name}" == "4") {
                if ("${expenseDTO.emp_no}" == "${sessionScope.emp_no}") {
                    $("input").removeAttr("readonly");
                    $("select").removeAttr("disabled");
                    $("#noNextSigner").hide();
                    $("#sign_state_4").hide();
                    $("#sign_state").prop("checked", true);
					$("#empty_button").removeAttr("hidden");
                } else {
                    $("#payment_button").hide();
                    $(".radiotr").hide();
    				$(".nextselecttr").hide();
                    $("#donotpayment").text("반려되어 수정이 불가능합니다.");
                }
            } else if ("${expenseDTO.sign_name}" == "1" && "${pickNextEmp.SIGN_NAME}" == "3") {
				if ("${expenseDTO.emp_no}" == "${sessionScope.emp_no}") {
                    $("input").removeAttr("readonly");
                    $("select").removeAttr("disabled");
                    $("#noNextSigner").hide();
                    $("#sign_state_4").hide();
                    $("#sign_state").prop("checked", true);
					$("#empty_button").removeAttr("hidden");
                    $("[name=is_update]").val("true");
                } else{
					$("#payment_button").hide();
					$("#today").attr('href', '#');
					$(".radiotr").hide();
					$(".nextselecttr").hide();
					$("#donotpayment").text("결재되어 수정이 불가능합니다.");
				}
            } else if ("${expenseDTO.sign_name}" == "1" && "${pickNextEmp.SIGN_NAME}" != "3") {
                $("#payment_button").hide();
                $(".radiotr").hide();
				$(".nextselecttr").hide();
                $("#donotpayment").text("결재되어 수정이 불가능합니다.");
            } else if ("${expenseDTO.sign_name}" == "2") {
                $("#payment_button").hide();
                $(".radiotr").hide();
				$(".nextselecttr").hide();
                $("#donotpayment").text("결재 최종 완료된 보고서입니다.");
            }

            inputData("report_name", "${expenseDTO.report_name}");
            inputData("expense_field_code", "${expenseDTO.expense_field_code }");
            inputData("expense_price", "${expenseDTO.expense_price}");
            inputData("expense_method_code", "${expenseDTO.expense_method_code }");
            inputData("receipt_no", "${expenseDTO.receipt_no}");
            inputData("expense_price", "${expenseDTO.expense_price}");
            inputData("expense_method_code", "${expenseDTO.expense_method_code }");
            inputData("expense_year", "${expenseDTO.expense_year}");
            inputData("expense_month", "${expenseDTO.expense_month }");
            inputData("expense_day", "${expenseDTO.expense_day }");
            inputData("remarks", "${expenseDTO.remarks }");

            $('[name=expense_price]').val($('[name=expense_price]').val().split(" ").join(""));

            console.log(${ pickNextEmp.EMP_NO });


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



        //**************************
        // 저장 버트을 누르면 호출되는 함수
        // 입력양식들의 유효성 체크를 한 후 모두 유효성에 합당하면
        // 서버로 전송하는 기능을 가지고 있다.
        //**************************
        $("[name=결재비용]").bind('keyup', function () {
            var money = $(this).val();
            // $('[name='결재비용']') 대신 this를 쓰는 이유: 관리하는 태그중 이벤트가 발생한 특정의 1개 태그를 따로 관리하는 제이쿼리 객체를 생성하고자함.
            // 관리하는 요소가 2개이상 일경우 this를 쓰지 않으면 문제가 발생한다.
            // 관리하는 요소가 1개일때에도 this를 써주는 것이 유지보수 차원에서 좋다.

            // 하나하나씩 골라낼것이다.
            // 입력한 값을

            //--------
            // 숫자만 골라서 저장할 변수num선언
            //--------
            var num = "";

            //-------
            // money 변수안에 데이터중 숫자만 골라 num 변수데이터에 축적시킴
            //---------
            for (var i = 0; i < money.length; i++) {
                //money 안에 데이터중 i 번째 데이터가 숫자문자일때에만 num 변수 축적
                if ("0123456789".indexOf(money.charAt(i)) >= 0) {
                    num = num + money.charAt(i);
                }
                // 4번숫자 입력할때마다 인데스0과  , 삽입하기
            }
            // num 변수 안의 인덱스번호0번째의 문자열이 0이면 인덱스번호1번째부터 맨끝까지 복사하여 변수num 의 값을 갱신한다.

            while (num.charAt(0) == '0') { num = num.substring(1); }
            //---
            // 방법1
            //---
            var result = "";
            //--
            // 기존 입력 문자열에서 맨 뒤에서 하나씩 낚아채서
            // result 변수 누적 갱신
            // 변수누적갱신발생할때마다 변수 cnt값이 1증가
            // 이때 갱신된 횟수가 3의 배수일경우 result 맨앞에 콤마를 넣음
            // 
            var cnt = 0;
            for (var i = num.length - 1; i >= 0; i--) {
                ++cnt;
                if (cnt % 3 == 0 && i > 0) { result = ',' + num.charAt(i) + result; }
                else { result = num.charAt(i) + result; }

            }
            $(this).val(result);
        });

        $("[name=영수증번호]").bind('keyup', function () {
            var money = $(this).val();
            // $('[name='결재비용']') 대신 this를 쓰는 이유: 관리하는 태그중 이벤트가 발생한 특정의 1개 태그를 따로 관리하는 제이쿼리 객체를 생성하고자함.
            // 관리하는 요소가 2개이상 일경우 this를 쓰지 않으면 문제가 발생한다.
            // 관리하는 요소가 1개일때에도 this를 써주는 것이 유지보수 차원에서 좋다.

            // 하나하나씩 골라낼것이다.
            // 입력한 값을

            //--------
            // 숫자만 골라서 저장할 변수num선언
            //--------
            var num = "";

            //-------
            // money 변수안에 데이터중 숫자만 골라 num 변수데이터에 축적시킴
            //---------
            for (var i = 0; i < money.length; i++) {
                //money 안에 데이터중 i 번째 데이터가 숫자문자일때에만 num 변수 축적
                if ("0123456789".indexOf(money.charAt(i)) >= 0) {
                    num = num + money.charAt(i);
                }
                // 4번숫자 입력할때마다 인데스0과  , 삽입하기
            }
            // num 변수 안의 인덱스번호0번째의 문자열이 0이면 인덱스번호1번째부터 맨끝까지 복사하여 변수num 의 값을 갱신한다.

            while (num.charAt(0) == '0') { num = num.substring(1); }
            // //---
            // // 방법1
            // //---
            // var result = "";
            // //--
            // // 기존 입력 문자열에서 맨 뒤에서 하나씩 낚아채서
            // // result 변수 누적 갱신
            // // 변수누적갱신발생할때마다 변수 cnt값이 1증가
            // // 이때 갱신된 횟수가 3의 배수일경우 result 맨앞에 콤마를 넣음
            // // 
            // var cnt = 0;
            // for (var i = num.length - 1; i >= 0; i--) {
            //     ++cnt;
            //     if (cnt % 3 == 0 && i > 0) { result = ',' + num.charAt(i) + result; }
            //     else { result = num.charAt(i) + result; }

            // }

            $(this).val(num);

        });

        });

        function showBoryu_reason() {
            $("#boryu_reason").show();
        }
        function hideBoryu_reason() {
            $("#boryu_reason").hide();
        }



        //===========================================================
        // 폼태그 안의 모든 입력양식의 입력데이터를 없애거나 선택 데이터를 취소해버리는 함수.
        // 즉 초기화 함수
        //===========================================================

        function setEmptyAll() {
			setEmpty2("[name=expense_year],[name=expense_month],[name=expense_day],[name=report_name],[name=expense_field_code],[name=expense_price],[name=expense_method_code],[name=receipt_no],[name=remarks]")
        }

        // 미션 선택한 년 월에 맞게 날짜 자동

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
                alert("[년도]를 선택하세요.");
                expense_month.value = "";
                return;
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
        function checkExpenseUpdelForm() {
            if (doubleSubmitCheck()) return;


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

            var expense_date = $("[name=expense_year]").val()+$("[name=expense_month]").val()+$("[name=expense_day]").val();

            if (is_empty("report_name")) {
                alert("지출제목을 입력해 주세요");
                $("[name=report_name]").focus();
                doubleSubmitFlag = false;
                return;
            }

            if (is_empty("expense_field_code")) {
                alert("분야를 선택해 주세요");
                $("[name=expense_field_code]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("expense_price")) {
                alert("비용을 입력해 주세요");
                $("[name=expense_price]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("expense_method_code")) {
                alert("수단을 선택해 주세요");
                $("[name=expense_method_code]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("receipt_no")) {
                alert("영수증 번호을 입력해 주세요");
                $("[name=receipt_no]").focus();
                doubleSubmitFlag = false;
                return;
            }

            if (is_empty("expense_year")) {
                alert("지출년도를 선택해 주세요");
                $("[name=expense_year]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("expense_month")) {
                alert("지출월을 선택해 주세요");
                $("[name=expense_month]").focus();
                doubleSubmitFlag = false;
                return;
            }
            if (is_empty("expense_day")) {
                alert("지출일을 선택해 주세요");
                $("[name=expense_day]").focus();
                doubleSubmitFlag = false;
                return;
            }

            if (is_empty("sign_state")) {
                alert("결재/반려를 선택해 주세요");
                $("[name=sign_state]").focus();
                doubleSubmitFlag = false;
                return;
            }

            if (is_empty("sign_state")) {
                alert("결재/반려를 선택해 주세요");
                $("[name=sign_state]").focus();
                doubleSubmitFlag = false;
                return;
            }

            if (is_empty("noNextSigner") && is_empty("sign_emp_no")) {
                alert("다음 결재자를 선택해 주세요");
                $("[name=sign_emp_no]").focus();
                doubleSubmitFlag = false;
                return;
            }

            if(expense_date>now_date){
                alert("지출일이 현재 날짜 이후입니다.\n지출일을 다시 확인해주세요.");
                $("[name=expense_year]").val("");
                $("[name=expense_month]").val("");
                $("[name=expense_day]").val("");
				return;
            }
			
			if( is_pattern("report_name",/^[a-zA-Z가-힣0-9\s]{3,25}$/)==false){
				alert("제목은 3~25자리의 영어, 숫자, 한글만 입력 가능합니다");
				$("[name=report_name]").val("");
                doubleSubmitFlag = false;
				return;
			}


            if (confirm("정말 저장하시겠습니까?") != true) {
                doubleSubmitFlag = false;
                return;
            }
            $('[name=expense_price]').val(($('[name=expense_price]').val().split(",").join("")).split(" ").join(""));

            // ==========================================================
            // 현재 화면에서 페이지 이동 없이 서버쪽 "/erp/boardRegProc.do"를 호출하여
            // [게시판 입력 행 적용 개수]가 있는 html 소스를 문자열로 받기
            // ==========================================================
            $.ajax({
                // 서버쪽 호출 URL 주소
                url: "/ware/expenseUpdelProc.do",
                type: "post",
                data: $("[name=expenseUpdelForm").serialize(),
                success: function (data) {
                    if (data == 1) {
                        alert("지출보고서 결재 성공!");
                        //location.replace("/ware/expenseListForm.do");
                        document.goExpenseListForm.submit();
                    } else if (data == -10) {
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

        function expenseListForm() {
            //location.replace("/ware/expenseListForm.do");
            document.goExpenseListForm.submit();
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
                            <a class="dropdown-item" href="javascript:document.goDailyListForm.submit();">일일 보고서</a>
                            <a class="dropdown-item" href="javascript:document.goSalesListForm.submit();">영업 보고서</a>
                            <a class="dropdown-item active" href="javascript:document.goExpenseListForm.submit();">지출
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

    <div class="mt-5 ml-7 mr-7">
        <div class="row tm-content-row">
            <div class="col-12 tm-block-col">
                <div class="tm-bg-primary-dark tm-block tm-block-h-auto tm-block-scroll" style="margin-bottom:80px">
                    <h2 class="tm-block-title">지출보고서</h2>
                    <!--===============================================================================================-->
                    <!-- 지출보고서 -->
                    <!--===============================================================================================-->
                    <form name="expenseUpdelForm" method="post" action="">
                        <table class="table">
                            <tr>
                                <th bgcolor="#486177">지출 제목</th>
                                <td>
                                    <input type="text" size="100" name="report_name"
                                        style="background-color: #54657d;
                                        color: #ffffff; border: 0; padding: 15px 10px; border-radius: 0; width:300px;height: 20px;" readonly>
                                </td>
                            </tr>
                            <tr>
                                <th bgcolor="#486177">결재 내역</th>
                                <td>
                                    <table class="table1 text-white">
                                        <tr bgcolor="#dcdcdc">
                                            <th style="font-size:13;">분야</th>
                                            <th style="font-size:13;width:200">비용</th>
                                            <th style="font-size:13;">수단</th>
                                            <th style="font-size:13;">영수증번호</th>
                                            <th style="font-size:13;width:350">지출일</th>
                                            <th style="font-size:13;">비고</th>
                                        </tr>
                                        <tr>
                                            <td>
                                                <select name="expense_field_code" disabled="true"
                                                    class="custom-select tm-select-accounts"
                                                    style="width:80px;height:30px; padding: 5px;font-size:13;">
                                                    <option value=""></option>
                                                    <option value=1>식대</option>
                                                    <option value=2>회식비</option>
                                                    <option value=3>접대비</option>
                                                    <option value=4>비품</option>
                                                    <option value=5>기자재</option>
                                                    <option value=6>사무가구</option>
                                                    <option value=7>교통비</option>
                                                    <option value=8>경조사비</option>
                                                    <option value=9>숙박비</option>
                                                    <option value=10>의류비</option>
                                                    <option value=11>도서비</option>
                                                    <option value=12>홍보비</option>
                                                    <option value=13>기타</option>
                                                </select>
                                            </td>
                                            <td>
                                                <!-- name="결재비용" 태그 클릭시 숫자만 입력되고 3자리마다 콤마 입력되는 함수 head에 선언해놓음 -->
                                                <input type="text" name="expense_price" size="5" readonly="true"
                                                    style="background-color: #54657d;
                                                    color: #ffffff; border: 0; padding: 15px 10px; border-radius: 0; width:80px;height: 20px;font-size:12;">
                                                <font color=#fff size=1px>원</font>
                                            </td>
                                            <td>
                                                <select name="expense_method_code" disabled="true"
                                                    class="custom-select tm-select-accounts"
                                                    style="width:80px;height:30px; padding: 5px;font-size:13;">
                                                    <option value=""></option>
                                                    <option value=1>회사카드</option>
                                                    <option value=2>회사현금</option>
                                                    <option value=3>개인카드</option>
                                                    <option value=4>개인현금</option>
                                                </select>
                                            </td>
                                            <td>
                                                <input type="text" name="receipt_no"
                                                    style="background-color: #54657d;
                                                    color: #ffffff; border: 0; padding: 15px 10px; border-radius: 0; width:110px;height: 20px;font-size:12;"
                                                    readonly>
                                            </td>
                                            <td>
                                                <select name="expense_year" id="expense_year"
                                                    class="custom-select tm-select-accounts"
                                                    style="width:50px;height:30px; padding: 5px;font-size:13;"
                                                    onchange="makeDate(document.getElementById('expense_year'),document.getElementById('expense_month'),document.getElementById('expense_day'));"
                                                    disabled="true">
                                                    <option value=""></option>
                                                    <script>
                                                        for (var i = 2000; i <= new Date().getFullYear() + 1; i++) {
                                                            document.write("<option value=" + i + ">" + i);
                                                        }
                                                    </script>
                                                </select>
                                                <font color=#fff size=1px>년</font>
                                                <select name="expense_month" id="expense_month"
                                                    class="custom-select tm-select-accounts"
                                                    style="width:35px;height:30px; padding: 5px;font-size:13;"
                                                    onchange="makeDate(document.getElementById('expense_year'),document.getElementById('expense_month'),document.getElementById('expense_day'));"
                                                    disabled="true">
                                                    <option value=""></option>
                                                    <script>
                                                        for (var i = 1; i <= 12; i++) {
                                                            var m = (i < 10) ? "0" + i : i;
                                                            document.write("<option value=" + m + ">" + m);
                                                        }
                                                    </script>
                                                </select>
                                                <font color=#fff size=1px>월</font>
                                                <select name="expense_day" id="expense_day" disabled="true"
                                                    class="custom-select tm-select-accounts"
                                                    style="width:35px;height:30px; padding: 5px;font-size:13;">
                                                    <option value="" id="graduate_date_op"></option>
                                                    <script>
                                                        for (var i = 1; i <= 31; i++) {
                                                            var m = (i < 10) ? "0" + i : i;
                                                            document.write("<option value=" + m + ">" + m);
                                                        }
                                                    </script>
                                                </select>
                                                <font color=#fff size=1px>일</font>
                                            </td>
                                            <td><input type="text" name="remarks"
                                                    style="background-color: #54657d;
                                                    color: #ffffff; border: 0; padding: 15px 10px; border-radius: 0; width:170px;height: 20px;font-size:12;"
                                                    readonly></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="radiotr">
                                <th bgcolor="#486177">결재/반려</th>
                                <td>
                                    <input type="radio" id="sign_state" name="sign_state" value="1" onclick="hideBoryu_reason();">결재
                                    <span id="sign_state_4"><input type="radio" name="sign_state" value="4"
                                            onclick="showBoryu_reason();">반려
                                        <span id="boryu_reason">(반려사유: <input type="text" name="return_reason"
                                                placeholder=" 내용을 입력해주세요">
                                            )</span>
                                    </span>
                                </td>
                            </tr>

                            <tr class="nextselecttr">
                                <th bgcolor="#486177" width=140>다음 결재자</th>
                                <td>
                                    <select name="sign_emp_no" class="custom-select tm-select-accounts"
                                        style="width:200px;height:25px; padding: 5px">
                                        <option value="">--선택--</option>
                                        <c:forEach items="${superiorList}" var="sup" varStatus="loopTagStatus">
                                            <option value="${sup.EMP_NO}">${sup.DEP_NAME} ${sup.JIKUP_NAME}
                                                ${sup.EMP_NAME}</option>
                                        </c:forEach>
                                    </select>
                                    <span id="noNextSigner"><input type="checkbox" name="noNextSigner">다음 결재자 없음</span>
                                </td>
                            </tr>
                            <input type="hidden" name="report_no" value="${expenseDTO.report_no}">
                            <input type="hidden" name="emp_no" value="${expenseDTO.emp_no}">
                            <input type="hidden" name="return_no" value="${expenseDTO.return_no}">
                            <input type="hidden" name="sign_name" value="${expenseDTO.sign_name}">
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
                                    <table class="table1 text-white"  width=90% align=center>
                                        <tr bgcolor="#dcdcdc">
                                            <th style="text-align: center;font-size:14;width:12%">결재순서</th>
                                            <th style="text-align: center;font-size:14;width:12%">결재자명</th>
                                            <th style="text-align: center;font-size:14;width:10%">부서명</th>
                                            <th style="text-align: center;font-size:14;width:10%">직책</th>
                                            <th style="text-align: center;font-size:14;width:15%">결재여부</th>
                                            <th style="text-align: center;font-size:14;width:20%">결재일</th>
                                            <th style="text-align: center;font-size:14;width:21%">반려사유</th>
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
                        <!-- <img src="/ware/resources/image/payment_permit.png" id="payment_button" style="cursor:pointer;" name="reg" width="80"
                            onclick="checkExpenseUpdelForm();">
                        <img src="/ware/resources/image/close_page.png" width="80" style="cursor:pointer;" onclick="expenseListForm();">
                        <img src="/ware/resources/image/reset_big.png" width="80" style="cursor:pointer;" onclick=""> -->
                        <table>
                            <td>
                            <td>
                                <!-- <input type="image" src="/ware/resources/image/register.png" width="80"
                                                                    onclick="checkExpenseRegForm();"> -->
                                <span tyle="cursor: pointer;">
                                    <input type="button" style="max-width: 90px;" id="payment_button"
                                        class="btn btn-small btn-primary btn-block text-uppercase" value="결재/반려"
                                        onclick="checkExpenseUpdelForm();">
                                </span>
                            </td>
                            <td width=5></td>
                            <td>
                                <!-- <input type="image" src="/ware/resources/image/close_page.png" width="80" onclick="expenseListForm();"> -->
                                <span tyle="cursor: pointer;">
                                    <input type="button" style="max-width: 80px;"
                                        class="btn btn-small btn-primary btn-block text-uppercase" value="화면닫기"
                                        onclick="document.goExpenseListForm.submit();">
                                </span>
                            </td>
                            <td width=5></td>
							<td>
								<span tyle="cursor: pointer;">
									<input type="button" style="max-width: 80px;" id="empty_button" hidden
										class="btn btn-small btn-primary btn-block text-uppercase" value="초기화"
										onclick="setEmptyAll();">
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
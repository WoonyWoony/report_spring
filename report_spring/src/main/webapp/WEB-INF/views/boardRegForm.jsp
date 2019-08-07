<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 common.jsp 파일 내의 소스를 삽입하기 -->
<%@include file="common.jsp"%>
<%@include file="checkLogin.jsp" %>
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

   <script src="/ware/resources/ckeditor/ckeditor.js"></script>
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
      function checkBoardRegForm() {
         CKEDITOR.instances.content.updateElement();
         if (is_empty("subject")) {
            alert("제목을 입력해 주십시요");
            $("[name=subject]").focus();
            return;
         }
         var subject = $("[name=subject]").val();
         if (subject.length >= 100) {
            alert("게시판 제목은 100자를 넘어서면 안됩니다.");
            return;
         }
         if (is_empty("content")) {
            alert("내용을 입력해 주십시요");
            $("[name=content]").focus();
            return;
         }
         if (confirm("정말 저장하시겠습니까?") == false) { return; }

         $.ajax({
            url: "/ware/boardRegProc.do"
            , type: "post"
            , data: $("[name=boardRegForm]").serialize()
            , datatype: "html"
            , success: function (boardRegCnt) {
               if (boardRegCnt == 1) {
                  alert("공지사항 새글 성공!");
                  //location.replace("/ware/boardListForm.do");
                  document.goBoardListForm.submit();
               }
               else {
                  alert("게시판 새글 등록 실패! 관리자 문의바람!");
               }
            }
            , error: function () {
               alert("서버 접속 실패!")
            }
         });
      }

      //**************************************************************
      // 게시판 수정 화면으로 이동하는 함수 선언
      //**************************************************************
      function goBoardUpDelForm() {
         document.boardUpDelForm.submit();
      }
          
      function setting(){
			inputData("subject", "2018년 APM 시장매출 272억원 기록..헬로웍스 시장점유율 1위 차지");
         CKEDITOR.instances.content.setData('지난해 헬로웍스가 APM 시장서 점유율 1위로 시장을 선도했다. 또한 침체기를 맞았던 EUE(엔드유저경험) 시장이 지난해 도약했다.  데일리그리드(DailyGrid)의 리서치센터가 2018년 3월 5일부터 4월 10일까지 기업 및 공공기관을 대상으로 방문, 전화, 설문 등을 통해 APM 시장 조사를 실시했다. 조사결과 WAS 모니터링, EUM 매출을 모두 포함한 2016년 전체 APM 시장은 272억원으로, 2015년 총매출인 256억원 대비 6.2% 증가했다.');
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
                     <a class="nav-link active" href="javascript:document.goBoardListForm.submit();">
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
                     <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fas fa-cog"></i>
                        <span>
                           관리자페이지 <i class="fas fa-angle-down"></i>
                        </span>
                     </a>
                     <div class="dropdown-menu" aria-labelledby="navbarDropdown" style="width: 100%">
                        <a class="dropdown-item" href="javascript:document.goEmployeeListForm.submit();" style="text-align: center">직원 관리</a>
                        <a class="dropdown-item" href="javascript:document.goEmployeeListForm_beforeAllow.submit();" style="text-align: center">가입 관리</a>
                        
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
                  <h2 class="tm-block-title">공지사항</h2>
                  <form method="post" name="boardRegForm" action="/ware/boardRegProc.do">
                     <table class="table">
                        <input type="hidden" size="10" maxlength="10" name="writer" value="${employeeDTO.emp_name}">
                        <input type="hidden" size="40" maxlength="30" name="email" value="${employeeDTO.email}">
                        <tr>
                           <th bgcolor="#486177" style="text-align: center;">제&emsp;&emsp;목</th>
                           <td>
                              <input type="text" class="form-control" size="80" name="subject">
                           </td>
                        </tr>
                        <tr>
                           <th bgcolor="#486177" style="text-align: center;">내&emsp;&emsp;용</th>
                           <td>
                              <textarea name="content" id="content" class="form-control"></textarea>
                              <script>
                                 CKEDITOR.replace('content');
                              </script>
                           </td>
                        </tr>
                     </table>
                     <input type="reset" style="display: none" id="iamreset">
                  </form>
                  <center>
                     <table>
                        <tr>
                           <td>
                              <span style="cursor: pointer" onclick="checkBoardRegForm();">
                                 <button style="min-width: 80px;" height=30 class="btn btn-small btn-primary btn-block text-uppercase">
                                    등록
                                 </button>
                              </span>
                           </td>
                           <td width=20></td>
                           <td>
                              <span style="cursor: pointer" onclick="document.goBoardListForm.submit();">
                                 <button style="min-width: 100px;" height=30 class="btn btn-small btn-primary btn-block text-uppercase">
                                    화면 닫기
                                 </button>
                              </span>
                           </td>
                           <td width=20></td>
                           <td>
                              <span style="cursor: pointer" onclick="setting();">
                                 <button style="min-width: 80px;" height=30 class="btn btn-small btn-primary btn-block text-uppercase">
                                    입력
                                 </button>
                              </span>
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

   <form name="boardRegForm" method="post" action="/ware/boardRegForm.do">
      <input type="hidden" name="b_no" value="${board.b_no}">
   </form>
   <form name="boardUpDelForm" method="post" action="/ware/boardUpDelForm.do">
      <input type="hidden" name="b_no" value="${board.b_no}">
   </form>

   <form name="boardContentForm" method="post" action="/ware/boardContentForm.do">
      <input type="hidden" name="b_no">
   </form>
   <form name="goDashboard" method="post" action="/ware/dashboard.do"></form>

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
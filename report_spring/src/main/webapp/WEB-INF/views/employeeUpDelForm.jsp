<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 common.jsp 파일 내의 소스를 삽입하기 -->
<%@include file="common.jsp"%>
<%@include file="checkLogin.jsp" %>

<c:if test="${emp_role ne 'ADMIN'}">
	<!-- 'sessionScope.' 빼면 먼저 HttpSession에서 찾음 그 다음 HttpServletRequest에서 찾음 키값 중복되지만 않으면 생략해서 씀-->
	<script>
		alert("잘못된 접근입니다.");
		location.replace("/ware/dashboard.do");
		// document.goDashboard.submit();
	</script>
</c:if>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="X-UA-Compatible" content="ie=edge" />
	<title>헬로웍스 - 직원수정</title>
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

			// 목록에서 한행클릭시 그대로 담아오기
			// 만약에 컨트롤러에서 넘어온 check값은 null이거나 no 이다. (한행을 클릭한 경우 넘어오는 check값은 null 직속상관의 )
			if ("${requestScope.empCheck}" == "no") {
				inputData("emp_name", "${employeeDTO.emp_name}");
				inputData("emp_no", "${employeeDTO.emp_no}");

				inputData("role", "${employeeDTO.role}");
				inputData("dep_no", "${employeeDTO.dep_no}");
				inputData("jikup_code", "${employeeDTO.jikup_code}");
				inputData("mgr_emp_no", "${employeeDTO.mgr_emp_no}");
				inputData("jumin_num", "${employeeDTO.jumin_num}");
				inputData("email", "${employeeDTO.email}");
				inputData("phone_num", "${employeeDTO.phone_num}");

			}
			else {
				inputData("dep_no", "${getEmployee.DEP_NO}");
				inputData("jikup_code", "${getEmployee.JIKUP_CODE}");
				inputData("role", "${getEmployee.ROLE}");
				inputData("mgr_emp_no", "${getEmployee.MGR_EMP_NO}");
				inputData("allow_code", "${getEmployee.ALLOW_CODE}");
			}
		});

		// 입력값 전체 초기화
		function setEmptyAll() {
			document.expenseSearchForm.reset();
		}

		function goDept() {

			//if(a!="" && b!=""){}else{}
			// alert("직급 과 부서를 모두 선택해야 직속상관을 설정할 수있습니다.")

			// 일단 함수 호출하고 
			// 백에서 직급 또는 부서가 파라미터값이 null또는 길이없는 문자열인경우 
			// 흔적은 유지하되 직속상관에 담길 값은 없도록 할것
			// 선택하였다가 다시 변경시 초기화혹은 변동되도록 하기 위함

			checkEmployeeUpDelForm('no');

		}
		//***************************************************************
		// EmployeeUpDelForm 유효성 체크
		//***************************************************************
		function checkEmployeeUpDelForm(form) {
			if (form == 'yes') {
				$("[name=empCheck]").val('yes');

				var name = $("[name=emp_name]").val();
				if (name.split(" ").join("") == "") {
					$('.emp_name_valid').text("이름을 입력해 주십시오");
					$("[name=emp_name]").focus();
					return;
				}
				if( is_pattern("emp_name",/^[가-힣]{2,20}$/)==false && is_pattern("emp_name",/^[a-zA-Z]{3,20}$/)==false ){
					$('.emp_name_valid').text("2~20자리의 한글,3~20자리의 영어만 입력 가능합니다");
					$("[name=emp_name]").focus();
					return;
				}else{
					$('.emp_name_valid').text("체크");
				}
				

				var emp_no = $("[name=emp_no]").val();
				if (emp_no.split(" ").join("") == "") {
					$('.emp_no_valid').text("사번을 입력해 주십시오");
					$("[name=emp_no]").focus();
					return;
				}
				var empExp = /^[0-9]{4,5}$/;

				if( empExp.test(emp_no)==false ){
					$('.emp_no_valid').text("4~5자리의 숫자만 입력 가능합니다");
					$("[name=emp_no]").focus();
					return;
				}else{
					$('.emp_no_valid').text("체크");
				}

				var pwd_01 = $("[name=new_emp_pwd]").val();
				var pwd_02 = $("[name=new_emp_pwd_chk]").val();
				  
				if (pwd_01.split(" ").join("").length > 0) {
					if (pwd_02.split(" ").join("") == "") {
						$('.new_emp_pwd_chk_valid').text("새로운 암호 확인 입력요망");
						$("[name=new_emp_pwd_chk]").focus();
						return;
					} else if (pwd_01 != pwd_02) {
						$('.new_emp_pwd_chk_valid').text("새로운 암호 불일치");
						$("[name=new_emp_pwd_chk]").focus();
						return;
					}else{
						$('.new_emp_pwd_valid').text("체크");
						$('.new_emp_pwd_chk_valid').text("체크");
					}
				} else {
					if (pwd_02.split(" ").join("").length > 0) {
						$('.new_emp_pwd_valid').text("새로운 암호가 입력되지 않았습니다.");
						$("[name=new_emp_pwd]").focus();
						return;
					}
				}
				var Val = $(".jumin_num").val();
				var reg_jumin = /^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))[1-4][0-9]{6}$/;
				if (Val.length == 13 && reg_jumin.test(Val)) {
					$('.jumin_num_valid').text("체크");
				}
				else {
					$('.jumin_num_valid').text("주민번호 양식에 맞지 않습니다.");
					$(".jumin_num").focus();
					return;
				}
				var emailV = $("[name=email]").val();
				if (emailV.split(" ").join("") != "") {
					var exptext = /^[A-Za-z0-9_\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
					if (!exptext.test(emailV)) {
						$('.email_valid').text("이메일형식이 올바르지 않습니다");
						$("[name=email]").focus();
						return;
					}
					else {
						$('.email_valid').text("체크");
					}
				}
				else {
					$('.email_valid').text("이메일을 입력해 주십시오");
					$("[name=email]").focus();
					return;
				}

				
				var role = $("[name=role]").val();
				if (role != "ADMIN") {
					var dept = $("[name=dep_no]").val();
					if (dept.split(" ").join("") == "") {
						$('.dep_no_valid').text("소속부서를 선택해 주십시오");
						$("[name=dep_no]").focus();
						return;
					}else{
						$('.dep_no_valid').text("체크");
					}
					var jikup = $("[name=jikup_code]").val();
					if (jikup.split(" ").join("") == "") {
						$('.jikup_code_valid ').text("직급을 선택해 주십시오");
						$("[name=jikup_code]").focus();
						return;
					}else{
						$('.jikup_code_valid').text("체크");
					}
				}

				var phone = $("[name=phone_num]").val();
				if (phone.split(" ").join("") == "") {
					$('.phone_num_valid').text("전화번호를 입력해 주십시오");
					$("[name=phone_num]").focus();
					return;
				}
				if( is_pattern("phone_num",/^[0-9]{6,15}$/)==false ){
					$('.phone_num_valid').text("6~15자리의 숫자만 입력 가능합니다");
					$("[name=phone_num]").focus();
					return;
				}else{
					$('.phone_num_valid').text("체크");
				}
				

				if (confirm("정말 등록 하시겠습니까?") == false) {
					return;
				}

				console.log($("[name=employeeUpDelForm]").serialize());

				$.ajax({
					url: "/ware/employeeUpDelProc.do",
					type: "post",
					data: $("[name=employeeUpDelForm]").serialize(),
					success: function (employeeRegCnt) {
						if (employeeRegCnt == 1) {
							alert("직원정보 수정 성공!");
							document.${empuri}.submit();
						} else if (employeeRegCnt == -9) {
							$('.emp_no_valid').text("이미 등록된 사원번호입니다. 다시 입력해주세요");
							$('.emp_no').focus();
						} else if (employeeRegCnt == -8) {
							$('.jumin_num_valid').text("이미 등록된 주민번호입니다. 다시 입력해주세요");
							$('.jumin_num').focus();
						} else if (employeeRegCnt == -7) {
							$('.email_valid').text("이미 등록된 이메일주소입니다. 다시 입력해주세요");
							$('.email').focus();						
						} else {
							alert("직원정보 수정 실패!");
						}
					},
					error: function () {
						alert("서버 접속 실패!");
					}
				});
			}
			else if (form == 'no') {
				$("[name=empCheck]").val('no');
				var a = $("[name=dep_no]").val();
				var b = $("[name=jikup_code]").val();
				if (a != "" && b != "") {
					$.ajax({
						url: "/ware/employeeUpDelProc.do",
						type: "post",
						data: $("[name=employeeUpDelForm]").serialize(),
						success: function (mgrEmployeeCnt) {
							var a = $("[name=dep_no]").val();
							var b = $("[name=jikup_code]").val();
							if (mgrEmployeeCnt > 0) {
								alert("직속상관후보가 존재합니다.");
								$("[name=empCheck]").val('no');
								document.employeeUpDelForm.submit();
							}
							else if (a != "" && b != "") {
								alert("직속상관후보가 존재하지 않습니다.");
								document.employeeUpDelForm.submit();
							}
						},
						error: function () {
							alert("서버 접속 실패!");
						}
					});
				} 
				else if (a == "" && b =="") {
					// alert($("[name=mgr_emp_no]").find(':first-child'));
					$("[name=mgr_emp_no]").find(':first-child').text("해당하는 직원이없습니다");
					$("[name=mgr_emp_no]").find(':first-child').siblings().remove();
				}			
			}
		}
	</script>
	<style>
		.emp_name_valid,
		.emp_no_valid,
		.dep_no_valid,
		.jikup_code_valid,
		.jumin_num_valid,
		.new_emp_pwd_valid,
		.new_emp_pwd_chk_valid,
		.email_valid,
		.phone_num_valid {
			text-align: right;
			font-size: 11;
			color: yellow;
			height: 0;
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
					<li class="nav-item dropdown" id="hidden_item" hidden>
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
					<li class="nav-item dropdown active">
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

	<div class="container mt-5 mb-7">
		<!-- row -->
		<div class="row tm-content-row">
			<div class="mx-auto tm-col-account-settings">
				<div class="tm-bg-primary-dark tm-block tm-block-settings">
					<h2 class="tm-block-title">직원 정보 수정</h2>
					<form method="post" name="employeeUpDelForm" class="tm-signup-form row" method=POST
						action="/ware/employeeUpDelForm.do">
						<div class="form-group col-lg-6">
							<label for="emp_name">이름</label>
							<input value="${getEmployee.EMP_NAME }" id="emp_name" name="emp_name" type="text" class="form-control validate emp_name" />
							<div class=emp_name_valid></div>
						</div>
						<div class="form-group col-lg-6">
							<label for="emp_no">변경할 사번</label>
							<input value="${getEmployee.EMP_NO }" id="emp_no" name="emp_no" type="text" class="form-control validate emp_no onlynumber" maxlength="5" />이전 사번:${beforeEmp_no}
							<div class=emp_no_valid></div>
						</div>
						<div class="form-group col-lg-6">
							<label for="new_emp_pwd">새로운 암호</label>
							<input id="new_emp_pwd" name="new_emp_pwd" type="password" class="form-control validate new_emp_pwd" />
							<div class=new_emp_pwd_valid></div>
						</div>
						<div class="form-group col-lg-6">
							<label for="new_emp_pwd_chk">새로운 암호확인</label>
							<input id="new_emp_pwd_chk" name="new_emp_pwd_chk" type="password" class="form-control validate new_emp_pwd_chk" />
							<div class=new_emp_pwd_chk_valid></div>
						</div>
						<div class="form-group col-lg-6">
							<label for="jumin_num">주민등록번호</label>
							<input value="${getEmployee.JUMIN_NUM}" id="jumin_num" name="jumin_num" type="text" class="form-control validate jumin_num onlynumber"
								maxlength="13" />
							<div class=jumin_num_valid></div>
						</div>
						<div class="form-group col-lg-6">
							<label for="email">이메일</label>
							<input value="${getEmployee.EMAIL}" id="email" name="email" type="email" class="form-control validate email" />
							<div class=email_valid></div>
						</div>
						<div class="form-group col-lg-6">
							<label for="role">권한설정</label>
							<select name="role" class="custom-select tm-select-accounts">
								<option value="USER">일반계정</option>
								<option value="ADMIN">관리자계정</option>
							</select>
						</div>
						<div class="form-group col-lg-6">
							<label for="dep_no">소속부서</label>
							<select name="dep_no" class="custom-select tm-select-accounts" onchange="goDept();">
								<option value="">소속부서</option>
								<c:forEach items="${requestScope.depList}" var="dep" varStatus="loopTagStatus">
									<option value="${dep.dep_no}">${dep.dep_name}</option>
								</c:forEach>
							</select>
							<div class=dep_no_valid></div>
						</div>
						<div class="form-group col-lg-6">
							<label for="jikup_code">직급</label>
							<select name="jikup_code" class="custom-select tm-select-accounts" onchange="goDept();">
								<option value=""> 직급</option>
								<c:forEach items="${requestScope.jikupList}" var="jikup" varStatus="loopTagStatus">
									<option value="${jikup.jikup_code}">${jikup.jikup_name}</option>
								</c:forEach>
							</select>
							<div class=jikup_code_valid></div>
						</div>
						<div class="form-group col-lg-6">
							<label for="mgr_emp_no">직속상관</label>
							<select name="mgr_emp_no" class="custom-select tm-select-accounts">
								<option value="">${empty requestScope.mgrEmployeeList ?'해당하는 직원이없습니다':'직속상관을 선택하지 않습니다'}
								</option>
								<c:forEach items="${requestScope.mgrEmployeeList}" var="mgrList"
									varStatus="loopTagStatus">
									<option value="${mgrList.mgr_emp_no}">${mgrList.mgr_dep_name}
										${mgrList.mgr_emp_name} ${mgrList.mgr_jikup_name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group col-lg-6">
							<label for="phone_num">전화번호</label>
							<input value="${getEmployee.PHONE_NUM}" id="phone_num" name="phone_num" type="tel" class="form-control validate phone_num onlynumber" maxlength="15" />
							<div class=phone_num_valid></div>
						</div>
						<div class="form-group col-lg-6">
							<label for="allow_code">가입상태</label>
							<select name="allow_code" class="custom-select tm-select-accounts">
								<option value="2">가입수락</option>
								<option value="1">가입대기</option>
								<option value="3">가입거절</option>
							</select>
						</div>
						<div class="form-group col-lg-6">
							<label class="tm-hide-sm">&nbsp;</label>
							<input type=button class="btn btn-primary btn-block text-uppercase" value="직원 수정"
								onclick="checkEmployeeUpDelForm('yes');">
						</div>
						<div class="form-group col-lg-6">
							<label class="tm-hide-sm">&nbsp;</label>
							<input type=button class="btn btn-primary btn-block text-uppercase" value="화면 닫기"
								onclick="document.${empuri}.submit();">
						</div>
						<input type="hidden" name=empCheck>
         				<input type="hidden" name=beforeEmp_no value="${beforeEmp_no}">
         				<input type="hidden" name=beforeJumin_num value="${beforeJumin_num}">
         				<input type="hidden" name=beforeEmail value="${beforeEmail}">
					</form>
				</div>
			</div>
		</div>
	</div>

	</div>


	<!-- <script src="js/jquery-3.3.1.min.js"></script> -->
	<!-- https://jquery.com/download/ -->
	<script src="/ware/resources/js/bootstrap.min.js"></script>
	<!-- https://getbootstrap.com/ -->
	<form name="goEmployeeList" method=POST action="/ware/employeeListForm.do">
		<input type=hidden name=emp_no>
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
	<form name="employeeListForm" method="post" action="/ware/employeeListForm.do"></form>
	<form name="goEmployeeListForm_beforeAllow" method="post" action="/ware/employeeListForm_beforeAllow.do"></form>
	<form name="employeeListForm_beforeAllow" method="post" action="/ware/employeeListForm_beforeAllow.do"></form>
	<footer class="tm-footer row tm-mt-small" style="position:absolute; min-width:100%; left:0; right:0; bottom:0; margin-top: auto;">
			<div class="col-12 font-weight-light">
				<p class="text-center text-white mb-0 px-4 small">
					Copyright &copy; <b>2019</b> All rights reserved.
				</p>
			</div>
		</footer>
</body>

</html>
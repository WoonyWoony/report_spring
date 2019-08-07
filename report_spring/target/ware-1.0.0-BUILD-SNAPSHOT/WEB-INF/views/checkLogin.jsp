<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- ************************************************* -->
<!-- [JSTL 커스텀 태그]와 EL을 사용하여 -->
<!-- HttpSession 객체에 로그인 아이디가 없으면 경고하고 -->
<!-- 로그인 화면으로 이동 시키기 -->
<!-- ************************************************* -->
<!-- 만약 HttpSession 객체에 admin_id 라는 키값으로 저장된 놈이 없으면 -->
<!-- 자스 코딩으로 경고하고 로그인 화면으로 이동 시키기 -->
<!-- ************************************************* -->

<script>
	$(function () {
		if ("${emp_role}" == "ADMIN") {
			$("#hidden_item").removeAttr("hidden");
		}
	});
</script>
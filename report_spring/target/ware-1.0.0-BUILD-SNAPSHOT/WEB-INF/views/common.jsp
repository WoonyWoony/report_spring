<!-- common.jsp -->
<!-- ================================================================================== -->
<!-- 같은 이름의 내장 객체, Scope 속성과 빈이 있을 때 EL의 우선순위는 아래와 같습니다. -->
<!-- Implicit Object > JavaBean > pageContext > request > session > application -->
<!-- 결론: 내장 객체 이름과 같은 건 사용하면 안됩니다. (연산자도 마찬가지) -->
<!-- ================================================================================== -->

<!-- ================================================= -->
<!-- 현재 JSP 페이지의 처리 방식 설정 -->
<!-- ================================================= -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
%>
<!-- ================================================= -->
<!-- JQuery 라이브러리 수입 -->
<!-- ================================================= -->
<script src="/ware/resources/jquery-1.11.0.min.js"></script>

<link rel="stylesheet" href="/ware/resources/jquery-ui-1.12.1/jquery-ui.min.css">

<script src="/ware/resources/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<script src="/ware/resources/jquery-ui-1.12.1/datepicker-ko.js"></script>


<!-- ================================================= -->
<!-- JQuery 라이브러리 수입 -->
<!-- ================================================= -->
<script src="/ware/resources/common.js?ver=<%=Math.random()%>"></script>

<!-- ================================================= -->
<!-- JSP 페이지에서 사용할 [사용자 정의 태그]인 [JSTL 의 C코어 태그] 선언 -->
<!-- ================================================= -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- ================================================= -->
<!-- JSP 페이지에서 사용할 [CSS 파일] 수입 -->
<!-- ================================================= -->
<link href="/ware/resources/common.css?ver=<%=Math.random()%>" rel="stylesheet" type="text/css">

<!-- ================================================= -->
<!-- [사용자 정의 태그]인 [JSTL 의 C 코어 태그]를 사용하여 변수 선언 -->
<!-- [JSTL 의 C 코어 태그]를 사용하여 선언된 변수는 자바영역의 변수와 동일하다 -->
<!-- C 코어 태그로 선언된 변수안의 데이터를 꺼낼 때는 EL 문법으로 달러표기{변수명} 꺼낸다. -->
<!-- ================================================= -->
<c:set var="headerColor" value="#FF88A7" />
<c:set var="oddTrColor" value="#FFF0F5" />
<c:set var="evenTrColor" value="#FFFFFF" />
<c:set var="mouseOverColor" value="#D0E0F4" />

<center>${warning}</center>
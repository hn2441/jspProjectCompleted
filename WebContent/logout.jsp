<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 로그아웃 action 페이지 -->
<%
// 1: 기존의 세션 데이터를 모두 삭제
session.invalidate();
// 2: 로그인 페이지로 이동시킴.
response.sendRedirect("loginPage.jsp");
%>

</body>
</html>
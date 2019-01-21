<%@page import="javax.websocket.SendResult"%>
<%@page import="bean.MemberDTO"%>
<%@page import="bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 회원정보 수정 페이지 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
/* 닉네임과 전화번호 수정 */
String name = request.getParameter("name");
String tel = request.getParameter("tel");

MemberDAO dao = new MemberDAO();

if (name!=null) {
	dao.update("name", name, (String)session.getAttribute("id"));
out.print("<script> alert(\"회원 정보가 수정되었습니다\"); location.href='myPage.jsp' </script>"); 
} else if (tel!=null) {
	dao.update("tel", tel, (String)session.getAttribute("id"));
}
%>
</body>
</html>
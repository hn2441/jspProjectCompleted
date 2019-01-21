<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript"></script>
<%
String id = (String)session.getAttribute("id");
if(id==null) {
	out.print("<script type='text/javascript'> alert('로그인을 해주세요'); location.href='loginPage.jsp';</script>");	
}
else{
	String p = request.getParameter("p");
	if(p.equals("m")){
		response.sendRedirect("myPage.jsp");
	}else if (p.equals("c")) {
		response.sendRedirect("cart.jsp");
	}
}
%>
</body>
</html>
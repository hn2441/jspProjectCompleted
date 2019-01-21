<%@page import="bean.ServiceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
</head>
<body>

<jsp:useBean id="dto" class="bean.ServiceDTO"/> 
<jsp:setProperty property="*" name="dto"/>

	<%
	/*ServiceDAO 에서 dao문 에서 수정문*/
		ServiceDAO dao=new bean.ServiceDAO();
		  		dao.update(dto);
	%>
	<div align="center">
	<font size="3">게시글이 다음과 같이 수정되었습니다.</font>
	<hr>
	<table border="1">
		<tr align="center">
		<td bgcolor="white" width="100">항목</td>
		<td bgcolor="green" width="300">내용</td>
	</tr>
		 <tr align="center">
		<td bgcolor="white" width="100">이메일</td>
		<td bgcolor="green" width="300"><%=dto.getEmail()%></td>
	</tr>
		<tr align="center">
		<td bgcolor="white" width="100">제목</td>
		<td bgcolor="green" width="300"><%=dto.getTitle()%></td>
		
	</tr>
		<tr align="center">
		<td bgcolor="white" width="100">패스워드</td>
		<td bgcolor="green" width="300"><%=dto.getPw() %></td>
	
	</tr>
		<tr align="center">
		<td bgcolor="white" width="100">내용</td>
		<td bgcolor="green" width="300"><%=dto.getContent() %></td>
		
	</tr>
	
	
	</table>
	</div>
	<hr>
	<a href="ServiceCustomer.jsp" class="btn btn-primary pull-right">글목록으로</a>
</body>
</html>
<%@page import="java.awt.TextArea"%>
<%@page import="bean.ServiceDTO"%>
<%@page import="bean.ServiceDAO"%>
<%@ page import="bean.ServiceDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body bgcolor="yellow">
	<%
		String title = request.getParameter("title");
		ServiceDAO dao = new ServiceDAO();
		ServiceDTO dto = dao.select(title);

		
	%>
	

	<center>
		<table class="table table-hover">
			<font color="rightgray" size="6">게시물 정보확인</font>
			<hr>
			<form action="boardUpdate.jsp">
				<table>
					<tr align="center">
						<td width="100">이 메 일</td>
						<td width="350"><input type="text" name="email"
							class="form-control" class="form-control"
							value="<%=dto.getEmail()%>" readonly="readonly" maxlength="50"></td>
					</tr>
					<tr align="center">
						<td width="100">제 목</td>
						<td width="350"><input type="text" name="title"
							class="form-control" maxlength="50" value="<%=dto.getTitle()%>"></td>
					</tr>
					<tr align="center">
						<td width="100">패스워드</td>
						<td width="350"><input type="password" name="pw"
							class="form-control" value="<%=dto.getPw()%>"></td>
					</tr>
					<tr align="center">
						<td width="100">내 용</td>
						<td width="550"><textarea type="text"  name="content"
								class="form-control" maxlength="2048" style="height: 550px;"><%=dto.getContent()%>"
			</textarea></td>
					</tr>
				</table>
				<tr align="center">
					<td bgcolor="yellow" colspan="10"><input type="submit"
						value="게시물 수정완료"></td>
				</tr>

				<hr>
				<a href="ServiceCustomer.jsp" class="btn btn-primary">게시글목록</a> <a
					href="boardDelete.jsp?title=<%=dto.getTitle()%>" class="btn btn-primary">게시글삭제</a>

			</form>
			</center>
</body>
</html>

<%@page import="bean.BBSDTO"%>
<%@page import="bean.BBSDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	//------------------------------------------------게시글 등록시 DB에 저장하는 페이지---------------------------------------------------
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	BBSDAO dao = new BBSDAO();
	BBSDTO dto = new BBSDTO();
	
	
	String title = request.getParameter("title");
	String write = request.getParameter("write");
	String id = request.getParameter("id");
	String id2 = request.getParameter("id2");
	String date = sf.format(now);
	int view = request.getContentLength();
	

	dto.setTitle(title);
	dto.setWrite(write);
	dto.setId(id);
	dto.setId2(id2);
	dto.setDate(date);
	dto.setView(view);
%>
<%
	dao.insert(dto); 
	response.sendRedirect("BBS.jsp");
%>

</body>
</html>
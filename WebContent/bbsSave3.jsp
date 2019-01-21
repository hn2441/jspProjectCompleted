<%@page import="java.net.URLEncoder"%>
<%@page import="bean.BBSDTO2"%>
<%@page import="bean.BBSDAO2"%>
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
<%//-------------------------------------------------------------답글 등록시 DB에 저장하는 페이지----------------------------------------------------------
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	BBSDAO2 dao2 = new BBSDAO2();
	BBSDTO2 dto2 = new BBSDTO2();
	
	
	String title = URLEncoder.encode(request.getParameter("title"), "UTF-8");
	String write = URLEncoder.encode(request.getParameter("write"), "UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String id2 = request.getParameter("id2");
	String date = sf.format(now);

	dto2.setNum(num);
	dto2.setTitle(title);
	dto2.setWrite(write);
	dto2.setId2(id2);
	dto2.setDate(date);
%>
<%
/* 	out.println(num);
	out.println(title);
	out.println(write);
	out.println(id2);
	out.println(date); */
	
	dao2.insert(dto2);
	response.sendRedirect("bbsShow.jsp?title=" + title + "&write="+write + "&date=" + date + "&num" + num);
%>

</body>
</html>
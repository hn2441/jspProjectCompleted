<%@page import="bean.SalesDTO"%>
<%@page import="bean.SalesDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="bean.AdvDTO"%>
<%@page import="bean.AdvDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String price0 = request.getParameter("price");
	int price = 0;
	if(price0 != null){
		price = Integer.parseInt(price0);		
	}
	if(price>0){
		String mid = (String)session.getAttribute("id");
		String sid = request.getParameter("id2");
		//날자만 오늘날자로 넣어줌
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
		Date day = new Date();
		String today = formatter.format(day);
		
		SalesDAO sdao = new SalesDAO();
		SalesDTO sdto = new SalesDTO(mid,sid,price,today);
		
		int rs = sdao.insertSales(sdto);
		//넘어가는 페이지 경로 수정 확인해야합니다.
		if(rs == 1){
			response.sendRedirect("BBSinput.jsp");
		}else{
			//원래 페이지로 돌아감
			response.sendRedirect("BBS.jsp");
		}
	}

%>
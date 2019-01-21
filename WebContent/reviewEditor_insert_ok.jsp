<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="bean.ReviewDTO"%>
<%@page import="bean.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<% 	
		//post방식으로 받아올때 쓰는 아이...
		request.setCharacterEncoding("UTF-8");
		
		//넘어온 값 받아서 ReviewDAO실행
		String mid = (String)session.getAttribute("id");
		String sid = request.getParameter("sid");
		String adno0 = request.getParameter("adno");
		int adno = 0;
		if(adno0 != null){
			adno = Integer.parseInt(adno0);
		}
		String content = request.getParameter("content");
		String starsc0 = request.getParameter("starsc");
		int starsc = 0;
		if(starsc0 != null){
			starsc = Integer.parseInt(starsc0);
		}
		//날자만 오늘날자로 넣어줌
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
		Date day = new Date();
		String today = formatter.format(day);
		
		ReviewDAO rdao = new ReviewDAO();
		ReviewDTO rdto = new ReviewDTO(mid,sid,adno,content,starsc,today);
		
		int rs = rdao.insertReview(rdto);
		if(rs==1){
			/* 리뷰 리스트 화면으로 넘어감 */
			response.sendRedirect("review.jsp?adno="+adno);			
		}else{
			/* 리뷰 수정 화면으로 넘어감 */
			response.sendRedirect("saleEditor_insert.jsp");			
		}
	%>	
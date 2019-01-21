<%@page import="bean.ReviewDAO"%>
<%@page import="bean.AdvDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		//넘어온 값 받아오기
		String adno0 = request.getParameter("adno");
		int adno=0;
		if(adno0 != null){
			adno = Integer.parseInt(adno0);
		}else{
    		adno = Integer.parseInt(request.getParameter("adno"));
    	}
		
		String rvno0 = request.getParameter("rvno");
		int rvno=0;
		if(rvno0 != null){
			rvno = Integer.parseInt(rvno0);
		}else{
    		rvno = Integer.parseInt(request.getParameter("rvno"));
    	}
		
		ReviewDAO rdao = new ReviewDAO();
		
		int rs = rdao.deleteReview(rvno);
		if(rs==1){
		//업데이트 성공시 판매글 메인 화면으로 이동 
			response.sendRedirect("review.jsp?adno="+adno);
		} 
	%>
	
	
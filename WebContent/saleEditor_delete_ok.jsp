<%@page import="bean.AdvDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		//넘어온 값 받아오기
		String no = request.getParameter("no");
		int adno=0;
		if(no!=null){
		adno = Integer.parseInt(no);
		}else{
    		adno = Integer.parseInt(request.getParameter("adno"));
    	}
		
		AdvDAO adao = new AdvDAO();
		int rs = adao.deleteAdv(adno);
		
		/* 판매글 리스트 화면으로 넘어감 */
		response.sendRedirect("advSidList.jsp?nowPage=1");
	%>
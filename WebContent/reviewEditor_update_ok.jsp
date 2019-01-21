<%@page import="java.io.Console"%>
<%@page import="bean.ReviewDTO"%>
<%@page import="bean.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<% 	
		//post방식으로 받아올때 쓰는 아이...
		request.setCharacterEncoding("UTF-8");
		
		//넘어온 값 받기
		String mid = (String)session.getAttribute("id");
		String sid = request.getParameter("sid");
		String adno0 = request.getParameter("adno").trim();
		int adno = 0;
		if(request.getParameter("adno") != null){
			try {
				adno = Integer.parseInt(adno0);
			} catch(NumberFormatException e) {%>
			    Console.log("adno")
			<%}
		}
		String rvno0 = request.getParameter("rvno").trim();
		int rvno = 0;
		if(request.getParameter("rvno") != null){
			try {
				rvno = Integer.parseInt(rvno0);
			} catch(NumberFormatException e) {
			    e.printStackTrace();
			}
		}
		String content = request.getParameter("content");
		String starsc0 = request.getParameter("starsc").trim();
		int starsc = 0;
		if(request.getParameter("starsc") != null){
			try {
				starsc = Integer.parseInt(starsc0);
			} catch(NumberFormatException e) {
			    e.printStackTrace();
			}
		}
		
		//DB동작
 		ReviewDAO rdao = new ReviewDAO();
		ReviewDTO rdto = new ReviewDTO(mid,sid,adno,content,starsc,"");
		rdto.setNo(rvno);
		
		int rs = rdao.updateReview(rdto);

		if(rs==1){
			/* 리뷰 리스트 화면으로 넘어감 */
			response.sendRedirect("review.jsp?adno="+adno+"&rvno="+rvno);			
		}else{
			/* 리뷰 수정 화면으로 넘어감 */
			response.sendRedirect("saleEditor_update.jsp?adno="+adno+"&rvno="+rvno);			
		}
	%>
	
	
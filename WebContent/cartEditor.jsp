<%@page import="java.util.Locale"%>
<%@page import="org.apache.tomcat.jni.Local"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.awt.List"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>

<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="bean.CartDTO"%>
<%@page import="bean.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
		//아이디, 판매글 번호 받기
		String id = request.getParameter("id");
		int adno = Integer.parseInt(request.getParameter("adno"));
		
		CartDAO cdao = new CartDAO();
		CartDTO cdto = null;
		
		//받아온 값들로 DB조회 후 값이 없으면 insert 있으면 delete를 실행해줌		
		cdto = cdao.selectCart(id, adno);
		if(cdto == null){
			//날자만 오늘날자로 넣어줌
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
			Date day = new Date();
			String today = formatter.format(day);
			cdto = new CartDTO(id,adno,today);
			
			int rs = cdao.insertCart(cdto);
			if(rs==1){	
				
			}else{
				
			}//end inner if
		}else{
			cdao.deleteCart(id, adno);
		}//end outer if
		response.sendRedirect("adv.jsp?adno="+adno);			
	%>	
		
	
	
	
	
	
	

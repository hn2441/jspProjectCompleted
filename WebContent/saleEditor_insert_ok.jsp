<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="bean.AdvDTO"%>
<%@page import="bean.AdvDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.oreilly.servlet.*"%>
	<%
	AdvDAO adao = new AdvDAO();
	AdvDTO adto = new AdvDTO();;
	int rs = 0;

	//경로 지정
	String uploadPath = config.getServletContext().getRealPath("images\\productImg");
	int size = 10 * 1024 * 1024;
	
	MultipartRequest multi = null;
	try{
		multi = new MultipartRequest(
			request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
		
		//넘어온 값 받아오기
		adto.setSid((String)session.getAttribute("id"));
		adto.setTitle(multi.getParameter("title"));
		adto.setPrice(multi.getParameter("price"));
		adto.setContent(multi.getParameter("content"));
		
		Enumeration files = multi.getFileNames();
		String file = (String)files.nextElement();
		String img = "images\\productImg\\"+multi.getFilesystemName(file);
		adto.setImg(img);
		
		rs = adao.insertAdv(adto);
		if(rs==1){
			response.sendRedirect("advSidList.jsp?nowPage=1");			
		}else{
			response.sendRedirect("saleEditor_insert.jsp");			
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	%>	
		
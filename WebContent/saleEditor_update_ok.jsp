<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="bean.AdvDTO"%>
<%@page import="bean.AdvDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.oreilly.servlet.*"%>
<%
	//경로 지정
	String uploadPath = config.getServletContext().getRealPath("images\\productImg");
	int size = 10 * 1024 * 1024;

	AdvDAO adao = new AdvDAO();
	AdvDTO adto = new AdvDTO();

	MultipartRequest multi = null;
	try {
		multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());

		//넘어온 값 받아오기
		String no = multi.getParameter("no");
		int adno = 0;
		if (no != null) {
			adno = Integer.parseInt(no);
		} else {
			adno = Integer.parseInt(multi.getParameter("adno"));
		}

		//넘어온 값 받아오기
		adto.setSid((String) session.getAttribute("id"));
		adto.setTitle(multi.getParameter("title"));
		adto.setPrice(multi.getParameter("price"));
		adto.setContent(multi.getParameter("content"));

		Enumeration files = multi.getFileNames();
		String file = (String) files.nextElement();
		String img = "images\\productImg\\" + multi.getFilesystemName(file);
		if (img == null || img.equals("")) {
			img = multi.getParameter("img");
		}
		adto.setImg(img);

		adto.setNo(adno);

		int rs = adao.updateAdv(adto);
		if (rs == 1) {
			/*업데이트 성공시 판매글 화면으로 이동 */
			response.sendRedirect("adv.jsp?adno=" + adno);
		} else {
			/* 업데이트 실패시 판매글 수정 화면으로 돌아감 */
			response.sendRedirect("saleEditor_update.jsp?adno=" + adno);
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
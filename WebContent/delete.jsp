<%@page import="bean.BBSDAO"%>
<%@page import="bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 회원이나 판매글게시판 관리자페이지에서 삭제하는 action -->
<%

 String id = request.getParameter("mId");
/* 회원아이디가 넘어온경우*/
if(id!=null && !id.equals("admin@naver.com")){
 MemberDAO mDao = new MemberDAO();
 mDao.delete(id);
 out.print("<script> alert(\"회원이 삭제되었습니다\"); location.href = 'loginPage.jsp' </script>");
 /* 관리자의 경우 */
} else if (id.equals("admin@naver.com")) {
	out.print("<script> alert(\"관리자는 삭제될 수 없습니다.\"); history.back() </script>");
}
/* 판매글게시판이 넘어온경우 */
String bId = request.getParameter("bId");
if(bId!=null){
 BBSDAO bDao = new BBSDAO();
 bDao.delete(bId);
 /* 관리자페이지로 */
 response.sendRedirect("adminPage.jsp");
}
%>
</body>
</html>
<%@page import="bean.ServiceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 삭제 화면입니다.</title>
</head>
<body>

<%	
/*제목을 삭제하는  파라미터  */
String title=request.getParameter("title");
ServiceDAO dao=new ServiceDAO();



dao.delete(title);/* dao메서드 에서 delte 가져와서 삭제하는 메서드 */
out.print("삭제되었습니다.");
out.print("<script type='text/javascript'>alert('삭제되었습니다');location.href='ServiceCustomer.jsp';</script>");
%>
</body>
</html>
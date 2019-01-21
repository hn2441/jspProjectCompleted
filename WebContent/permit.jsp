<%@page import="bean.MemberDAO"%>
<%@page import="bean.MemberDTO"%>
<%@page import="com.sun.xml.internal.bind.v2.runtime.Location"%>
<%@page import="javafx.scene.control.Alert"%>
<%@page import="bean.SellerDTO"%>
<%@page import="bean.SellerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 판매자 신청 허가 action 페이지 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<%

/* 입력 파라미터값  가져오기*/
String id = request.getParameter("id");
String bank = request.getParameter("bank");
String acc = request.getParameter("acc");

/* DB - member Table의 판매자 설정 */
MemberDAO mDao = new MemberDAO();
MemberDTO mDto = mDao.select("id", id);
mDao.update("category", true, id);

/* DB - seller Table의 판매자설정 */
SellerDAO sDao = new SellerDAO();
SellerDTO sDto = new SellerDTO();
sDto.setId(id);
sDto.setBank(bank);
sDto.setAcc(acc);
sDao.insert(sDto);
out.print("<script type=\"text/javascript\">");
/* 등록후 마이페이지로 이동 */
out.print("alert('등록되었습니다'); location.href='myPage.jsp' ");
out.print("</script>");
/* 
response.sendRedirect("myPage.jsp"); */
%>
</body>
</html>
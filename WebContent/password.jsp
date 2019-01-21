<%@page import="bean.MemberDTO"%>
<%@page import="bean.MemberDAO"%>
<%@page import="bean.KISA_SHA256"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 비밀번호 변경 action 페이지 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
/* 현재 비밀번호 */
 String current = request.getParameter("current");
/* 변경 비밀번호 */
 String pw = request.getParameter("pw");

 
 MemberDAO mDao = new MemberDAO();
 MemberDTO mDto = mDao.select("id", "admin@naver.com");
	
/* 변경비밀번호 해쉬 적용 */
 KISA_SHA256 kisa = new KISA_SHA256();
/* 입력받은 현재 비밀번호  - 해쉬적용 */
 String hashedPw = kisa.encrypt(mDto.getSalt()+current+"_kmong");
/* 입력받은 변경 비밀번호 해쉬 적용 */
 String changedPw = kisa.encrypt(mDto.getSalt()+pw+"_kmong");

/* 입력받은 현재 비밀번호와 계정의 비밀번호 일치 */
 if( hashedPw.equals(mDto.getPw())) {
	 mDto.setPw(changedPw);
	 mDao.update("pw", changedPw, mDto.getId());
	 out.print("<script> alert(\"비밀번호가 변경되었습니다.\"); location.href='myPage.jsp'; </script>");
/* 불일치 */
 } else {
	 out.print("<script> alert(\"입력하신 비밀번호가 일치하지 않습니다.\");  location.href='changingPassword.jsp'  </script>"); 
 }
%>

</body>
</html>
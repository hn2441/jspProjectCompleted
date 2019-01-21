<%@page import="bean.CountDTO"%>
<%@page import="bean.CountDAO"%>
<%@page import="java.sql.Date"%>
<%@page import="bean.MemberDTO"%>
<%@page import="bean.KISA_SHA256"%>
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
<!-- 로그인 action 페이지 -->
<%
	/* id값, pw값 받기 */
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	/* 아이디해당하는 값 dto에 가져오기 */
	MemberDAO dao = new MemberDAO();
	MemberDTO dto = dao.select("id", id);
	
	/* 입력받은 비밀번호 (솔트 + 비밀번호 + _kmong) 해쉬함수로 변환 */
	KISA_SHA256 kisa = new KISA_SHA256();
	String hashedPw = kisa.encrypt(dto.getSalt()+pw+"_kmong");
%>
<%-- 	HashedPw : <%= hashedPw %><br>
	salt : <%= dto.getSalt() %> --%>
<% 
	/* 변환받은 해쉬함수번호로 로그인*/  
	if(hashedPw.equals(dto.getPw())) {	
		session.setAttribute("id", id);
		/* 로그인되면 메인페이지로 이동 */
		response.sendRedirect("main.jsp");
	}else {
		 out.print("<script> alert(\"회원 정보가 없습니다\"); history.back() </script>"); 
	};  
%>
<%

/* 방문자 카운트 */
/* 방문이 처음일때 */
if(session.getAttribute("visit")==null) {
	session.setAttribute("visit", "today");
	java.util.Date today = new java.util.Date(); 	
	Date date = new Date(today.getTime());
	CountDAO cDao = new CountDAO();
	
	CountDTO cDto = cDao.select("visitDate", date);
	
	/* 오늘 처음방문자 */
	if(cDto.getVisitDate()==null) {
		CountDTO cDto2 = new CountDTO();
		cDto2.setVisitDate(date);
		cDto2.setCount(1);
		cDao.insert(cDto2);
	/* 방문수 추가 */
	}else {
		int count = cDto.getCount();
		count++;
		CountDTO cDto2 = new CountDTO();
		cDto2.setVisitDate(date);
		cDto2.setCount(count);
		cDao.Update(cDto2);
	}
	
}
/* 방문했던 사람일때 */
else if(session.getAttribute("visit")!=null) {
	
}%>
</body>
</html>
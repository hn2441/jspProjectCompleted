<%@page import="java.security.SecureRandom"%>
<%@page import="bean.KISA_SHA256"%>
<%@page import="bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 회원가입 action 페이지 -->
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- usebean에 dto설정 -->
<jsp:useBean id="dto" class="bean.MemberDTO">
<jsp:setProperty name="dto" property="*" />
</jsp:useBean>
<%
/* 해쉬함수호출 */
KISA_SHA256 kisa = new KISA_SHA256();
MemberDAO dao = new MemberDAO();
dto.setId(request.getParameter("id"));
String pw = request.getParameter("pw");

/* java.security.SecureRandom 클래스를 사용해 고품질의 난수를 만들어낸다. */
SecureRandom rand3 = null;
try {
    rand3 = SecureRandom.getInstance("SHA1PRNG");
} catch (Exception e) {
    e.printStackTrace();
}
int n = rand3.nextInt(100);
/* 솔트값에 해쉬화된 난수/32글자로 설정 */
String salt = kisa.encrypt((String.valueOf(n))).substring(0, 32);
dto.setSalt(salt);

/* 솔트+입력된 비밀번호 +_kmong값으로 해쉬화 */
String hashedPw = kisa.encrypt(salt+pw+"_kmong");
dto.setPw(hashedPw);

/* 닉네임 변수해쉬화로 무작위 생성 */
int nick = rand3.nextInt(100);
String nickname = kisa.encrypt(String.valueOf(nick)).substring(0, 10);
dto.setName(nickname);

dto.setTel(request.getParameter("tel"));
dao.insert(dto);

/* 페이지 이동 설정 */
out.print("<script> alert(\"회원가입이 완료되었습니다\"); </script>");
response.sendRedirect("loginPage.jsp");

%>

</body>
</html>
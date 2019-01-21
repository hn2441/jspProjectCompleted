<%@page import="org.w3c.dom.css.DocumentCSS"%>
<%@page import="org.w3c.dom.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!-- 회원가입 입력 페이지 -->
<html>
<head>

<title>회원 가입</title>
<script type="text/javascript">

	/* 아이디 체크 */
	function idCheck() {
		var id = document.getElementById("id").value;
		var idSign = document.getElementById("idSign");
		if (id.length < 8) {
			idSign.innerHTML = '이메일은 8글자 이상이어야 합니다';
		} else if (id.indexOf('@') == -1) {
			idSign.innerHTML = '이메일은 \'@\'를 포함해야 합니다';
		} else {
			idSign.innerHTML = null;
		}
	}
	/* 비밀번호 체크 */
	function pwCheck() {
		var pw = document.getElementById("pw").value;
		var rpw = document.getElementById("rpw").value;
		/* var pwSign = document.getElementById("pwSign").innerHTML; */
		if (pw.length<8 || pw.length>20) {
			document.getElementById("pwSign").innerHTML = "비밀번호는 8글자 이상 20글자 이하여야 합니다";
		} else if (!pw
				.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) {
			document.getElementById("pwSign").innerHTML = "비밀번호는 영문(대소문자구분),숫자,특수문자(~!@#$%^&*()-_? 만 허용)를 포함하여야 합니다";
		} else {
			document.getElementById("pwSign").innerHTML = null;
		}
	}
	/* 비밀번호 재입력 체크 */
	function rpwCheck() {
		var pw = document.getElementById("pw").value;
		var rpw = document.getElementById("rpw").value;
		/* var pwSign = document.getElementById("pwSign").innerHTML; */
		if (pw != rpw) {
			document.getElementById("rpwSign").innerHTML = "비밀번호가 재입력과 일치하지 않습니다";
		} else {
			document.getElementById("rpwSign").innerHTML = null;
		}
	}
	/* 서버로 전송전 모든사항 체크 */
	function Check() {
		var id = document.getElementById("id").value;
		var pw = document.getElementById("pw").value;
		var rpw = document.getElementById("rpw").value;
		var tel = document.getElementById("tel").value;
		if (id == "" || id.length < 6 || id.indexOf('@') == -1) {
			alert('이메일을 확인해주세요');
			return false;
		} else if (pw == ""
				|| rpw == ""
				|| !pw
						.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)
				|| pw != rpw) {
			alert('비밀번호를 확인해주세요');
			return false;
		} else if (!tel) {
			alert('전화번호를 입력해주세요');
			return false;
		} else {
			return true;
		}
	}
</script>

<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body class="no-sidebar is-preload">
<%
/* 클릭재킹 방어 헤더 */
response.addHeader("X-Frame-Options", "SAMEORIGIN");
/* 크로스 사이트 스크립팅 방어 헤더 */
response.setHeader("X-XSS-Protection", "1; mode=block"); 
%>
	<div id="page-wrapper">
		<!-- Header -->
		<section id="header" class="wrapper">

			<!-- Logo -->
			<div id="logo">
				<h1>
					<a href="index.html">회원 가입</a>
				</h1>
			</div>

			<!-- Nav -->
			  <nav id="nav">
                     <ul>
                        <li class="current"><a href="main.jsp">홈</a></li>
                        <li><a href="idCheck.jsp?p=m">마이페이지</a></li>
                        <li><a href="idCheck.jsp?p=c">찜 목록</a></li>
                        <li><a href="googleMap.jsp">찾아 오시는 길</a></li>
                        <li><a href="FAQ.html">고객 센터</a></li>
                        <li>|</li>
                    <%
                  /* 로그인한 세션 값 확인 */
                     if(session.getAttribute("id") == null) {
                  %>
                        <li><a href="loginPage.jsp">로그인</a></li>
                  <% 
                     } else {
                  %>
                        <li><a href="#"><%= session.getAttribute("id") %></a></li>
                        <li><a href="logout.jsp">로그아웃</a></li>
                  <%    
                     } /* end 로그인한 세션 값 확인 */
                  %>
                     </ul>
                  </nav>
            <div>
            </div>

		</section>

		<!-- Main -->
		<div id="main" class="wrapper style2">
			<div class="title">회원 가입</div>
			<div class="container">

				<!-- Content -->
				<div id="content">
					<article class="box post">
						<header class="style1">
							<!-- <h2>회원가입</h2> -->
							<div align="center">
							<!-- 입력창 -->
							<form action="signup.jsp" method="post" onsubmit="return Check()">
							<%
							/* 네이버로 로그인 어트리뷰트*/
							String id = null;
							if(session.getAttribute("id")!=null) {
								id = (String)session.getAttribute("id");
							%>
							<input type="text" name="id" placeholder="이메일" id="id" value=<%= id %> style="width: 380px" onchange="idCheck()">
							
							<%
							/* 카카오로 로그인 파라미터 */
							} else if(request.getParameter("id")!=null) {
							%>
							<input type="text" name="id" placeholder="이메일" id="id" value=<%=request.getParameter("id") + "@kakao.com"%> style="width: 380px" onchange="idCheck()">
							<%
							} else {
							%>
							<!-- 입력창 -->
						 		<input type="text" name="id" placeholder="이메일" id="id" style="width: 380px" onchange="idCheck()">
						 	<%} %>
						 		<span id = "idSign" style="color: red"></span><br>
								<input type="password" autocomplete="off" name="pw" placeholder="비밀번호" id="pw" style="width: 380px" onchange="pwCheck()" ><span id = "pwSign" style="color: red"></span> <br>
								
								<input type="password" name="rpw" placeholder="비밀번호확인" id="rpw" style="width: 380px" onchange="rpwCheck()" autocomplete="off"><span id = "rpwSign" style="color: red"></span> <br>
								
								<input type="text" name="tel" placeholder="핸드폰번호" id="tel" style="width: 380px" ><br>
								<input type="submit" value="동의하고 가입완료" class="button style1" style="width: 380px" > <br>
							</form>
							</div>
						</header>
					</article>
				</div>

			</div>
		</div>



	</div>

	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/jquery.dropotron.min.js"></script>
	<script src="assets/js/browser.min.js"></script>
	<script src="assets/js/breakpoints.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>

</body>
</html>
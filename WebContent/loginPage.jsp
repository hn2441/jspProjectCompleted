<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ page errorPage="erroPage.jsp" %>
<!-- 로그인하는 페이지 -->
<html>
<head>
<title>로그인 페이지</title>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
/* 서버로 넘어가기전 체크 */
 function logIns() {
	var id = document.getElementById("id").value;
	var pw = document.getElementById("pw").value;
	
	if(id=="") {
		alert('이메일를 입력해주세요');
		return false;
	} else if(pw=="") {
		alert('비밀번호를 입력해주세요');
		return false;
		/* sql injection방어 특수문자 */
	} else if(pw.match(/[‘,“,/,\,:,;, ,<,>]/)) {
		alert("sql injection");
		return false;
	} else {
		return true;
	}
}
</script>
<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body class="no-sidebar is-preload">
<%
/* 클릭재킹 방어 헤더 */
response.addHeader("X-Frame-Options", "SAMEORIGIN");
/* 크로스 사이트 스크립팅 방어 헤더 */
response.setHeader("X-XSS-Protection", "1; mode=block"); 
%>
	<%
		/* 네이버 로그인 설정 */
		String clientId = "zPkC7VG30yLkI1RAu_15";//네이버 클라이언트 아이디;
		String redirectURI = URLEncoder.encode("http://localhost:7777/project/callback.jsp", "UTF-8");
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString();
		String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		apiURL += "&client_id=" + clientId;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&state=" + state;
		session.setAttribute("state", state);
	%>
	<div id="page-wrapper">

		<!-- Header -->
		<section id="header" class="wrapper">

			<!-- Logo -->
			<div id="logo">
				<h1>
					<a href="index.html">로그인</a>
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
			<!-- <div class="title">No Sidebar</div> -->
			<div class="container">

				<!-- Content -->
				<div id="content">
					<article class="box post">
						<header class="style1">
							<h2>
								<!-- 로그인<br class="mobile-hide" /> -->
							</h2>
						</header>
						<!-- <a href="#" class="image featured">
										<img src="images/pic01.jpg" alt="" />
									</a> -->
						<div align="center">
							<!-- 전송전 체크 onsubmit -->
							<form action="login.jsp" method="post" onsubmit="return logIns()">
								<div class="col-6 col-12-small">
								<!-- 입력창 -->
									<input type="text" name="id" id="id" placeholder="이메일"
										style="width: 380px" ><br>
										
								</div>
								<div class="col-6 col-12-small">
								
									<input type="password" name="pw" id="pw" placeholder="패스워드" style="width: 380px" autocomplete="off"><br>
								</div>
								<input type="submit" value="로그인" class="button style1" style="width: 380px"><br>
								
								<a href="signupPage.jsp" style="width: 220px" >회원가입</a>
								
							</form>
							<!-- 네이버로그인 -->
							<a href="<%=apiURL%>"><img height="48" src="img/naver.PNG"></a><br>
							<!-- 카카오로그인 -->
							<a id="kakao-login-btn"></a> <a href="http://developers.kakao.com/logout"></a>
							<!-- 카카오로그인 자바스크립트 -->
						<script type='text/javascript'>
							//<![CDATA[
							// 사용할 앱의 JavaScript 키를 설정해 주세요.
							Kakao.init('17a08956249b46d62303f89288735141');
							// 카카오 로그인 버튼을 생성합니다.
							Kakao.Auth.createLoginButton({
								container : '#kakao-login-btn',
								success : function(authObj) {
									Kakao.API.request({
										url : '/v2/user/me',
										success : function(res) {
											/*  console.out(JSON.stringify(res));   */
											alert(res.properties.nickname
													+ '님 환영합니다.');
											/* localStorage.setItem('id',res.properties.nickname); */
											 location.href = "signupPage.jsp?id=" + res.properties.nickname; 
										}
									})
									/*  alert(JSON.stringify(authObj)); */
									/*   JsonObject object =JSON.pase(authObj);
									 alert(object.get("name")); */
								},
								fail : function(err) {
									alert(JSON.stringify(err));
								}
							});
							//]]>
						</script>
				</div>

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
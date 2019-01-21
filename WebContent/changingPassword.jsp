<%@page import="bean.MemberDTO"%>
<%@page import="bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 비밀번호 변경 페이지 -->

<html>
<head>
<title>마이 페이지</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<script type="text/javascript">
	/* 클라이언트에서 submit하기전에 체크하는 function */
	function check() {
		var current = document.getElementById("currnet").value;
		var pw = document.getElementById("pw").value;
		var rpw = document.getElementById("rpw").value;
		if (!current || !pw || !rpw) {
			alert('항목을 모두 입력해주세요');
			return false;
		} else if (pw != rpw) {
			alert('비밀번호가 재입력과 일치하지 않습니다.');
			return false;
		} else if (pw.length<8 || pw.length>20
				|| !pw
						.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) {
			alert('비밀번호 규격을 확인해주세요');
			return false;
		} else {
			return true;
		}
	}
	/* 비밀번호 체크 함수 */
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
	/* 비밀번호 재입력 함수 */
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
</script>
<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body class="left-sidebar is-preload">

	<%
		/* 세션아이디로 정보 가져오기 */
		String id = (String) session.getAttribute("id");
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = dao.select("id", id);
	%>
	<div id="page-wrapper">

		<!-- Header -->
		<section id="header" class="wrapper">

			<!-- Logo -->
			<div id="logo">
				<h1>
					<a href="index.html">마이 페이지</a>
				</h1>
				<!-- <p>A free responsive site template by HTML5 UP</p> -->
			</div>

			<!-- Nav -->
			<!-- Nav: 사이트에서 주요한 네비게이션 역할을 하는 링크 그룹을 담을 때 사용 -->

			<!-- Nav: 사이트에서 주요한 네비게이션 역할을 하는 링크 그룹을 담을 때 사용 -->

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
						if (session.getAttribute("id") == null) {
					%>
					<li><a href="loginPage.jsp">로그인</a></li>
					<%
						} else {
					%>
					<li><a href="#"><%=session.getAttribute("id")%></a></li>
					<li><a href="logout.jsp">로그아웃</a></li>
					<%
						} /* end 로그인한 세션 값 확인 */
					%>
				</ul>
			</nav>
			<div></div>

		</section>

		<!-- Main -->
		<section id="main" class="wrapper style2">
			<div class="title">비밀번호 변경</div>
			<div class="container">
				<div class="row gtr-150">
					<div class="col-4 col-12-medium">

						<!-- Sidebar -->
						<div id="sidebar">
							<section class="box">
								<header>
									<h2><%=session.getAttribute("id")%></h2>
								</header>
								<p>
									이름 :
									<%=dto.getName()%></p>
								<!-- <a href="#" class="button style1">Learn More</a> -->
							</section>
							<section class="box">
								<header>
									<h2>내 정보</h2>
								</header>
								<ul class="style2">
									<li>
										<article class="box post-excerpt">
											<!-- <a href="#" class="image left"><img src="images/pic08.jpg" alt="" /></a> -->
											<h3>
												<a href="myPage.jsp">나의정보</a>
											</h3>
										</article>
									</li>
									<li>
										<article class="box post-excerpt">
											<!-- 	<a href="#" class="image left"><img src="images/pic09.jpg" alt="" /></a> -->
											<h3>
												<a href="changingPassword.jsp">비밀번호변경</a>
											</h3>
										</article>
									</li>

									<%
										/* 판매자면 -판매자페이지, 아니면 판매자신청 */
										if (dto.isCategory()) {
									%>
									<li>
										<article class="box post-excerpt">
											<!-- <a href="#" class="image left"><img src="images/pic10.jpg" alt="" /></a> -->
											<h3>
												<a href="SellerPermit.jsp">판매자페이지</a>
											</h3>
										</article>
									</li>
									<%
										} else {
									%>
									<li>
										<article class="box post-excerpt">
											<!-- <a href="#" class="image left"><img src="images/pic10.jpg" alt="" /></a> -->
											<h3>
												<a href="SellerPermit.jsp">판매자신청</a>
											</h3>
										</article>
									</li>
									<%
										}
									%>
									<li>
										<article class="box post-excerpt">
											<!-- <a href="#" class="image left"><img src="images/pic10.jpg" alt="" /></a> -->
											<h3>
												<a href="delete.jsp?mId=<%=id%>">회원탈퇴</a>
											</h3>
										</article>
									</li>
								</ul>
								<!-- <a href="#" class="button style1">Archives</a> -->
							</section>
						</div>

					</div>
					<div class="col-8 col-12-medium imp-medium">
						<div class="container">
							<!-- Content -->
							<div id="content">
								<article class="box post">
									<header class="style1">
										<!-- <h2>비밀번호변경</h2> -->
									</header>
									<div align="center">
										<!-- 서브밋 하기전 체크 -->
										<form action="password.jsp" onsubmit="check()">
											<div class="col-6 col-12-small">
												<input type="password" name="current" id="current"
													placeholder="현재비밀번호" style="width: 380px"><br>
											</div>
											<div class="col-6 col-12-small">
												<input type="password" name="pw" id="pw"
													placeholder="변경할 비밀번호" style="width: 380px"
													onchange="pwCheck()"><span id="pwSign"
													style="color: red"></span> <br>
											</div>
											<div class="col-6 col-12-small">
												<input type="password" name="pw" id="rpw"
													placeholder="한번 더 입력" style="width: 380px"
													onchange="rpwCheck()"><span id="rpwSign"
													style="color: red"></span> <br>
											</div>
											<input type="submit" value="확인" class="button style1"
												style="width: 380px">
										</form>
									</div>
								</article>
							</div>
						</div>

					</div>
				</div>
			</div>
		</section>




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
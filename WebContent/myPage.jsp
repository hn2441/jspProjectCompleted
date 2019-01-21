	<%@page import="bean.MemberDTO"%>
<%@page import="bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<!--
	Escape Velocity by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->

<html>
<head>
<title>마이 페이지</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<script type="text/javascript">
	/* 이름 완료버튼 */
	function activate() {
		document.getElementById("name").readOnly="true";
		 var name = document.getElementById("name").value; 
		 location.href = "updateMember.jsp?name=" + name; 
	}
	/* 이름 수정버튼 */
	function deactivate(){
		/* 수정가능하게 바꾸기 */
		document.getElementById("name").removeAttribute("readOnly");
	}
	/* 전화번호 완료버튼 */
 	function activate2() {
		document.getElementById("tel").readOnly="true";
		var name = document.getElementById("tel").value;
		location.href = "updateMember.jsp?tel=" + tel;
	} 
	/* 전화번호 수정버튼 */
	function deactivate2(){
		document.getElementById("tel").removeAttribute("readOnly");
	} 
	
</script>
<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body class="left-sidebar is-preload">
	<%
		/* 세션아이디와 정보세팅 */
		String sid = (String) session.getAttribute("id");
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = dao.select("id", sid);
		String id = dto.getId();
		String name = dto.getName();
		String tel = dto.getTel();
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
		<section id="main" class="wrapper style2">
			<div class="title">기본정보</div>
			<div class="container">
				<div class="row gtr-150">
					<div class="col-4 col-12-medium">

						<!-- Sidebar -->
						<div id="sidebar">
							<section class="box">
								<header>
									<h2><%=session.getAttribute("id")%></h2>
								</header>
								<p>이름 : <%=dto.getName() %></p>
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
									<!-- 판매자일경우 - 판매자페이지, 아닐경우 - 판매자 신청 -->
									<%
										if (dto.isCategory()) {
									%>
									<li>
										<article class="box post-excerpt">
											<!-- <a href="#" class="image left"><img src="images/pic10.jpg" alt="" /></a> -->
											<h3>
												<a href="advSidList.jsp?nowPage=1">판매자페이지</a>
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
												<a href="delete.jsp?mId=<%= id%>">회원탈퇴</a>
											</h3>
										</article>
									</li>
								</ul>
								<!-- <a href="#" class="button style1">Archives</a> -->
							</section>
							<section class="box"></section>
						</div>

					</div>
					<div class="col-8 col-12-medium imp-medium">
						<div class="container">
							<!-- Content -->
							<div id="content">
								<article class="box post">
									<header class="style1">
										<h2>기본정보</h2>
									</header>
									<div align="center">
										<form action="" name="updateForm">
											<div class="col-6 col-12-small">
												아이디 : <input type="text" name="id" id="id"
													placeholder="<%=id%>" style="width: 380px" readonly><br>
											</div>
											<div class="col-6 col-12-small">
													<!-- 수정 - readonly제거, activate - 서버에 submit -->
												닉네임 : <input type="text" name="name" id="name"
													placeholder="<%=name%>" style="width: 380px" readonly="readonly">
													<input type="button" value = "설정" onclick="activate()">
													<input type="button" value = "수정 " onclick="deactivate()">
													<br><br>
											</div>
											<div class="col-6 col-12-small">
													<!-- 수정 - readonly제거, activate - 서버에 submit -->
												전화번호 : <input type="text" name="tel" id="tel"
													placeholder="<%=tel%>" style="width: 380px" readonly="readonly">
													 <input type="button" value = "설정" onclick="activate2()">
													<input type="button" value = "수정 " onclick="deactivate2()" > 
											</div>
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
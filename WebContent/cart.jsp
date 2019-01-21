<%@page import="bean.AdvDTO"%>
<%@page import="bean.AdvDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.CartDTO"%>
<%@page import="bean.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	메인화면에서 넘어오는 장바구니 or 찜하기
-->
<html>
<head>
<title>장바구니</title>
<meta charset="utf-8" />
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<%
	//카트 리스트
	CartDAO cdao = new CartDAO();
	CartDTO cdto = null;
	ArrayList<CartDTO> list = cdao.selectMyCart((String) session.getAttribute("id"));
	int count = list.size();

	//판매글 관련 
	AdvDAO adao = new AdvDAO();
	AdvDTO adto = null;
%>
</head>
<body class="no-sidebar is-preload">
	<div id="page-wrapper">

		<!-- Header -->
		<section id="header" class="wrapper">

			<!-- Logo -->
			<div id="logo">
				<h1><a href="index.html">찜하기 페이지</a></h1>
				<p><%=session.getAttribute("id") %>님의 찜하기 페이지입니다!</p>
			</div>

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
		<div id="main" class="wrapper style2">
			<div class="container">

				<!-- Content -->
				<div id="content">
					<article class="box post">
						<header class="style1">
						</header>
						<div class="row gtr-150">
							<%
								// 판매자의 판매글 중 찜하기 한 부분 리스트 출력
								for (int i = count - 1; i >= 0; i--) {
									cdto = list.get(i);
									adto = adao.selectAdv(cdto.getAdno());
							%>
							<div class="col-6 col-12-small">
								<section class="box">
									<header>
										<h2><%=adto.getTitle()%></h2>
									</header>
									<a href="#" class="image featured"> <img
										src="<%=adto.getImg()%>" alt="" />
									</a>
									<p><%=adto.getPrice()%></p>
									<button class="button style1"
										onclick="location.href='adv.jsp?no=<%=cdto.getAdno()%>'">
										글 보러가기</button>
								</section>
							</div>
							<%
								}
							%>
						</div>
					</article>
				</div>
			</div>
		</div>
</body>
</html>


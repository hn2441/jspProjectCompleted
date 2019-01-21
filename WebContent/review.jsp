<%@page import="java.io.Console"%>
<%@page import="bean.SalesDAO"%>
<%@page import="bean.CartDTO"%>
<%@page import="bean.CartDAO"%>
<%@page import="bean.MemberDAO"%>
<%@page import="bean.MemberDTO"%>
<%@page import="bean.AdvDTO"%>
<%@page import="bean.AdvDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.ReviewDTO"%>
<%@page import="bean.ReviewDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	판매글을 올린 판매자에게 올라온 리뷰 전체를 출력해주는 페이지
-->
<html>
<head>
<title>리뷰페이지</title>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<style type="text/css">
/* 하트 */
#crud1 {
	text-decoration: none;
	float: right;
	font-size: 10px;
	text-align: right;
	display:
}

#heart {
	position: relative;
	width: 25px;
	height: 22.5px;
}

#heart:before, #heart:after {
	position: absolute;
	content: "";
	left: 12.5px;
	top: 0px;
	width: 12.5px;
	height: 20px;
	background: #f98780;
	border-radius: 12.5px 12.5px 0 0;
	transform: rotate(-45deg);
	transform-origin: 0 100%
}

#heart:after {
	left: 0;
	transform: rotate(45deg);
	transform-origin: 100% 100%;
}

#heart:hover {
	background: #fcc8c4;
	width: 30px;
	height: 27px;
}

/* 버튼스타일 */
input[type="button"], input[type="submit"], input[type="reset"], button.style99,
	.button.style99 {
	-moz-transition: all .25s ease-in-out;
	-webkit-transition: all .25s ease-in-out;
	-ms-transition: all .25s ease-in-out;
	transition: all .25s ease-in-out;
	display: inline-block;
	background: #444;
	text-align: center;
	text-transform: uppercase;
	font-weight: 700;
	letter-spacing: 0.25em;
	text-decoration: none;
	border-radius: 0.35em;
	border: 0;
	outline: 0;
	cursor: pointer;
	padding: 0 1em 0 1em;
	font-size: 0.9em;
	min-width: 5em;
	height: 2em;
	line-height: 2em;
}

input[type="button"]:hover, input[type="submit"]:hover, input[type="reset"]:hover,
	button:hover, .button.style99:hover {
	background-color: #f98780;
}

input[type="button"].large, input[type="submit"].large, input[type="reset"].large,
	button.style99.large, .button.style99.large {
	font-size: 1em;
	min-width: 14em;
}

input[type="button"].style99, input[type="submit"].style99, input[type="reset"].style99,
	button.style99, .button.style99 {
	background: #e97770 url("images/overlay.png");
	color: #fff;
}

input[type="button"].style99:hover, input[type="submit"].style99:hover,
	input[type="reset"].style99:hover, button.style99:hover, .button.style99:hover
	{
	background-color: #f98780;
}

input[type="button"].style99:active, input[type="submit"].style99:active,
	input[type="reset"].style99:active, button.style99:active, .button.style99:active
	{
	background-color: #d96760;
}
</style>
<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body class="right-sidebar is-preload">
	<%
		//판매글 불러오는 페이지
		int adno = Integer.parseInt(request.getParameter("adno"));

		//판매글 불러오는 페이지
		AdvDAO adao = new AdvDAO();
		AdvDTO adto = null;
		adto = adao.selectAdv(adno);

		//네임카드에 올릴 개인정보
		MemberDAO mdao = new MemberDAO();
		MemberDTO mdto = null;

		//결제여부에 따른 이메일 출력
		SalesDAO sdao = new SalesDAO();

		//리뷰 출력
		ReviewDAO rdao = new ReviewDAO();
		ReviewDTO rdto = null;

		//판매자 아이디
		String sid = adto.getSid();
		//리뷰 전체 리스트
		ArrayList<ReviewDTO> list = rdao.selectSidReview(sid);
		int count = list.size();

		//찜하기
		CartDAO cdao = new CartDAO();
		CartDTO cdto = null;

		//Sales테이블의 결제 개수가 Review테이블의 결제 개수보다 많을 경우만 '리뷰작성'버튼이 보임	
		//한 구매자가 한 판매자의 상품을 결제한 갯수만큼 리뷰를 쓸 수 있음
		//Sales테이블의 결제 개수가 1회 이상일 경우 판매자의 아이디(이메일)을 출력해줌
		int ckS = sdao.selectCheckPayment(sid, (String) session.getAttribute("id"));
		int ckR = rdao.selectCheckPayment(sid, (String) session.getAttribute("id"));
	%>
	<div id="page-wrapper">

		<!-- Header -->
		<section id="header" class="wrapper">

			<!-- Logo -->
			<div id="logo">
				<h1><a href="#">리뷰 리스트 입니다.</a></h1>
				<p><%=sid %>님의 고객리뷰 페이지 입니다.</p>
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
		<section id="main" class="wrapper style2">
			<div class="container">
				<div class="row gtr-150">
					<div class="col-8 col-12-medium">

						<!-- Content -->
						<div id="content">
							<article class="box post">
								<header class="style1">
									<h2><%=adto.getTitle()%></h2>
								</header>
								<div>
									<ul class="style2">
										<li>
											<%
												
											%>

										</li>
										<%
											//모든 리뷰를 출력해줌
											for (int i = 0; i < count; i++) {
										%><li style="font-size: 17px">
											<article>
												<h3>
													<%
														rdto = list.get(count - 1 - i);
															String mid = rdto.getMid();
															String mid2 = "";
															int rvno = rdto.getNo();
															System.out.println("rvno : " + rvno);
															//리뷰 작성자 아이디중 앞에 2글자만 그대로 출력하고 나머지는 *로 출력해줌
															for (int j = 0; j < mid.length(); j++) {
																if (j > 1) {
																	mid2 += "*";
																} else {
																	mid2 += mid.charAt(j);
																}
															}
													%>
													<a href="#"> <%=count - i%>
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=mid2%> | 별점 <%
 	int starsc = rdto.getStarsc();
 		for (int j = 0; j < 5; j++) {
 			if (j < starsc) {
 				out.print("★");
 			} //end if
 		} //end for
 %></a>

													<div align="right" style="font-size: 14px; color: blue">
														<%
															//본인이 쓴 글은 수정삭제 가능, 판매자는 본인글에 해당하는 모든 리뷰 삭제할 수 있음
																if (rdto.getMid().equals((String) session.getAttribute("id"))) {
														%>
														<form action="reviewEditor_update.jsp" method="post">
															<%
																if (ckS > 0) {
															%>
															<input type="hidden" name="sid" value="<%=sid%>">
															<input type="hidden" name="adno" value="<%=adno%>">
															<input type="hidden" name="rvno" value="<%=rvno%>">
															<button class="button style99">
																<font style="font-size: 15px;">수정</font>
															</button>
															<%
																}
															%>
															<a href="reviewEditor_delete_ok.jsp?adno=<%=rvno%>"
																class="button style99"> 삭제</a>
														</form>
														<%
															} else if (rdto.getSid().equals((String) session.getAttribute("id"))) {
														%>
														<a
															href="reviewEditor_delete_ok.jsp?rvno=<%=rvno%>&adno=<%=adno%>">삭제</a>
														<%
															} //end if
														%>
													</div>
												</h3>
												<p><%=rdto.getContent()%></p>
											</article>
										</li>
										<%
											} //end for
										%>
										<li><a href="adv.jsp?no=<%=adno%>">이전화면으로..</a></li>
									</ul>
								</div>
							</article>
						</div>

					</div>
					<div class="col-4 col-12-medium">

						<!-- Sidebar -->
						<div id="sidebar">
							<section class="box">
								<header>
									<%
										mdto = mdao.selectNameCard(sid);
									%>
									<div align="center">
										<!-- 세션에 아이디값이 있는 경우에만 보입니다. -->
										<%
											if (session.getAttribute("id") != null) {
										%>
										<a id="heart"
											href="cartEditor.jsp?adno=<%=adno%>&id=<%=session.getAttribute("id")%>"></a>
										<%
											}
										%>
									</div>
									<p style="font-size: 20px; color: black;">
										<b>네임카드</b>
									</p>
								</header>
							</section>
							<section class="box">
								<ul class="style2">
									<li>
										<div align="left">
											<!--닉네임만 출력 -->
											<h3>
												닉네임 :
												<%=mdto.getName()%></h3>
											<!-- 결제를 했을 경우만 판매자 연락처 띄워줌 -->
											<%
												if (ckS > 0) {
											%>
											<h3>
												연락처 :
												<%=sid%></h3>
											<%
												} //end if
											%>
										</div>
									</li>
								</ul>
								<br> <a href="bbs.jsp" class="button style1">주문하기</a>
							</section>
						</div>
					</div>
				</div>
			</div>
		</section>
</body>
</html>
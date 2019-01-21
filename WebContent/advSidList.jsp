<%@page import="java.util.ArrayList"%>
<%@page import="bean.AdvDTO"%>
<%@page import="bean.AdvDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	판매글 리스트 페이지. 판매자 마이페이지와 메인화면에서 넘어옴.
	로그인 한 판매자 본인의 판매글들을 띄워줍니다.
-->
<html>
<head>
<title>판매글 리스트</title>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body class="no-sidebar is-preload">
	<%
		//판매글 리스트에 올릴 정보
		AdvDAO adao = new AdvDAO();
		AdvDTO adto = null;
		//판매글 개수
		ArrayList<AdvDTO> list = adao.selectMyAdv((String) session.getAttribute("id"));
		int count = list.size();
		//판매글을 4개씩 나눠서 페이징 - 4로 나눠 남는 판매글이 있으면 1 추가
		int pageCount = 0;
		if (count % 4 == 0) {
			pageCount = count / 4;
		} else {
			pageCount = (count / 4) + 1;
		}
		//지금 페이지값 받아오기
		int nowPage = Integer.parseInt(request.getParameter("nowPage"));
	%>
	<div id="page-wrapper">

		<!-- Header -->
		<section id="header" class="wrapper">

			<!-- Logo -->
						<!-- Logo -->
			<div id="logo">
				<h1><a href="#">판매글 리스트</a></h1>
				<p><%=session.getAttribute("id") %>님의 판매글 목록입니다!</p>
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
			<div></div>
		</section>

		<!-- Main -->
		<div id="main" class="wrapper style2">
			<div class="container">

				<!-- Content -->
				<div id="content">
					<article class="box post">
						<header class="style1">
							<p align="right">
								<a href="saleEditor_insert.jsp">판매글 쓰기</a>
							</p>
						</header>
						<div class="row gtr-150">
							<%
								// 판매자의 판매글 리스트 출력
								// start는 지금 페이지의 첫번째 번호
								// end는 지금 페이지의 마지막 인덱스
								int start = (nowPage - 1) * 4;
								int end = nowPage * 4;
								if ((pageCount == nowPage) && (count % 4 != 0)) {
									end = start + count % 4;
								}
								for (int i = start; i < end; i++) {
									adto = list.get(i);
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
										onclick="location.href='adv.jsp?no=<%=adto.getNo()%>'">
										글 보러가기</button>
								</section>
							</div>
							<%
								}
							%>
						</div>
					</article>
					<div align="center"
						style="font-size: 18px; padding: 5%; height: 10%'">
						<%
							//지금페이지가 1이 아닐경우만 '이전'을 띄워주고, 지금 페이지가 마지막 페이지가 아닐 경우에만 '다음'을 띄워줌
							if (nowPage > 1) {
						%>
						<a href="advSidList.jsp?nowPage=<%=nowPage - 1%>">이전</a>
						<%
							}
						%>
						&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
						<%=nowPage%>
						&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
						<%
							if (nowPage < pageCount) {
						%>
						<a href="advSidList.jsp?nowPage=<%=nowPage + 1%>">다음</a>
						<%
							}
						%>
					</div>

				</div>
			</div>
		</div>
	</div>
</body>
</html>


<%@page import="java.util.Date"%>
<%@page import="javax.swing.text.Style"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.*"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<!DOCTYPE HTML>
<!--
	Escape Velocity by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<title>IT 개발자들을 위한 프리랜서 마켓</title>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />

<!-- 메인 페이지 자동 새로고침 10초 마다 한 번씩 -->
<meta http-equiv="refresh" content="10">
<link rel="stylesheet" href="assets/css/main1.css" />
</head>

<body class="homepage is-preload">

	<div id="page-wrapper">

		<!-- Header -->
		<section id="header" class="wrapper">

			<!-- Logo -->
			<div id="logo">
				<form action="search.jsp">
					<input type="text" name="search" id="search"
						style="width: 500px; margin: auto;"><br> <input
						type="submit" value="검색">
				</form>
			</div>

			<!-- Nav: 사이트에서 주요한 네비게이션 역할을 하는 링크 그룹을 담을 때 사용 -->
			<nav id="nav">
				<ul>
				<% if(session.getAttribute("id")!=null){
				if(session.getAttribute("id").equals("admin@naver.com")) {%>
					<li><a href="adminPage.jsp">관리자페이지</a></li>
					<%}} %>
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
		</section>


		<!-- Highlights -->
		<section id="highlights" class="wrapper style3">

			<div style="align-content: center; margin: auto; width: 500px;">

				<% 
						/* TOP 검색어(오늘 날짜 기준) */
						searchDAO sDao = new searchDAO();
						searchDTO sDto = new searchDTO();
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
						Date day = new Date();
						String today = formatter.format(day);
					%>
				<h3 align="center"><%= today %></h3>
				<br>
				<h3 align="center">검색어 TOP 5</h3>
				<%
						ArrayList<searchDTO> sList = sDao.topFive(today);
					
						for(int i = 0; i < sList.size(); i++) {
							sDto = new searchDTO();
							sDto = sList.get(i);
							
					%>
				<!-- 검색 순위 출력 -->
				<h3 align="center"><%= i+1 + " 위"%>
					&nbsp; <a href="search.jsp?search=<%= sDto.getSearch() %>"><%= sDto.getSearch() %></a>
				</h3>
				<% 							
						} 
					%>
			</div>
			<!-- end TOP 검색어 -->

			<div class="title">The Endorsements</div>
			<% 
					/* 상품 랜덤 출력  */
						        Random ran = new Random();
                  AdvDAO dao = new AdvDAO();
                  ArrayList<AdvDTO> list = dao.number();

                  int ranNum1=0;
                  int ranNum2=0;
                  int ranNum3=0;
                  
                  AdvDTO ranlist1 = null;
                  AdvDTO ranlist2 = null;
                  AdvDTO ranlist3 = null;

                  while(true) {
                     ranNum1 = ran.nextInt(list.size()) + 1;
                     ranNum2 = ran.nextInt(list.size()) + 1;
                     ranNum3 = ran.nextInt(list.size()) + 1;
                     
                     ranlist1 = dao.randomPro(ranNum1);
                     ranlist2 = dao.randomPro(ranNum2);
                     ranlist3 = dao.randomPro(ranNum3);
                     
                     while(ranlist1.getNo() == 0) {
                        ranNum1 = ran.nextInt(list.size()) + 1;
                        ranlist1 = dao.randomPro(ranNum1);
                     }
                     while(ranlist2.getNo() == 0) {
                        ranNum2 = ran.nextInt(list.size()) + 1;
                        ranlist2 = dao.randomPro(ranNum2);
                     }
                     while(ranlist3.getNo() == 0) {
                        ranNum3 = ran.nextInt(list.size()) + 1;
                        ranlist3 = dao.randomPro(ranNum3);
                     }
                     
                     if(ranNum1 != ranNum2 && ranNum2 != ranNum3 && ranNum1 != ranNum3) {
                        break;
                     }
                     
                  }
					%>

			<br>
			<br>
			<br>

			<!-- 상품 랜던 출력 결과 뿌리기 -->
			<div class="title">상 &nbsp; &nbsp; &nbsp; &nbsp; 품</div>
			<div class="container">
				<div class="row aln-center">
					<div class="col-4 col-12-medium">
						<section class="highlight">
							<h3 align="center">
								<a href="adv.jsp?no=<%= ranlist1.getNo() %>">상품: <%= ranlist1.getTitle() %></a>
							</h3>
							<a href="adv.jsp?no=<%= ranlist1.getNo() %>"
								class="image featured"><img src="<%= ranlist1.getImg() %>"
								width="350" height="300" /></a>
							<h3 align="center">
								<a href="adv.jsp?no=<%= ranlist1.getNo() %>">가격: <%= ranlist1.getPrice() %></a>
							</h3>
							<p></p>
						</section>
					</div>
					<div class="col-4 col-12-medium">
						<section class="highlight">
							<h3 align="center">
								<a href="adv.jsp?no=<%= ranlist2.getNo() %>">상품: <%= ranlist2.getTitle() %></a>
							</h3>
							<a href="adv.jsp?no=<%= ranlist2.getNo() %>"
								class="image featured"><img src="<%= ranlist2.getImg() %>"
								width="350" height="300" /></a>
							<h3 align="center">
								<a href="adv.jsp?no=<%= ranlist2.getNo() %>">가격: <%= ranlist2.getPrice() %></a>
							</h3>
							<p></p>
						</section>
					</div>
					<div class="col-4 col-12-medium">
						<section class="highlight">
							<h3 align="center">
								<a href="adv.jsp?no=<%= ranlist3.getNo() %>">상품: <%= ranlist3.getTitle() %></a>
							</h3>
							<a href="adv.jsp?no=<%= ranlist3.getNo() %>"
								class="image featured"><img src="<%= ranlist3.getImg() %>"
								width="350" height="300" /></a>
							<h3 align="center">
								<a href="adv.jsp?no=<%= ranlist3.getNo() %>">가격: <%= ranlist3.getPrice() %></a>
							</h3>
							<p></p>
						</section>
					</div>
				</div>
			</div>
			<!-- end 상품 랜덤 출력 -->

			<!-- 최근 본 상품 목록 -->
			<div id="recent">
				<table id="recentTable">
					<tr height="25">
						<td>최근 본 상품</td>
					</tr>
					<% 
					/* 등록 된 쿠키 값 가져오기 */
					Cookie[] cookies = request.getCookies();
					
					if(cookies != null) {
						for(int i = 0; i < cookies.length; i++) {
							if(! cookies[i].getName().equals("JSESSIONID")) {
								/* 쿠키가 4개 이상 존재시 첫 번째 쿠키 삭제 */
								if(cookies.length > 4) {
									cookies[1].setMaxAge(0);
									response.addCookie(cookies[1]);
								}
										
								/* 등록 된 쿠키에 해당하는 상품 정보 DB에서 가져오기 */
								String title = URLDecoder.decode(cookies[i].getName(), "UTF-8");
								AdvDTO dto = dao.selectTitle(title);
				%>
					<tr height="25">
						<td><h3>
								<a href="adv.jsp?no=<%= dto.getNo() %>"><%= URLDecoder.decode(cookies[i].getName(), "UTF-8") %></a>
							</h3></td>
					</tr>
					<tr height="130">
						<td><a href="adv.jsp?no=<%= dto.getNo() %>"><img
								src="<%= URLDecoder.decode(cookies[i].getValue(), "UTF-8") %>"
								height="120" width="180"></a></td>
					</tr>
				</table>
				<%
							}					
						}		
					}
				%>
			</div>
			<!-- end 최근 본 상품 목록 -->

		</section>
	</div>
</body>
</html>
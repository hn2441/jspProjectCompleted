<%@page import="java.util.Locale"%>
<%@page import="org.apache.tomcat.jni.Local"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.awt.List"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="bean.*"%>
<%@page import= "java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>IT 개발자들을 위한 프리랜서 마켓</title>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main1.css" />
	</head>
	<body class="homepage is-preload">
		<div id="page-wrapper">

			<!-- Header -->
			
				<section id="header" class="wrapper">
					
					<!-- Logo -->
					<div id="logo">
						<form action="search.jsp">
							<input type="text" name="search" id="search" style="width: 500px; margin: auto;"><br>
							<input type="submit" value="검색">
						</form>
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
				</section>
				
		<%		
			/* 연관 검색어 */
			String search = request.getParameter("search");
			int count = 0; // 검색어를 수치를 증가 시킬 변수
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
			Date day = new Date();
			String today = formatter.format(day);
			searchDTO sDto = null;
			
			/* 입력한 검색어가 DB에 있는지 확인 */
			searchDAO sDao = new searchDAO();
			sDto = sDao.select(search);
			
			/* 검색어가 DB에 있을 경우 --> 검색어 수치 1 증가 */
			if(search.equals(sDto.getSearch())) {
				/* DB에서 가져온 day가 오늘 날짜와 같은 경우 */
				if(today.equals(sDto.getDay())) {
					search = sDto.getSearch();
					count = sDto.getCount() + 1;
					
					sDto.setSearch(search);
					sDto.setCount(count);
					sDto.setDay(today);
					
					/* 검색어 수치 증가 */
					sDao.update(sDto);
					
				/* DB에서 가져온 day가 오늘 날짜와 다른 경우 */	
				} else {
					search = sDto.getSearch();
					count = 1;
					
					sDto.setSearch(search);
					sDto.setCount(count);
					sDto.setDay(today);
					
					/* 검색어 수치 1로 리셋 */
					sDao.update(sDto);
				}
				
			/* 검색어가 DB에 없을 경우 --> DB에 해당 검색어 등록 후 수치를 1로 지정 */
			} else if (sDto.getSearch() == null){
				count = 1;
				sDto.setSearch(search);
				sDto.setCount(count);
				sDto.setDay(today);
				
				/* 검색어 등록 */
				sDao.insert(sDto);
			}
			
		%>
			<section id="highlights" class="wrapper style3">
			
			<div class="title"><h3>검색 결과 </h3></div>
			<h3>입력한 검색어: <%= search %> </h3>
			<h3>연관 검색어:
			
		<% 
			/* DB에서 입력한 검색어를 포함한 모든 데이터를 불러옴 */
			ArrayList<searchDTO> sList = sDao.searchInc(search);
			
			/* 입력한 검색어가 없을 경우 */
			if(search.equals("")) {
		%>
				없음
		<% 
			/* 입력한 검색어가 있을 경우 */
			} else {
				for(int i = 0; i < sList.size(); i++) {
					sDto = new searchDTO();
					sDto = sList.get(i);
			%>
					&nbsp; 
					<a href="search.jsp?search=<%= sDto.getSearch() %>"><%= sDto.getSearch() %></a>
					&nbsp; &nbsp; &nbsp; &nbsp; 
			<% 
				} 
			}
		%>
				</h3> <!-- end 연관 검색어 -->
				
		<%
			/* 검색한 상품 목록 출력 */
			AdvDAO dao = new AdvDAO();
			ArrayList<AdvDTO> list = dao.search(search);
			AdvDTO dto = null;
		
			for(int i = 0; i < list.size(); i++) {
				dto = list.get(i);	
				if(dto.getTitle() == null) {
			%>			
				<h3>검색결과 없음</h3>
			<%			
				} else {
			%>
				<div class="container">
						<div style="float: left; margin: 25px; border: 2px solid; background-image: url('images/pic02.jpg'); background-size: 1000%">
								<br> <h3 align="center"><a href="adv.jsp?no=<%= dto.getNo() %>"> 상품: <%= dto.getTitle() %></a></h3> <br>
								<a href="adv.jsp?no=<%= dto.getNo() %>"><img src="<%= dto.getImg() %>" width="350" height="300"/></a> <br>
								<h3 align="center"><a href="adv.jsp?no=<%= dto.getNo() %>"> 가격: <%= dto.getPrice() %></a></h3> 
						</div>
			<%	
				}
			}
			
			%>
				</div> <!-- end 검색한 상품 목록 출력 -->
				
			<!-- 최근 본 상품 목록 -->
						
			<div id="recent">
				<table id="recentTable">
					<tr height="25">
						<td>최근 본 상품</td>
					</tr>
			<% 
				Cookie[] cookies = request.getCookies();
					
				if(cookies != null) {
					for(int i = 0; i < cookies.length; i++) {
						if(! cookies[i].getName().equals("JSESSIONID")) {
							/* 쿠키가 4개 이상 존재시 첫 번째 쿠키 삭제 */
							if(cookies.length > 4) {
							cookies[1].setMaxAge(0);
							response.addCookie(cookies[1]);
							}
							
							String title = URLDecoder.decode(cookies[i].getName(), "UTF-8");
							dto = dao.selectTitle(title);
			%>			
					<tr height="25">
						<td><h3><a href="adv.jsp?no=<%= dto.getNo() %>"><%= URLDecoder.decode(cookies[i].getName(), "UTF-8") %></a></h3></td>
					</tr>
					<tr height="130">
						<td><a href="adv.jsp?no=<%= dto.getNo() %>"><img src="<%= URLDecoder.decode(cookies[i].getValue(), "UTF-8") %>" height="120" width="180"></a></td>
					</tr>
				</table>
			<%
							}					
						}
					}
			%>
			</div> <!-- end 최근 본 상품 목록 -->
			
		</section>
	</div>
	</body>
</html>
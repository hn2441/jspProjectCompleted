<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.BBSDTO"%>
<%@page import="bean.BBSDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>등록한 글</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<script type="text/javascript">
		
		//게시판 업데이트시 값 전달하는 함수
		function update() {
			var num = document.getElementById("num").getAttribute("value");
			var	title = document.getElementById("title").value;
			var	write = document.getElementById("write").value;
			//var date = document.getElementById("date").value;
			//var view = document.getElemeentById("view").value;
			
			document.write(title + "<br>");
			document.write(write + "<br>");
			document.write(num);
			location.href="bbsSave2.jsp?&title=" + title + "&write=" + write +"&num=" + num;
			alert('수정완료');
		}
		
		</script>
	</head>
	<body class="no-sidebar is-preload" style="color:black">
		<div id="page-wrapper">

			<!-- Header -->
				<section id="header" class="wrapper">

					<!-- Logo -->
						<div id="logo">
							<h1>당신이 쓴 글</h1>
							<p>일단 보겠습니다.</p>
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
            <div>
            </div>
            </section>

			<!-- Main -->
				<div id="main" class="wrapper style2">
					<div class="title">글 보기</div> 
					<div class="container">
					<div style="text-align:center;">
						<table class = "bbs">
						<%	
							Date now = new Date();
							SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
							String date = sf.format(now);
							
							int num = request.getContentLength();
							String title = request.getParameter("title");
							String id = request.getParameter("id");
							String day = request.getParameter("date");
							int view = request.getContentLength();
							String write = request.getParameter("write");
							
							BBSDAO dao = new BBSDAO();
							BBSDTO dto = dao.select(title);			
						%>
							<tr>
								<td style ="width: 20%;">글 번호</td>
								<td colspan="2" id="num" value="<%= dto.getNum() %>"><%= dto.getNum() %></td>
							</tr>
							<tr>
								<td style ="width: 20%;">제목</td>
								<td colspan="2"><input type="text" id = "title" value="<%= dto.getTitle() %>"></td>
							</tr>
							<tr>
								<td style ="width: 20%;">작성자</td>
								<td colspan="2"><%= id %></td>
							</tr>
							<tr>
								<td style ="width: 20%;">작성한 날짜</td>
								<td colspan="2"><%= day %></td>
							</tr>
							<tr>
								<td style ="width: 20%;">조회수</td>
								<td colspan="2" id="view" value="<%= dto.getView() %>"><%= dto.getView() %></td>
							</tr>
							<tr>
								<td style ="width: 20%;">작성한 글</td>
								<%-- <td colspan="2"><input type="text" id = "write" value="<%= dto.getWrite() %>"></td> --%>
								<td><textarea rows="15" cols="80" id="write" value="<%= dto.getWrite() %>"><%= dto.getWrite() %></textarea></td>
							</tr>
							
					</table>
					<button type = "button" onclick="location.href='BBS.jsp' ">목록</button>
					<button type = "button">답글</button>
					<button type = "button" onclick="update();">수정</a></button>
					</div>
					</div>
				</div>
			</div>

	</body>
</html>
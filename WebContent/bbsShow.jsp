<%@page import="java.net.URLDecoder"%>
<%@page import="bean.BBSDTO2"%>
<%@page import="bean.BBSDAO2"%>
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
		
	//원글 수정시 값 전달하는 함수	
 	function update() {
			var	title = document.getElementById("title").getAttribute("value");
			var num = document.getElementById("num").getAttribute("value");			
			location.href="bbsUpdate.jsp?title=" + title + "&num=" + num + "&id=" + document.getElementById("id").innerHTML + "&date=" + document.getElementById("date").innerHTML;
			}
	
 	//답글 작성시 값 전달하는 함수
 	function answer() {
		var	title = document.getElementById("title").getAttribute("value");
		var num = document.getElementById("num").getAttribute("value");			
		location.href="BBSAnswer.jsp?title=" + title + "&num=" + num;
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
						<%	//---------------------------------게시판 원글 부분 값 -----------------------------------------------
							Date now = new Date();
							SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
							String date = sf.format(now);
							
							String title = request.getParameter("title");
							String write = request.getParameter("write");
							String id = request.getParameter("id");
							String id2 = request.getParameter("id2");
							int view = request.getContentLength();
							
							
							BBSDAO dao = new BBSDAO();
							
							BBSDTO dto = dao.select(title); //정보
							BBSDTO dto1 = dao.select2(title); //날짜가져오기
							dao.update(title);
						
							int num = dto.getNum();
							
							
						%>
							<tr>
								<td style ="width: 20%;">글 번호</td>
								<td colspan="2" id="num" value="<%= dto.getNum() %>"><%= dto.getNum() %></td>
							</tr>
							<tr>
								<td style ="width: 20%;">제목</td>
								<td colspan="2" id="title" value="<%= dto.getTitle() %>"><%= dto.getTitle() %></td>
							</tr>
							<tr>
								<td style ="width: 20%;">작성자</td>
								<td colspan="2" id ="id"><%= dto.getId() %></td>
							</tr>
							<tr>
								<td style ="width: 20%;">작성한 날짜</td>
								<td colspan="2" id="date" value ="<%= dto1.getDate() %>"><%= dto1.getDate() %></td>
							</tr>
							<tr>
								<td style ="width: 20%;">조회수</td>
								<td colspan="2" id="view" value="<%= dto.getView() %>"><%= dto.getView() %></td>
							</tr>
							<tr>
								<td style ="width: 20%;">작성한 글</td>
								<td colspan="2" id="write" value="<%= dto.getWrite() %>"><%= dto.getWrite() %></td>
							</tr>
					</table>
					
					
					
				답글<br>
					<%	//------------------------------------게시판 답글 부분 값-------------------------------------------------
						BBSDAO2 dao2 = new BBSDAO2();
						BBSDTO2 dto2 = dao2.select(num);
						//int num2 = Integer.parseInt(request.getParameter("num"));
						String title2 = request.getParameter("title");
						String write2 = request.getParameter("write");
						dto2 = dao2.select(num);
						
						
						//title2 = URLDecoder.decode(title2,"UTF-8");
						if(dto2.getWrite() == null) {
							write2 = " ";
							dto2.setDate(" ");
						}else{
						write2 = URLDecoder.decode(dto2.getWrite(),"UTF-8");
						}
						
					%>
					<table class = "bbs">
					<tr>
						<td style ="width: 20%;">글 번호</td>
						<td colspan = "2" ><%= dto.getNum() %></td>
					</tr>
					<tr>
						<td style ="width: 20%;">제목</td>
						<td colspan = "2"><%=title2 + "의 답글"%></td>
					</tr>
					<tr>
						<td style ="width: 20%;">작성자</td>
						<td colspan = "2" ><%= dto2.getId2() %></td>
					</tr>
					<tr>
						<th>작성일</th>
						<td colspan = "2" ><%= dto2.getDate() %></td>
					</tr>
					<tr>
						<td style ="width: 20%;">내용</td>
						<td colspan="5"><%= write2 %></td>
					</tr>
					</table>
					<button type = "button" onclick="location.href='BBS.jsp?write2=<%= write2 %>'" >목록</button>
					<button type = "button" onclick="answer();">답글</button>
					<button type = "button" onclick="update();">수정</button>
					</div>			
					</div>
				</div>
			</div>

	</body>
</html>
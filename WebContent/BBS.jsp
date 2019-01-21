<%@page import="bean.BBSDTO2"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.BBSDTO"%>
<%@page import="bean.BBSDAO"%>
<%@page import="bean.BBSDAO2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>판매자 게시판</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
	</head>
	
	<body class="no-sidebar is-preload" style="color:black">
		<script type="text/javascript">
		<%	
		BBSDAO dao = new BBSDAO();
		String id = request.getParameter("id");
		String id2 = request.getParameter("id2");
		session.setAttribute("id2", id2);
		%>
		
		//글 작성시 로그인 여부 체크 함수
			function check(){
				var id = '<%=(String)session.getAttribute("id") %>';
				var id2 = '<%=(String)session.getAttribute("id2") %>';
				
				if('<%=(String)session.getAttribute("id2") %>' != null){
					id2 = '<%=(String)session.getAttribute("id2") %>';
					var price = prompt("가격을 입력하세요");
					alert("글 작성을 시작합니다.");
					location.href = "BBSinput.jsp?id=" + id;
					//location.href = "payment.jsp?id2=" + id2 +"&price=" + price; -------한나씨 페이지로 값 넘김.
				}else if('<%=(String)session.getAttribute("id") %>' != null){
					id2 = '<%=(String)session.getAttribute("id") %>';
					alert("글 작성을 시작합니다.");
					location.href = "BBSinput.jsp?id=" + id;
				}else{
				alert("로그인해주세요");
				//location.href = "#"; -----로그인 페이지
				}
			}
			
		</script>
		<div id="page-wrapper">

			<!-- Header -->
				<section id="header" class="wrapper">

					<!-- Logo -->
						<div id="logo">
							<h1>판매자페이지</h1>
							<p>궁금하신 점은 게시판에 글을 남겨주세요.</p>
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
					
					<div class="title">게시판</div> 
					<div class="container">
					<div style="text-align:center;">
						<table class = "bbs">
						<!-- <colgroup>
							<col width = "100">
							<col width = "500">
							<col width = "100">
							<col width = "200">
							<col width = "50">
						</colgroup> -->
							 <tr align ="center">
							 	<td width="150"><strong>번&nbsp;&nbsp;&nbsp;호</strong></td> 
								<td width="200"><strong>제&nbsp;&nbsp;&nbsp;목</strong></td>
								<td width="150"><strong>글&nbsp;쓴&nbsp;이&nbsp;</strong></td>
								<td width="100"><strong>날&nbsp;&nbsp;&nbsp;짜</strong></td>
								<td width="100"><strong>조회수</td>
							</tr>
							
						<%	
							//게시판 메인에 게시글 목록띄우는 것
							BBSDAO2 dao2 = new BBSDAO2();
							ArrayList<BBSDTO> list = dao.selectAll();
							BBSDTO dto = null;
							BBSDTO2 dto2 = null;
							
							for(int i = 0; i < list.size(); i++){
								dto = list.get(i);
								dto2 = dao2.select(dto.getNum());
								dto2.setNum(dto.getNum());
						%>
							<tr>
								<td><%= dto.getNum()%></td>
								<td><a href= "bbsShow.jsp?title=<%= dto.getTitle()%>&num=<%= dto2.getNum() %>"><%= dto.getTitle()%></a></td>
								<td><%= dto.getId()%></td>
								<td><%= dto.getDate()%></td>
								<td><%= dto.getView()%></td>
							</tr>
						<%		
							}
						%>
					</table>
					<button type = "button" onclick="check();">주문하기</button>
					<button type = "button" onclick="location.href='main.jsp'">되돌아가기</button>
					</div>
					</div>
				</div>
			</div>

	</body>
</html>
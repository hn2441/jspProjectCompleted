<%@page import="bean.ReviewDAO"%>
<%@page import="bean.ReviewDTO"%>
<%@page import="bean.AdvDTO"%>
<%@page import="bean.AdvDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	리뷰 수정 페이지
-->
<html>
<head>
<title>리뷰 에디터 페이지 입니다.</title>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<style type="text/css">
input[type="radio"] {
	display: none;
}

input[type="radio"] {
	display: inline-block;
	width: 19px;
	height: 19px;
	margin: -2px 10px 0 0;
	vertical-align: middle;
	background: url(check_radio_sheet.png) left top no-repeat;
	cursor: pointer;
}

input[type="radio"] {
	background: url(check_radio_sheet.png) -19px top no-repeat;
}
</style>
<script type="text/javascript">
		/* 빈칸 확인하는 함수 */
		function checkEmpty(){
			var content = document.getElementById("content").value;
			var starsc = document.getElementById("starsc").value;
			
			/* 빈칸 있을시 알림 띄워줌 */
			if(content=="" || starsc==""){
				alert("빈칸이 있습니다. 확인해주세요.");
				return false;
			}else{
				return true;
			}
		}
	</script>
</head>
<body class="no-sidebar is-preload">
	<%
	String mid = (String)session.getAttribute("id");
	String sid = request.getParameter("sid");
	int adno = Integer.parseInt(request.getParameter("adno"));
	int rvno = Integer.parseInt(request.getParameter("rvno"));
	
	//판매글 제목 불러오는 페이지
	AdvDAO adao = new AdvDAO();
	AdvDTO adto = adao.selectAdv(adno);
	
	//리뷰 내용 불러오는 페이지
	ReviewDAO rdao = new ReviewDAO();
	ReviewDTO rdto = rdao.selectReview(rvno);
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
						<header class="style1"> </header>
						<div align="center">
							<form action="reviewEditor_update_ok.jsp" method="post">
								<table>
									<tr>
										<td style="width: 150px;"></td>
										<td style="width: 20px;">판</td>
										<td style="width: 20px;">매</td>
										<td style="width: 20px;">글</td>
										<td style="width: 20px;">제</td>
										<td style="width: 20px;">목</td>
										<td colspan="4"><input type="text" name="title"
											readonly="readonly" style="width: 600px;"
											value=<%=adto.getTitle() %>></td>
									</tr>
									<tr>
										<td colspan="8" style="height: 10px"></td>
									</tr>
									<tr>
										<td style="width: 150px;"></td>
										<td style="width: 20px;">리</td>
										<td style="width: 20px;"></td>
										<td style="width: 20px;"></td>
										<td style="width: 20px;"></td>
										<td style="width: 15px;">뷰</td>
										<td colspan="4">
											<textarea id="content" name="content" style="height: 200px;"><%=rdto.getContent() %></textarea>
										</td>
									</tr>
									<tr>
										<td colspan="6" style="width: 250px;"></td>
										<td colspan="4">
											<% for(int i=5;i>0;i--){%> <input type="radio" id="starsc"
											name="starsc" value="<%=i %>"
											<%//StarSC(별점)의 값이 i랑 같을때만 checked를 해줌
												if(rdto.getStarsc()==i){ %>
											checked="checked" <%} %> style="visibility: visible;">
											<font style="color: #e5b624"> <%for(int j=i;j>0;j--){ %>
												★ <%} %>
										</font> <%	}//outer for	
										%>
										</td>
									</tr>
									<tr>
										<td colspan="8" style="height: 50px"></td>
									</tr>
									<tr>
										<td style="width: 150px;"></td>
										<td colspan="8">
											<div align="center" style="width: 700px;">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="hidden"
													name="sid" value="<%=sid%>"> <input type="hidden"
													name="adno" value="<%=adno%>"> <input type="hidden"
													name="rvno" value="<%=rvno%>"> <input type="hidden"
													name="date" value="<%=rdto.getDate()%>"> <input
													type="submit" value="수정" class="button style1"
													onclick="return checkEmpty()">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="reset"
													class="button style1">
											</div>
										</td>

									</tr>
								</table>
							</form>
						</div>
					</article>
				</div>

			</div>
		</div>
</body>
</html>
<%@page import="bean.BBSDTO2"%>
<%@page import="bean.BBSDAO2"%>
<%@page import="bean.BBSDTO"%>
<%@page import="bean.BBSDAO"%>
<%@page import="bean.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Escape Velocity by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<style>
table, th, td {
	border: 1px solid black;
}
</style>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<title>관리자페이지</title>
<link rel="stylesheet" href="assets/css/main.css" />

<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
	var queryObject = "";
	var queryObjectLen = "";
	$.ajax({
		type : 'POST',
		url : 'googleChart.jsp',
		dataType : 'json',
		success : function(data) {
			queryObject = eval('(' + JSON.stringify(data, null, 2) + ')');
			// stringify : 인자로 전달된 자바스크립트의 데이터(배열)를 JSON문자열로 바꾸기.   
			// eval: javascript 코드가 맞는지 검증하고 문자열을 자바스크립트 코드로 처리하는 함수 
			// queryObject.barlist[0].city ="korea"

			queryObjectLen = queryObject.barlist.length;
			// queryObject.empdetails 에는 4개의 Json 객체가 있음 

			/* alert('연도 : ' + queryObject.barlist[0].visitDate.substr(0, 4)
					+ " 월 : " + queryObject.barlist[0].visitDate.substr(5, 2)
					+ " 일 : " + queryObject.barlist[0].visitDate.substr(8, 2)); */
			// alert(queryObject.barlist[0].city +queryObject.barlist[0].per );
			/* var visitDate = queryObject.barlist[0].visitDate;
			var year = visitDate.substr(0,3);
			var month = secDate.substr(5,6);
			var day = secDate.substr(8,9);
			
			alert('연도' + visitDate); */
		},
		/* error : function(xhr, type) {
			alert('server error occoured'); */

		error : function(request, status, error) {
			alert("code = " + request.status + " message = "
					+ request.responseText + " error = " + error); // 실패 시 처리
		}
	});
	google.charts.load('current', {
		'packages' : [ 'bar' ]
	});
	google.charts.setOnLoadCallback(drawChart);

	function drawChart() {
		var data = new google.visualization.DataTable();
		data.addColumn('date', 'visitDate');
		data.addColumn('number', 'amount');
		/* data.addRows([
		   [new Date(2000, 8, 5),2] 
		]); */

		//alert('data생성');
		for (var i = 0; i < queryObjectLen; i++) {
			var visitDate = queryObject.barlist[i].visitDate;
			var year = visitDate.substr(0, 4);
			var month = visitDate.substr(5, 2) - 1;
			var day = visitDate.substr(8, 2);

			var count = queryObject.barlist[i].count;
			//alert(city + amount + per);
			data.addRows([ [ new Date(year, month, day), count ] ]);
		}

		var options = {
			chart : {
				title : '접속 통계',
			}
		};

		var chart = new google.charts.Bar(document
				.getElementById('columnchart_material'));

		chart.draw(data, google.charts.Bar.convertOptions(options));
	}
</script>

</head>

<body class="no-sidebar is-preload">


	<div id="page-wrapper">

		<!-- Header -->
		<section id="header" class="wrapper">

			<!-- Logo -->
			<div id="logo">
				<h1>
					<a href="index.html">관리자 페이지</a>
				</h1>
			</div>

			<!-- Nav -->
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
			<!-- <div class="title">No Sidebar</div> -->
			<div class="container">

				<!-- Content -->
				<div id="content">

					<article class="box post">
						<header class="style1">
							<!-- 	<h2>관리자 페이지</h2> -->
						</header>
						<hr style="border: solid 3px lightblue;">
						<div align="center">
							<div id="columnchart_material"
								style="width: 800px; height: 500px;"></div>
						</div>
						<hr style="border: solid 3px lightblue;">
						<!-- 회원목록 -->
						<%
							/* memberDAo 호출 */
							MemberDAO mDao = new MemberDAO();
							ArrayList<MemberDTO> mList = mDao.selectAll();
							/* out.print("전체 회원수 : " + mList.size() + "<br>"); */
						%>

						<h2>
							전체 회원수 :
							<%=mList.size()%></h2>
						<hr style="border: solid 1px black">
						<!-- 멤버 표현해주는 테이블 -->
						<table>
							<tr>
								<td>아이디</td>
								<td>닉네임</td>
								<td>전화번호</td>
								<td>삭제</td>
							</tr>
							<%
								/* 페이징 */
								int pageNum = 0; //페이지넘버
								int startNum = 0; //시작인덱스
								int lastNum = 0; //페이지 끝 인덱스
								int rest; //10으로 나눴을때 나머지값으로 마지막페이지에 표시할 값
								/* 1페이지호출 */
								if (request.getParameter("page") == null || Integer.parseInt(request.getParameter("page")) == 1) {
									startNum = 0;
									if (mList.size() % 10 > 1) {
										lastNum = +startNum + 10;
									} else {
										rest = mList.size() % 10;
										lastNum = +startNum + rest;
									}
									/* 2페이지~호출 */
								} else if (request.getParameter("page") != null) {
									pageNum = Integer.parseInt(request.getParameter("page"));
									startNum = (pageNum - 1) * 10;
									rest = mList.size() % 10;
									lastNum = startNum + rest;
								}
								/* for문으로 리스트가져오기 */
								for (int i = startNum; i < lastNum; i++) {
									MemberDTO mDto = mList.get(i);
							%>
							<tr>
								<td><%=mDto.getId()%></td>
								<td><%=mDto.getName()%></td>
								<td><%=mDto.getTel()%></td>
								<td><a href="delete.jsp?mId=<%=mDto.getId()%>">삭제</a></td>
							</tr>
							<%
								}
							%>
						</table>
						<div align="center">
							페이지 : &nbsp;&nbsp;&nbsp;&nbsp;
							<%
								/* 페이지 수 적기 */
								for (int j = 0; j < mList.size() / 10 + 1; j++) {
							%>
							<a href="adminPage.jsp?page=<%=j + 1%>"><font size="5">&nbsp;&nbsp;&nbsp;&nbsp;<%=j + 1%>&nbsp;&nbsp;&nbsp;&nbsp;
							</font></abbr></a> <a href=""></a>
							<%
								}
							%>
							<hr style="border: solid 3px lightblue;">
							<!-- 판매목록 -->
						</div>
						<%
							/* 판매글수 DAO와 개수 */
							BBSDAO bDao = new BBSDAO();
							ArrayList<BBSDTO> bList = bDao.selectAll();
							/* out.print("전체 판매글 수는 : " + bList.size() + "<br>"); */
						%>
						<h2>
							전체 판매수 :
							<%=bList.size()%></h2>
						<hr style="border: solid 1px black">
						<!-- 판매글수 테이블 -->
						<table>
							 <tr align ="center">
							 	<td width="150"><strong>번&nbsp;&nbsp;&nbsp;호</strong></td> 
								<td width="200"><strong>제&nbsp;&nbsp;&nbsp;목</strong></td>
								<td width="150"><strong>글&nbsp;쓴&nbsp;이&nbsp;</strong></td>
								<td width="100"><strong>날&nbsp;&nbsp;&nbsp;짜</strong></td>
								<td width="100">조회수</td>
								<td width="100">삭제</td>
								
							</tr>
							<%	
							//게시판 메인에 게시글 목록띄우는 것
							BBSDAO2 bDao2 = new BBSDAO2();
							ArrayList<BBSDTO> list = bDao.selectAll();
							BBSDTO bDto = null;
							BBSDTO2 bDto2 = null;
							
							for(int i = 0; i < bList.size(); i++){
								bDto = bList.get(i);
								bDto2 = bDao2.select(bDto.getNum());
								bDto2.setNum(bDto.getNum());
						%>
							<tr>
								<td><%= bDto.getNum()%></td>
								<td><a href= "bbsShow.jsp?title=<%= bDto.getTitle()%>&num=<%= bDto2.getNum() %>"><%= bDto.getTitle()%></a></td>
								<td><%= bDto.getId()%></td>
								<td><%= bDto.getDate()%></td>
								<td><%= bDto.getView()%></td>
								<td><a href="delete.jsp?bId=<%=bDto.getId()%>">삭제</a></td>
							</tr>
						<%		
							}
						%>
						</table>
					</article>
				</div>
			</div>
		</div>


		

					
				<div id="copyright">
					<ul>
						<li>&copy; Untitled.</li>
						<li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
					</ul>
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
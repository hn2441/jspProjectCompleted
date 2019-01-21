<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>오시는길</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	height: 100%;
}
/* Optional: Makes the sample page fill the window. */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body class="left-sidebar is-preload">
	<div id="page-wrapper">

		<!-- Header -->
		<section id="header" class="wrapper">

			<!-- Logo -->
			<div id="logo">
				<h1>
					<a href="index.html">오시는길</a>
				</h1>
				<p>서울특별시 금천구 가산동 벚꽃로 244 벽산디지털밸리</p>
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
	</div>
	<!-- Content -->
	<div id="map" ><!-- style="width: 70%;  padding-top: 500px" -->
	</div>
	<script>
		function initMap() {
			var myLatLng = {
				lat : 37.476957,
				lng : 126.885557
			};

			var map = new google.maps.Map(document.getElementById('map'), {
				zoom : 18,
				center : myLatLng
			});

			var marker = new google.maps.Marker({
				position : myLatLng,
				map : map,
				title : '서울특별시 금천구 가산동 벚꽃로 244 벽산디지털밸리'
			});
		}
	</script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDbSxM3Ds6DGZts102QW_pbb3324bxunFs&callback=initMap"
		async defer></script>

	<!-- Highlights -->

	<!-- Footer -->
	<section id="footer" class="wrapper">
		<div class="title">The Rest Of It</div>
		<div class="container">
			<header class="style1">
				<h2></h2>
			</header>
			<!-- <div class="row">
				<div class="col-6 col-12-medium">

					 Contact Form
					<section>
						<form method="post" action="#">
							<div class="row gtr-50">
								<div class="col-6 col-12-small">
									<input type="text" name="name" id="contact-name"
										placeholder="Name" />
								</div>
								<div class="col-6 col-12-small">
									<input type="text" name="email" id="contact-email"
										placeholder="Email" />
								</div>
								<div class="col-12">
									<textarea name="message" id="contact-message"
										placeholder="Message" rows="4"></textarea>
								</div>
								<div class="col-12">
									<ul class="actions">
										<li><input type="submit" class="style1" value="Send" /></li>
										<li><input type="reset" class="style2" value="Reset" /></li>
									</ul>
								</div>
							</div>
						</form>
					</section>

				</div>
				<div class="col-6 col-12-medium">

					Contact
					<section class="feature-list small">
						<div class="row">
							<div class="col-6 col-12-small">
								<section>
									<h3 class="icon fa-home">Mailing Address</h3>
									<p>
										Untitled Corp<br /> 1234 Somewhere Rd<br /> Nashville, TN
										00000
									</p>
								</section>
							</div>
							<div class="col-6 col-12-small">
								<section>
									<h3 class="icon fa-comment">Social</h3>
									<p>
										<a href="#">@untitled-corp</a><br /> <a href="#">linkedin.com/untitled</a><br />
										<a href="#">facebook.com/untitled</a>
									</p>
								</section>
							</div>
							<div class="col-6 col-12-small">
								<section>
									<h3 class="icon fa-envelope">Email</h3>
									<p>
										<a href="#">info@untitled.tld</a>
									</p>
								</section>
							</div>
							<div class="col-6 col-12-small">
								<section>
									<h3 class="icon fa-phone">Phone</h3>
									<p>(000) 555-0000</p>
								</section>
							</div>
						</div>
					</section>

				</div>
			</div>
			<div id="copyright">
				<ul>
					<li>&copy; Untitled.</li>
					<li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
				</ul> -->
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
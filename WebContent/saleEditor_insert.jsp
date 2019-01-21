<%@page import="bean.CartDTO"%>
<%@page import="bean.CartDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.ReviewDTO"%>
<%@page import="bean.ReviewDAO"%>
<%@page import="bean.SalesDAO"%>
<%@page import="bean.MemberDTO"%>
<%@page import="bean.MemberDAO"%>
<%@page import="bean.AdvDTO"%>
<%@page import="bean.AdvDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	판매글 입력 페이지
	판매자가 자신의 판매글 리스트에서만 들어올 수 있음

-->
<html>
<head>
<title>판매 입력 페이지 입니다.</title>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<style type="text/css">
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
}
</style>

<link rel="stylesheet" href="assets/css/main.css" />
<script type="text/javascript">
	/* 빈칸 확인하는 함수 */
	function checkEmpty() {
		var title = document.getElementById("title").value;
		var price = document.getElementById("price").value;
		var content = document.getElementById("content").value;
		var img = document.getElementById("img").value;

		/* 빈칸 있을시 알림 띄워줌 */
		if (title == "" || price == "" || content == "" || img == "") {
			alert("빈칸이 있습니다. 확인해주세요.");
			return false;
		} else {
			return true;
		}
	}
</script>
</head>
<body class="right-sidebar is-preload">
	<%
	//판매자 아이디 - 로그인한 판매자 본인 아이디 받아옴 		
	String sid = (String)session.getAttribute("id");
	
	//네임카드에 올릴 판매자 정보가 필요해서 호출함
	MemberDAO mdao = new MemberDAO();
	MemberDTO mdto = null; 
	
	//결제여부가 확인되면 구매자에게 판매지 이메일을 네임카드 위에 출력
	SalesDAO sdao = new SalesDAO();
	
	//리뷰
 	ReviewDAO rdao = new ReviewDAO();
	ReviewDTO rdto = null;
	//판매자 아이디에 해당하는 리뷰 개수
	ArrayList<ReviewDTO> list = rdao.selectSidReview(sid);
	int count = list.size();
	
	//찜하기
	CartDAO cdao = new CartDAO();
	CartDTO cdto = null;
	
	//Sales테이블의 결제 개수가 Review테이블의 결제 개수보다 많을 경우만 '리뷰작성'버튼이 보임	
	//한 구매자가 한 판매자의 상품을 결제한 갯수만큼 리뷰를 쓸 수 있음
	//Sales테이블의 결제 개수가 1회 이상일 경우 판매자의 아이디(이메일)을 출력해줌
	//ckS : Sales 테이블 체크, ckR : 리뷰 테이블 체크
	int ckS = sdao.selectCheckPayment(sid,(String)session.getAttribute("id"));
	int ckR = rdao.selectCheckPayment(sid,(String)session.getAttribute("id"));
	
	%>
	<div id="page-wrapper">

		<!-- Header -->
		<section id="header" class="wrapper">

			<!-- Logo -->
			<div id="logo">
				<h1><a href="#">판매글 페이지</a></h1>
				<p><%=sid %>님의 판매글 입력페이지입니다!</p>
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
								<header class="style1"> </header>
								<div class="row gtr-150">
									<div class="col-6 col-12-small">
										<form id="temp" method="post"
											action="saleEditor_insert_ok.jsp"
											enctype="multipart/form-data">
											<table style="width: 200%">
												<tr>
													<td style="width: 2%">제</td>
													<td style="width: 2%;"></td>
													<td style="width: 2%;"></td>
													<td style="width: 2%;">목</td>
													<td style="width: 2%;"></td>
													<td><input type="text" id="title" name="title"></td>
												</tr>
												<tr>
													<td colspan="6" style="height: 20px"></td>
												</tr>
												<tr>
													<td style="width: 2%;">가</td>
													<td style="width: 2%;"></td>
													<td style="width: 2%;"></td>
													<td style="width: 2%;">격</td>
													<td style="width: 2%;"></td>
													<td><input type="text" id="price" name="price"></td>
												</tr>
												<tr>
													<td colspan="6" style="height: 20px"></td>
												</tr>
												<tr>
													<td style="width: 2%;">상</td>
													<td style="width: 2%;">세</td>
													<td style="width: 2%;">내</td>
													<td style="width: 2%;">용</td>
													<td style="width: 2%;"></td>
													<td>
														<textarea id="content" name="content" style="height: 200px;">
														</textarea></td>
												</tr>
												<tr>
													<td colspan="6" style="height: 20px"></td>
												</tr>
												<tr>
													<td style="width: 2%;">파</td>
													<td style="width: 2%;">일</td>
													<td style="width: 2%;">첨</td>
													<td style="width: 2%;">부</td>
													<td style="width: 2%;"></td>
													<td><input type="file" id="img" name="img"></td>
												</tr>
												<tr>
													<td style="height: 70px"></td>
												</tr>
												<tr>
													<td colspan="6">
														<div align="center" style="width: 110%">
															<input type="submit" value="입력" class="button style1"
																onclick="return checkEmpty()"> <input
																type="reset" class="button style1">
														</div>
													</td>
												</tr>
											</table>
										</form>
									</div>
								</div>
							</article>
						</div>
					</div>
					<div class="col-4 col-12-medium">
					</div>
				</div>
			</div>
		</section>
</body>
</html>

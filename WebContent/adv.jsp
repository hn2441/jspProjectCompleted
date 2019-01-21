<%@page import="java.net.URLEncoder"%>
<%@page import="bean.CartDTO"%>
<%@page import="bean.CartDAO"%>
<%@page import="bean.AdvDTO"%>
<%@page import="bean.AdvDAO"%>
<%@page import="bean.SalesDAO"%>
<%@page import="bean.MemberDTO"%>
<%@page import="bean.MemberDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.ReviewDTO"%>
<%@page import="bean.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	판매글 페이지 입니다. 글 고유번호 받아와서 띄워줍니다.
	판매글 / 리뷰3개 / 네임카드 띄워줍니다
-->
<html>
<head>
<title>판매 페이지 입니다.</title>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<!-- 최근 본 상품 목록 자동 새로 고침  -->
		<script type="text/javascript">
			function refresh() {
				if (self.name != 'reload') {
					self.name = 'reload';
				   	self.location.reload(true);
				}
				else self.name = ''; 
			} /* end 자동 새로 고침 */
		</script>
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
</head>
<body class="right-sidebar is-preload" onload="refresh()">
	<%
		//메인페이지에서 넘어오는 글 고유번호 받기
		//no으로 넘어오든, adno으로 넘어오든 받을 수 있음
		String no = request.getParameter("no");
		int adno = 0;
		if(no!=null){
			adno = Integer.parseInt(no);
		}else{
			adno = Integer.parseInt(request.getParameter("adno"));
		}
		
		//판매글 올리는 부분
		AdvDAO adao = new AdvDAO();
		AdvDTO adto = null;
		//판매자 아이디 판매글 번호로 받아옴		
		String sid = adao.selectAdv(adno).getSid();
		
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
				<p><%=sid %>님의 판매글 페이지입니다!</p>
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
		<% 
			/* 상품 쿠키 등록 */
			int no1 = Integer.parseInt(request.getParameter("no"));
			
			AdvDAO dao = new AdvDAO();
			AdvDTO dto = dao.select(no1);
			
			String product = dto.getTitle();
			String content = dto.getImg();
			
			/* 쿠키에 상품에 대한 정보를 등록 할 때 URLENcoder를 이용하여 생성 */
	 		Cookie cProduct = new Cookie(URLEncoder.encode(product, "UTF-8"), URLEncoder.encode(content, "UTF-8"));
			response.addCookie(cProduct);
		%>
		

		<!-- Main -->
		<section id="main" class="wrapper style2">
			<div class="container">
				<div class="row gtr-150">
					<div class="col-8 col-12-medium">

						<!-- Content -->
						<div id="content">
							<%//판매글 올라오는 부분. 세션에 있는 id와 글쓴이 id가 일치할 경우 수정삭제 링크가 보임
						if(sid.equals(session.getAttribute("id"))){ %>
							<a href="saleEditor_update.jsp?no=<%=adno %>" class="crud1">수정</a>
							<a href="saleEditor_delete_ok.jsp?no=<%=adno %>" class="crud1">삭제</a>
							<%} %>
							<article class="box post">
								<header class="style1">
									<div style="text-align: left; padding: 3%">
										<%//판매글 
										adto = adao.selectAdv(adno);
										%>
										<h2 name="title" style="font-size: 25px"><%=adto.getTitle() %></h2>
									</div>
									<div class="row gtr-150"
										style="height: 100px; font-size: 20px;">
										<div class="col-6 col-12-small" style="padding: 3%;">
											<section class="box">
												<br><br>
												최소 주문금액 : <%=adto.getPrice() %>원
											</section>
										</div>
									</div>
								</header>
								<div class="row gtr-150">
									<div class="col-6 col-12-small">
										<section class="box"></section>
									</div>
								</div>
								<a href="#" class="image featured"> <!-- 이미지 첨부 --> <img
									src="<%=adto.getImg() %>" alt="" style="width: 95%" />
								</a>
								<p
									style="height: 300px; background-color: #F2F2F2; padding: 3%;">
									<font style="font-size: 20px; color: #717479;"> <%=adto.getContent() %>
									</font>
								</p>

								<div>
									<ul class="style2">
										<%	//리뷰 3개만 출력해줌, 리뷰가 3개 이하면 있는 리뷰만 출력해줌
										int k = 3; //출력할 리뷰 갯수
										if(count<3){
											k = count;
										}											
											for(int i=0;i<k;i++){
											%><li style="font-size: 17px">
											<article>
												<h3>
													<%	rdto = list.get(list.size()-1-i);
															String mid = rdto.getMid();
															String mid2 = "";
	
															//리뷰 작성자 아이디중 앞에 2글자만 그대로 출력하고 나머지는 *로 출력해줌
															for(int j=0;j<mid.length();j++){
																if(j>1){
																	mid2 += "*";
																}else{
																	mid2 += mid.charAt(j);
																}
																
															}
														%>
													<a href="#"> <%=count-i %>
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=mid2 %> | 별점 <%
														int starsc = rdto.getStarsc();
														for(int j=0; j<5;j++){
															if(j<starsc){
																out.print("★");
															}//end if
														}//end for
														%></a>
												</h3>
												<p><%=rdto.getContent() %></p>
											</article>
										</li>
										<%
											}//end for
											%>
										<li>
											<div align="right">
												<form action="reviewEditor_insert.jsp" method="post">
													<!-- 주문갯수가 리뷰 갯수보다 많을때만 리뷰 작성 가능 -->
													<%if(ckS > ckR){ %>
													<input type="hidden" name="sid" value="<%=sid%>"> <input
														type="hidden" name="adno" value="<%=adno%>">
													<button class="button style1">
														<font style="font-size: 15px">리뷰작성</font>
													</button>
													<%}%>
													<!-- 판매자에 구매한 모든 리뷰를 출력해줌 -->
													<a href="review.jsp?adno=<%=adno %>" class="button style1">
														리뷰 보기</a>
												</form>
											</div>
										</li>
									</ul>
								</div>
							</article>
						</div>

					</div>
					<div class="col-4 col-12-medium">

						<!-- Sidebar -->
						<div id="sidebar">
							<section class="box">
								<header>
									<%	//네임카드에 올릴 정보를 받아옴
										mdto=mdao.selectNameCard(sid);									
									%>
									<div align="center">
										<!-- 세션에 아이디값이 있는 경우에만 보입니다. -->
										<%if(session.getAttribute("id") != null){ %>
										<a id="heart"
											href="cartEditor.jsp?adno=<%=adno%>&id=<%=session.getAttribute("id")%>"></a>
										<%} %>
									</div>
									<p style="font-size: 20px; color: black;">
										<b>네임카드</b>
									</p>
								</header>
							</section>
							<section class="box">
								<ul class="style2">
									<li>
										<div align="left">
											<!--닉네임만 출력 -->
											<h3>
												닉네임 :
												<%=mdto.getName() %></h3>
											<!-- 결제를 했을 경우만 판매자 연락처 띄워줌 -->
											<%if(ckS>0){ %>
											<h3>
												연락처 :
												<%=sid %></h3>
											<%}//end if %>
										</div>
									</li>
								</ul>
								<!-- bbs로 연결 -->
								<br> <a href="BBS.jsp?id=<%= session.getAttribute("id")%>&id2=<%= adto.getSid() %>" class="button style1">주문하기</a>
							</section>
						</div>
					</div>
				</div>
			</div>
		</section>
</body>
</html>

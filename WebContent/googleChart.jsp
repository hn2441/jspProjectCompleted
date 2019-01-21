<%@page import="java.sql.Date"%>
<%@page import="bean.DBConnectionMgr"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="org.json.JSONObject"%>
<%
/* 방문자 정보 불러오는 action 페이지 */
		Connection con = null;
		try {
			PreparedStatement ps = null;
			ResultSet rs = null;
			DBConnectionMgr pool;
			pool = DBConnectionMgr.getInstance();

			List barlist = new LinkedList();
			con = pool.getConnection();

			String sql = "select * from count ORDER BY visitDate desc limit 6";
			ps = con.prepareStatement(sql);

			rs = ps.executeQuery();

			JSONObject responseObj = new JSONObject();
			JSONObject barObj = null;

			//소수점 2번째 이하로 자름
			DecimalFormat f1 = new DecimalFormat("");

			while (rs.next()) {
				Date visitDate = rs.getDate("visitDate");
				int count = rs.getInt("count");
				barObj = new JSONObject();
				barObj.put("visitDate", visitDate);
				barObj.put("count", count);
				barlist.add(barObj);
			}
			responseObj.put("barlist", barlist);
			out.print(responseObj.toString());

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		}
	%>
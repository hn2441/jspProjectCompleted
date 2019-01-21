package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class ServiceDAO {
	DBConnectionMgr pool;
	Connection con;
	ResultSet rs;

	public ServiceDAO() {
		pool = DBConnectionMgr.getInstance();
	}
			
	//게시글 수정문
	public void update(ServiceDTO dto) throws Exception {

		con = pool.getConnection();

		// 3. SQL문 객체화
		String sql = "update service set title = ?, pw = ?, content = ? where email = ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(4, dto.getEmail());
		ps.setString(1, dto.getTitle());
		ps.setString(2, dto.getPw());
		ps.setString(3, dto.getContent());

		// 4. SQL문 실행 요청
		ps.executeUpdate();
		System.out.println("update문 요청완료");
		pool.freeConnection(con, ps);
	}
	
		//제목값 삭제
	public void delete(String title) throws Exception {

		con = pool.getConnection();

		// 3. SQL문 객체화
		String sql = "delete from service where title=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, title);

		// 4. SQL문 실행 요청
		ps.executeUpdate();
		pool.freeConnection(con, ps);
		System.out.println("delete문 요청완료");

	}
	//게시글 등록
	public void insert(ServiceDTO dto) throws Exception {

		con = pool.getConnection();

		// 3. SQL등록쿼리문
		String sql = "insert into service(title,email,pw,content) values (?,?,?,?)";
		//String sql2="insert into service(null,?,?,?,?,null)values";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, dto.getTitle());
		ps.setString(2, dto.getEmail());
		ps.setString(3, dto.getPw());
		ps.setString(4, dto.getContent());

		// 4. SQL문 실행 요청
		ps.executeUpdate();
		pool.freeConnection(con, ps);
		System.out.println("insert문 요청완료");

	}
/*	public int getNext() { // 게시글의 번호 다음 페이지 함수
		String sql = "select serviceID  from  service ORDER BY serviceID DESC";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}*/

	/*ArrayList에서  ServiceDTO에있는 리스트를  게시글 전체리스트 출력*/
	public ArrayList<ServiceDTO> selectAll() throws Exception {

		con = pool.getConnection();

		// 3. SQL문 객체화
		// String sql = "select *from service ORDER BY serviceID desc limit 10";
		// String sql = "select * from service";
		String sql = "select *from service";

		PreparedStatement ps = con.prepareStatement(sql);

		// 4. SQL문 실행 요청
		ResultSet rs = ps.executeQuery();
		System.out.println("start " + rs.getRow());

		// 해당 row index의 값이 존재하는가? 체크..
		// System.out.println(rs.first());
		// System.out.println(rs.absolute(1));

		// 해당 ResultSet의 갯수를 구하는 방법..==========
		// rs의 맨 끝으로 이동
		// rs.last();
		// 그 맨 끝의 getRow()를 출력
		// System.out.println("레코드의 갯수는 " + rs.getRow());

		ServiceDTO dto = null;
		ArrayList<ServiceDTO> list = new ArrayList<>();

		while (rs.next()) { // 커서를 옮겨서 레코드가 있는지 체크
			System.out.println("row: " + rs.getRow());
			dto = new ServiceDTO();

			int serviceID = rs.getInt("serviceID");
			String email = rs.getString("email");
			String title = rs.getString("title");
			String pw=rs.getString("pw");
			java.sql.Timestamp tm=rs.getTimestamp("tm");			 
			String content=rs.getString("content");

			dto.setServiceID(serviceID);
			dto.setTitle(title);
			dto.setEmail(email);
			dto.setTm(tm);
			list.add(dto);

		}
		pool.freeConnection(con, ps, rs);
		return list;
	}

	/*public ArrayList<ServiceDTO> getList(int pageNumber) {
		String sql = "select *from service ORDER BY serviceID desc limit 10";
		ArrayList<ServiceDTO> list = new ArrayList<ServiceDTO>();
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = ps.executeQuery();
			while (rs.next()) {
				ServiceDTO service = new ServiceDTO();
				service.serServiceID(rs.getInt(1));
				service.setTitle(rs.getString(2));
				service.setEmail(rs.getString(3));
				service.setPw(rs.getString(4));
				service.setTm(rs.getTimestamp(5));
				service.setContent(rs.getString(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}*/

		//게시글의 제목검색
	public ServiceDTO select(String title1) throws Exception {

		con = pool.getConnection();

		// 3. SQL문 객체화
		String sql = "select *from service where title=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, title1);
		// 4. SQL문 실행 요청
		ResultSet rs = ps.executeQuery();
		ServiceDTO dto = null;
		while (rs.next()) { // 커서를 옮겨서 레코드가 있는지 체크
			dto = new ServiceDTO();

			String email = rs.getString("email");
			String title = rs.getString("title");
			String pw = rs.getString("pw");
			String content = rs.getString("content");

			dto.setEmail(email);
			dto.setTitle(title);
			dto.setPw(pw);
			dto.setContent(content);
		}
		return dto;
	}

/*	public boolean nextPage(int pageNumber) {

		String SQL = "select *from service ORDER BY serviceID desc limit 10;";
		ArrayList<ServiceDTO> list = new ArrayList<ServiceDTO>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}*/

	

}

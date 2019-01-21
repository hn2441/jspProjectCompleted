package bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;;

public class MemberDAO {
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	boolean result = false;
	boolean loginResult = false;
	DBConnectionMgr pool;
	

	public MemberDAO() {
		pool = DBConnectionMgr.getInstance();
	}

	/*public boolean login(String id, String pw) throws Exception {
		con = pool.getConnection();
		String sql = "select * from member where id = ? and pw = ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, id);
		ps.setString(2, pw);

		rs = ps.executeQuery();

		if (rs.next()) {
			loginResult = true;
		} else {
			System.out.println("로그인 실패.");
		}
		pool.freeConnection(con, ps, rs);
		return loginResult;
	}*/

	public ArrayList<MemberDTO> selectAll() throws Exception {
		ArrayList<MemberDTO> list = new ArrayList<>();
		con = pool.getConnection();
		String sql = "select * from member";
		ps = con.prepareStatement(sql);

		rs = ps.executeQuery();

		MemberDTO dto = null;

		while (rs.next()) {
			dto = new MemberDTO();
			dto.setId(rs.getString("id"));
			dto.setPw(rs.getString("pw"));
			dto.setName(rs.getString("name"));
			dto.setTel(rs.getString("tel"));
			dto.setCategory(rs.getBoolean("category"));
			dto.setSalt(rs.getString("salt"));
			list.add(dto);
		}
		pool.freeConnection(con, ps, rs);
		return list;
	}
	
	public MemberDTO select(String column, String value) throws Exception {
		MemberDTO dto = new MemberDTO();
		con = pool.getConnection();
		String sql = "select * from member where "+ column + "= ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, value);
		rs = ps.executeQuery();

		if (rs.next()) {
			dto.setId(rs.getString("id"));
			dto.setPw(rs.getString("pw"));
			dto.setName(rs.getString("name"));
			dto.setTel(rs.getString("tel"));
			dto.setCategory(rs.getBoolean("category"));
			dto.setSalt(rs.getString("salt"));
		}
		pool.freeConnection(con, ps, rs);
		return dto;
	}

	public void insert(MemberDTO dto) throws Exception {
		con = pool.getConnection();
		String sql = "insert into member values(?,?,?,?,?,?)";
		ps = con.prepareStatement(sql);
		ps.setString(1, dto.getId());
		ps.setString(2, dto.getPw());
		ps.setString(3, dto.getName());
		ps.setString(4, dto.getTel());
		ps.setBoolean(5, dto.isCategory());
		ps.setString(6, dto.getSalt());
		ps.executeUpdate();
		pool.freeConnection(con, ps);
	}
	
	public void delete(String id) throws Exception {
		con = pool.getConnection();
		String sql = "delete from member where id = ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, id);
		ps.executeUpdate();
		pool.freeConnection(con, ps);
	}
	
	public void update(String column, Boolean value, String id) throws Exception {
		con = pool.getConnection();
		String sql = "update member set " + column + " = ? where id = ?";
		ps = con.prepareStatement(sql);
		ps.setBoolean(1, value);
		ps.setString(2, id);
		ps.executeUpdate();
		pool.freeConnection(con, ps);
	}
	
	public void update(String column, String value, String id) throws Exception {
		con = pool.getConnection();
		String sql = "update member set " + column + " = ? where id = ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, value);
		ps.setString(2, id);
		ps.executeUpdate();
		pool.freeConnection(con, ps);
	}
	
	//whn : 판매글 페이지 네임카드에 닉네임 / 이메일 출력
		public MemberDTO selectNameCard(String sid) {
			PreparedStatement ps = null;
			ResultSet rs = null;
			MemberDTO dto = null;
			try {
				con = pool.getConnection();
				
				//3. sql문 객체화
				String sql="SELECT * FROM MEMBER WHERE ID=?;";
				ps = con.prepareStatement(sql);
				ps.setString(1, sid);
				
				//4. sql문 실행 요청
				rs = ps.executeQuery();
				while(rs.next()) {
					dto = new MemberDTO();
					
					dto.setId(rs.getString(1));
					dto.setPw(rs.getString(2));
					dto.setTel(rs.getString(3));
					dto.setName(rs.getString(4));
					dto.setCategory(rs.getBoolean(5));
					dto.setSalt(rs.getString(6));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				pool.freeConnection(con, ps, rs);
			}
			
			return dto;
		}//end selectAllAdv()
		
}

package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class searchDAO {
	DBConnectionMgr pool;
	Connection con;
	
	public searchDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//yis 검색어 select
	public searchDTO select(String search) throws Exception {
		PreparedStatement ps = null;
		ResultSet rs = null;
		searchDTO dto = new searchDTO();
		
		con = pool.getConnection();
		
		String sql = "select * from search where search=?";
		ps = con.prepareStatement(sql);
		ps.setString(1, search);
		rs = ps.executeQuery();
		
		while (rs.next()) {
			if(search.equals(rs.getString("search"))) {
				dto.setSearch(rs.getString("search"));
				dto.setCount(rs.getInt("count"));
				dto.setDay(rs.getString("day"));
			} else {
				dto.setSearch(null);
			}
		}
		
		pool.freeConnection(con, ps, rs);
		
		return dto;
	}// end select()
	
	//yis 검색어 insert
	public void insert(searchDTO dto) throws Exception {
		PreparedStatement ps = null;
		
		con = pool.getConnection();
		
		// 넘어온 값이 공백일 경우
		if(dto.getSearch().equals("")) {
			
		//  넘어온 값이 공백이 아닌 경우
		} else {
			String sql = "insert into search values (?, ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getSearch());
			ps.setInt(2, dto.getCount());
			ps.setString(3, dto.getDay());
			ps.executeUpdate();
			
			System.out.println("sql문 실행 완료");
		}
		
		pool.freeConnection(con, ps);
	}// end insert
	
	//yis 검색어 update
	public void update(searchDTO dto) throws Exception {
		PreparedStatement ps = null;
		
		con = pool.getConnection();
		
		String sql = "update search set count = ?, day = ? where search = ?";
		ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getCount());
		ps.setString(2, dto.getDay());
		ps.setString(3, dto.getSearch());
		ps.executeUpdate();
		
		System.out.println("sql문 실행 완료");
		
		pool.freeConnection(con, ps);
	}// end update
	
	//yis 연관 검색어
	public ArrayList<searchDTO> searchInc(String search) throws Exception {
		PreparedStatement ps = null;
		ResultSet rs = null;
		searchDTO dto = null;
		
		con = pool.getConnection();
		
		String sql = "select * from search where search like '%" + search + "%' order by count desc limit 5";
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
		
		ArrayList<searchDTO> list = new ArrayList<>();
		
		while (rs.next()) {
			dto = new searchDTO();
			
			dto.setSearch(rs.getString("search"));
			dto.setCount(rs.getInt("count"));
			
			list.add(dto);
		}
		
		pool.freeConnection(con, ps, rs);
		
		return list;
	}// end searchInc
	
	//yis top5 검색어
	public ArrayList<searchDTO> topFive(String day) throws Exception{
		PreparedStatement ps = null;
		ResultSet rs = null;
		searchDTO dto = null;
		
		con = pool.getConnection();
		
		String sql = "select * from search where day like '" + day + "%' order by count desc limit 5";
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
		
		ArrayList<searchDTO> list = new ArrayList<>();
		
		while(rs.next()) {
			dto = new searchDTO();
			
			dto.setSearch(rs.getString("search"));
			
			list.add(dto);
		}
		
		pool.freeConnection(con, ps, rs);
		
		return list;
	}// end topFive
}

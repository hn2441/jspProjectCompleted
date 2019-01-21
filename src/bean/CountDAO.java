package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

public class CountDAO {
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	DBConnectionMgr pool;
	

	public CountDAO() {
		pool = DBConnectionMgr.getInstance();
	}

	public ArrayList<CountDTO> selectAll() throws Exception {
		ArrayList<CountDTO> list = new ArrayList<>();
		con = pool.getConnection();
		String sql = "select * from count";
		ps = con.prepareStatement(sql);

		rs = ps.executeQuery();

		CountDTO dto = null;

		while (rs.next()) {
			dto = new CountDTO();
			dto.setVisitDate(rs.getDate("visitDate"));
			dto.setCount(rs.getInt("count"));
			list.add(dto);
		}
		pool.freeConnection(con, ps, rs);
		return list;
	}
	
	public CountDTO select(String column, java.sql.Date value) throws Exception {
		CountDTO dto = new CountDTO();
		con = pool.getConnection();
		String sql = "select * from count where "+ column + "= ?";
		ps = con.prepareStatement(sql);
		ps.setDate(1,  value);
		rs = ps.executeQuery();

		if (rs.next()) {
			dto.setVisitDate(rs.getDate("visitDate"));
			dto.setCount(rs.getInt("count"));
		}
		pool.freeConnection(con, ps, rs);
		return dto;
	}

	public void insert(CountDTO dto) throws Exception {
		con = pool.getConnection();
		String sql = "insert into count values(?,?)";
		ps = con.prepareStatement(sql);
		ps.setDate(1, dto.getVisitDate());
		ps.setInt(2, dto.getCount());
		ps.executeUpdate();
		pool.freeConnection(con, ps);
	}
	public void Update(CountDTO dto) throws Exception {
		con = pool.getConnection();
		String sql = "update count set count=? where visitdate = ?";
		ps = con.prepareStatement(sql);
		ps.setInt(1, dto.getCount());
		ps.setDate(2, dto.getVisitDate());
		ps.executeUpdate();
		pool.freeConnection(con, ps);
	}
	public void delete(String visitDate) throws Exception {
		con = pool.getConnection();
		String sql = "delete from Count where visitDate = ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, visitDate);
		ps.executeUpdate();
		pool.freeConnection(con, ps);
	}
}

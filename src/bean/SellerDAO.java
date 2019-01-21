package bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;;

public class SellerDAO {
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	DBConnectionMgr pool;
	

	public SellerDAO() {
		pool = DBConnectionMgr.getInstance();
	}

	public ArrayList<SellerDTO> selectAll() throws Exception {
		ArrayList<SellerDTO> list = new ArrayList<>();
		con = pool.getConnection();
		String sql = "select * from Seller";
		ps = con.prepareStatement(sql);

		rs = ps.executeQuery();

		SellerDTO dto = null;

		while (rs.next()) {
			dto = new SellerDTO();
			dto.setId(rs.getString("id"));
			dto.setBank(rs.getString("bank"));
			dto.setAcc(rs.getString("acc"));
			list.add(dto);
		}
		pool.freeConnection(con, ps, rs);
		return list;
	}
	
	public SellerDTO select(String column, String value) throws Exception {
		SellerDTO dto = new SellerDTO();
		con = pool.getConnection();
		String sql = "select * from seller where "+ column + "= ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, value);
		rs = ps.executeQuery();

		if (rs.next()) {
			dto.setId(rs.getString("id"));
			dto.setBank(rs.getString("bank"));
			dto.setAcc(rs.getString("acc"));
		}
		pool.freeConnection(con, ps, rs);
		return dto;
	}

	public void insert(SellerDTO dto) throws Exception {
		con = pool.getConnection();
		String sql = "insert into Seller values(?,?,?)";
		ps = con.prepareStatement(sql);
		ps.setString(1, dto.getId());
		ps.setString(2, dto.getBank());
		ps.setString(3, dto.getAcc());
		ps.executeUpdate();
		pool.freeConnection(con, ps);
	}
	
	public void delete(String id) throws Exception {
		con = pool.getConnection();
		String sql = "delete from Seller where id = ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, id);
		ps.executeUpdate();
		pool.freeConnection(con, ps);
	}
}

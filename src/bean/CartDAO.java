package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CartDAO {
	DBConnectionMgr pool;
	Connection con;
	
	public CartDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//whn : 판매페이지에서 하트를 누르면 실행되는 부분
	public int insertCart(CartDTO dto){
		PreparedStatement ps = null;
		int rs=0;
		try {
			con = pool.getConnection();
			//3. SQL문 객체화
			String sql = "INSERT INTO CART VALUES(?,?,?);";
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getId());
			ps.setInt(2, dto.getAdno());
			ps.setString(3, dto.getDate());
			
			//4. SQL문 실행 요청
			ps.executeUpdate();
			System.out.println("insertCart sql문 요청 완료");
			rs = 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, ps);
		}
		return rs;
		
	}//end insertCart()
	
	//whn : 판매페이지에서 하트를 한번 더 누르면 실행됨
	public int deleteCart(String id, int no) {
		PreparedStatement ps =null;
		int rs = 0;
		try {
			con = pool.getConnection();
			
			//3.sql문 객체화
			String sql = "DELETE FROM Cart WHERE MID=? AND ADNO=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ps.setInt(2, no);
			
			//4.sql문 실행요청
			ps.executeUpdate();
			System.out.println("deleteCart sql문 요청 완료");
			rs = 1;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, ps);
		}
		return rs;
	}//end deleteCart()
	
	//whn : 
	public CartDTO selectCart(String id, int no) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		CartDTO dto = null;
		try {
			con = pool.getConnection();
			
			//3. sql문 객체화
			String sql="SELECT * FROM CART WHERE MID=? AND ADNO=?;";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ps.setInt(2, no);
			
			//4. sql문 실행 요청
			rs = ps.executeQuery();
			while(rs.next()) {
				dto = new CartDTO();
				
				dto.setId(rs.getString(1));
				dto.setAdno(rs.getInt(2));
				dto.setDate(rs.getString(3));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, ps, rs);
		}
		return dto;
	}
	
	//whn : 아이디에 해당하는 좋아요만 출력해줌
	public ArrayList<CartDTO> selectMyCart(String id) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<CartDTO> list = null;
		CartDTO dto = null;
		try {
			con = pool.getConnection();
			
			//3. sql문 객체화
			String sql="SELECT * FROM CART WHERE MID=?;";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			
			//4. sql문 실행 요청
			rs = ps.executeQuery();
			list = new ArrayList<>();
			while(rs.next()) {
				dto = new CartDTO();
				
				dto.setId(rs.getString(1));
				dto.setAdno(rs.getInt(2));
				dto.setDate(rs.getString(3));
				
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, ps, rs);
		}
		
		return list;
	}//end selectAllCart()
}

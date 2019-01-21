package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class SalesDAO {
	
	DBConnectionMgr pool;
	Connection con;
	
	public SalesDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//whn : 판매페이지에서 하트를 누르면 실행되는 부분
	public int insertSales(SalesDTO dto){
		PreparedStatement ps = null;
		int rs=0;
		try {
			con = pool.getConnection();
			//3. SQL문 객체화
			String sql = "INSERT INTO SALES(mid,sid,price,date) VALUES(?,?,?,?);";
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getMid());
			ps.setString(2, dto.getSid());
			ps.setInt(3, dto.getPrice());
			ps.setString(4, dto.getDate());
			
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
	}//end insertSales()
		
	//whn : 판매글 페이지 네임카드에 닉네임 / 이메일 출력
	public int selectCheckPayment(String sid,String mid) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		int rst =0;
		try {
			con = pool.getConnection();
			
			//3. sql문 객체화
			String sql="SELECT * FROM SALES WHERE SID=? AND MID=?;";
			ps = con.prepareStatement(sql);
			ps.setString(1, sid);
			ps.setString(2, mid);
			
			//4. sql문 실행 요청
			rs = ps.executeQuery();
			while(rs.next()) {
				rst++;
			}
			return rst;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, ps, rs);
		}
		return rst;
	}//end selectCheckPayment()
	
}

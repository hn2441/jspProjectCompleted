package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReviewDAO {
	DBConnectionMgr pool;
	Connection con;
	
	public ReviewDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//whn
	public int insertReview(ReviewDTO dto){
		PreparedStatement ps = null;
		int rs = 0;
		try {
			con = pool.getConnection();

			//3. SQL문 객체화
			String sql = "INSERT INTO REVIEW (mid,sid,adno,content,starsc,date) VALUES(?,?,?,?,?,?);";
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getMid());
			ps.setString(2, dto.getSid());
			ps.setInt(3, dto.getAdno());
			ps.setString(4, dto.getContent());
			ps.setInt(5, dto.getStarsc());
			
			//4. SQL문 실행 요청
			ps.executeUpdate();
			System.out.println("insertReview sql문 요청 완료");
			
			rs=1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, ps);
		}
		return rs;
		
	}//end insertReview()
	
	//whn
	public int updateReview(ReviewDTO dto){
		PreparedStatement ps = null;
		int rs = 0;
		try {
			con = pool.getConnection();
			
			//3.sql문 객체화
			String sql = "UPDATE REVIEW SET CONTENT=?, STARSC=? WHERE NO=?;";
			ps = con.prepareStatement(sql);
			ps.setInt(3, dto.getNo());
			ps.setString(1, dto.getContent());
			ps.setInt(2, dto.getStarsc());
			
			//4.sql문 실행요청
			ps.executeUpdate();
			System.out.println("updateReview sql문 요청 완료");
			rs = 1;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, ps);
		}
		return rs;
	}//end updateReview
	
	//whn
	public int deleteReview(int no) {
		PreparedStatement ps =null;
		int rs = 0;
		try {
			con = pool.getConnection();
			
			//3.sql문 객체화
			String sql = "DELETE FROM REVIEW WHERE NO=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			
			//4.sql문 실행요청
			ps.executeUpdate();
			System.out.println("deleteReview sql문 요청 완료");
			rs = 1;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, ps);
		}
		
		return rs;
	}//end deleteReview()
	
	//whn
	public ReviewDTO selectReview(int no) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		ReviewDTO dto = null;
		try {
			con = pool.getConnection();
			
			//3. sql문 객체화
			String sql="SELECT * FROM REVIEW WHERE no=?;";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			
			//4. sql문 실행 요청
			rs = ps.executeQuery();
			while(rs.next()) {
				dto = new ReviewDTO();
				
				dto.setNo(rs.getInt(1));
				dto.setMid(rs.getString(2));
				dto.setSid(rs.getString(3));
				dto.setAdno(rs.getInt(4));
				dto.setContent(rs.getString(5));
				dto.setStarsc(rs.getInt(6));
				dto.setDate(rs.getString(7));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, ps, rs);
		}
		
		return dto;
	}//end selectSidReview()
	
	//whn
	public ArrayList<ReviewDTO> selectSidReview(String sid) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<ReviewDTO> list = null;
		ReviewDTO dto = null;
		try {
			con = pool.getConnection();
			
			//3. sql문 객체화
			String sql="SELECT * FROM REVIEW WHERE SID=?;";
			ps = con.prepareStatement(sql);
			ps.setString(1, sid);
			
			//4. sql문 실행 요청
			rs = ps.executeQuery();
			list = new ArrayList<>();
			while(rs.next()) {
				dto = new ReviewDTO();
				
				dto.setNo(rs.getInt(1));
				dto.setMid(rs.getString(2));
				dto.setSid(rs.getString(3));
				dto.setAdno(rs.getInt(4));
				dto.setContent(rs.getString(5));
				dto.setStarsc(rs.getInt(6));
				dto.setDate(rs.getString(7));
				
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, ps, rs);
		}
		
		return list;
	}//end selectSidReview()
	
	//whn : 판매글 페이지 네임카드에 닉네임 / 이메일 출력
	public int selectCheckPayment(String sid,String mid) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		int rst =0;
		try {
			con = pool.getConnection();
			
			//3. sql문 객체화
			String sql="SELECT * FROM REVIEW WHERE SID=? AND MID=?;";
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

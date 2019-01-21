package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class AdvDAO {
	DBConnectionMgr pool;
	Connection con;
	
	public AdvDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//whn : 입력
	public int insertAdv(AdvDTO dto){
		PreparedStatement ps = null;
		int rs = 0;
		try {
			con = pool.getConnection();

			//3. SQL문 객체화
			String sql = "INSERT INTO ADV(sid,title,price,content,img) VALUES(?,?,?,?,?);";
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getSid());
			ps.setString(2, dto.getTitle());
			ps.setString(3, dto.getPrice());
			ps.setString(4, dto.getContent());
			ps.setString(5, dto.getImg());
			
			//4. SQL문 실행 요청
			ps.executeUpdate();
			System.out.println("insertAdv sql문 요청 완료");
			rs = 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, ps);
		}
		
		return rs;
		
	}//end insertAdv()
	
	//whn : 수정
	public int updateAdv(AdvDTO dto){
		PreparedStatement ps = null;
		int rs = 0;
		try {
			con = pool.getConnection();
			
			//3.sql문 객체화
			String sql = "UPDATE ADV SET TITLE=?, PRICE=?, CONTENT=?, IMG=? WHERE NO=?;";
			ps = con.prepareStatement(sql);
			ps.setInt(5, dto.getNo());
			ps.setString(1, dto.getTitle());
			ps.setString(2, dto.getPrice());
			ps.setString(3, dto.getContent());
			ps.setString(4, dto.getImg());
			
			//4.sql문 실행요청
			ps.executeUpdate();
			System.out.println("updateAdv sql문 요청 완료");
			rs = 1;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, ps);
		}
		return rs;
	}//end updateAdv
	
	//whn : 삭제
	public int deleteAdv(int no) {
		PreparedStatement ps =null;
		int rs = 0;
		try {
			con = pool.getConnection();
			
			//3.sql문 객체화
			String sql = "DELETE FROM ADV WHERE NO=?;";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			
			//4.sql문 실행요청
			ps.executeUpdate();
			System.out.println("deleteAdv sql문 요청 완료");
			rs = 1;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, ps);
		}
		return rs;
	}//end deleteAdv()
	
	//whn : 판매글 페이지에 하나 출력
	public AdvDTO selectAdv(int no) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		AdvDTO dto = null;
		try {
			con = pool.getConnection();
			
			//3. sql문 객체화
			String sql="SELECT * FROM ADV WHERE NO=?;";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			
			//4. sql문 실행 요청
			rs = ps.executeQuery();
			while(rs.next()) {
				dto = new AdvDTO();
				
				dto.setNo(rs.getInt(1));
				dto.setSid(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setPrice(rs.getString(4));
				dto.setContent(rs.getString(5));
				dto.setImg(rs.getString(6));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, ps, rs);
		}
		
		return dto;
	}//end selectAllAdv()

	//whn : 판매자의 개인 판매글 리스트를 출력해주는 페이지
	public ArrayList<AdvDTO> selectMyAdv(String id) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<AdvDTO> list = null;
		AdvDTO dto = null;
		try {
			con = pool.getConnection();
			
			//3. sql문 객체화
			String sql="SELECT * FROM ADV WHERE SID= ?;";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			
			//4. sql문 실행 요청
			rs = ps.executeQuery();
			list = new ArrayList<>();
			while(rs.next()) {
				dto = new AdvDTO();
				
				dto.setNo(rs.getInt(1));
				dto.setSid(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setPrice(rs.getString(4));
				dto.setContent(rs.getString(5));
				dto.setImg(rs.getString(6));
				
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, ps, rs);
		}
		
		return list;
	}//end selectAllAdv()
	
	// yis 검색 결과
		public ArrayList<AdvDTO> search(String search) throws Exception {
			PreparedStatement ps = null;
			ResultSet rs = null;
			AdvDTO dto = null;
			
			con = pool.getConnection();
			
			String sql = "select no, title, price, img from ADV where title like '%" + search + "%'";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			ArrayList<AdvDTO> list = new ArrayList<>();
			
			if(search.equals("")) {
				dto = new AdvDTO();
				
				dto.setNo(0);
				dto.setTitle(null);
				dto.setPrice(null);
				dto.setImg(null);
				
				list.add(dto);
			} else {
				while(rs.next()) {
					dto = new AdvDTO();
					
					dto.setNo(rs.getInt("no"));
					dto.setTitle(rs.getString("title"));
					dto.setPrice(rs.getString("price"));
					dto.setImg(rs.getString("img"));
					
					list.add(dto);
				}
			}
			
			pool.freeConnection(con, ps, rs);
			
			return list;
		}//end search()
		
		
		//yis 상품 검색(세부 상품 결과 가져오기)
		public AdvDTO select(int no) throws Exception {
			PreparedStatement ps = null;
			ResultSet rs = null;
			AdvDTO dto = new AdvDTO();
			
			con = pool.getConnection();
			
			String sql = "select * from ADV where no=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				dto.setNo(rs.getInt("no"));
				dto.setSid(rs.getString("sid"));
				dto.setTitle(rs.getString("title"));
				dto.setPrice(rs.getString("price"));
				dto.setContent(rs.getString("content"));
				dto.setImg(rs.getString("img"));
			
			}
			
			pool.freeConnection(con, ps, rs);
			
			return dto;
		}//end select()
		
		//yis --> title을 받아서 no 값을 넘겨줌
		public AdvDTO selectTitle(String title) throws Exception {
			PreparedStatement ps = null;
			ResultSet rs = null;
			AdvDTO dto = new AdvDTO();
			
			con = pool.getConnection();
			
			String sql = "select no from ADV where title=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, title);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				dto.setNo(rs.getInt("no"));
			
			}
			
			pool.freeConnection(con, ps, rs);
			
			return dto;
		}//end select()
		
		//yis DB에 저장되어 있는 상품의 개수 확인
		public ArrayList<AdvDTO> number() throws Exception {
			PreparedStatement ps = null;
			ResultSet rs = null;
			AdvDTO dto = null;
		
			con = pool.getConnection();
			
			String sql = "select no from ADV";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			ArrayList<AdvDTO> list = new ArrayList<>();
			
			while(rs.next()) {
				dto = new AdvDTO();
				dto.setNo(rs.getInt("no"));
				
				list.add(dto);
			}
			
			pool.freeConnection(con, ps, rs);
			
			return list;
		}//end number
		
		//yis 랜덤 값에 맞는 상품 결과 가져오기
		public AdvDTO randomPro(int no) throws Exception {
			PreparedStatement ps = null;
			ResultSet rs = null;
			AdvDTO dto = new AdvDTO();
		
			con = pool.getConnection();
			
			String sql = "select no, title, price, img from ADV where no=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, no);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				dto.setNo(rs.getInt("no"));
				dto.setTitle(rs.getString("title"));
				dto.setPrice(rs.getString("price"));
				dto.setImg(rs.getString("img"));
			}
			
			pool.freeConnection(con, ps, rs);
			
			return dto;
		}//end randomPro
}

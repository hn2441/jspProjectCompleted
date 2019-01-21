package bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.xml.ws.RespectBinding;


public class BBSDAO {
	DBConnectionMgr pool;
	Connection con;
	
	public BBSDAO() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	//게시글 입력
	public void insert(BBSDTO dto) throws Exception {
		con = pool.getConnection();
		
		String sql = "insert into bbs (title, write, id, id2, date, view) values (?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		//ps.setInt(1, dto.getNum());//자동 증가
		ps.setString(1, dto.getTitle());
		ps.setString(2, dto.getWrite());
		ps.setString(3, dto.getId());
		ps.setString(4, dto.getId2());
		ps.setString(5, dto.getDate());
		ps.setInt(6, dto.getView()+1);
		
		ps.executeUpdate();
		pool.freeConnection(con, ps);
		System.out.println("SQL문 요청 완료..");
	}
	
	
	//게시글 리스트뽑기
		public ArrayList<BBSDTO> selectAll() throws Exception {
			con = pool.getConnection();

			String sql = "select * from bbs order by num asc";
			PreparedStatement ps = con.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();
			System.out.println("start " + rs.getRow());
			
			
			BBSDTO dto = null;
			ArrayList<BBSDTO> list = new ArrayList<>();
			
			while (rs.next()) { 
				System.out.println("row: " + rs.getRow());
				dto = new BBSDTO();

				int num = rs.getInt(1);
				String title = rs.getString(2);
				String write = rs.getString(3);
				String id = rs.getString(4);
				String date = rs.getString(6);
				int view = rs.getInt(7);
				
				dto.setNum(num);
				dto.setTitle(title);
				dto.setWrite(write);
				dto.setId(id);
				dto.setDate(date);
				dto.setView(view);
				
				list.add(dto);
				System.out.println();
			}
			pool.freeConnection(con, ps, rs);
			return list;
		}
		
		//사용자가 작성한 제목으로 검색
		public BBSDTO select(String input) throws Exception {
			con = pool.getConnection();

			String sql = "select * from bbs where title=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, input);

			System.out.println(input);
			
			ResultSet rs = ps.executeQuery();
			BBSDTO dto = new BBSDTO();
			while (rs.next()) { 
				int num = rs.getInt(1);
				String title = rs.getString(2);
				String write = rs.getString(3);
				String id = rs.getString(4);
				String date = rs.getString(5);
				int view = rs.getInt(7);

				dto.setNum(num);
				dto.setTitle(title);
				dto.setWrite(write);
				dto.setId(id);
				dto.setDate(date);
				dto.setView(view);
			}
			pool.freeConnection(con, ps, rs);
			return dto;
		}
		
		//아이디 가져오기
				public BBSDTO check(String input) throws Exception {
					con = pool.getConnection();

					String sql = "select * from bbs where id=?";
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setString(1, input);

					System.out.println(input);
					
					ResultSet rs = ps.executeQuery();
					BBSDTO dto = new BBSDTO();
					while (rs.next()) {
						int num = rs.getInt(1);
						String title = rs.getString(2);
						String write = rs.getString(3);
						String id = rs.getString(4);
						String date = rs.getString(5);
						int view = rs.getInt(7);

						dto.setNum(num);
						dto.setTitle(title);
						dto.setWrite(write);
						dto.setId(id);
						dto.setDate(date);
						dto.setView(view);
					}
					pool.freeConnection(con, ps, rs);
					return dto;
				}
		
		//날짜가져오기
				public BBSDTO select2(String input2) throws Exception {
					con = pool.getConnection();

					String sql = "select date from bbs where title=?";
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setString(1, input2);

					System.out.println(input2);
					
					ResultSet rs = ps.executeQuery();
					BBSDTO dto = new BBSDTO();
					while (rs.next()) { 
						String date = rs.getString(1);

						dto.setDate(date);
					}
					pool.freeConnection(con, ps, rs);
					return dto;
				}
		
		public void login(String input1, String input2) throws Exception {
			con = pool.getConnection();

			// id와 pw 맞는지 체크-방법1
			String sql = "select * from member where id = ? and pw = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, input1);
			ps.setString(2, input2);

			ResultSet rs = ps.executeQuery();
			
			if(rs.next()) {
				System.out.println("아이디: " + rs.getString(1));
				System.out.println("패스워드: " + rs.getString(2));
				System.out.println("로그인 성공.");
			}else {
				System.out.println("로그인 실패.");
			}
			System.out.println();
			
			// id와 pw 맞는지 체크-방법2
			String sql2 = "select count(*) from member where id = ? and pw = ?";
			PreparedStatement ps2 = con.prepareStatement(sql2);
			ps2.setString(1, input1);
			ps2.setString(2, input2);

			ResultSet rs2 = ps2.executeQuery();
			rs2.next();
			if(rs2.getInt(1) == 1) {
				System.out.println("로그인 성공.");
			}else {
				System.out.println("로그인 실패.");
			}
			pool.freeConnection(con, ps);
		}
		
		//조회수 증가
		public void update(String input) throws Exception {
			con = pool.getConnection();

			String sql = "update bbs set view = view+1 where title = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, input);
			
			ps.executeUpdate();	
			pool.freeConnection(con, ps);
		}		
		
		//게시판 수정
		public void writeUpdate(BBSDTO dto) throws Exception {
			con = pool.getConnection();
			
			System.out.println(dto.getTitle());
			System.out.println(dto.getWrite());
			System.out.println(dto.getNum());
			
			String sql = "update bbs set (title,write) = (?,?) where num=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getTitle());
			ps.setString(2, dto.getWrite());
			ps.setInt(3, dto.getNum());
			
			ps.executeUpdate();	
			pool.freeConnection(con, ps);
		}	
		
		// 삭제
		   public void delete(String num) throws Exception {
		      con = pool.getConnection();

		      String sql = "delete bbs where num = ?";
		      PreparedStatement ps = con.prepareStatement(sql);
		      ps.setString(1, num);

		      ps.executeUpdate();
		      pool.freeConnection(con, ps);
		   }
		
}
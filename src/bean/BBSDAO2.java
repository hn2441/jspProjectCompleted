package bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.xml.ws.RespectBinding;


public class BBSDAO2 {
	DBConnectionMgr pool;
	Connection con;
	
	public BBSDAO2() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	//답글 등록
	public void insert(BBSDTO2 dto2) throws Exception {
		con = pool.getConnection();
		
		String sql = "insert into bbsanswer (num, title, write, id2, date) values (?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, dto2.getNum());
		ps.setString(2, dto2.getTitle());
		ps.setString(3, dto2.getWrite());
		ps.setString(4, dto2.getId2());
		ps.setString(5, dto2.getDate());
		
		ps.executeUpdate();
		pool.freeConnection(con, ps);
		System.out.println("SQL문 요청 완료..");
	}
	
	
		
		//답글을 원문과 똑같은 번호일시 출력
		public BBSDTO2 select(int num) throws Exception {
			con = pool.getConnection();

			// 3. SQL문 객체화
			String sql = "select * from bbsanswer where num=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, num);

			System.out.println("넘어온값: "+num);
			// 4. SQL문 실행 요청
			ResultSet rs = ps.executeQuery();
			BBSDTO2 dto2 = new BBSDTO2();
			while (rs.next()) { // 커서를 옮겨서 레코드가 있는지 체크
				String title = rs.getString(2);
				String id2 = rs.getString(4);
				String date = rs.getString(5);
				String write = rs.getString(3);
				
				dto2.setTitle(title);
				dto2.setId2(id2);
				dto2.setDate(date);
				dto2.setWrite(write);
			}
			pool.freeConnection(con, ps, rs);
			return dto2;
		}
		
		//아이디 가져오기
				public BBSDTO2 check(String input) throws Exception {
					con = pool.getConnection();

					// 3. SQL문 객체화
					String sql = "select * from bbsanswer where id=?";
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setString(1, input);

					System.out.println(input);
					
					// 4. SQL문 실행 요청
					ResultSet rs = ps.executeQuery();
					BBSDTO2 dto2 = new BBSDTO2();
					while (rs.next()) { // 커서를 옮겨서 레코드가 있는지 체크
						int num = rs.getInt(1);
						String title = rs.getString(2);
						String write = rs.getString(3);
						String id2 = rs.getString(4);
						String date = rs.getString(5);

						dto2.setNum(num);
						dto2.setTitle(title);
						dto2.setWrite(write);
						dto2.setId2(id2);
						dto2.setDate(date);
					}
					pool.freeConnection(con, ps, rs);
					return dto2;
				}
		
		//날짜가져오기
				public BBSDTO2 select2(String input2) throws Exception {
					con = pool.getConnection();

					// 3. SQL문 객체화
					String sql = "select date from bbsanswer where title=?";
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setString(1, input2);

					System.out.println(input2);
					
					// 4. SQL문 실행 요청
					ResultSet rs = ps.executeQuery();
					BBSDTO2 dto2 = new BBSDTO2();
					while (rs.next()) { // 커서를 옮겨서 레코드가 있는지 체크
						String date = rs.getString(1);

						dto2.setDate(date);
					}
					pool.freeConnection(con, ps, rs);
					return dto2;
				}
		
		public void login(String input1, String input2) throws Exception {
			con = pool.getConnection();

			// id와 pw 맞는지 체크-방법1
			String sql = "select * from member where id2 = ? and pw = ?";
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
			String sql2 = "select count(*) from member where id2 = ? and pw = ?";
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

			// 3. SQL문 객체화
			String sql = "update bbsanswer set view = view+1 where title = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, input);
			
			// 4. SQL문 실행 요청
			ps.executeUpdate();	
			pool.freeConnection(con, ps);
		}		
		
		//게시판 수정
		public void writeUpdate(BBSDTO dto) throws Exception {
			con = pool.getConnection();
			
			System.out.println(dto.getTitle());
			System.out.println(dto.getWrite());
			System.out.println(dto.getNum());
			
			// 3. SQL문 객체화
			String sql = "update bbsanswer set (title,write) = (?,?) where num=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, dto.getTitle());
			ps.setString(2, dto.getWrite());
			ps.setInt(3, dto.getNum());
			
			// 4. SQL문 실행 요청
			ps.executeUpdate();	
			pool.freeConnection(con, ps);
		}		
}
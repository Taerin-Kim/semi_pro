package com.util;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import static com.util.JDBCTemplate.*;

public class BoardDao {

	public int getTotalCount() {
		
		String sql = " SELECT COUNT(*) FROM BOARD ";
		
		int totalCount = 0;
		
		Connection con = getConnection();
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			close(rs, stmt, con);
		}
		
		return totalCount;
	}

	public List<BoardDto> selectListPage(int page) {
		 //1번 페이지 1~10
        //2번 페이지 11~20
		
        int start = (page-1)*10+1;
        int end = page*10;
        
        String sql = "SELECT * FROM ("
                + "SELECT * FROM ("
                + "SELECT ROWNUM row_num, BOARD.* FROM BOARD "
                + ") WHERE row_num >= ?"
                + ") WHERE row_num <= ?";
        
        List<BoardDto> list = new ArrayList<BoardDto>();
        
        PreparedStatement pstm = null;
        ResultSet rs = null;
        
        Connection con = getConnection();
        
        try{
        	
            pstm = con.prepareStatement(sql);
            pstm.setInt(1, start);
            pstm.setInt(2, end);
            rs = pstm.executeQuery();
            while(rs.next()){
                BoardDto dto = new BoardDto();
                dto.setNum(rs.getInt("num"));
                dto.setId(rs.getString("id"));
                dto.setPwd(rs.getString("pwd"));
                dto.setName(rs.getString("name"));
                list.add(dto);
            }
        }catch(SQLException e){
            e.printStackTrace();
        }finally{
            close(rs, pstm, con);
        }
        return list;
	}
}

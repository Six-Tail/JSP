// FeedDAO.java
package dao;

import java.sql.*;
import java.util.ArrayList;

import javax.naming.NamingException;
import util.*;

public class FeedDAO {

	public boolean insert(String uid, String ucon, String uimages) throws NamingException, SQLException {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    try {
	        String sql = "INSERT INTO feed(id, content, images) VALUES(?, ?, ?)";
	        
	        conn = ConnectionPool.get();
	        stmt = conn.prepareStatement(sql);

	        // 디버깅을 위해 출력 추가
	        System.out.println("Debug: User ID in DAO: " + uid);

	        stmt.setString(1, uid);
	        stmt.setString(2, ucon);
	        stmt.setString(3, uimages);
	        
	        int count = stmt.executeUpdate();
	        return (count == 1);
	        
	    } finally {
	        if (stmt != null) stmt.close(); 
	        if (conn != null) conn.close();
	    }
	}
    
	public FeedObj getFeed(String feedId) throws NamingException, SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT id, content, ts, images FROM feed WHERE ts = ?";
            
            conn = ConnectionPool.get();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, feedId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return new FeedObj(rs.getString("id"), rs.getString("content"), rs.getString("ts"), rs.getString("images"));
            }

            return null; // 해당 ID에 대한 데이터가 없을 경우 null 반환

        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
	}
	
	// FeedDAO.java의 feedDeleteByTimestamp 메서드에 로그 추가
	public boolean feedDeleteByTimestamp(String ts) throws NamingException, SQLException {
	    Connection conn = null;
	    PreparedStatement stmt = null;

	    try {
	        String sql = "DELETE FROM feed WHERE ts = ?";
	        
	        conn = ConnectionPool.get();
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, ts);

	        // 로그 추가
	        System.out.println("Debug: SQL Query: " + stmt.toString());

	        int count = stmt.executeUpdate();
	        return (count == 1);
	        
	    } finally {
	        if (stmt != null) stmt.close(); 
	        if (conn != null) conn.close();
	    }
	}

	public boolean feedUpdateByTimestamp(String ts, String ucon, String uimages) throws NamingException, SQLException {
	    Connection conn = null;
	    PreparedStatement stmt = null;

	    try {
	        String sql = "UPDATE feed SET content = ?, images = ? WHERE ts = ?";

	        conn = ConnectionPool.get();
	        stmt = conn.prepareStatement(sql);

	        // content와 images가 모두 null이면 아무 작업도 수행하지 않음
	        if (ucon == null && uimages == null) {
	            return false;
	        }

	        int parameterIndex = 1;

	        if (ucon != null) {
	            stmt.setString(parameterIndex++, ucon);
	        } else {
	            stmt.setNull(parameterIndex++, Types.VARCHAR);
	        }

	        if (uimages != null) {
	            stmt.setString(parameterIndex++, uimages);
	        } else {
	            stmt.setNull(parameterIndex++, Types.VARCHAR);
	        }

	        stmt.setString(parameterIndex, ts);

	        int count = stmt.executeUpdate();
	        return (count == 1);

	    } finally {
	        if (stmt != null) stmt.close();
	        if (conn != null) conn.close();
	    }
	}
    
    public ArrayList<FeedObj> getList() throws NamingException, SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT id, content, ts, images FROM feed ORDER BY ts DESC";
            
            conn = ConnectionPool.get();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            ArrayList<FeedObj> feeds = new ArrayList<FeedObj>();
            while(rs.next()) {
                feeds.add(new FeedObj(rs.getString("id"), rs.getString("content"), rs.getString("ts"), rs.getString("images")));
            }
            return feeds;
            
        } finally {
            if (rs != null) rs.close(); 
            if (stmt != null) stmt.close(); 
            if (conn != null) conn.close();
        }
    }
}

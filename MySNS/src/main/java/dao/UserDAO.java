//UserDAO.java
package dao;

import java.sql.*;
import javax.naming.NamingException;
import util.*;

public class UserDAO {

	public boolean insert(UserBean user) throws NamingException, SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            String sql = "INSERT INTO user(id, password, name, phone_number, email) VALUES(?, ?, ?, ?, ?)";
            
            conn = ConnectionPool.get();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getId());
            stmt.setString(2, user.getPs());
            stmt.setString(3, user.getName());
            stmt.setString(4, user.getPhone()); 
            stmt.setString(5, user.getEmail()); 
            
            int count = stmt.executeUpdate();
            return (count == 1);
            
        } finally {
            if (stmt != null) stmt.close(); 
            if (conn != null) conn.close();
        }
    }
    
    public boolean exists(String uid) throws NamingException, SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT id FROM user WHERE id = ?";
            
            conn = ConnectionPool.get();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, uid);
            
            rs = stmt.executeQuery();
            return rs.next();
            
        } finally {
            if (rs != null) rs.close(); 
            if (stmt != null) stmt.close(); 
            if (conn != null) conn.close();
        }
    }

    public boolean delete(String uid) throws NamingException, SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            String sql = "DELETE FROM user WHERE id = ?";
            
            conn = ConnectionPool.get();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, uid);
            
            int count = stmt.executeUpdate();
            return (count == 1) ? true : false;
            
        } finally {
            if (stmt != null) stmt.close(); 
            if (conn != null) conn.close();
        }
    }

    public int login(String uid, String upass) throws NamingException, SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT id, password FROM user WHERE id = ?";
            
            conn = ConnectionPool.get();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, uid);
            
            rs = stmt.executeQuery();
            if (!rs.next()) return 1;
            if (!upass.equals(rs.getString("password"))) return 2;

            return 0;
            
        } finally {
            if (rs != null) rs.close(); 
            if (stmt != null) stmt.close(); 
            if (conn != null) conn.close();
        }
    }

  //회원정보를 수정하기 위해 기존의 정보를 표시
    public UserBean getUser(String uid) throws NamingException, SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        UserBean user = null;        
        try {
            String sql = "SELECT * FROM user WHERE id = ?";

            conn = ConnectionPool.get();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, uid);
            
            rs = stmt.executeQuery();

            if (rs.next()) {
                user = new UserBean();
                user.setId(rs.getString("id"));
                user.setPs(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setPhone(rs.getString("phone_number"));
                user.setEmail(rs.getString("email")); 
            }
            return user;
            
        } finally {
            if (rs != null) rs.close(); 
            if (stmt != null) stmt.close(); 
            if (conn != null) conn.close();
        }
    }

  //회원의 정보수정
    public boolean update(UserBean user) throws NamingException, SQLException { 

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            String sql = "UPDATE user SET password = ?, name = ?, phone_number = ?, email = ? WHERE id = ?";

            conn = ConnectionPool.get();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getPs());
            stmt.setString(2, user.getName());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getId());

            int count = stmt.executeUpdate();
            return (count == 1) ? true : false;
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }

    }
}

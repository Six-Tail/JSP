<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.ConnectionPool" %>
<%
    Connection conn = ConnectionPool.get();
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT id, name, ts, phone_number, email FROM user");

    String str = "<table align=center>";
    str += "<tr><th colspan=5>가입자 리스트</th></tr>";
    str += "<tr><td>ID</td><td>Name</td><td>Phone Number</td><td>Email</td><td>Timestamp</td></tr>";
    while(rs.next()) {
        str += "<tr><td colspan=5><hr></td></tr>";
        str += "<tr>";
        str += "<td>" + rs.getString("id") + "</td>";
        str += "<td>" + rs.getString("name") + "</td>";
        str += "<td>" + rs.getString("phone_number") + "</td>";
        str += "<td>" + rs.getString("email") + "</td>";
        str += "<td>&nbsp;(" + rs.getTimestamp("ts") + ")</td>";
        str += "</tr>";
    }
    str += "</table>";
    out.print(str);

    rs.close(); stmt.close(); conn.close();
%>

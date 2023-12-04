<!-- feedList.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%
	ArrayList<FeedObj> feeds = (new FeedDAO()).getList();
    
    String str = "<table align=center>";
    str += "<tr><th colspan=2>작성글 리스트</th></tr>";
    for (FeedObj feed : feeds) {
        str += "<tr><td colspan=2><hr></td></tr>";
        str += "<tr>";
    	str += "<td><small>" + feed.getId() + "</small></td>";
    	str += "<td><small>&nbsp;(" + feed.getTs() + ")</small></td>";
        str += "</tr>";
    	str += "<tr><td colspan=2>" + feed.getContent() + "</td></tr>";
    }
    str += "</table>";
    out.print(str);
%>

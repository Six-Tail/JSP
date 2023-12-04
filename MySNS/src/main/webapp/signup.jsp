<!-- signup.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
%>
	<jsp:useBean id="user" class="dao.UserBean">
		<jsp:setProperty name="user" property="*" />
	</jsp:useBean>
<% 
    
	UserDAO dao = new UserDAO();

	if (dao.exists(user.getId())) {
	out.print("이미 가입한 회원입니다.");
	out.print("<script>");
    out.print("setTimeout(function() { window.location.href = 'loginForm.jsp'; }, 1000);");
    out.print("</script>");
	return;
	}
	
    if (dao.insert(user)) {
        out.print("회원 가입이 완료되었습니다.");
        
        out.print("<script>");
        out.print("setTimeout(function() { window.location.href = 'loginForm.jsp'; }, 1000);");
        out.print("</script>");
    }
    else {
        out.print("오류가 발생하였습니다.");
    }
%>

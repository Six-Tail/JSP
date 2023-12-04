<!-- update.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO, dao.UserBean"%>
<%
request.setCharacterEncoding("utf-8");

String uid = request.getParameter("id");
String newPassword = request.getParameter("ps");
String confirmPassword = request.getParameter("ps2");
String newName = request.getParameter("name");
String newPhone = request.getParameter("phone");
String newEmail = request.getParameter("email");

UserDAO dao = new UserDAO();
UserBean user = new UserBean();
user.setId(uid);
user.setPs(newPassword);
user.setName(newName);
user.setPhone(newPhone);
user.setEmail(newEmail);

if (dao.update(user)) {
	out.print("회원정보 수정이 완료되었습니다.");

	out.print("<script>");
	out.print("setTimeout(function() { window.location.href = 'main.jsp'; }, 1000);");
	out.print("</script>");
} else {
	out.print("회원정보 수정 중 오류가 발생하였습니다.");
	out.print("<script>");
	out.print("setTimeout(function() { window.location.href = 'main.jsp'; }, 1000);");
	out.print("</script>");
}
%>

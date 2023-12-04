<!-- withdraw.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.UserBean" %>

<%
    request.setCharacterEncoding("utf-8");

    String uid = request.getParameter("id");

    UserDAO dao = new UserDAO();
    
    // 사용자가 존재하는지 확인
    if (!dao.exists(uid)) {
        out.print("회원 정보를 찾을 수 없습니다.");
        return;
    }

    // 회원탈퇴 처리
    if (dao.delete(uid)) {
        // 회원탈퇴 후 사용자 로그아웃 (세션 비우기)
        session.invalidate();

        // 3, 2, 1 순서로 카운트다운하는 JavaScript 코드 추가
        out.print("<div id='message'>회원 탈퇴가 완료되었습니다. ");
        out.print("<span id='countdown'></span>초 후에 로그인 페이지로 이동됩니다. </div>");

        out.print("<script>");
        out.print("var countdown = 3;");
        out.print("function updateCountdown() {");
        out.print("  document.getElementById('countdown').innerHTML = countdown;");
        out.print("  if (countdown === 0) {");
        out.print("    window.location.href = 'loginForm.jsp';");
        out.print("  } else {");
        out.print("    setTimeout(function() {");
        out.print("      countdown--;");
        out.print("      updateCountdown();");
        out.print("    }, 1000);");
        out.print("  }");
        out.print("}");
        out.print("updateCountdown();");
        out.print("</script>");
    } else {
        out.print("회원 탈퇴 중 오류가 발생하였습니다.");
        out.print("<script>");
        out.print("setTimeout(function() { window.location.href = 'main.jsp'; }, 1000);");
        out.print("</script>");
    }
%>

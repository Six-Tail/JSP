<!-- logout.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    session.invalidate();
	
	out.print("<div id='message'>로그아웃이 완료되었습니다. ");
	out.print("<span id='countdown'></span>초 후에 메인 페이지로 이동됩니다. </div>");

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
%>

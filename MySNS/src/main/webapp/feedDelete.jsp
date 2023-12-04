<%@ page contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="dao.*" %>
<%
    String tsToDelete = request.getParameter("tsToDelete");

    // 로그 추가
    System.out.println("Debug: tsToDelete value: " + tsToDelete);

    // feedDeleteByTimestamp 메서드 호출
    boolean success = (new FeedDAO()).feedDeleteByTimestamp(tsToDelete);

    // 결과 처리, 예를 들어 성공 또는 오류 메시지 표시
    if (success) {
        out.println("게시글이 성공적으로 삭제되었습니다");
        out.print("<script>");
        out.print("setTimeout(function() { window.location.href = 'main.jsp'; }, 1000);");
        out.print("</script>");
    } else {
        out.println("게시글 삭제 중 오류가 발생했습니다");
        out.print("<script>");
        out.print("setTimeout(function() { window.location.href = 'main.jsp'; }, 1000);");
        out.print("</script>");
    }
%>

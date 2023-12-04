<!-- feedUpdate.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="util.FileUtil" %>
<%@ page import="dao.FeedDAO" %>
<%@ page import="dao.FeedObj" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dao.UserBean" %>

<%
    request.setCharacterEncoding("utf-8");

    // 세션에서 사용자 ID 가져오기
    String uid = (String) session.getAttribute("id");

    String ts = request.getParameter("ts");
    
    String feedId = request.getParameter("feedId");

    System.out.println("Debug: Feed ID from Session: " + feedId);  // 디버깅 출력
    // 수정할 게시글 정보 가져오기
    FeedDAO feedDAO = new FeedDAO();
    FeedObj selectedFeed = feedDAO.getFeed(feedId);

    if (selectedFeed == null) {
        // 선택한 게시글이 없을 경우 메인 페이지로 리다이렉트
        response.sendRedirect("main.jsp");
        return;
    }

    String ucon = null;

    ServletFileUpload sfu = new ServletFileUpload(new DiskFileItemFactory());
    List<FileItem> items = sfu.parseRequest(request);

    Iterator<FileItem> iter = items.iterator();
    while(iter.hasNext()) {
        FileItem item = iter.next();
        String name = item.getFieldName();
        if(item.isFormField()) {
            String value = new String(item.getString().getBytes("8859_1"), "utf-8");
            if (name.equals("content")) ucon = value;
        }
    }

 // 이미지가 있는 경우에만 처리
    String ufname = null;
    byte[] ufile = null;
    Optional<FileItem> imageItemOptional = items.stream()
            .filter(item -> "image".equals(item.getFieldName()))
            .findFirst();

    if (imageItemOptional.isPresent() && !imageItemOptional.get().getName().isEmpty()) {
        FileItem imageItem = imageItemOptional.get();
        ufname = imageItem.getName();
        ufile = imageItem.get();
        String root = application.getRealPath(java.io.File.separator);
        FileUtil.saveImage(root, ufname, ufile);
    }


 // FeedDAO를 통해 게시글 수정
    if (feedDAO.feedUpdateByTimestamp(ts, ucon, ufname)) {
        response.sendRedirect("main.jsp");
    } else {
        out.print("게시글 수정 중 오류가 발생하였습니다.");
        out.print("<script>");
        out.print("setTimeout(function() { window.location.href = 'main.jsp'; }, 1000);");
        out.print("</script>");
    }
%>

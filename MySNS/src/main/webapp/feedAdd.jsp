<!-- feedAdd.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="util.FileUtil" %>
<%@ page import="dao.FeedDAO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dao.UserBean" %>

<%
    request.setCharacterEncoding("utf-8");

    // 세션에서 사용자 ID 가져오기
    String uid = (String) session.getAttribute("id");
    System.out.println("Debug: User ID from Session: " + uid);  // 디버깅 출력

    String ucon = null;

    // 디버깅을 위해 출력 추가
    System.out.println("Debug: User ID before getting content: " + uid);

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

 // insert 메서드에서 uid 사용
    FeedDAO dao = new FeedDAO();
    if (dao.insert(uid, ucon, ufname)) {
        response.sendRedirect("main.jsp");
    } else {
        out.print("작성 글의 업로드 중 오류가 발생하였습니다.");
        out.print("<script>");
        out.print("setTimeout(function() { window.location.href = 'main.jsp'; }, 1000);");
        out.print("</script>");
    }
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.FeedDAO, dao.FeedObj"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="util.FileUtil"%>

<%
request.setCharacterEncoding("utf-8");

String ts = request.getParameter("ts");

FeedDAO feedDAO = new FeedDAO();
FeedObj selectedFeed = feedDAO.getFeed(ts);

if (selectedFeed == null) {
	response.sendRedirect("main.jsp");
	return;
}

String ucon = null;
String ufname = selectedFeed.getImages(); // Keep the existing image if no new image is uploaded

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

Optional<FileItem> imageItemOptional = items.stream()
        .filter(item -> "image".equals(item.getFieldName()))
        .findFirst();

if (imageItemOptional.isPresent() && !imageItemOptional.get().getName().isEmpty()) {
    FileItem imageItem = imageItemOptional.get();
    ufname = FileUtil.generateFileName(imageItem.getName()); // Generate a new file name
    byte[] ufile = imageItem.get();
    String root = application.getRealPath(java.io.File.separator);
    FileUtil.saveImage(root, ufname, ufile);
}

if (feedDAO.feedUpdateByTimestamp(ts, ucon, ufname)) {
    response.sendRedirect("main.jsp");
} else {
    out.print("게시글 수정 중 오류가 발생하였습니다.");
    out.print("<script>");
    out.print("setTimeout(function() { window.location.href = 'main.jsp'; }, 1000);");
    out.print("</script>");
}
%>

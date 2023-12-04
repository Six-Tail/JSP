<%@ page contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>

<%
    // Java code for handling logic

    String uid = (String) session.getAttribute("id");
    if (uid == null) {
        response.sendRedirect("loginForm.jsp");
        return;
    }
    session.setAttribute("id", uid);

    int recordsPerPage = 5;
    int currentPage = 1;
    String pageParam = request.getParameter("page");
    if (pageParam != null) {
        currentPage = Integer.parseInt(pageParam);
    }

    ArrayList<FeedObj> feeds = (new FeedDAO()).getList();

    int totalRecords = feeds.size();
    int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

    int startIdx = (currentPage - 1) * recordsPerPage;
    int endIdx = Math.min(startIdx + recordsPerPage, totalRecords);
    List<FeedObj> currentFeeds = feeds.subList(startIdx, endIdx);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main Page</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(115deg, #56d8e4 10%, #9f01ea 90%);
            color: #333;
            margin: 20px;
            min-height: 100vh;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        td img {
            display: block;
            margin: 0 auto;
            max-width: 100%;
            height: auto;
        }

        button {
            padding: 8px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        a {
            text-decoration: none;
            color: #4CAF50;
        }

        a:hover {
            text-decoration: underline;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination a {
            color: #4CAF50;
            padding: 8px;
            margin: 0 4px;
            text-decoration: none;
        }

        .pagination b {
            padding: 8px;
            margin: 0 4px;
            color: white;
        }
    </style>
</head>
<body>
    <table>
        <thead>
            <tr>
                <th colspan="2">작성글 리스트</th>
                <th align="right">
                    <a href="feedAddForm.jsp"><button>글쓰기</button></a>
                    <a href="logout.jsp"><button>로그아웃</button></a>
                    <a href="updateForm.jsp"><button>회원정보수정</button></a>
                    <a href="withdrawForm.jsp"><button>회원탈퇴</button></a>
                </th>
            </tr>
        </thead>
        <tbody>
            <!-- Loop through the feeds -->
            <% for (FeedObj feed : currentFeeds) { %>
                <!-- HTML markup for each feed -->
                <tr>
                    <td colspan="3"><hr></td>
                </tr>
                <tr>
                    <td colspan="2"><small><%= feed.getId() %></small></td>
                    <td align="right"><small style="float: right;">(<%= feed.getTs() %>)</small></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <!-- Check if there is an image -->
                        <% if (feed.getImages() != null) { %>
                            <img src="images/<%= feed.getImages() %>" alt="Feed Image">
                        <% } %>
                    </td>
                </tr>
                <tr>
                    <td colspan="3"><%= feed.getContent() %></td>
                </tr>

                <!-- Check if the user is the author of the feed for edit and delete options -->
                <% if (uid.equals(feed.getId())) { %>
                    <tr>
                        <td colspan="3" align="right">
                            <!-- Edit form -->
                            <form action="feedUpdateForm.jsp" method="post" style="display: inline; margin-right: 3px;">
                                <input type="hidden" name="feedId" value="<%= feed.getId() %>">
                                <button type="submit">수정</button>
                            </form>
                            
                            <!-- Delete form -->
                            <form action="confirmFeedDelete.jsp" method="post" style="display: inline;">
                                <input type="hidden" name="tsToDelete" value="<%= feed.getTs() %>">
                                <button type="submit">삭제</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            <% } %>
        </tbody>
    </table>

    <!-- Paging links -->
    <div class="pagination">
        <% for (int i = 1; i <= totalPages; i++) { %>
            <% if (i == currentPage) { %>
                <b><%= i %></b>&nbsp;
            <% } else { %>
                <a href="main.jsp?page=<%= i %>"><%= i %></a>&nbsp;
            <% } %>
        <% } %>
    </div>

</body>
</html>

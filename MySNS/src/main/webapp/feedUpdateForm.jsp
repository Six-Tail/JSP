<!-- feedUpdateForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.FeedDAO, dao.FeedObj"%>
<%@ page import="java.util.ArrayList"%>

<%
String uid = (String) session.getAttribute("id");
if (uid == null) {
	response.sendRedirect("loginForm.jsp");
	return;
}

FeedDAO feedDAO = new FeedDAO();
ArrayList<FeedObj> feeds = feedDAO.getList();

// 게시글 목록에서 선택한 게시글의 ID
String selectedFeedId = request.getParameter("feedId");
String selectedFeedTs = request.getParameter("ts");

System.out.println("Debug: selectedFeed ID from Session: " + selectedFeedId); // 디버깅 출력
System.out.println("Debug: selectedFeed Ts from Session: " + selectedFeedTs); // 디버깅 출력

// 선택한 게시글 정보 가져오기
FeedObj selectedFeed = null;
for (FeedObj feed : feeds) {
	if (feed.getId().equals(selectedFeedId) && feed.getTs().equals(selectedFeedTs)) {
		selectedFeed = feed;
		break;
	}
}

// 선택한 게시글이 없을 경우 메인 페이지로 리다이렉트
if (selectedFeed == null) {
	response.sendRedirect("main.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>글 수정하기</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Montserrat:600|Noto+Sans|Open+Sans:400,700&display=swap">
<style>
* {
	margin: 0;
	padding: 0;
	border-radius: 5px;
	box-sizing: border-box;
}

body {
	height: 100vh;
	display: flex;
	align-items: center;
	text-align: center;
	font-family: sans-serif;
	justify-content: center;
	background-size: cover;
	background-position: center;
	background: linear-gradient(115deg, #56d8e4 10%, #9f01ea 90%);
}

form {
	position: relative;
	width: 400px;
	height: auto;
	background: white;
	padding: 60px 40px;
}

header {
	font-size: 40px;
	margin-bottom: 60px;
	font-family: 'Montserrat', sans-serif;
}

.input-field, form .button {
	margin: 25px 0;
	position: relative;
	height: 50px;
	width: 100%;
}

.input-field input {
	height: 100%;
	width: 100%;
	border: 1px solid silver;
	padding-left: 15px;
	outline: none;
	font-size: 19px;
	transition: .4s;
}

input:focus {
	border: 1px solid #1DA1F2;
}

.input-field label, span.show {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
}

.input-field label {
	left: 15px;
	pointer-events: none;
	color: grey;
	font-size: 18px;
	transition: .4s;
}

span.show {
	right: 20px;
	color: #111;
	font-size: 14px;
	font-weight: bold;
	cursor: pointer;
	user-select: none;
	visibility: hidden;
	font-family: 'Open Sans', sans-serif;
}

input:valid ~span.show {
	visibility: visible;
}

input:focus ~label, input:valid ~label {
	transform: translateY(-33px);
	background: white;
	font-size: 16px;
	color: #1DA1F2;
}

form .button {
	margin-top: 30px;
	overflow: hidden;
	z-index: 111;
}

.input-field input:focus {
	border: 1px solid #1DA1F2;
}

.input-field textarea:focus {
	border: 1px solid #1DA1F2;
}

.input-field image:focus {
	border: 1px solid #1DA1F2;
}

.input-field textarea:valid ~ label {
	transform: translateY(-33px);
	background: white;
	font-size: 16px;
	color: #1DA1F2;
}

.input-field input:focus ~ label, .input-field textarea:focus ~ label {
	transform: translateY(-33px);
	background: white;
	font-size: 16px;
	color: #1DA1F2;
}

.button .inner {
	position: absolute;
	height: 100%;
	width: 300%;
	left: -100%;
	z-index: -1;
	transition: all .4s;
	background: -webkit-linear-gradient(right, #00dbde, #fc00ff, #00dbde, #fc00ff);
}
/* 아이디 라벨에만 스타일 적용 */
.input-field input[name="id"]:not(:focus) ~ label {
	transform: translateY(-33px);
	background: white;
	font-size: 16px;
	color: #1DA1F2;
}

.button:hover .inner {
	left: 0;
}

.button button {
	width: 100%;
	height: 100%;
	border: none;
	background: none;
	outline: none;
	color: white;
	font-size: 20px;
	cursor: pointer;
	font-family: 'Montserrat', sans-serif;
}

.container .auth {
	margin: 35px 0 20px 0;
	font-size: 19px;
	color: grey;
}

a {
	color: #1DA1F2;
	text-decoration: none;
}

a:hover {
	text-decoration: none;
}

.input-field textarea {
	position: relative;
	height: 100%; /* Adjust the height as needed */
	width: 100%;
	border: 1px solid silver;
	padding-left: 15px;
	outline: none;
	font-size: 16px;
	padding: 15px; /* 수정: 상하 여백을 통해 텍스트의 높이 중앙을 조절합니다. */
	transition: .4s;
	resize: none; /* Disable textarea resizing by the user */
	align-items: center;
}
/* Added styles for the file input box */
.input-field input[type="file"] {
	position: relative;
	height: 100%;
	width: 100%;
	border: 1px solid silver;
	padding-left: 15px;
	outline: none;
	font-size: 16px;
	padding: 12px;
	transition: .4s;
	align-items: center;
}

</style>
</head>
<body>
    <form action="feedUpdate.jsp?feedId=<%=selectedFeed.getId()%>&ts=<%=selectedFeed.getTs()%>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%=selectedFeed.getId()%>">
        <header>글 수정</header>
        <div class="input-field">
            <input type="hidden" name="id" value="<%=selectedFeed.getId()%>">
            <input type="text" name="id" class="idInput" value="<%=selectedFeed.getId()%>" required readonly>
            <label for="id">아이디</label>
        </div>
        <div class="input-field">
            <textarea name="content" required><%=selectedFeed.getContent()%></textarea>
            <label for="content">수정글</label>
        </div>
        <div class="input-field">
            <!-- Modified the file input -->
            <input type="file" name="image" <%=selectedFeed.getImages()%>>
            <label for="image">이미지</label>
        </div>
        <div class="button">
            <div class="inner"></div>
            <button type="submit">수정하기</button>
        </div>
    </form>
</body>
</html>

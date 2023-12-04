<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO, dao.UserBean"%>

<%
String uid = (String) session.getAttribute("id");

if (uid == null) {
	response.sendRedirect("loginForm.jsp");
	return;
}

UserDAO dao = new UserDAO();
UserBean user = dao.getUser(uid);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>글 작성하기</title>
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
/* 이미지 input 박스 스타일 수정 */
.input-field input[type="file"] {
	position: relative;
	height: 100%; /* Adjust the height as needed */
	width: 100%;
	border: 1px solid silver;
	padding-left: 15px;
	outline: none;
	font-size: 16px;
	padding: 12px; /* 수정: 상하 여백을 통해 텍스트의 높이 중앙을 조절합니다. */
	transition: .4s;
	align-items: center;
}
</style>
</head>
<body>
	<form action="feedAdd.jsp" method="post" enctype="multipart/form-data">
		<header>글 작성</header>
		<div class="input-field">
			<input type="hidden" name="id" value="<%=user.getId()%>"> <input
				type="text" name="id" class="idInput" value="<%=user.getId()%>"
				required readonly> <label for="id">아이디</label>
		</div>
		<div class="input-field">
			<textarea name="content" required ></textarea>
			<label for="content">작성글</label>
		</div>
		<div class="input-field">
			<input type="file" name="image"> 
			<label for="image">이미지</label>
		</div>
		<div class="button">
			<div class="inner"></div>
			<button type="submit">업로드하기</button>
		</div>
	</form>
</body>
</html>

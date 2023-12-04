<!-- withdrawForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.UserBean"%>

<%
// 사용자가 로그인되어 있는지 확인
String uid = (String) session.getAttribute("id");

if (uid == null) {
	// 로그인되어 있지 않다면 로그인 페이지로 리다이렉트
	response.sendRedirect("loginForm.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인 창</title>
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
}

.container {
	position: relative;
	width: 400px;
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

/* 아이디 라벨에만 스타일 적용 */
.input-field input[name="id"]:not(:focus) ~ label {
	transform: translateY(-33px);
	background: white;
	font-size: 16px;
	color: #1DA1F2;
}

.button {
	position: relative;
	overflow: hidden;
	margin-top: 30px;
	margin-right: 20px;
	margin-left: 20px;
	height: 50px; /* 예시로 높이를 지정, 실제로 필요한 높이로 조정하세요 */
}

.button .inner {
	position: absolute;
	height: 100%;
	width: 300%;
	left: -100%;
	z-index: 1;
	transition: all 0.4s;
	background: linear-gradient(to right, #00dbde, #fc00ff, #00dbde, #fc00ff);
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
	position: relative;
	z-index: 1;
}

.container .auth {
	margin: 35px 0 20px 0;
	font-size: 19px;
	color: grey;
}
a {
	color: #1DA1F2; /* 파란색으로 변경 */
	text-decoration: none;
}

a:hover {
	text-decoration: none; /* 밑줄 없애기 */
}
</style>
</head>
<body
	style="background: linear-gradient(115deg, #56d8e4 10%, #9f01ea 90%);">
	<div class="container">
		<header>회원탈퇴</header>
		<form action="withdraw.jsp">
			<div class="input-field">
				<input type="text" name="id" value="<%=uid%>" readonly> <label
					for="id">아이디</label>
			</div>
			<div class="button">
				<div class="inner"></div>
				<button type="submit">탈퇴하기</button>
			</div>
		</form>
		<p class="auth">
			<a href="main.jsp">홈으로 돌아가기</a>
		</p>
	</div>
</body>
</html>

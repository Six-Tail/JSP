<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
session.invalidate();
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

.button .inner {
	position: absolute;
	height: 100%;
	width: 300%;
	left: -100%;
	z-index: -1;
	transition: all .4s;
	background: -webkit-linear-gradient(right, #00dbde, #fc00ff, #00dbde, #fc00ff);
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

.links {
	display: flex;
	cursor: pointer;
}

.signup {
	margin-top: 50px;
	font-family: 'Noto Sans', sans-serif;
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
		<header>로그인</header>
		<form action="login.jsp">
			<div class="input-field">
				<input type="text" name="id" required> <label for="id">아이디</label>
			</div>
			<div class="input-field">
				<input type="password" name="ps" required> <label for="ps">패스워드</label>
			</div>
			<div class="button">
				<div class="inner"></div>
				<button type="submit">로그인하기</button>
			</div>
		</form>
		<p class="auth">
			회원이 아니신가요? <a href="signupForm.jsp">회원가입</a>
		</p>
	</div>
</body>
</html>

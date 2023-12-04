<!-- confirmFeedDelete.jsp -->
<%@ page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="dao.*"%>
<%
// 삭제할 피드의 타임스탬프를 가져옵니다.
String tsToDelete = request.getParameter("tsToDelete");

// 사용자가 로그인되어 있는지 확인합니다.
String uid = (String) session.getAttribute("id");
if (uid == null) {
	response.sendRedirect("loginForm.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>삭제 확인</title>
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
	margin: 0;
	overflow: hidden;
}

.container {
	display: flex;
	flex-direction: column;
	align-items: center;
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

.confirmation-text {
	margin-bottom: 20px;
	font-family: 'Noto Sans', sans-serif;
}

.button-container {
    display: flex;
    justify-content: space-between;
    flex-direction: row-reverse;
}

.button {
	position: relative;
	overflow: hidden;
	margin-top: 30px;
	margin-right: 20px;
	margin-left: 20px;
	height: 50px; /* 예시로 높이를 지정, 실제로 필요한 높이로 조정하세요 */
	width: 100px;
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
</style>
</head>
<body
	style="background: linear-gradient(115deg, #56d8e4 10%, #9f01ea 90%);">
	<div class="container">
		<header>게시글 삭제 확인</header>
		<p class="confirmation-text">정말로 이 게시글을 삭제하시겠습니까?</p>
		<form action='feedDelete.jsp' method='post'>
			<input type='hidden' name='tsToDelete' value='<%=tsToDelete%>'>
			<div class="button-container">
				<div class="button">
					<div class="inner"></div>
					<button formaction='main.jsp' type="submit">아니오</button>
				</div>
				<div class="button">
					<div class="inner"></div>
					<button type="submit">예</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>


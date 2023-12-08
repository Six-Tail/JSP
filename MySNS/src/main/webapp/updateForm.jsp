<!-- updateForm.jsp -->
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
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원정보 수정</title>
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
	width: 450px;
	background: white;
	padding: 60px 40px;
}

header {
	font-size: 40px;
	margin-bottom: 60px;
	font-family: 'Montserrat', sans-serif;
}

.input-field, form .button {
	margin: 30px 0;
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
/* 아이디 라벨에만 스타일 적용 */
.input-field input[name="id"]:not(:focus) ~ label {
	transform: translateY(-33px);
	background: white;
	font-size: 16px;
	color: #1DA1F2;
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

.button {
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
	width: 100%; /* 버튼의 넓이에 따라 조정 */
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

.error-message {
	color: red;
	font-size: 14px;
}
</style>
</head>
<body
	style="background: linear-gradient(115deg, #56d8e4 10%, #9f01ea 90%);">
	<div class="container">
		<header>회원정보 수정</header>
		<form action="update.jsp" method="post"
			onsubmit="return validateForm()">
			<div class="input-field">
				<input type="hidden" name="id" value="<%=user.getId()%>"> <input
					type="text" name="id" class="idInput" value="<%=user.getId()%>"
					required readonly> <label for="id">아이디</label>
			</div>
			<div class="input-field">
				<input type="password" name="ps" id="password"
					value="<%=user.getPs()%>" required> <label for="ps">패스워드</label>
				<span id="passwordError" class="error-message"></span>
			</div>
			<div class="input-field">
				<input type="password" name="ps2" id="confirmPassword"
					value="<%=user.getPs()%>" required> <label for="ps2">패스워드(확인)</label>
				<span id="confirmPasswordError" class="error-message"></span>
			</div>
			<div class="input-field">
				<input type="text" name="name" value="<%=user.getName()%>" required>
				<label for="name">이름</label>
			</div>
			<div class="input-field">
				<input type="text" name="phone" value="<%=user.getPhone()%>"
					required> <label for="phone">전화번호 '-' 없이 숫자만 입력</label> <span
					id="phoneError" class="error-message"></span>
			</div>
			<div class="input-field">
				<input type="text" name="email" value="<%=user.getEmail()%>"
					required> <label for="email">이메일</label> <span
					id="emailError" class="error-message"></span>
			</div>
			<div class="button">
				<div class="inner"></div>
				<button type="submit">회원정보 수정하기</button>
			</div>
		</form>
		<p class="auth">
			<a href="main.jsp">홈으로 돌아가기</a>
		</p>
	</div>
	<script type="text/javascript">
		// JavaScript 코드 추가
		window.onload = function() {
			var idInput = document.querySelector('.idInput');
			var idLabel = document.querySelector('label[for="id"]');

			if (idInput.readOnly) {
				// 읽기 전용이면 라벨의 스타일 조정
				idLabel.style.left = '15px';
			}
		};

		function validateForm() {
			var password = document.getElementsByName("ps")[0].value;
			var confirmPassword = document.getElementsByName("ps2")[0].value;
			var phone = document.getElementsByName("phone")[0].value;
			var email = document.getElementsByName("email")[0].value;

			// 패스워드 유효성 검사
			var passwordError = document.getElementById("passwordError");
			if (!isValidPassword(password)) {
				passwordError.innerHTML = "영문, 숫자, 특수문자 조합으로 8~16자여야 합니다.";
				return false;
			} else {
				passwordError.innerHTML = "";
			}

			// 패스워드 확인 일치 여부 확인
			var confirmPasswordError = document
					.getElementById("confirmPasswordError");
			if (password !== confirmPassword) {
				confirmPasswordError.innerHTML = "패스워드가 일치하지 않습니다.";
				return false;
			} else {
				confirmPasswordError.innerHTML = "";
			}

			// 전화번호 숫자만 입력 여부 확인
			var phoneError = document.getElementById("phoneError");
			if (!isValidPhone(phone)) {
				phoneError.innerHTML = "전화번호는 '-' 없이 숫자(11자)만 입력하세요.";
				return false;
			} else {
				phoneError.innerHTML = "";
			}

			// Email 유효성 검사
			var emailError = document.getElementById("emailError");
			if (!isValidEmail(email)) {
				emailError.innerHTML = "올바른 이메일 형식이 아닙니다.";
				return false;
			} else {
				emailError.innerHTML = "";
			}

			return true;
		}

		function isValidPassword(password) {
			// 영문, 숫자, 특수문자 조합으로 8~16자
			var passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$/;
			return passwordRegex.test(password);
		}

		function isValidEmail(email) {
			// 이메일 유효성 검사
			var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
			return emailRegex.test(email);
		}

		function isValidPhone(phone) {
		    // 숫자만 입력이고 11자인지 확인
		    var phoneRegex = /^\d{11}$/;
		    return phoneRegex.test(phone);
		}
	</script>

</body>
</html>

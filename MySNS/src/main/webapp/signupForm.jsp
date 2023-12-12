<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 창</title>
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

.input-field .idCheckButton {
	padding: 10px 15px;
	right: 10px;
	top: 5px;
	height: 80%;
	width: 100px;
	background: -webkit-linear-gradient(right, #00dbde, #fc00ff, #00dbde, #fc00ff);
	outline: none;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-family: 'Montserrat', sans-serif;
	transition: background 0.3s ease;
	background-size: 250%;
	background-position: bottom;
	position: absolute;
	overflow: hidden;
	font-size: medium;
}

.input-field .idCheckButton:hover {
	background-position: left 0;
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
		<header>회원가입</header>
		<form action="signup.jsp" onsubmit="return validateForm()">
			<div class="input-field">
				<input type="text" name="id" class="idInput" required> <label
					for="id">아이디</label>
				<button type="button" class="idCheckButton"
					onclick="id_check(document.getElementsByName('id')[0].value)">중복확인</button>
				<span id="idError" class="error-message"></span>
			</div>
			<div class="input-field">
				<input type="password" name="ps" id="password" required> <label
					for="ps">패스워드</label> <span id="passwordError"
					class="error-message"></span>
			</div>
			<div class="input-field">
				<input type="password" name="ps2" id="confirmPassword" required>
				<label for="ps2">패스워드(확인)</label> <span id="confirmPasswordError"
					class="error-message"></span>
			</div>
			<div class="input-field">
				<input type="text" name="name" required> <label for="name">이름</label>
			</div>
			<div class="input-field">
				<input type="text" name="phone" required> <label for="phone">전화번호
					'-'없이 숫자만 입력</label> <span id="phoneError" class="error-message"></span>
			</div>
			<div class="input-field">
				<input type="text" name="email" required> <label for="email">이메일</label>
				<span id="emailError" class="error-message"></span>
			</div>
			<div class="button">
				<div class="inner"></div>
				<button type="submit">회원가입하기</button>
			</div>
		</form>
		<p class="auth">
			이미 회원이신가요? <a href="loginForm.jsp">로그인</a>
		</p>
	</div>
	<script type="text/javascript">
		function id_check(id) {
			if (id == "") {
				alert("ID를 입력하세요");
				return;
			}

			// ID 유효성 검사
			if (!isValidId(id)) {
				alert("아이디는 4~20자의 영어나 숫자만 입력하세요.");
				return;
			}

			url = "confirmId.jsp?id=" + id;
			window.open(url, "confirm", "width=300, height=200");
		}

		function validateForm() {
			var password = document.getElementById("password").value;
			var confirmPassword = document.getElementById("confirmPassword").value;
			var phone = document.getElementsByName("phone")[0].value;
			var id = document.getElementsByName("id")[0].value;
			var email = document.getElementsByName("email")[0].value;

			// ID 유효성 검사
			var idError = document.getElementById("idError");
			if (!isValidId(id)) {
				idError.innerHTML = "아이디는 4~20자의 영어나 숫자만 입력하세요.";
				return false;
			} else {
				idError.innerHTML = "";
			}

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
				phoneError.innerHTML = "전화번호는 '-'없이 숫자(11자)만 입력하세요.";
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

		function isValidId(id) {
			// 4~20자의 영어나 숫자만 입력
			var idRegex = /^[a-zA-Z0-9]{4,20}$/;
			return idRegex.test(id);
		}

		function isValidPhone(phone) {
			// 숫자만 입력이고 11자인지 확인
			var phoneRegex = /^\d{11}$/;
			return phoneRegex.test(phone);
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
	</script>
</body>
</html>

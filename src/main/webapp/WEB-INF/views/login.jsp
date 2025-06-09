<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="login-container">
    <div class="login-box">
        <h2>로그인</h2>

        <c:if test="${not empty sessionScope.loginError}">
            <div class="error-msg">${sessionScope.loginError}</div>
            <c:remove var="loginError" scope="session"/>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="login-button">로그인</button>
        </form>
    </div>
</div>
</body>
</html>
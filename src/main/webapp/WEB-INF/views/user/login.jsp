<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="login-container">
    <div class="login-box">
        <h2>로그인</h2>

        <!-- 로그인 실패 메시지 -->
        <c:if test="${param.error != null}">
            <div class="alert alert-error">
                아이디 또는 비밀번호가 올바르지 않습니다.
            </div>
        </c:if>

        <!-- 로그아웃 성공 메시지 -->
        <c:if test="${param.logout != null}">
            <div class="alert alert-success">
                정상적으로 로그아웃되었습니다.
            </div>
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
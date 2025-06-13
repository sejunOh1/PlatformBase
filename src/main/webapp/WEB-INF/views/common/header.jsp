<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="main-header">
    <div class="header-left">
        <img src="${pageContext.request.contextPath}/static/img/logo.png" alt="Logo" class="logo-icon">
    </div>


    <!-- 상단 메뉴 -->
    <nav class="header-nav">
        <ul>
            <li><a href="${pageContext.request.contextPath}/test-1">Test no1</a></li>
            <li><a href="${pageContext.request.contextPath}/test-2">Test no2</a></li>
            <li><a href="${pageContext.request.contextPath}/test-3">Test no3</a></li>
            <li><a href="${pageContext.request.contextPath}/test-4">Test no4</a></li>
            <li><a href="${pageContext.request.contextPath}/test-5">Test no5</a></li>
            <li><a href="${pageContext.request.contextPath}/test-6">Test no6</a></li>
        </ul>
    </nav>

    <%--<div class="header-right">
        <div class="notification">
            <img src="${pageContext.request.contextPath}/static/img/bell.svg" alt="Notifications" class="icon">
        </div>
        <div class="user-info">
            <span class="username">User123</span>
            <img src="${pageContext.request.contextPath}/static/img/profile.jpg" alt="Profile" class="profile-img">
        </div>
    </div>--%>

</header>
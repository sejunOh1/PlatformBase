<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
</head>

<header class="main-header">
    <div class="header-left">
        <img src="${pageContext.request.contextPath}/static/img/logo.png" alt="Logo" class="logo-icon">
    </div>
    <div class="header-right">
        <div class="notification">
            <img src="${pageContext.request.contextPath}/static/img/bell.svg" alt="Notifications" class="icon">
        </div>
        <div class="user-info">
            <span class="username">User123</span>
            <img src="${pageContext.request.contextPath}/static/img/profile.jpg" alt="Profile" class="profile-img">
        </div>
    </div>
</header>

<body>
<div class="dashboard">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="logo">
            <span>MyDash</span>
        </div>
        <nav>
            <ul>
                <li class="active"><a href="#">Dashboard</a></li>
                <li><a href="#">Manage</a></li>
                <li><a href="#">Component Test</a></li>
                <li><a href="#">API Console</a></li>
                <li><a href="#">Message Alert</a></li>
            </ul>
        </nav>
    </aside>

    <!-- Main Content -->
    <div class="main">
        <!-- Content -->
        <section class="content">
            <h2>대시보드 개요</h2>
            <div class="cards">
                <div class="card">
                    <h3>테스트 슬롯1</h3>
                    <p>12건</p>
                </div>
                <div class="card">
                    <h3>테스트 슬롯2</h3>
                    <p>1,450장</p>
                </div>
                <div class="card">
                    <h3>테스트 슬롯3</h3>
                    <p>7일</p>
                </div>
            </div>
        </section>
    </div>
</div>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>MyDash Layout</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <tiles:insertAttribute name="header" />
    <tiles:insertAttribute name="sidebar" />

    <main class="main-content">
        <tiles:insertAttribute name="body" />
    </main>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>MyDash Layout</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

    <main class="main-content">
        <c:import url="/WEB-INF/views/${contentPage}" />
    </main>

</body>
</html>
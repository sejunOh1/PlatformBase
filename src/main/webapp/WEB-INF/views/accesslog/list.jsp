<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>Access Log</title>

    <!-- Toast UI Grid -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/tui/tui-grid.css" />
    <script src="${pageContext.request.contextPath}/static/js/tui/tui-grid.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

    <style>
        #grid { margin-top: 20px; }
        h1 { font-size: 1.8rem; font-weight: bold; }
    </style>
</head>
<body>
<h1>Access Log 조회</h1>
<div id="grid"></div>

<script>
    const grid = new tui.Grid({
        el: document.getElementById('grid'),
        rowHeaders: ['rowNum'],
        bodyHeight: 500,
        scrollX: true,
        scrollY: true,
        columns: [
            { header: 'ID', name: 'id', width: 80 },
            { header: '사용자명', name: 'username' },
            { header: '접속시간', name: 'accessTime' },
            { header: 'IP 주소', name: 'ipAddress' },
            { header: 'User-Agent', name: 'userAgent' },
            { header: '요청 URI', name: 'requestUri' },
            { header: 'HTTP 메서드', name: 'httpMethod' },
            { header: '응답 상태', name: 'responseStatus' },
            { header: '로그인 성공', name: 'loginSuccess' }
        ]
    });

    // 데이터 AJAX 로딩 (헤더 명시 포함)
    fetch('${pageContext.request.contextPath}/accesslog/list.json', {
        headers: {
            'Accept': 'application/json'  // 서버에게 JSON 응답을 요청
        }
    })
        .then(res => {
            if (!res.ok) throw new Error("서버 응답 오류");
            return res.json();
        })
        .then(data => grid.resetData(data))
        .catch(error => {
            console.error('Fetch error:', error);
        });

</script>
</body>
</html>
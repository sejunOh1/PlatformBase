<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>Manage List</title></head>
<body>
<h2>Manage List</h2>

<form action="save" method="post">
    <input type="hidden" name="id" />
    제목: <input type="text" name="title" required /> <br/>
    내용: <textarea name="content" required></textarea><br/>
    <button type="submit">저장</button>
</form>

<hr/>
<table border="1">
    <tr><th>ID</th><th>제목</th><th>내용</th><th>삭제</th></tr>
    <c:forEach var="item" items="${items}">
        <tr>
            <td>${item.id}</td>
            <td>${item.title}</td>
            <td>${item.content}</td>
            <td><a href="delete?id=${item.id}">삭제</a></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
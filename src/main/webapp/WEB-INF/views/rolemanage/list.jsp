<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>권한 목록</h2>

<div style="margin-bottom: 15px;">
  <a href="${pageContext.request.contextPath}/role/form">
    ➕ 새 권한 등록
  </a>
</div>

<table border="1" cellpadding="8" cellspacing="0" style="width: 100%; border-collapse: collapse;">
  <thead>
  <tr style="background-color: #f0f0f0;">
    <th style="width: 10%;">ID</th>
    <th style="width: 30%;">권한 이름</th>
    <th style="width: 40%;">설명</th>
    <th style="width: 20%;">관리</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="role" items="${roleList}">
    <tr>
      <td>${role.id}</td>
      <td>${role.roleName}</td>
      <td>${role.description}</td>
      <td>
        <a href="${pageContext.request.contextPath}/role/form?id=${role.id}">수정</a>
        |
        <a href="${pageContext.request.contextPath}/role/delete?id=${role.id}"
           onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
      </td>
    </tr>
  </c:forEach>

  <c:if test="${empty roleList}">
    <tr>
      <td colspan="4" style="text-align: center;">등록된 권한이 없습니다.</td>
    </tr>
  </c:if>
  </tbody>
</table>
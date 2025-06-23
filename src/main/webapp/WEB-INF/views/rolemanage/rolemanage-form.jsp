<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>${role.id == null ? "권한 등록" : "권한 수정"}</h2>

<form action="${pageContext.request.contextPath}/role/save" method="post">
  <!-- 수정 시에는 ID 포함 -->
  <c:if test="${role.id != null}">
    <input type="hidden" name="id" value="${role.id}" />
  </c:if>

  <table>
    <tr>
      <td><label for="roleName">권한 이름</label></td>
      <td>
        <input type="text" id="roleName" name="roleName" value="${role.roleName}" required />
      </td>
    </tr>
    <tr>
      <td><label for="description">설명</label></td>
      <td>
        <input type="text" id="description" name="description" value="${role.description}" />
      </td>
    </tr>
  </table>

  <div style="margin-top: 15px;">
    <button type="submit">저장</button>
    <a href="${pageContext.request.contextPath}/role/list">취소</a>
  </div>
</form>
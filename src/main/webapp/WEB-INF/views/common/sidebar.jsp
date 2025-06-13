<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String currentUri = (String) request.getAttribute("originalUri");
%>
<aside class="sidebar">
  <div class="logo">
    <span>MyDash</span>
  </div>
  <nav>
    <ul>
      <li class="<%= currentUri != null && currentUri.contains("/dashboard") ? "active" : "" %>">
        <a href="${pageContext.request.contextPath}/dashboard.do">Dashboard</a>
      </li>
      <li class="<%= currentUri != null && currentUri.contains("/manage") ? "active" : "" %>">
        <a href="${pageContext.request.contextPath}/manage/list">Manage</a>
      </li>
      <li><a href="#">Component Test</a></li>
      <li><a href="#">API Console</a></li>
      <li><a href="#">Message Alert</a></li>
    </ul>
  </nav>
</aside>
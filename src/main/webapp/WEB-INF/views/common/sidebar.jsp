<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="currentUri" value="${pageContext.request.requestURI}" />

<aside class="sidebar">
  <div class="logo">
    <span>MyDash</span>
  </div>
  <div class="user-info">
    <p>👤 <span class="username-highlight">${sessionScope.username}</span>님</p>
  </div>
  <nav>
    <ul>
      <li class="${fn:contains(currentUri, '/dashboard') ? 'active' : ''}">
        <a href="${pageContext.request.contextPath}/dashboard.do">Dashboard</a>
      </li>
      <li class="${fn:contains(currentUri, '/manage') ? 'active' : ''}">
        <a href="${pageContext.request.contextPath}/manage/list">Manage</a>
      </li>
      <li class="${fn:contains(currentUri, '/rolemanage') ? 'active' : ''}">
        <a href="${pageContext.request.contextPath}/rolemanage/rolemanage-list">Role Manage</a>
      </li>
      <li><a href="#">Component Test</a></li>
      <li><a href="#">API Console</a></li>
      <li><a href="#">Message Alert</a></li>
       <li class="${fn:contains(currentUri, '/grid') ? 'active' : ''}">
        <a href="${pageContext.request.contextPath}/grid/toastgrid">Grid</a>
      </li>
    </ul>
  </nav>
</aside>
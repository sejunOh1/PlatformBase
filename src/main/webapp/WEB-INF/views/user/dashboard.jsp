<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Main Content -->
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
    <div>
        <sec:authorize access="hasRole('ADMIN')">
            <li><a href="/admin/config">관리자 메뉴</a></li>
        </sec:authorize>
    </div>
</section>

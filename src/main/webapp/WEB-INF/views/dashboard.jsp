<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setAttribute("contentPage", "user/dashboard.jsp");  // 여기가 실제 본문 JSP 위치
    RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views//layout.jsp");
    rd.forward(request, response);
%>

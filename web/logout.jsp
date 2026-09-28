<%-- 
    Document   : logout
    Created on : Sep 28, 2026, 9:54:12 PM
    Author     : anandaanugrah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>
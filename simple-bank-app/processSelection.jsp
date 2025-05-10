<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String action = request.getParameter("action");
    
    if ("createAccount".equals(action)) {
        response.sendRedirect("account.jsp");
    } else if ("eodReport".equals(action)) {
        response.sendRedirect("report.jsp");
    } else {
        response.sendRedirect("index.jsp");
    }
%> 
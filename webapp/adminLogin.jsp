<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = request.getParameter("error");
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String password = request.getParameter("password");
        if (password == null || password.trim().isEmpty()) {
            error = "Invalid Credentials";
        } else if ("admin@2026".equals(password)) {
            session.setAttribute("userRole", "admin");
            session.setAttribute("userId", "admin");
            response.sendRedirect("adminDashboard.jsp");
            return;
        } else {
            error = "Invalid Admin Key";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - UniCore ERP</title>
    <link rel="stylesheet" href="css/style.css?v=20260324-5">
</head>
<body class="auth-page admin-auth">
<div class="container">
    <div class="login-wrapper">
        <div class="login-box">
            <div class="auth-brand"><img src="images/unicore-logo-banner.png" alt="UniCore ERP Logo" class="auth-logo"></div>
            <h2>Admin Login</h2>
                <% if (error != null && !"Database Authentication Not Configured".equals(error)) { %>
                <div class="error-message"><%= error %></div>
            <% } %>
            
            <form method="POST" action="adminLogin.jsp">
                <div class="form-group">
                    <label for="password">Admin Key</label>
                    <input type="password" id="password" name="password" required placeholder="Enter admin key">
                </div>
                
                <button type="submit" class="btn btn-submit">Login</button>
            </form>
            
            <p><a href="index.jsp">← Back to Home</a></p>
        </div>
    </div>
</div>
</body>
</html>

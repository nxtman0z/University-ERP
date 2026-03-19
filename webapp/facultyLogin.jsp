<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Faculty Login - University ERP</title>
    <link rel="stylesheet" href="css/style.css?v=20260319">
</head>
<body>
<div class="container">
    <div class="login-wrapper">
        <div class="login-box">
            <h2>Faculty Login</h2>
            <% String error = request.getParameter("error"); 
               if (error != null) { %>
                <div class="error-message"><%= error %></div>
            <% } %>
            
            <form method="POST" action="facultyLogin">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required placeholder="Enter faculty username">
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required placeholder="Enter faculty password">
                </div>
                
                <button type="submit" class="btn btn-submit">Login</button>
            </form>
            
            <p><a href="index.jsp">← Back to Home</a></p>
        </div>
    </div>
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - University ERP</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <div class="login-header">
                <div class="logo-container">🎓</div>
                <h1>University ERP</h1>
                <p>Welcome back! Please login to your account</p>
            </div>
            
            <form onsubmit="return handleLogin(event)" id="loginForm">
                <div class="form-group">
                    <label for="role">Select Role</label>
                    <select id="role" name="role" class="form-control" required>
                        <option value="">-- Choose Role --</option>
                        <option value="student">Student</option>
                        <option value="faculty">Faculty</option>
                        <option value="admin">Admin</option>
                        <option value="head">University Head</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="username">Username / Email</label>
                    <input type="text" id="username" name="username" class="form-control" 
                           placeholder="Enter your username or email" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" 
                           placeholder="Enter your password" required>
                </div>
                
                <button type="submit" class="btn btn-primary">Login</button>
                
                <div class="login-links">
                    <a href="forgot-password.jsp">Forgot Password?</a>
                </div>
            </form>
            
            <div style="margin-top: 30px; padding-top: 20px; border-top: 1px solid #e5e7eb; text-align: center; color: #6b7280; font-size: 13px;">
                <p><strong>Demo Credentials:</strong></p>
                <p>Student: student / password</p>
                <p>Faculty: faculty / password</p>
                <p>Admin: admin / password</p>
                <p>Head: head / password</p>
            </div>
        </div>
    </div>
    
    <script src="js/main.js"></script>
</body>
</html>

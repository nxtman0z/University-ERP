<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - University ERP</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <div class="login-header">
                <div class="logo-container">🔑</div>
                <h1>Forgot Password</h1>
                <p>Enter your email to reset password</p>
            </div>
            
            <form onsubmit="return handleForgotPassword(event)" id="forgotForm">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" class="form-control" 
                           placeholder="Enter your registered email" required>
                </div>
                
                <button type="submit" class="btn btn-primary">Send Reset Link</button>
                
                <div class="login-links">
                    <a href="login.jsp">← Back to Login</a>
                </div>
            </form>
        </div>
    </div>
    
    <script src="js/main.js"></script>
    <script>
        function handleForgotPassword(event) {
            event.preventDefault();
            const email = document.getElementById('email').value;
            alert('Password reset link has been sent to: ' + email);
            setTimeout(() => {
                window.location.href = 'login.jsp';
            }, 2000);
            return false;
        }
    </script>
</body>
</html>

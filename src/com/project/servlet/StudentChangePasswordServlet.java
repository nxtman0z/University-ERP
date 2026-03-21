package com.project.servlet;

import com.project.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StudentChangePasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("studentLogin.jsp?error=Session Expired");
            return;
        }

        String studentId = session.getAttribute("userId").toString();
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (isBlank(currentPassword) || isBlank(newPassword) || isBlank(confirmPassword)) {
            redirectWithPopup(response, "error", "Invalid Password Data", "Please fill all password fields.");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            redirectWithPopup(response, "error", "Password Mismatch", "New password and confirm password do not match.");
            return;
        }

        if (newPassword.trim().length() < 6) {
            redirectWithPopup(response, "error", "Weak Password", "Please use at least 6 characters in new password.");
            return;
        }

        String selectSql = "SELECT password_hash FROM users WHERE user_id = ? AND role = 'student'";
        String updateSql = "UPDATE users SET password_hash = ?, must_change_password = 0 WHERE user_id = ? AND role = 'student'";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement selectStmt = conn.prepareStatement(selectSql);
             PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {

            selectStmt.setString(1, studentId);
            try (ResultSet rs = selectStmt.executeQuery()) {
                if (!rs.next()) {
                    redirectWithPopup(response, "error", "User Not Found", "Student account was not found.");
                    return;
                }

                String existingHash = rs.getString("password_hash");
                String currentHash = DatabaseUtil.hashPassword(currentPassword.trim());
                if (existingHash == null || !existingHash.equals(currentHash)) {
                    redirectWithPopup(response, "error", "Wrong Current Password", "Current password is incorrect.");
                    return;
                }
            }

            updateStmt.setString(1, DatabaseUtil.hashPassword(newPassword.trim()));
            updateStmt.setString(2, studentId);
            updateStmt.executeUpdate();

            redirectWithPopup(response, "success", "Password Updated", "Password changed successfully.");
        } catch (SQLException e) {
            redirectWithPopup(response, "error", "Database Operation Failed", "Could not update password due to database issue.");
        }
    }

    private void redirectWithPopup(HttpServletResponse response, String type, String message, String popup) throws IOException {
        String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.name());
        String encodedPopup = URLEncoder.encode(popup, StandardCharsets.UTF_8.name());
        response.sendRedirect("studentDashboard.jsp?" + type + "=" + encodedMessage + "&popup=" + encodedPopup + "#dashboard");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

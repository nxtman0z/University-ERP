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

public class FacultyChangePasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("facultyLogin.jsp?error=Session Expired");
            return;
        }

        String facultyId = session.getAttribute("userId").toString();
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (isBlank(currentPassword) || isBlank(newPassword) || isBlank(confirmPassword)) {
            redirectToProfile(response, "error", "Please fill all password fields.");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            redirectToProfile(response, "error", "New password and confirm password do not match.");
            return;
        }

        if (newPassword.trim().length() < 6) {
            redirectToProfile(response, "error", "New password must be at least 6 characters.");
            return;
        }

        String selectSql = "SELECT password_hash FROM users WHERE user_id = ? AND role = 'faculty'";
        String updateSql = "UPDATE users SET password_hash = ?, must_change_password = 0 WHERE user_id = ? AND role = 'faculty'";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement selectStmt = conn.prepareStatement(selectSql);
             PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {

            selectStmt.setString(1, facultyId);
            try (ResultSet rs = selectStmt.executeQuery()) {
                if (!rs.next()) {
                    redirectToProfile(response, "error", "Faculty account not found.");
                    return;
                }

                String existingHash = rs.getString("password_hash");
                String currentHash = DatabaseUtil.hashPassword(currentPassword.trim());
                if (existingHash == null || !existingHash.equals(currentHash)) {
                    redirectToProfile(response, "error", "Current password is incorrect.");
                    return;
                }
            }

            updateStmt.setString(1, DatabaseUtil.hashPassword(newPassword.trim()));
            updateStmt.setString(2, facultyId);
            updateStmt.executeUpdate();

            redirectToProfile(response, "success", "Password updated successfully.");
        } catch (SQLException e) {
            redirectToProfile(response, "error", "Could not update password due to database issue.");
        }
    }

    private void redirectToProfile(HttpServletResponse response, String type, String message) throws IOException {
        String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.name());
        response.sendRedirect("facultyDashboard.jsp?" + type + "=" + encodedMessage + "#profile");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.project.util.DatabaseUtil;

public class FacultyLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect("facultyLogin.jsp?error=Invalid Credentials");
            return;
        }

        String sql = "SELECT user_id, email, password_hash, is_active FROM users WHERE user_id = ? AND role = 'faculty'";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username.trim());

            try (ResultSet rs = stmt.executeQuery()) {
                if (!rs.next()) {
                    response.sendRedirect("facultyLogin.jsp?error=Invalid Credentials");
                    return;
                }

                String expectedHash = rs.getString("password_hash");
                String providedHash = DatabaseUtil.hashPassword(password.trim());
                boolean isActive = rs.getBoolean("is_active");

                if (!isActive || expectedHash == null || !expectedHash.equals(providedHash)) {
                    response.sendRedirect("facultyLogin.jsp?error=Invalid Credentials");
                    return;
                }

                HttpSession session = request.getSession();
                session.setAttribute("userRole", "faculty");
                session.setAttribute("userId", rs.getString("user_id"));
                session.setAttribute("userEmail", rs.getString("email"));
                response.sendRedirect("facultyDashboard.jsp");
            }
        } catch (SQLException e) {
            response.sendRedirect("facultyLogin.jsp?error=Database Connection Failed");
        }
    }
}

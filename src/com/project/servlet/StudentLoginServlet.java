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

public class StudentLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String password = request.getParameter("password");

        if (studentId == null || studentId.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect("studentLogin.jsp?error=Invalid Credentials");
            return;
        }

        String sql = "SELECT user_id, email, password_hash, is_active FROM users WHERE user_id = ? AND role = 'student'";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId.trim());

            try (ResultSet rs = stmt.executeQuery()) {
                if (!rs.next()) {
                    response.sendRedirect("studentLogin.jsp?error=Invalid Credentials");
                    return;
                }

                String expectedHash = rs.getString("password_hash");
                String providedHash = DatabaseUtil.hashPassword(password.trim());
                boolean isActive = rs.getBoolean("is_active");

                if (!isActive || expectedHash == null || !expectedHash.equals(providedHash)) {
                    response.sendRedirect("studentLogin.jsp?error=Invalid Credentials");
                    return;
                }

                HttpSession session = request.getSession();
                session.setAttribute("userRole", "student");
                session.setAttribute("userId", rs.getString("user_id"));
                session.setAttribute("userEmail", rs.getString("email"));
                response.sendRedirect("studentDashboard.jsp");
            }
        } catch (SQLException e) {
            response.sendRedirect("studentLogin.jsp?error=Database Connection Failed");
        }
    }
}

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

public class StudentLibraryCardRequestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("studentLogin.jsp?error=Session Expired");
            return;
        }

        String studentId = session.getAttribute("userId").toString();
        String checkSql = "SELECT status FROM library_card_requests WHERE student_id = ? ORDER BY created_at DESC LIMIT 1";
        String insertSql = "INSERT INTO library_card_requests (request_id, student_id, request_date, status) VALUES (?, ?, CURDATE(), 'PENDING')";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, studentId);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    String status = rs.getString("status");
                    if ("PENDING".equalsIgnoreCase(status)) {
                        redirectWithPopup(response, "error", "Request Pending", "Your previous library card request is still pending.");
                        return;
                    }
                    if ("APPROVED".equalsIgnoreCase(status) || "ISSUED".equalsIgnoreCase(status)) {
                        redirectWithPopup(response, "success", "Already Approved", "Your library card request is already approved.");
                        return;
                    }
                }
            }

            String requestId = "LR" + System.currentTimeMillis();
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                insertStmt.setString(1, requestId);
                insertStmt.setString(2, studentId);
                insertStmt.executeUpdate();
            }

            redirectWithPopup(response, "success", "Request Submitted", "Library card issue request sent to admin successfully.");
        } catch (SQLException e) {
            redirectWithPopup(response, "error", "Database Operation Failed", "Could not submit library card request.");
        }
    }

    private void redirectWithPopup(HttpServletResponse response, String type, String message, String popup) throws IOException {
        String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.name());
        String encodedPopup = URLEncoder.encode(popup, StandardCharsets.UTF_8.name());
        response.sendRedirect("studentDashboard.jsp?" + type + "=" + encodedMessage + "&popup=" + encodedPopup + "#library-card");
    }
}

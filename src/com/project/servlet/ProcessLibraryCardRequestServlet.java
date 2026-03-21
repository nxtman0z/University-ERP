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
import java.sql.SQLException;

public class ProcessLibraryCardRequestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("adminLogin.jsp?error=Session Expired");
            return;
        }

        String adminId = session.getAttribute("userId").toString();
        String requestId = request.getParameter("requestId");
        String status = request.getParameter("status");
        String remarks = request.getParameter("remarks");

        if (isBlank(requestId) || isBlank(status)) {
            redirectWithPopup(response, "error", "Invalid Request", "Request ID or status is missing.");
            return;
        }

        String normalized = status.trim().toUpperCase();
        if (!("APPROVED".equals(normalized) || "REJECTED".equals(normalized) || "ISSUED".equals(normalized))) {
            redirectWithPopup(response, "error", "Invalid Status", "Only APPROVED, REJECTED, or ISSUED are allowed.");
            return;
        }

        String sql = "UPDATE library_card_requests SET status = ?, processed_by = ?, processed_at = NOW(), remarks = ? WHERE request_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, normalized);
            stmt.setString(2, adminId);
            stmt.setString(3, isBlank(remarks) ? null : remarks.trim());
            stmt.setString(4, requestId.trim());
            int rows = stmt.executeUpdate();
            if (rows == 0) {
                redirectWithPopup(response, "error", "Request Not Found", "No matching library request found.");
                return;
            }
            redirectWithPopup(response, "success", "Request Updated", "Library card request status updated successfully.");
        } catch (SQLException e) {
            redirectWithPopup(response, "error", "Database Operation Failed", "Could not update request status.");
        }
    }

    private void redirectWithPopup(HttpServletResponse response, String type, String message, String popup) throws IOException {
        String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.name());
        String encodedPopup = URLEncoder.encode(popup, StandardCharsets.UTF_8.name());
        response.sendRedirect("adminDashboard.jsp?" + type + "=" + encodedMessage + "&popup=" + encodedPopup + "#library");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.project.util.DatabaseUtil;

public class SendNoticeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("noticeId");
        String noticeText = request.getParameter("noticeText");
        String targetGroup = request.getParameter("targetGroup");
        String date = request.getParameter("date");

        if (isBlank(id) || isBlank(noticeText) || isBlank(targetGroup) || isBlank(date)) {
            response.sendRedirect("adminDashboard.jsp?error=Invalid Notice Data");
            return;
        }

        String insertSql = "INSERT INTO notices (notice_id, notice_title, notice_text, target_group, notice_date, created_by, is_active) VALUES (?, ?, ?, ?, ?, ?, 1)";
        String creator = request.getSession().getAttribute("userId") != null
                ? request.getSession().getAttribute("userId").toString()
                : "admin";
        String title = noticeText.length() > 50 ? noticeText.substring(0, 50) + "..." : noticeText;

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(insertSql)) {
            stmt.setString(1, id.trim());
            stmt.setString(2, title.trim());
            stmt.setString(3, noticeText.trim());
            stmt.setString(4, targetGroup.trim());
            stmt.setString(5, date.trim());
            stmt.setString(6, creator);
            stmt.executeUpdate();

            response.sendRedirect("adminDashboard.jsp?success=Notice Saved Successfully");
        } catch (SQLException e) {
            response.sendRedirect("adminDashboard.jsp?error=Database Operation Failed");
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

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

        // TODO: Persist notice data using JDBC.
        // Suggested flow:
        // 1. Open DB connection
        // 2. Execute INSERT INTO notices (...)
        // 3. Close resources and handle SQL exceptions

        response.sendRedirect("adminDashboard.jsp?error=Database Not Configured");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

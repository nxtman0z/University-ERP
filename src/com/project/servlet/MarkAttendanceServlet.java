package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MarkAttendanceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("attendanceId");
        String studentId = request.getParameter("studentId");
        String subject = request.getParameter("subject");
        String date = request.getParameter("date");
        String status = request.getParameter("status");

        if (isBlank(id) || isBlank(studentId) || isBlank(subject) || isBlank(date) || isBlank(status)) {
            response.sendRedirect("facultyDashboard.jsp?error=Invalid Attendance Data");
            return;
        }

        // TODO: Persist attendance data using JDBC.
        // Suggested flow:
        // 1. Open DB connection
        // 2. Execute INSERT INTO attendance (...)
        // 3. Close resources and handle SQL exceptions

        response.sendRedirect("facultyDashboard.jsp?error=Database Not Configured");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

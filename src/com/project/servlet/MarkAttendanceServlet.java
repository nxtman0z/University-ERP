package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MarkAttendanceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String department = request.getParameter("department");
        if (isBlank(department)) {
            department = request.getParameter("facultyDepartment");
        }
        String subject = request.getParameter("subject");
        if (isBlank(subject)) {
            subject = request.getParameter("course");
        }
        String timeSlot = request.getParameter("timeSlot");
        if (isBlank(timeSlot)) {
            timeSlot = request.getParameter("time");
        }
        String date = request.getParameter("date");
        String status = request.getParameter("status");
        String[] studentIds = request.getParameterValues("studentIds");

        if (studentIds == null || studentIds.length == 0) {
            String singleStudent = request.getParameter("studentIds");
            if (!isBlank(singleStudent)) {
                studentIds = new String[] { singleStudent };
            }
        }

        if (studentIds == null || studentIds.length == 0) {
            String selectedStudents = request.getParameter("selectedStudents");
            if (!isBlank(selectedStudents)) {
                studentIds = selectedStudents.split("\\s*,\\s*");
            }
        }

        if (studentIds == null || studentIds.length == 0) {
            String fallbackStudent = request.getParameter("studentId");
            if (!isBlank(fallbackStudent)) {
                studentIds = new String[] { fallbackStudent };
            }
        }

        if (isBlank(department) || isBlank(subject) || isBlank(timeSlot) || isBlank(date)
                || isBlank(status) || studentIds == null || studentIds.length == 0) {
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

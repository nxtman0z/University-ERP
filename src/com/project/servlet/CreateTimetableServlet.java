package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CreateTimetableServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String department = request.getParameter("department");
        String subject = request.getParameter("subject");
        if (isBlank(subject)) {
            subject = request.getParameter("course");
        }
        String day = request.getParameter("day");
        String time = request.getParameter("time");
        String subjectCode = request.getParameter("subjectCode");
        if (isBlank(subjectCode)) {
            subjectCode = request.getParameter("courseCode");
        }
        String facultyName = request.getParameter("facultyName");

        if (isBlank(department) || isBlank(subject) || isBlank(day) || isBlank(time)
                || isBlank(subjectCode) || isBlank(facultyName)) {
            response.sendRedirect("adminDashboard.jsp?error=Invalid Timetable Data");
            return;
        }

        // TODO: Persist timetable data using JDBC.
        // Suggested flow:
        // 1. Open DB connection
        // 2. Execute INSERT INTO timetable (...)
        // 3. Close resources and handle SQL exceptions

        response.sendRedirect("adminDashboard.jsp?error=Database Not Configured");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

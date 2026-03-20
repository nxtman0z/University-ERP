package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddCourseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String department = request.getParameter("department");
        String subjectName = request.getParameter("subjectName");
        if (isBlank(subjectName)) {
            subjectName = request.getParameter("courseName");
        }
        String subjectCode = request.getParameter("subjectCode");
        if (isBlank(subjectCode)) {
            subjectCode = request.getParameter("courseCode");
        }
        String credits = request.getParameter("credits");

        if (isBlank(department) || isBlank(subjectName) || isBlank(subjectCode) || isBlank(credits)) {
            response.sendRedirect("adminDashboard.jsp?error=Invalid Subject Data");
            return;
        }

        // TODO: Persist course data using JDBC.
        // Suggested flow:
        // 1. Open DB connection
        // 2. Execute INSERT INTO courses (...)
        // 3. Close resources and handle SQL exceptions

        response.sendRedirect("adminDashboard.jsp?error=Database Not Configured");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

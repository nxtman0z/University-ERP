package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CreateExamServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("examId");
        String course = request.getParameter("course");
        String subject = request.getParameter("subject");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String location = request.getParameter("location");

        if (isBlank(id) || isBlank(course) || isBlank(subject) || isBlank(date) || isBlank(time) || isBlank(location)) {
            response.sendRedirect("adminDashboard.jsp?error=Invalid Exam Data");
            return;
        }

        // TODO: Persist exam data using JDBC.
        // Suggested flow:
        // 1. Open DB connection
        // 2. Execute INSERT INTO exams (...)
        // 3. Close resources and handle SQL exceptions

        response.sendRedirect("adminDashboard.jsp?error=Database Not Configured");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UploadAssignmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("assignmentId");
        String subject = request.getParameter("subject");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String dueDate = request.getParameter("dueDate");
        String facultyId = (String) request.getSession().getAttribute("userId");

        if (isBlank(id) || isBlank(subject) || isBlank(title) || isBlank(description) || isBlank(dueDate) || isBlank(facultyId)) {
            response.sendRedirect("facultyDashboard.jsp?error=Invalid Assignment Data");
            return;
        }

        // TODO: Persist assignment data using JDBC.
        // Suggested flow:
        // 1. Open DB connection
        // 2. Execute INSERT INTO assignments (...)
        // 3. Close resources and handle SQL exceptions

        response.sendRedirect("facultyDashboard.jsp?error=Database Not Configured");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

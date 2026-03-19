package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddFacultyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("facultyId");
        String name = request.getParameter("facultyName");
        String subject = request.getParameter("subject");
        String email = request.getParameter("email");

        if (isBlank(id) || isBlank(name) || isBlank(subject) || isBlank(email)) {
            response.sendRedirect("adminDashboard.jsp?error=Invalid Faculty Data");
            return;
        }

        // TODO: Persist faculty data using JDBC.
        // Suggested flow:
        // 1. Open DB connection
        // 2. Execute INSERT INTO faculty (...)
        // 3. Close resources and handle SQL exceptions

        response.sendRedirect("adminDashboard.jsp?error=Database Not Configured");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

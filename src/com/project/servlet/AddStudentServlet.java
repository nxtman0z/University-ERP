package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("studentId");
        String rollNumber = request.getParameter("rollNumber");
        String name = request.getParameter("studentName");
        String course = request.getParameter("department");
        if (isBlank(course)) {
            course = request.getParameter("course");
        }
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (isBlank(id) || isBlank(rollNumber) || isBlank(name) || isBlank(course) || isBlank(email) || isBlank(phone) || isBlank(address)) {
            response.sendRedirect("adminDashboard.jsp?error=Invalid Student Data");
            return;
        }

        // TODO: Persist student data using JDBC.
        // Suggested flow:
        // 1. Open DB connection
        // 2. Execute INSERT INTO students (...)
        // 3. Close resources and handle SQL exceptions

        response.sendRedirect("adminDashboard.jsp?error=Database Not Configured");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

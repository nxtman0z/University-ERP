package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class FacultyLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect("facultyLogin.jsp?error=Invalid Credentials");
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("userRole", "faculty");
        session.setAttribute("userId", username.trim());
        response.sendRedirect("facultyDashboard.jsp");
    }
}

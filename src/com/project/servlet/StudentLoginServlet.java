package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class StudentLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String password = request.getParameter("password");

        if (studentId == null || studentId.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect("studentLogin.jsp?error=Invalid Credentials");
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("userRole", "student");
        session.setAttribute("userId", studentId.trim());
        response.sendRedirect("studentDashboard.jsp");
    }
}

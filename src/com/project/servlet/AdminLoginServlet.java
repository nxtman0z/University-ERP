package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;

public class AdminLoginServlet extends HttpServlet {
    private static final String ADMIN_LOGIN_KEY = "admin@2026";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String password = resolvePassword(request);
        System.out.println("[AdminLoginServlet] resolvedPassword=" + (password == null ? "<null>" : password));

        if (password == null || password.trim().isEmpty()) {
            System.out.println("[AdminLoginServlet] redirect=Invalid Credentials");
            response.sendRedirect("adminLogin.jsp?error=Invalid Credentials");
            return;
        }

        if (!ADMIN_LOGIN_KEY.equals(password)) {
            System.out.println("[AdminLoginServlet] redirect=Invalid Admin Key");
            response.sendRedirect("adminLogin.jsp?error=Invalid Admin Key");
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("userRole", "admin");
        session.setAttribute("userId", "admin");
        System.out.println("[AdminLoginServlet] redirect=adminDashboard.jsp");
        response.sendRedirect("adminDashboard.jsp");
    }

    private String resolvePassword(HttpServletRequest request) throws IOException {
        String password = request.getParameter("password");
        if (!isBlank(password)) {
            return password;
        }

        String queryString = request.getQueryString();
        password = parseFormField(queryString, "password");
        if (!isBlank(password)) {
            return password;
        }

        StringBuilder body = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            body.append(line);
        }
        return parseFormField(body.toString(), "password");
    }

    private String parseFormField(String encodedData, String key) {
        if (isBlank(encodedData)) {
            return null;
        }

        String[] parts = encodedData.split("&");
        for (String part : parts) {
            String[] pair = part.split("=", 2);
            if (pair.length == 2 && key.equals(decode(pair[0]))) {
                return decode(pair[1]);
            }
        }
        return null;
    }

    private String decode(String value) {
        return URLDecoder.decode(value, StandardCharsets.UTF_8);
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

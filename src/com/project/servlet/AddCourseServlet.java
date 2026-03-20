package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.project.util.DatabaseUtil;

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

        String departmentSql = "SELECT department_id FROM departments WHERE department_code = ? AND is_active = 1";
        String insertSql = "INSERT INTO subjects (department_id, subject_code, subject_name, credits, is_active) VALUES (?, ?, ?, ?, 1)";

        try (Connection conn = DatabaseUtil.getConnection()) {
            Long departmentId = findDepartmentId(conn, departmentSql, department);
            if (departmentId == null) {
                response.sendRedirect("adminDashboard.jsp?error=Invalid Department");
                return;
            }

            try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                stmt.setLong(1, departmentId);
                stmt.setString(2, subjectCode.trim());
                stmt.setString(3, subjectName.trim());
                stmt.setInt(4, Integer.parseInt(credits.trim()));
                stmt.executeUpdate();
            }

            response.sendRedirect("adminDashboard.jsp?success=Subject Added Successfully");
        } catch (NumberFormatException e) {
            response.sendRedirect("adminDashboard.jsp?error=Invalid Credits Value");
        } catch (SQLException e) {
            response.sendRedirect("adminDashboard.jsp?error=Database Operation Failed");
        }
    }

    private Long findDepartmentId(Connection conn, String sql, String departmentCode) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, departmentCode.trim());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong("department_id");
                }
            }
        }
        return null;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

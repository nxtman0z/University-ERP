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

public class UploadAssignmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("assignmentId");
        String department = request.getParameter("department");
        String subject = request.getParameter("subject");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String dueDate = request.getParameter("dueDate");
        String facultyId = (String) request.getSession().getAttribute("userId");

        if (isBlank(id) || isBlank(department) || isBlank(subject) || isBlank(title)
                || isBlank(description) || isBlank(dueDate) || isBlank(facultyId)) {
            response.sendRedirect("facultyDashboard.jsp?error=Invalid Assignment Data");
            return;
        }

        String departmentSql = "SELECT department_id FROM departments WHERE department_code = ? AND is_active = 1";
        String subjectSql = "SELECT subject_id FROM subjects WHERE department_id = ? AND (subject_code = ? OR subject_name = ?)";
        String insertSql = "INSERT INTO assignments (assignment_id, department_id, subject_id, faculty_id, title, description, due_date, total_marks, attachment_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection()) {
            Long departmentId = findDepartmentId(conn, departmentSql, department);
            if (departmentId == null) {
                response.sendRedirect("facultyDashboard.jsp?error=Invalid Department");
                return;
            }

            Long subjectId = findSubjectId(conn, subjectSql, departmentId, subject);
            if (subjectId == null) {
                response.sendRedirect("facultyDashboard.jsp?error=Subject Not Found");
                return;
            }

            try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                stmt.setString(1, id.trim());
                stmt.setLong(2, departmentId);
                stmt.setLong(3, subjectId);
                stmt.setString(4, facultyId.trim());
                stmt.setString(5, title.trim());
                stmt.setString(6, description.trim());
                stmt.setString(7, dueDate.trim());
                stmt.setBigDecimal(8, new java.math.BigDecimal("100.00"));
                stmt.setString(9, null);
                stmt.executeUpdate();
            }

            response.sendRedirect("facultyDashboard.jsp?success=Assignment Saved Successfully");
        } catch (SQLException e) {
            response.sendRedirect("facultyDashboard.jsp?error=Database Operation Failed");
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

    private Long findSubjectId(Connection conn, String sql, long departmentId, String subjectNameOrCode) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, departmentId);
            stmt.setString(2, subjectNameOrCode.trim());
            stmt.setString(3, subjectNameOrCode.trim());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong("subject_id");
                }
            }
        }
        return null;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

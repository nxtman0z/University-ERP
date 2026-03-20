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
import java.time.LocalTime;
import java.time.format.DateTimeParseException;

import com.project.util.DatabaseUtil;

public class CreateExamServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("examId");
        String department = request.getParameter("department");
        String subject = request.getParameter("subject");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String location = request.getParameter("location");

        if (isBlank(id) || isBlank(department) || isBlank(subject) || isBlank(date) || isBlank(time) || isBlank(location)) {
            response.sendRedirect("adminDashboard.jsp?error=Invalid Exam Data");
            return;
        }

        String departmentSql = "SELECT department_id FROM departments WHERE department_code = ? AND is_active = 1";
        String subjectSql = "SELECT subject_id FROM subjects WHERE department_id = ? AND (subject_code = ? OR subject_name = ?)";
        String insertSql = "INSERT INTO exams (exam_id, department_id, subject_id, exam_type, exam_date, start_time, end_time, location, max_marks) VALUES (?, ?, ?, 'OTHER', ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection()) {
            Long departmentId = findDepartmentId(conn, departmentSql, department);
            if (departmentId == null) {
                response.sendRedirect("adminDashboard.jsp?error=Invalid Department");
                return;
            }

            Long subjectId = findSubjectId(conn, subjectSql, departmentId, subject);
            if (subjectId == null) {
                response.sendRedirect("adminDashboard.jsp?error=Subject Not Found");
                return;
            }

            LocalTime[] range = parseTimeRange(time);
            if (range == null) {
                response.sendRedirect("adminDashboard.jsp?error=Invalid Time Format");
                return;
            }

            try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                stmt.setString(1, id.trim());
                stmt.setLong(2, departmentId);
                stmt.setLong(3, subjectId);
                stmt.setString(4, date.trim());
                stmt.setTime(5, java.sql.Time.valueOf(range[0]));
                stmt.setTime(6, java.sql.Time.valueOf(range[1]));
                stmt.setString(7, location.trim());
                stmt.setBigDecimal(8, new java.math.BigDecimal("100.00"));
                stmt.executeUpdate();
            }

            response.sendRedirect("adminDashboard.jsp?success=Exam Saved Successfully");
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

    private LocalTime[] parseTimeRange(String value) {
        try {
            String[] parts = value.replace(" ", "").split("-");
            if (parts.length == 2) {
                return new LocalTime[] { LocalTime.parse(parts[0]), LocalTime.parse(parts[1]) };
            }
            LocalTime start = LocalTime.parse(value.trim());
            return new LocalTime[] { start, start.plusHours(1) };
        } catch (DateTimeParseException e) {
            return null;
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

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

public class CreateTimetableServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String department = request.getParameter("department");
        String subject = request.getParameter("subject");
        if (isBlank(subject)) {
            subject = request.getParameter("course");
        }
        String day = request.getParameter("day");
        String time = request.getParameter("time");
        String subjectCode = request.getParameter("subjectCode");
        if (isBlank(subjectCode)) {
            subjectCode = request.getParameter("courseCode");
        }
        String facultyName = request.getParameter("facultyName");

        if (isBlank(department) || isBlank(subject) || isBlank(day) || isBlank(time)
                || isBlank(subjectCode) || isBlank(facultyName)) {
            response.sendRedirect("adminDashboard.jsp?error=Invalid Timetable Data");
            return;
        }

        String departmentSql = "SELECT department_id FROM departments WHERE department_code = ? AND is_active = 1";
        String subjectSql = "SELECT subject_id FROM subjects WHERE department_id = ? AND (subject_code = ? OR subject_name = ?)";
        String facultySql = "SELECT faculty_id FROM faculty WHERE faculty_id = ? OR full_name = ?";
        String insertSql = "INSERT INTO timetable (timetable_id, department_id, subject_id, faculty_id, day_name, start_time, end_time, room_no, section_name, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 1)";

        try (Connection conn = DatabaseUtil.getConnection()) {
            Long departmentId = findDepartmentId(conn, departmentSql, department);
            if (departmentId == null) {
                response.sendRedirect("adminDashboard.jsp?error=Invalid Department");
                return;
            }

            Long subjectId = findSubjectId(conn, subjectSql, departmentId, subjectCode, subject);
            if (subjectId == null) {
                response.sendRedirect("adminDashboard.jsp?error=Subject Not Found");
                return;
            }

            String facultyId = findFacultyId(conn, facultySql, facultyName);
            if (isBlank(facultyId)) {
                response.sendRedirect("adminDashboard.jsp?error=Faculty Not Found");
                return;
            }

            LocalTime[] range = parseTimeRange(time);
            if (range == null) {
                response.sendRedirect("adminDashboard.jsp?error=Invalid Time Format");
                return;
            }

            String timetableId = "TT-" + System.currentTimeMillis();
            try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                stmt.setString(1, timetableId);
                stmt.setLong(2, departmentId);
                stmt.setLong(3, subjectId);
                stmt.setString(4, facultyId);
                stmt.setString(5, normalizeDay(day));
                stmt.setTime(6, java.sql.Time.valueOf(range[0]));
                stmt.setTime(7, java.sql.Time.valueOf(range[1]));
                stmt.setString(8, "TBD");
                stmt.setString(9, "A");
                stmt.executeUpdate();
            }

            response.sendRedirect("adminDashboard.jsp?success=Timetable Saved Successfully");
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

    private Long findSubjectId(Connection conn, String sql, long departmentId, String subjectCode, String subjectName) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, departmentId);
            stmt.setString(2, subjectCode.trim());
            stmt.setString(3, subjectName.trim());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong("subject_id");
                }
            }
        }
        return null;
    }

    private String findFacultyId(Connection conn, String sql, String facultyInput) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, facultyInput.trim());
            stmt.setString(2, facultyInput.trim());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("faculty_id");
                }
            }
        }
        return null;
    }

    private String normalizeDay(String day) {
        String value = day.trim().toLowerCase();
        return Character.toUpperCase(value.charAt(0)) + value.substring(1);
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

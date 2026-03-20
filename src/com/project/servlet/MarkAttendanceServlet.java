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

public class MarkAttendanceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String department = request.getParameter("department");
        if (isBlank(department)) {
            department = request.getParameter("facultyDepartment");
        }
        String subject = request.getParameter("subject");
        if (isBlank(subject)) {
            subject = request.getParameter("course");
        }
        String timeSlot = request.getParameter("timeSlot");
        if (isBlank(timeSlot)) {
            timeSlot = request.getParameter("time");
        }
        String date = request.getParameter("date");
        String status = request.getParameter("status");
        String[] studentIds = request.getParameterValues("studentIds");

        if (studentIds == null || studentIds.length == 0) {
            String singleStudent = request.getParameter("studentIds");
            if (!isBlank(singleStudent)) {
                studentIds = new String[] { singleStudent };
            }
        }

        if (studentIds == null || studentIds.length == 0) {
            String selectedStudents = request.getParameter("selectedStudents");
            if (!isBlank(selectedStudents)) {
                studentIds = selectedStudents.split("\\s*,\\s*");
            }
        }

        if (studentIds == null || studentIds.length == 0) {
            String fallbackStudent = request.getParameter("studentId");
            if (!isBlank(fallbackStudent)) {
                studentIds = new String[] { fallbackStudent };
            }
        }

        if (isBlank(department) || isBlank(subject) || isBlank(timeSlot) || isBlank(date)
                || isBlank(status) || studentIds == null || studentIds.length == 0) {
            response.sendRedirect("facultyDashboard.jsp?error=Invalid Attendance Data");
            return;
        }

        String facultyId = request.getSession().getAttribute("userId") != null
                ? request.getSession().getAttribute("userId").toString()
                : null;
        if (isBlank(facultyId)) {
            response.sendRedirect("facultyLogin.jsp?error=Session Expired");
            return;
        }
        String facultyIdSafe = facultyId.trim();

        String departmentSql = "SELECT department_id FROM departments WHERE department_code = ? AND is_active = 1";
        String subjectSql = "SELECT subject_id FROM subjects WHERE department_id = ? AND (subject_code = ? OR subject_name = ?)";
        String sessionInsertSql = "INSERT INTO attendance_sessions (attendance_id, department_id, subject_id, faculty_id, attendance_date, time_slot, default_status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String recordInsertSql = "INSERT INTO attendance_records (attendance_id, student_id, status, remarks) VALUES (?, ?, ?, ?)";

        String attendanceId = request.getParameter("attendanceId");
        if (isBlank(attendanceId)) {
            attendanceId = "ATT-" + System.currentTimeMillis();
        }

        try (Connection conn = DatabaseUtil.getConnection()) {
            conn.setAutoCommit(false);

            Long departmentId = findDepartmentId(conn, departmentSql, department);
            if (departmentId == null) {
                conn.rollback();
                response.sendRedirect("facultyDashboard.jsp?error=Invalid Department");
                return;
            }

            Long subjectId = findSubjectId(conn, subjectSql, departmentId, subject);
            if (subjectId == null) {
                conn.rollback();
                response.sendRedirect("facultyDashboard.jsp?error=Subject Not Found");
                return;
            }

            try (PreparedStatement sessionStmt = conn.prepareStatement(sessionInsertSql);
                 PreparedStatement recordStmt = conn.prepareStatement(recordInsertSql)) {
                sessionStmt.setString(1, attendanceId);
                sessionStmt.setLong(2, departmentId);
                sessionStmt.setLong(3, subjectId);
                sessionStmt.setString(4, facultyIdSafe);
                sessionStmt.setString(5, date.trim());
                sessionStmt.setString(6, timeSlot.trim());
                sessionStmt.setString(7, normalizeStatus(status));
                sessionStmt.executeUpdate();

                int insertedCount = 0;
                for (String studentId : studentIds) {
                    if (isBlank(studentId)) {
                        continue;
                    }
                    recordStmt.setString(1, attendanceId);
                    recordStmt.setString(2, studentId.trim());
                    recordStmt.setString(3, normalizeStatus(status));
                    recordStmt.setString(4, "Marked from faculty dashboard");
                    recordStmt.addBatch();
                    insertedCount++;
                }

                if (insertedCount == 0) {
                    conn.rollback();
                    response.sendRedirect("facultyDashboard.jsp?error=No Valid Students Selected");
                    return;
                }

                recordStmt.executeBatch();
            }

            conn.commit();
            response.sendRedirect("facultyDashboard.jsp?success=Attendance Saved Successfully");
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

    private String normalizeStatus(String status) {
        if (status == null) {
            return "Present";
        }
        String value = status.trim().toLowerCase();
        if ("absent".equals(value)) {
            return "Absent";
        }
        if ("late".equals(value)) {
            return "Late";
        }
        return "Present";
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

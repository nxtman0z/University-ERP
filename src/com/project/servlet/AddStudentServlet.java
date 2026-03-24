package com.project.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.project.util.DatabaseUtil;
import com.project.util.EmailUtil;

public class AddStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("studentId");
        String rollNumber = request.getParameter("rollNumber");
        String name = request.getParameter("studentName");
        String course = request.getParameter("department");
        if (isBlank(course)) {
            course = request.getParameter("course");
        }
        course = normalizeDepartmentCode(course);
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (isBlank(id) || isBlank(rollNumber) || isBlank(name) || isBlank(course) || isBlank(email) || isBlank(phone) || isBlank(address)) {
            redirectToSection(response, "students", "error", "Invalid Student Data", "Please fill all required student fields.");
            return;
        }

        String tempPassword = DatabaseUtil.generateTemporaryPassword(10);
        String passwordHash = DatabaseUtil.hashPassword(tempPassword);

        String departmentSql = "SELECT department_id FROM departments WHERE UPPER(department_code) = ? AND is_active = 1";
        String btechDepartmentSql = "SELECT department_id FROM departments WHERE UPPER(department_code) LIKE 'BTECH-%' AND is_active = 1 ORDER BY department_code LIMIT 1";
        String userInsertSql = "INSERT INTO users (user_id, role, password_hash, must_change_password, email, phone, is_active) VALUES (?, 'student', ?, 1, ?, ?, 1)";
        String studentInsertSql = "INSERT INTO students (student_id, roll_number, full_name, department_id, address) VALUES (?, ?, ?, ?, ?)";
        String emailQueueSql = "INSERT INTO email_queue (recipient_user_id, recipient_email, mail_subject, mail_body, template_key, status) VALUES (?, ?, ?, ?, 'STUDENT_WELCOME_CREDENTIALS', 'PENDING')";
        String mailSubject = "Your UniCore ERP Login Credentials";
        String mailBody = "Hello " + name.trim() + ",\n\n"
            + "Your account has been created successfully.\n"
            + "Student ID: " + id.trim() + "\n"
            + "Temporary Password: " + tempPassword + "\n\n"
            + "Please login and change your password immediately.\n"
            + "\nRegards,\nUniCore ERP Admin";

        try (Connection conn = DatabaseUtil.getConnection()) {
            conn.setAutoCommit(false);

            Long departmentId = findDepartmentId(conn, departmentSql, course);
            if (departmentId == null && "BTECH".equalsIgnoreCase(course)) {
                departmentId = findBtechDepartmentId(conn, btechDepartmentSql);
            }
            if (departmentId == null) {
                conn.rollback();
                redirectToSection(response, "students", "error", "Invalid Department", "Invalid department selected.");
                return;
            }

            try (PreparedStatement userStmt = conn.prepareStatement(userInsertSql);
                 PreparedStatement studentStmt = conn.prepareStatement(studentInsertSql);
                 PreparedStatement queueStmt = conn.prepareStatement(emailQueueSql)) {

                userStmt.setString(1, id.trim());
                userStmt.setString(2, passwordHash);
                userStmt.setString(3, email.trim());
                userStmt.setString(4, phone.trim());
                userStmt.executeUpdate();

                studentStmt.setString(1, id.trim());
                studentStmt.setString(2, rollNumber.trim());
                studentStmt.setString(3, name.trim());
                studentStmt.setLong(4, departmentId);
                studentStmt.setString(5, address.trim());
                studentStmt.executeUpdate();

                boolean mailSent = EmailUtil.sendPlainText(email.trim(), mailSubject, mailBody);
                if (!mailSent) {
                    queueStmt.setString(1, id.trim());
                    queueStmt.setString(2, email.trim());
                    queueStmt.setString(3, mailSubject);
                    queueStmt.setString(4, mailBody);
                    queueStmt.executeUpdate();
                }

                conn.commit();
                if (mailSent) {
                    redirectToSection(
                            response,
                            "students",
                            "success",
                            "Student Added Successfully",
                            "Student added successfully. Mail sent successfully with Student ID and default password.");
                } else {
                    redirectToSection(
                            response,
                            "students",
                            "success",
                            "Student Added Successfully",
                            "Student added successfully. Mail is queued and will be sent shortly.");
                }
                return;
            }
        } catch (SQLException e) {
            redirectToSection(response, "students", "error", "Database Operation Failed", "Student creation failed due to database issue.");
        }
    }

    private void redirectToSection(HttpServletResponse response, String section, String type, String message, String popup)
            throws IOException {
        String encodedMessage = URLEncoder.encode(message, StandardCharsets.UTF_8.name());
        String encodedPopup = URLEncoder.encode(popup, StandardCharsets.UTF_8.name());
        response.sendRedirect("adminDashboard.jsp?" + type + "=" + encodedMessage + "&popup=" + encodedPopup + "#" + section);
    }

    private Long findDepartmentId(Connection conn, String sql, String departmentCode) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, departmentCode.trim().toUpperCase());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong("department_id");
                }
            }
        }
        return null;
    }

    private Long findBtechDepartmentId(Connection conn, String sql) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getLong("department_id");
            }
        }
        return null;
    }

    private String normalizeDepartmentCode(String value) {
        if (value == null) {
            return null;
        }

        String normalized = value.trim().toUpperCase().replace('_', '-');
        normalized = normalized.replaceAll("\\s+", "");

        if ("BTECHCSE".equals(normalized)) {
            return "BTECH-CSE";
        }
        if ("BTECHIT".equals(normalized)) {
            return "BTECH-IT";
        }
        if ("BTECH".equals(normalized)) {
            return "BTECH";
        }
        return normalized;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}

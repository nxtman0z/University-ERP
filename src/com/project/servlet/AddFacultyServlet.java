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

public class AddFacultyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("facultyId");
        String name = request.getParameter("facultyName");
        String department = request.getParameter("facultyDepartment");
        String contact = request.getParameter("facultyContact");
        String email = request.getParameter("email");

        if (isBlank(id) || isBlank(name) || isBlank(department) || isBlank(contact) || isBlank(email)) {
            redirectToSection(response, "faculty", "error", "Invalid Faculty Data", "Please fill all required faculty fields.");
            return;
        }

        String tempPassword = DatabaseUtil.generateTemporaryPassword(10);
        String passwordHash = DatabaseUtil.hashPassword(tempPassword);

        String departmentSql = "SELECT department_id FROM departments WHERE department_code = ? AND is_active = 1";
        String userInsertSql = "INSERT INTO users (user_id, role, password_hash, must_change_password, email, phone, is_active) VALUES (?, 'faculty', ?, 1, ?, ?, 1)";
        String facultyInsertSql = "INSERT INTO faculty (faculty_id, full_name, department_id, contact_no, designation) VALUES (?, ?, ?, ?, ?)";
        String emailQueueSql = "INSERT INTO email_queue (recipient_user_id, recipient_email, mail_subject, mail_body, template_key, status) VALUES (?, ?, ?, ?, 'FACULTY_WELCOME_CREDENTIALS', 'PENDING')";

        try (Connection conn = DatabaseUtil.getConnection()) {
            conn.setAutoCommit(false);

            Long departmentId = findDepartmentId(conn, departmentSql, department);
            if (departmentId == null) {
                conn.rollback();
                redirectToSection(response, "faculty", "error", "Invalid Department", "Invalid department selected.");
                return;
            }

            try (PreparedStatement userStmt = conn.prepareStatement(userInsertSql);
                 PreparedStatement facultyStmt = conn.prepareStatement(facultyInsertSql);
                 PreparedStatement queueStmt = conn.prepareStatement(emailQueueSql)) {

                userStmt.setString(1, id.trim());
                userStmt.setString(2, passwordHash);
                userStmt.setString(3, email.trim());
                userStmt.setString(4, contact.trim());
                userStmt.executeUpdate();

                facultyStmt.setString(1, id.trim());
                facultyStmt.setString(2, name.trim());
                facultyStmt.setLong(3, departmentId);
                facultyStmt.setString(4, contact.trim());
                facultyStmt.setString(5, "Faculty");
                facultyStmt.executeUpdate();

                String subject = "Your UniCore ERP Login Credentials";
                String body = "Hello " + name.trim() + ",\n\n"
                        + "Your account has been created successfully.\n"
                        + "Faculty ID: " + id.trim() + "\n"
                        + "Temporary Password: " + tempPassword + "\n\n"
                        + "Please login and change your password immediately.\n"
                        + "\nRegards,\nUniCore ERP Admin";

                boolean mailSent = EmailUtil.sendPlainText(email.trim(), subject, body);
                if (!mailSent) {
                    queueStmt.setString(1, id.trim());
                    queueStmt.setString(2, email.trim());
                    queueStmt.setString(3, subject);
                    queueStmt.setString(4, body);
                    queueStmt.executeUpdate();
                }

                conn.commit();
                if (mailSent) {
                    redirectToSection(
                            response,
                            "faculty",
                            "success",
                            "Faculty Added Successfully",
                            "Faculty added successfully. Mail sent successfully with Faculty ID and default password.");
                } else {
                    redirectToSection(
                            response,
                            "faculty",
                            "success",
                            "Faculty Added Successfully",
                            "Faculty added successfully. Mail is queued and will be sent shortly.");
                }
                return;
            }
        } catch (SQLException e) {
            redirectToSection(response, "faculty", "error", "Database Operation Failed", "Faculty creation failed due to database issue.");
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

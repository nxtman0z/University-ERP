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

public class AddStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("studentId");
        String rollNumber = request.getParameter("rollNumber");
        String name = request.getParameter("studentName");
        String course = request.getParameter("department");
        if (isBlank(course)) {
            course = request.getParameter("course");
        }
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (isBlank(id) || isBlank(rollNumber) || isBlank(name) || isBlank(course) || isBlank(email) || isBlank(phone) || isBlank(address)) {
            response.sendRedirect("adminDashboard.jsp?error=Invalid Student Data");
            return;
        }

        String tempPassword = DatabaseUtil.generateTemporaryPassword(10);
        String passwordHash = DatabaseUtil.hashPassword(tempPassword);

        String departmentSql = "SELECT department_id FROM departments WHERE department_code = ? AND is_active = 1";
        String userInsertSql = "INSERT INTO users (user_id, role, password_hash, must_change_password, email, phone, is_active) VALUES (?, 'student', ?, 1, ?, ?, 1)";
        String studentInsertSql = "INSERT INTO students (student_id, roll_number, full_name, department_id, address) VALUES (?, ?, ?, ?, ?)";
        String emailQueueSql = "INSERT INTO email_queue (recipient_user_id, recipient_email, mail_subject, mail_body, template_key, status) VALUES (?, ?, ?, ?, 'STUDENT_WELCOME_CREDENTIALS', 'PENDING')";

        try (Connection conn = DatabaseUtil.getConnection()) {
            conn.setAutoCommit(false);

            Long departmentId = findDepartmentId(conn, departmentSql, course);
            if (departmentId == null) {
                conn.rollback();
                response.sendRedirect("adminDashboard.jsp?error=Invalid Department");
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

                queueStmt.setString(1, id.trim());
                queueStmt.setString(2, email.trim());
                queueStmt.setString(3, "Your University ERP Login Credentials");
                queueStmt.setString(4, "Student ID: " + id.trim() + " | Temporary Password: " + tempPassword);
                queueStmt.executeUpdate();
            }

            conn.commit();
            response.sendRedirect("adminDashboard.jsp?success=Student Added Successfully");
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

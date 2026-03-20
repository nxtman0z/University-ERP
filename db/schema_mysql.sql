-- University ERP: full relational schema for admin, faculty, and student workflows.
-- MySQL version: 8.0+

CREATE DATABASE IF NOT EXISTS university_erp
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;
USE university_erp;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP VIEW IF EXISTS v_attendance;
DROP TABLE IF EXISTS login_audit;
DROP TABLE IF EXISTS email_queue;
DROP TABLE IF EXISTS library_card_requests;
DROP TABLE IF EXISTS assignment_submissions;
DROP TABLE IF EXISTS attendance_records;
DROP TABLE IF EXISTS attendance_sessions;
DROP TABLE IF EXISTS notices;
DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS exams;
DROP TABLE IF EXISTS timetable;
DROP TABLE IF EXISTS faculty_subject_map;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS faculty;
DROP TABLE IF EXISTS admins;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS departments;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE departments (
    department_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    department_code VARCHAR(30) NOT NULL UNIQUE,
    department_name VARCHAR(120) NOT NULL,
    program_type ENUM('UG', 'PG', 'DIPLOMA', 'PHD', 'OTHER') NOT NULL DEFAULT 'UG',
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    role ENUM('admin', 'faculty', 'student') NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    must_change_password TINYINT(1) NOT NULL DEFAULT 1,
    email VARCHAR(160) NOT NULL UNIQUE,
    phone VARCHAR(25) NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    last_login_at DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_users_role_active (role, is_active)
);

CREATE TABLE admins (
    admin_id VARCHAR(50) PRIMARY KEY,
    full_name VARCHAR(120) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_admins_user FOREIGN KEY (admin_id) REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE faculty (
    faculty_id VARCHAR(50) PRIMARY KEY,
    full_name VARCHAR(120) NOT NULL,
    department_id BIGINT UNSIGNED NOT NULL,
    contact_no VARCHAR(25) NULL,
    designation VARCHAR(80) NULL,
    profile_photo_url VARCHAR(255) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_faculty_user FOREIGN KEY (faculty_id) REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_faculty_department FOREIGN KEY (department_id) REFERENCES departments(department_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_faculty_department (department_id)
);

CREATE TABLE students (
    student_id VARCHAR(50) PRIMARY KEY,
    roll_number VARCHAR(50) NOT NULL UNIQUE,
    full_name VARCHAR(120) NOT NULL,
    department_id BIGINT UNSIGNED NOT NULL,
    semester TINYINT UNSIGNED NULL,
    admission_year SMALLINT UNSIGNED NULL,
    address TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_students_user FOREIGN KEY (student_id) REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_students_department FOREIGN KEY (department_id) REFERENCES departments(department_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_students_department_sem (department_id, semester)
);

CREATE TABLE subjects (
    subject_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    department_id BIGINT UNSIGNED NOT NULL,
    subject_code VARCHAR(40) NOT NULL UNIQUE,
    subject_name VARCHAR(160) NOT NULL,
    credits TINYINT UNSIGNED NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_subjects_department FOREIGN KEY (department_id) REFERENCES departments(department_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_subjects_dept_name (department_id, subject_name)
);

CREATE TABLE faculty_subject_map (
    faculty_id VARCHAR(50) NOT NULL,
    subject_id BIGINT UNSIGNED NOT NULL,
    assigned_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (faculty_id, subject_id),
    CONSTRAINT fk_faculty_subject_faculty FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_faculty_subject_subject FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE timetable (
    timetable_id VARCHAR(50) PRIMARY KEY,
    department_id BIGINT UNSIGNED NOT NULL,
    subject_id BIGINT UNSIGNED NOT NULL,
    faculty_id VARCHAR(50) NOT NULL,
    day_name ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    room_no VARCHAR(40) NULL,
    section_name VARCHAR(40) NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_timetable_department FOREIGN KEY (department_id) REFERENCES departments(department_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_timetable_subject FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_timetable_faculty FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_timetable_department_day (department_id, day_name, start_time),
    INDEX idx_timetable_faculty_day (faculty_id, day_name, start_time)
);

CREATE TABLE exams (
    exam_id VARCHAR(50) PRIMARY KEY,
    department_id BIGINT UNSIGNED NOT NULL,
    subject_id BIGINT UNSIGNED NOT NULL,
    exam_type ENUM('MIDTERM', 'ENDTERM', 'QUIZ', 'PRACTICAL', 'VIVA', 'OTHER') NOT NULL DEFAULT 'OTHER',
    exam_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NULL,
    location VARCHAR(160) NOT NULL,
    max_marks DECIMAL(6,2) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_exams_department FOREIGN KEY (department_id) REFERENCES departments(department_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_exams_subject FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_exams_department_date (department_id, exam_date),
    INDEX idx_exams_subject_date (subject_id, exam_date)
);

CREATE TABLE assignments (
    assignment_id VARCHAR(50) PRIMARY KEY,
    department_id BIGINT UNSIGNED NOT NULL,
    subject_id BIGINT UNSIGNED NOT NULL,
    faculty_id VARCHAR(50) NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    due_date DATE NOT NULL,
    total_marks DECIMAL(6,2) NULL,
    attachment_url VARCHAR(255) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_assignments_department FOREIGN KEY (department_id) REFERENCES departments(department_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_assignments_subject FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_assignments_faculty FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_assignments_due_date (due_date),
    INDEX idx_assignments_faculty (faculty_id)
);

CREATE TABLE assignment_submissions (
    submission_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    assignment_id VARCHAR(50) NOT NULL,
    student_id VARCHAR(50) NOT NULL,
    submission_text TEXT NULL,
    submitted_file_url VARCHAR(255) NULL,
    submitted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    submission_status ENUM('SUBMITTED', 'LATE', 'MISSING') NOT NULL DEFAULT 'SUBMITTED',
    marks_awarded DECIMAL(6,2) NULL,
    feedback TEXT NULL,
    evaluated_at DATETIME NULL,
    evaluated_by VARCHAR(50) NULL,
    CONSTRAINT fk_submissions_assignment FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_submissions_student FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_submissions_evaluator FOREIGN KEY (evaluated_by) REFERENCES faculty(faculty_id)
        ON UPDATE CASCADE ON DELETE SET NULL,
    UNIQUE KEY uk_submission_assignment_student (assignment_id, student_id),
    INDEX idx_submissions_student_time (student_id, submitted_at)
);

CREATE TABLE notices (
    notice_id VARCHAR(50) PRIMARY KEY,
    notice_title VARCHAR(200) NOT NULL,
    notice_text TEXT NOT NULL,
    target_group VARCHAR(60) NOT NULL,
    notice_date DATE NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_notices_creator FOREIGN KEY (created_by) REFERENCES admins(admin_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX idx_notices_target_date (target_group, notice_date),
    INDEX idx_notices_active_date (is_active, notice_date)
);

CREATE TABLE attendance_sessions (
    attendance_id VARCHAR(50) PRIMARY KEY,
    department_id BIGINT UNSIGNED NOT NULL,
    subject_id BIGINT UNSIGNED NOT NULL,
    faculty_id VARCHAR(50) NOT NULL,
    attendance_date DATE NOT NULL,
    time_slot VARCHAR(40) NOT NULL,
    default_status ENUM('Present', 'Absent', 'Late') NOT NULL DEFAULT 'Present',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_attendance_session_department FOREIGN KEY (department_id) REFERENCES departments(department_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_attendance_session_subject FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_attendance_session_faculty FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    UNIQUE KEY uk_attendance_unique_session (department_id, subject_id, faculty_id, attendance_date, time_slot),
    INDEX idx_attendance_session_date (attendance_date)
);

CREATE TABLE attendance_records (
    attendance_record_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    attendance_id VARCHAR(50) NOT NULL,
    student_id VARCHAR(50) NOT NULL,
    status ENUM('Present', 'Absent', 'Late') NOT NULL,
    remarks VARCHAR(255) NULL,
    marked_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_attendance_record_session FOREIGN KEY (attendance_id) REFERENCES attendance_sessions(attendance_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_attendance_record_student FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    UNIQUE KEY uk_attendance_record_unique (attendance_id, student_id),
    INDEX idx_attendance_student_date (student_id, marked_at)
);

CREATE TABLE library_card_requests (
    request_id VARCHAR(50) PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    request_date DATE NOT NULL,
    status ENUM('PENDING', 'APPROVED', 'REJECTED', 'ISSUED') NOT NULL DEFAULT 'PENDING',
    processed_by VARCHAR(50) NULL,
    processed_at DATETIME NULL,
    remarks VARCHAR(255) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_library_request_student FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_library_request_admin FOREIGN KEY (processed_by) REFERENCES admins(admin_id)
        ON UPDATE CASCADE ON DELETE SET NULL,
    INDEX idx_library_status_date (status, request_date)
);

CREATE TABLE email_queue (
    email_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    recipient_user_id VARCHAR(50) NULL,
    recipient_email VARCHAR(160) NOT NULL,
    mail_subject VARCHAR(255) NOT NULL,
    mail_body TEXT NOT NULL,
    template_key VARCHAR(80) NULL,
    status ENUM('PENDING', 'SENT', 'FAILED') NOT NULL DEFAULT 'PENDING',
    retry_count TINYINT UNSIGNED NOT NULL DEFAULT 0,
    last_error TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    sent_at DATETIME NULL,
    CONSTRAINT fk_email_queue_user FOREIGN KEY (recipient_user_id) REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE SET NULL,
    INDEX idx_email_queue_status_created (status, created_at)
);

CREATE TABLE login_audit (
    audit_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(50) NULL,
    login_role ENUM('admin', 'faculty', 'student') NULL,
    login_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_success TINYINT(1) NOT NULL,
    ip_address VARCHAR(50) NULL,
    user_agent VARCHAR(255) NULL,
    failure_reason VARCHAR(120) NULL,
    INDEX idx_login_audit_user_time (user_id, login_time),
    INDEX idx_login_audit_success_time (is_success, login_time)
);

-- Compatibility view for simplified attendance reporting and old model style reads.
CREATE VIEW v_attendance AS
SELECT
    s.attendance_id,
    r.student_id,
    sub.subject_name AS subject,
    s.attendance_date,
    r.status,
    r.marked_at
FROM attendance_sessions s
JOIN attendance_records r ON r.attendance_id = s.attendance_id
JOIN subjects sub ON sub.subject_id = s.subject_id;

-- Seed master departments used in UI dropdowns.
INSERT INTO departments (department_code, department_name, program_type)
VALUES
    ('MCA', 'Master of Computer Applications', 'PG'),
    ('BCA', 'Bachelor of Computer Applications', 'UG'),
    ('BTECH-CSE', 'B.Tech Computer Science Engineering', 'UG'),
    ('BTECH-IT', 'B.Tech Information Technology', 'UG'),
    ('MBA', 'Master of Business Administration', 'PG'),
    ('MSC', 'Master of Science', 'PG')
ON DUPLICATE KEY UPDATE
    department_name = VALUES(department_name),
    program_type = VALUES(program_type),
    is_active = 1;

-- Bootstrap default admin login (replace hash immediately in production).
-- Hash below is a placeholder value and must be replaced with app-generated secure hash.
INSERT INTO users (user_id, role, password_hash, must_change_password, email, phone, is_active)
VALUES ('admin', 'admin', 'REPLACE_WITH_BCRYPT_HASH', 1, 'admin@university.local', NULL, 1)
ON DUPLICATE KEY UPDATE
    role = VALUES(role),
    email = VALUES(email),
    is_active = VALUES(is_active);

INSERT INTO admins (admin_id, full_name)
VALUES ('admin', 'System Administrator')
ON DUPLICATE KEY UPDATE
    full_name = VALUES(full_name);

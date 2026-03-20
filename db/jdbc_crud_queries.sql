-- University ERP: JDBC-ready CRUD and dashboard query reference
-- Use PreparedStatement placeholders (?) in Java code.

USE university_erp;

-- ============================================================
-- 1) STUDENT CREATE (transaction)
-- ============================================================
-- Step 1: user row
INSERT INTO users (user_id, role, password_hash, must_change_password, email, phone, is_active)
VALUES (?, 'student', ?, 1, ?, ?, 1);

-- Step 2: student profile row
INSERT INTO students (student_id, roll_number, full_name, department_id, semester, admission_year, address)
VALUES (?, ?, ?, ?, ?, ?, ?);

-- Step 3: queue welcome credentials email
INSERT INTO email_queue (recipient_user_id, recipient_email, mail_subject, mail_body, template_key, status)
VALUES (?, ?, ?, ?, 'STUDENT_WELCOME_CREDENTIALS', 'PENDING');

-- ============================================================
-- 2) STUDENT READ / UPDATE / DELETE
-- ============================================================
SELECT s.student_id, s.roll_number, s.full_name, d.department_code, d.department_name,
       u.email, u.phone, s.semester, s.admission_year, s.address, u.is_active
FROM students s
JOIN users u ON u.user_id = s.student_id
JOIN departments d ON d.department_id = s.department_id
WHERE s.student_id = ?;

SELECT s.student_id, s.roll_number, s.full_name, d.department_code, u.email, u.phone
FROM students s
JOIN users u ON u.user_id = s.student_id
JOIN departments d ON d.department_id = s.department_id
ORDER BY s.created_at DESC;

UPDATE users
SET email = ?, phone = ?, is_active = ?
WHERE user_id = ? AND role = 'student';

UPDATE students
SET full_name = ?, department_id = ?, semester = ?, admission_year = ?, address = ?
WHERE student_id = ?;

DELETE FROM users
WHERE user_id = ? AND role = 'student';
-- Student row auto-deletes due to FK ON DELETE CASCADE.

-- ============================================================
-- 3) FACULTY CREATE / CRUD
-- ============================================================
INSERT INTO users (user_id, role, password_hash, must_change_password, email, phone, is_active)
VALUES (?, 'faculty', ?, 1, ?, ?, 1);

INSERT INTO faculty (faculty_id, full_name, department_id, contact_no, designation, profile_photo_url)
VALUES (?, ?, ?, ?, ?, ?);

INSERT INTO email_queue (recipient_user_id, recipient_email, mail_subject, mail_body, template_key, status)
VALUES (?, ?, ?, ?, 'FACULTY_WELCOME_CREDENTIALS', 'PENDING');

SELECT f.faculty_id, f.full_name, d.department_code, u.email, f.contact_no, f.designation, u.is_active
FROM faculty f
JOIN users u ON u.user_id = f.faculty_id
JOIN departments d ON d.department_id = f.department_id
ORDER BY f.created_at DESC;

UPDATE users
SET email = ?, phone = ?, is_active = ?
WHERE user_id = ? AND role = 'faculty';

UPDATE faculty
SET full_name = ?, department_id = ?, contact_no = ?, designation = ?, profile_photo_url = ?
WHERE faculty_id = ?;

DELETE FROM users
WHERE user_id = ? AND role = 'faculty';

-- ============================================================
-- 4) SUBJECT (COURSE) CRUD
-- ============================================================
INSERT INTO subjects (department_id, subject_code, subject_name, credits, is_active)
VALUES (?, ?, ?, ?, 1);

SELECT sub.subject_id, d.department_code, sub.subject_code, sub.subject_name, sub.credits, sub.is_active
FROM subjects sub
JOIN departments d ON d.department_id = sub.department_id
ORDER BY d.department_code, sub.subject_code;

UPDATE subjects
SET department_id = ?, subject_name = ?, credits = ?, is_active = ?
WHERE subject_code = ?;

DELETE FROM subjects
WHERE subject_code = ?;

-- ============================================================
-- 5) TIMETABLE CRUD
-- ============================================================
INSERT INTO timetable (timetable_id, department_id, subject_id, faculty_id, day_name, start_time, end_time, room_no, section_name, is_active)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 1);

SELECT t.timetable_id, d.department_code, sub.subject_code, sub.subject_name,
       f.full_name AS faculty_name, t.day_name, t.start_time, t.end_time, t.room_no, t.section_name
FROM timetable t
JOIN departments d ON d.department_id = t.department_id
JOIN subjects sub ON sub.subject_id = t.subject_id
JOIN faculty f ON f.faculty_id = t.faculty_id
WHERE t.is_active = 1
ORDER BY FIELD(t.day_name, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'), t.start_time;

UPDATE timetable
SET department_id = ?, subject_id = ?, faculty_id = ?, day_name = ?, start_time = ?, end_time = ?, room_no = ?, section_name = ?, is_active = ?
WHERE timetable_id = ?;

DELETE FROM timetable
WHERE timetable_id = ?;

-- ============================================================
-- 6) EXAM CRUD
-- ============================================================
INSERT INTO exams (exam_id, department_id, subject_id, exam_type, exam_date, start_time, end_time, location, max_marks)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);

SELECT e.exam_id, d.department_code, sub.subject_code, sub.subject_name,
       e.exam_type, e.exam_date, e.start_time, e.end_time, e.location, e.max_marks
FROM exams e
JOIN departments d ON d.department_id = e.department_id
JOIN subjects sub ON sub.subject_id = e.subject_id
ORDER BY e.exam_date, e.start_time;

UPDATE exams
SET department_id = ?, subject_id = ?, exam_type = ?, exam_date = ?, start_time = ?, end_time = ?, location = ?, max_marks = ?
WHERE exam_id = ?;

DELETE FROM exams
WHERE exam_id = ?;

-- ============================================================
-- 7) NOTICE CRUD
-- ============================================================
INSERT INTO notices (notice_id, notice_title, notice_text, target_group, notice_date, created_by, is_active)
VALUES (?, ?, ?, ?, ?, ?, 1);

SELECT notice_id, notice_title, notice_text, target_group, notice_date, is_active
FROM notices
WHERE is_active = 1
ORDER BY notice_date DESC, created_at DESC;

UPDATE notices
SET notice_title = ?, notice_text = ?, target_group = ?, notice_date = ?, is_active = ?
WHERE notice_id = ?;

DELETE FROM notices
WHERE notice_id = ?;

-- ============================================================
-- 8) ASSIGNMENT CRUD + SUBMISSIONS
-- ============================================================
INSERT INTO assignments (assignment_id, department_id, subject_id, faculty_id, title, description, due_date, total_marks, attachment_url)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);

SELECT a.assignment_id, d.department_code, sub.subject_code, sub.subject_name, a.title, a.due_date,
       f.full_name AS faculty_name, a.total_marks
FROM assignments a
JOIN departments d ON d.department_id = a.department_id
JOIN subjects sub ON sub.subject_id = a.subject_id
JOIN faculty f ON f.faculty_id = a.faculty_id
ORDER BY a.due_date ASC;

UPDATE assignments
SET department_id = ?, subject_id = ?, title = ?, description = ?, due_date = ?, total_marks = ?, attachment_url = ?
WHERE assignment_id = ?;

DELETE FROM assignments
WHERE assignment_id = ?;

INSERT INTO assignment_submissions (assignment_id, student_id, submission_text, submitted_file_url, submission_status)
VALUES (?, ?, ?, ?, ?);

UPDATE assignment_submissions
SET marks_awarded = ?, feedback = ?, evaluated_at = NOW(), evaluated_by = ?
WHERE assignment_id = ? AND student_id = ?;

-- ============================================================
-- 9) ATTENDANCE (session + records)
-- ============================================================
INSERT INTO attendance_sessions (attendance_id, department_id, subject_id, faculty_id, attendance_date, time_slot, default_status)
VALUES (?, ?, ?, ?, ?, ?, ?);

INSERT INTO attendance_records (attendance_id, student_id, status, remarks)
VALUES (?, ?, ?, ?);

SELECT ar.attendance_record_id, s.attendance_id, s.attendance_date, s.time_slot,
       sub.subject_name, ar.student_id, st.full_name, ar.status
FROM attendance_records ar
JOIN attendance_sessions s ON s.attendance_id = ar.attendance_id
JOIN subjects sub ON sub.subject_id = s.subject_id
JOIN students st ON st.student_id = ar.student_id
WHERE ar.student_id = ?
ORDER BY s.attendance_date DESC, s.time_slot DESC;

UPDATE attendance_records
SET status = ?, remarks = ?, marked_at = NOW()
WHERE attendance_id = ? AND student_id = ?;

DELETE FROM attendance_sessions
WHERE attendance_id = ?;
-- Attendance records auto-delete due to FK cascade.

-- ============================================================
-- 10) LIBRARY REQUESTS
-- ============================================================
INSERT INTO library_card_requests (request_id, student_id, request_date, status)
VALUES (?, ?, CURDATE(), 'PENDING');

SELECT request_id, student_id, request_date, status, processed_by, processed_at, remarks
FROM library_card_requests
ORDER BY request_date DESC, created_at DESC;

UPDATE library_card_requests
SET status = ?, processed_by = ?, processed_at = NOW(), remarks = ?
WHERE request_id = ?;

-- ============================================================
-- 11) LOGIN FLOW QUERIES
-- ============================================================
SELECT user_id, role, password_hash, is_active, must_change_password
FROM users
WHERE user_id = ?;

UPDATE users
SET last_login_at = NOW()
WHERE user_id = ?;

INSERT INTO login_audit (user_id, login_role, is_success, ip_address, user_agent, failure_reason)
VALUES (?, ?, ?, ?, ?, ?);

-- ============================================================
-- 12) DASHBOARD STATS QUERIES
-- ============================================================
-- Admin dashboard cards
SELECT (SELECT COUNT(*) FROM students WHERE 1) AS total_students,
       (SELECT COUNT(*) FROM faculty WHERE 1) AS total_faculty,
       (SELECT COUNT(*) FROM subjects WHERE is_active = 1) AS total_courses,
       (SELECT COUNT(*) FROM notices WHERE is_active = 1) AS total_notices;

-- Faculty dashboard cards (by faculty_id)
SELECT
    (SELECT COUNT(*)
     FROM timetable t
     WHERE t.faculty_id = ?
       AND t.day_name = DAYNAME(CURDATE())
       AND t.is_active = 1) AS classes_today,
    (SELECT COUNT(DISTINCT st.student_id)
     FROM students st
     JOIN timetable t ON t.department_id = st.department_id
     WHERE t.faculty_id = ?
       AND t.is_active = 1) AS total_students,
    (SELECT COUNT(*)
     FROM assignments a
     WHERE a.faculty_id = ?
       AND a.due_date >= CURDATE()) AS pending_assignments,
    (SELECT COUNT(*)
     FROM notices n
     WHERE n.is_active = 1
       AND (
           n.target_group IN ('ALL_STUDENTS', 'ALL_FACULTY')
           OR n.target_group LIKE 'DEPT_%'
       )) AS notice_count;

-- Student dashboard cards (by student_id)
SELECT
    (SELECT COUNT(*)
     FROM timetable t
     JOIN students st ON st.department_id = t.department_id
     WHERE st.student_id = ?
       AND t.day_name = DAYNAME(CURDATE())
       AND t.is_active = 1) AS classes_today,
    (SELECT ROUND(
        100 * SUM(CASE WHEN ar.status = 'Present' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
        2
    )
     FROM attendance_records ar
     WHERE ar.student_id = ?) AS attendance_percent,
    (SELECT COUNT(*)
     FROM assignments a
     JOIN students st ON st.department_id = a.department_id
     WHERE st.student_id = ?
       AND a.due_date >= CURDATE()) AS pending_assignments,
    (SELECT COUNT(*)
     FROM notices n
     JOIN students st ON st.student_id = ?
     JOIN departments d ON d.department_id = st.department_id
     WHERE n.is_active = 1
       AND (
           n.target_group = 'ALL_STUDENTS'
           OR n.target_group = CONCAT('DEPT_', REPLACE(d.department_code, '-', '_'))
       )) AS latest_notices;

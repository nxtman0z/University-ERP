<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet" %>
<%@ page import="com.project.util.DatabaseUtil" %>
<%
    String totalStudents = "0";
    String totalFaculty = "0";
    String totalCourses = "0";
    String totalNotices = "0";
    String adminDisplayName = session.getAttribute("userId") != null ? session.getAttribute("userId").toString() : "User";
    String adminSessionId = session.getId();

    List<String[]> studentRows = new ArrayList<String[]>();
    List<String[]> facultyRows = new ArrayList<String[]>();
    List<String[]> courseRows = new ArrayList<String[]>();
    List<String[]> libraryRequests = new ArrayList<String[]>();
    List<String[]> departmentRows = new ArrayList<String[]>();
    List<String[]> subjectRows = new ArrayList<String[]>();
    List<String[]> facultyOptionRows = new ArrayList<String[]>();

    try (Connection conn = DatabaseUtil.getConnection()) {
        try (PreparedStatement statsStmt = conn.prepareStatement(
                "SELECT "
                        + "(SELECT COUNT(*) FROM students) AS total_students, "
                        + "(SELECT COUNT(*) FROM faculty) AS total_faculty, "
                        + "(SELECT COUNT(*) FROM subjects WHERE is_active = 1) AS total_courses, "
                        + "(SELECT COUNT(*) FROM notices WHERE is_active = 1) AS total_notices")) {
            try (ResultSet rs = statsStmt.executeQuery()) {
                if (rs.next()) {
                    totalStudents = String.valueOf(rs.getInt("total_students"));
                    totalFaculty = String.valueOf(rs.getInt("total_faculty"));
                    totalCourses = String.valueOf(rs.getInt("total_courses"));
                    totalNotices = String.valueOf(rs.getInt("total_notices"));
                }
            }
        }

        try (PreparedStatement studentStmt = conn.prepareStatement(
                "SELECT s.student_id, s.roll_number, s.full_name, d.department_code, u.email, u.phone, COALESCE(s.address, '') AS address "
                        + "FROM students s "
                        + "JOIN departments d ON d.department_id = s.department_id "
                        + "JOIN users u ON u.user_id = s.student_id "
                        + "ORDER BY s.created_at DESC")) {
            try (ResultSet rs = studentStmt.executeQuery()) {
                while (rs.next()) {
                    studentRows.add(new String[] {
                            rs.getString("student_id"),
                            rs.getString("roll_number"),
                            rs.getString("full_name"),
                            rs.getString("department_code"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getString("address")
                    });
                }
            }
        }

        try (PreparedStatement facultyStmt = conn.prepareStatement(
                "SELECT f.faculty_id, f.full_name, d.department_code, COALESCE(f.contact_no, '') AS contact_no, u.email "
                        + "FROM faculty f "
                        + "JOIN departments d ON d.department_id = f.department_id "
                        + "JOIN users u ON u.user_id = f.faculty_id "
                        + "ORDER BY f.created_at DESC")) {
            try (ResultSet rs = facultyStmt.executeQuery()) {
                while (rs.next()) {
                    facultyRows.add(new String[] {
                            rs.getString("faculty_id"),
                            rs.getString("full_name"),
                            rs.getString("department_code"),
                            rs.getString("contact_no"),
                            rs.getString("email")
                    });
                }
            }
        }

        try (PreparedStatement courseStmt = conn.prepareStatement(
                "SELECT d.department_code, s.subject_code, s.subject_name, s.credits "
                        + "FROM subjects s "
                        + "JOIN departments d ON d.department_id = s.department_id "
                        + "ORDER BY d.department_code, s.subject_code")) {
            try (ResultSet rs = courseStmt.executeQuery()) {
                while (rs.next()) {
                    courseRows.add(new String[] {
                            rs.getString("department_code"),
                            rs.getString("subject_code"),
                            rs.getString("subject_name"),
                            String.valueOf(rs.getInt("credits"))
                    });
                }
            }
        }

        try (PreparedStatement departmentStmt = conn.prepareStatement(
                "SELECT department_code, department_name FROM departments WHERE is_active = 1 ORDER BY department_code")) {
            try (ResultSet rs = departmentStmt.executeQuery()) {
                while (rs.next()) {
                    departmentRows.add(new String[] {
                            rs.getString("department_code"),
                            rs.getString("department_name")
                    });
                }
            }
        }

        try (PreparedStatement subjectStmt = conn.prepareStatement(
                "SELECT d.department_code, s.subject_code, s.subject_name "
                        + "FROM subjects s "
                        + "JOIN departments d ON d.department_id = s.department_id "
                        + "WHERE s.is_active = 1 "
                        + "ORDER BY d.department_code, s.subject_code")) {
            try (ResultSet rs = subjectStmt.executeQuery()) {
                while (rs.next()) {
                    subjectRows.add(new String[] {
                            rs.getString("department_code"),
                            rs.getString("subject_code"),
                            rs.getString("subject_name")
                    });
                }
            }
        }

        try (PreparedStatement facultyOptionStmt = conn.prepareStatement(
                "SELECT f.faculty_id, f.full_name, d.department_code "
                        + "FROM faculty f "
                        + "JOIN departments d ON d.department_id = f.department_id "
                        + "ORDER BY f.full_name")) {
            try (ResultSet rs = facultyOptionStmt.executeQuery()) {
                while (rs.next()) {
                    facultyOptionRows.add(new String[] {
                            rs.getString("faculty_id"),
                            rs.getString("full_name"),
                            rs.getString("department_code")
                    });
                }
            }
        }

        try (PreparedStatement libraryStmt = conn.prepareStatement(
            "SELECT request_id, student_id, request_date, status, COALESCE(remarks, '') AS remarks, "
                + "COALESCE(processed_by, '') AS processed_by, COALESCE(DATE_FORMAT(processed_at, '%Y-%m-%d %H:%i:%s'), '') AS processed_at "
                + "FROM library_card_requests ORDER BY created_at DESC LIMIT 100")) {
            try (ResultSet rs = libraryStmt.executeQuery()) {
                while (rs.next()) {
                    libraryRequests.add(new String[] {
                            rs.getString("request_id"),
                            rs.getString("student_id"),
                            rs.getString("request_date"),
                    rs.getString("status"),
                    rs.getString("remarks"),
                    rs.getString("processed_by"),
                    rs.getString("processed_at")
                    });
                }
            }
        }
    } catch (Exception ignore) {
        // Keep dashboard usable even if DB is temporarily unreachable.
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - UniCore ERP</title>
    <link rel="stylesheet" href="css/dashboard.css?v=20260324-logo">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <div class="admin-container">
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="logo"><img src="images/unicore-logo-banner.png" alt="UniCore ERP Logo" class="sidebar-logo-image"></div>
            </div>
            <nav class="sidebar-menu">
                <ul>
                    <li><a href="#dashboard" class="menu-item active" onclick="showSection(event, 'dashboard')"><span class="menu-icon">O</span><span class="menu-text">Dashboard</span></a></li>
                    <li><a href="#students" class="menu-item" onclick="showSection(event, 'students')"><span class="menu-icon">S</span><span class="menu-text">Students</span></a></li>
                    <li><a href="#faculty" class="menu-item" onclick="showSection(event, 'faculty')"><span class="menu-icon">F</span><span class="menu-text">Faculty</span></a></li>
                    <li><a href="#courses" class="menu-item" onclick="showSection(event, 'courses')"><span class="menu-icon">C</span><span class="menu-text">Courses</span></a></li>
                    <li><a href="#timetable" class="menu-item" onclick="showSection(event, 'timetable')"><span class="menu-icon">T</span><span class="menu-text">Timetable</span></a></li>
                    <li><a href="#exams" class="menu-item" onclick="showSection(event, 'exams')"><span class="menu-icon">E</span><span class="menu-text">Exams</span></a></li>
                    <li><a href="#notices" class="menu-item" onclick="showSection(event, 'notices')"><span class="menu-icon">N</span><span class="menu-text">Notices</span></a></li>
                    <li><a href="#library" class="menu-item" onclick="showSection(event, 'library')"><span class="menu-icon">L</span><span class="menu-text">Library Cards</span></a></li>
                </ul>
            </nav>
            <div class="sidebar-footer">
                <a href="logout" class="logout-btn"><span class="menu-icon">X</span><span class="menu-text">Logout</span></a>
            </div>
        </aside>

        <main class="main-content">
            <header class="header">
                <div class="header-left"><h1 class="page-title">Dashboard</h1></div>
                <div class="header-right">
                    <div class="admin-profile-wrapper">
                        <button type="button" class="admin-profile admin-profile-btn" id="adminProfileBtn" aria-expanded="false" aria-controls="adminProfileCard">
                            <div class="profile-avatar">A</div>
                            <div class="profile-info"><div class="profile-name"><%= adminDisplayName %></div><div class="profile-role">Administrator</div></div>
                        </button>
                        <div class="admin-profile-card" id="adminProfileCard">
                            <h3>Admin Details</h3>
                            <div class="admin-profile-row"><span>Name</span><strong><%= adminDisplayName %></strong></div>
                            <div class="admin-profile-row"><span>Role</span><strong>Administrator</strong></div>
                            <div class="admin-profile-row"><span>Session</span><strong><%= adminSessionId %></strong></div>
                            <div class="admin-profile-row"><span>Status</span><strong>Active</strong></div>
                        </div>
                    </div>
                </div>
            </header>

            <section id="dashboard" class="content-section active">
                <div class="section-header"><h2>Dashboard Overview</h2><p>Summary based on request attributes</p></div>
                <div class="stats-grid">
                    <div class="stat-card" data-target-section="student-directory"><div class="stat-icon">🎓</div><div class="stat-content"><div class="stat-value"><%= totalStudents %></div><div class="stat-label">Total Students</div></div></div>
                    <div class="stat-card" data-target-section="faculty-directory"><div class="stat-icon">👨‍🏫</div><div class="stat-content"><div class="stat-value"><%= totalFaculty %></div><div class="stat-label">Total Faculty</div></div></div>
                    <div class="stat-card" data-target-section="course-directory"><div class="stat-icon">📚</div><div class="stat-content"><div class="stat-value"><%= totalCourses %></div><div class="stat-label">Total Courses</div></div></div>
                    <div class="stat-card" data-target-section="notices"><div class="stat-icon">📢</div><div class="stat-content"><div class="stat-value"><%= totalNotices %></div><div class="stat-label">Total Notices</div></div></div>
                </div>
            </section>

            <section id="student-directory" class="content-section">
                <div class="section-header"><h2>Student Directory</h2><p>All registered students with search</p></div>
                <div class="form-container">
                    <div class="form-card">
                        <div class="form-row">
                            <div class="form-group">
                                <label>Search Student</label>
                                <input type="text" id="studentListSearch" placeholder="Search by ID, roll number, name, email, phone, department">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-container">
                    <table class="data-table" id="studentListTable">
                        <thead>
                            <tr>
                                <th>Student ID</th>
                                <th>Roll Number</th>
                                <th>Name</th>
                                <th>Department</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Address</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (studentRows != null && !studentRows.isEmpty()) { %>
                                <% for (String[] row : studentRows) { %>
                                    <tr>
                                        <td><%= row[0] %></td>
                                        <td><%= row[1] %></td>
                                        <td><%= row[2] %></td>
                                        <td><%= row[3] %></td>
                                        <td><%= row[4] %></td>
                                        <td><%= row[5] %></td>
                                        <td><%= row[6] %></td>
                                    </tr>
                                <% } %>
                            <% } else { %>
                                <tr><td colspan="7">No Data Available</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="faculty-directory" class="content-section">
                <div class="section-header"><h2>Faculty Directory</h2><p>All registered faculty with search</p></div>
                <div class="form-container">
                    <div class="form-card">
                        <div class="form-row">
                            <div class="form-group">
                                <label>Search Faculty</label>
                                <input type="text" id="facultyListSearch" placeholder="Search by ID, name, department, contact, email">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-container">
                    <table class="data-table" id="facultyListTable">
                        <thead>
                            <tr>
                                <th>Faculty ID</th>
                                <th>Name</th>
                                <th>Department</th>
                                <th>Contact</th>
                                <th>Email</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (facultyRows != null && !facultyRows.isEmpty()) { %>
                                <% for (String[] row : facultyRows) { %>
                                    <tr>
                                        <td><%= row[0] %></td>
                                        <td><%= row[1] %></td>
                                        <td><%= row[2] %></td>
                                        <td><%= row[3] %></td>
                                        <td><%= row[4] %></td>
                                    </tr>
                                <% } %>
                            <% } else { %>
                                <tr><td colspan="5">No Data Available</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="course-directory" class="content-section">
                <div class="section-header"><h2>Course Directory</h2><p>All registered courses with search</p></div>
                <div class="form-container">
                    <div class="form-card">
                        <div class="form-row">
                            <div class="form-group">
                                <label>Search Course</label>
                                <input type="text" id="courseListSearch" placeholder="Search by department, subject code, subject name, credits">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-container">
                    <table class="data-table" id="courseListTable">
                        <thead><tr><th>Department</th><th>Subject Code</th><th>Subject</th><th>Credits</th></tr></thead>
                        <tbody>
                            <% if (courseRows != null && !courseRows.isEmpty()) { %>
                                <% for (String[] row : courseRows) { %>
                                    <tr>
                                        <td><%= row[0] %></td>
                                        <td><%= row[1] %></td>
                                        <td><%= row[2] %></td>
                                        <td><%= row[3] %></td>
                                    </tr>
                                <% } %>
                            <% } else { %>
                                <tr><td colspan="4">No Data Available</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="students" class="content-section">
                <div class="section-header"><h2>Student Management</h2><p>Submit student data</p></div>
                <div class="form-container">
                    <div class="form-card">
                        <h3>Add New Student</h3>
                        <form class="management-form" method="post" action="addStudent">
                            <div class="form-row">
                                <div class="form-group"><label>Student ID</label><input type="text" name="studentId" required></div>
                                <div class="form-group"><label>Roll Number</label><input type="text" name="rollNumber" required></div>
                            </div>
                            <div class="form-row">
                                <div class="form-group"><label>Full Name</label><input type="text" name="studentName" required></div>
                                <div class="form-group">
                                    <label>Department</label>
                                    <select name="department" required>
                                        <option value="">Select Department</option>
                                        <% for (String[] dept : departmentRows) { %>
                                            <option value="<%= dept[0] %>"><%= dept[0] %> - <%= dept[1] %></option>
                                        <% } %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group"><label>Email</label><input type="email" name="email" required></div>
                                <div class="form-group"><label>Phone</label><input type="text" name="phone" required></div>
                            </div>
                            <div class="form-row">
                                <div class="form-group"><label>Address</label><textarea name="address" required></textarea></div>
                            </div>
                            <button type="submit" class="btn btn-primary">Save Student</button>
                        </form>
                    </div>
                </div>
            </section>

            <section id="faculty" class="content-section">
                <div class="section-header"><h2>Faculty Management</h2><p>Submit faculty data</p></div>
                <div class="form-container">
                    <div class="form-card">
                        <h3>Add New Faculty</h3>
                        <form class="management-form" method="post" action="addFaculty">
                            <div class="form-row">
                                <div class="form-group"><label>Faculty ID</label><input type="text" name="facultyId" required></div>
                                <div class="form-group"><label>Full Name</label><input type="text" name="facultyName" required></div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Department</label>
                                    <select name="facultyDepartment" required>
                                        <option value="">Select Department</option>
                                        <% for (String[] dept : departmentRows) { %>
                                            <option value="<%= dept[0] %>"><%= dept[0] %> - <%= dept[1] %></option>
                                        <% } %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group"><label>Faculty Contact</label><input type="text" name="facultyContact" required></div>
                                <div class="form-group"><label>Email</label><input type="email" name="email" required></div>
                            </div>
                            <button type="submit" class="btn btn-primary">Save Faculty</button>
                        </form>
                    </div>
                </div>
            </section>

            <section id="courses" class="content-section">
                <div class="section-header"><h2>Subject Management</h2><p>Add and view all subjects with departments</p></div>
                <div class="form-container">
                    <div class="form-card">
                        <h3>Add Subject</h3>
                        <form class="management-form" method="post" action="addCourse">
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Department</label>
                                    <select name="department" required>
                                        <option value="">Select Department</option>
                                        <% for (String[] dept : departmentRows) { %>
                                            <option value="<%= dept[0] %>"><%= dept[0] %> - <%= dept[1] %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="form-group"><label>Subject</label><input type="text" name="courseName" required></div>
                            </div>
                            <div class="form-row">
                                <div class="form-group"><label>Subject Code</label><input type="text" name="courseCode" required></div>
                                <div class="form-group"><label>Credits</label><input type="number" name="credits" min="1" max="10" required></div>
                            </div>
                            <button type="submit" class="btn btn-primary">Add Subject</button>
                        </form>
                    </div>
                </div>
            </section>

            <section id="timetable" class="content-section">
                <div class="section-header"><h2>Timetable Management</h2><p>Create timetable entries</p></div>
                <div class="form-container">
                    <div class="form-card">
                        <h3>Create Timetable Entry</h3>
                        <form class="management-form" method="post" action="createTimetable">
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Department</label>
                                    <select name="department" id="ttDepartment" required>
                                        <option value="">Select Department</option>
                                        <% for (String[] dept : departmentRows) { %>
                                            <option value="<%= dept[0] %>"><%= dept[0] %> - <%= dept[1] %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Subject</label>
                                    <select name="subject" id="ttSubject" required>
                                        <option value="">Select Subject</option>
                                        <% for (String[] subject : subjectRows) { %>
                                            <option value="<%= subject[2] %>" data-department="<%= subject[0] %>" data-code="<%= subject[1] %>"><%= subject[1] %> - <%= subject[2] %></option>
                                        <% } %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Day</label>
                                    <select name="day" required>
                                        <option value="">Select Day</option>
                                        <option value="Monday">Monday</option>
                                        <option value="Tuesday">Tuesday</option>
                                        <option value="Wednesday">Wednesday</option>
                                        <option value="Thursday">Thursday</option>
                                        <option value="Friday">Friday</option>
                                        <option value="Saturday">Saturday</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Time</label>
                                    <select name="time" required>
                                        <option value="">Select Time Slot</option>
                                        <option value="09:00-10:00">09:00 - 10:00</option>
                                        <option value="10:00-11:00">10:00 - 11:00</option>
                                        <option value="11:00-12:00">11:00 - 12:00</option>
                                        <option value="13:00-14:00">13:00 - 14:00</option>
                                        <option value="14:00-15:00">14:00 - 15:00</option>
                                        <option value="15:00-16:00">15:00 - 16:00</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Subject Code</label>
                                    <select name="subjectCode" id="ttSubjectCode" required>
                                        <option value="">Select Subject Code</option>
                                        <% for (String[] subject : subjectRows) { %>
                                            <option value="<%= subject[1] %>" data-department="<%= subject[0] %>" data-name="<%= subject[2] %>"><%= subject[1] %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Faculty</label>
                                    <select name="facultyName" id="ttFaculty" required>
                                        <option value="">Select Faculty</option>
                                        <% for (String[] faculty : facultyOptionRows) { %>
                                            <option value="<%= faculty[0] %>" data-department="<%= faculty[2] %>"><%= faculty[1] %> (<%= faculty[0] %>)</option>
                                        <% } %>
                                    </select>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">Save Timetable</button>
                        </form>
                    </div>
                </div>
            </section>

            <section id="exams" class="content-section">
                <div class="section-header"><h2>Exam Management</h2><p>Create exam entries</p></div>
                <div class="form-container">
                    <div class="form-card">
                        <h3>Create Exam</h3>
                        <form class="management-form" method="post" action="createExam">
                            <div class="form-row">
                                <div class="form-group"><label>Exam ID</label><input type="text" name="examId" required></div>
                                <div class="form-group">
                                    <label>Department</label>
                                    <select name="department" id="examDepartment" required>
                                        <option value="">Select Department</option>
                                        <% for (String[] dept : departmentRows) { %>
                                            <option value="<%= dept[0] %>"><%= dept[0] %> - <%= dept[1] %></option>
                                        <% } %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Subject</label>
                                    <select name="subject" id="examSubject" required>
                                        <option value="">Select Subject</option>
                                        <% for (String[] subject : subjectRows) { %>
                                            <option value="<%= subject[1] %>" data-department="<%= subject[0] %>"><%= subject[1] %> - <%= subject[2] %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="form-group"><label>Date</label><input type="date" name="date" required></div>
                            </div>
                            <div class="form-row">
                                <div class="form-group"><label>Time</label><input type="text" name="time" required></div>
                                <div class="form-group"><label>Location</label><input type="text" name="location" required></div>
                            </div>
                            <button type="submit" class="btn btn-primary">Save Exam</button>
                        </form>
                    </div>
                </div>
            </section>

            <section id="notices" class="content-section">
                <div class="section-header"><h2>Notice Management</h2><p>Create notice entries</p></div>
                <div class="form-container">
                    <div class="form-card">
                        <h3>Post Notice</h3>
                        <form class="management-form" method="post" action="sendNotice">
                            <div class="form-row"><div class="form-group"><label>Notice ID</label><input type="text" name="noticeId" required></div></div>
                            <div class="form-row"><div class="form-group"><label>Notice</label><textarea name="noticeText" required></textarea></div></div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Send To</label>
                                    <select name="targetGroup" required>
                                        <option value="">Select Target</option>
                                        <option value="ALL_STUDENTS">All Students</option>
                                        <option value="ALL_FACULTY">All Faculty</option>
                                        <% for (String[] dept : departmentRows) { %>
                                            <option value="DEPT_<%= dept[0].replace("-", "_") %>">Department - <%= dept[0] %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="form-group"><label>Date</label><input type="date" name="date" required></div>
                            </div>
                            <button type="submit" class="btn btn-primary">Save Notice</button>
                        </form>
                    </div>
                </div>
            </section>

            <section id="library" class="content-section">
                <div class="section-header"><h2>Library Card Requests</h2><p>Approve, reject, or issue requests from here</p></div>
                <div class="table-container">
                    <table class="data-table">
                        <thead><tr><th>Request ID</th><th>Student ID</th><th>Request Date</th><th>Status</th><th>Admin Remarks</th><th>Processed By</th><th>Processed At</th><th>Action</th></tr></thead>
                        <tbody>
                            <% if (libraryRequests != null && !libraryRequests.isEmpty()) { %>
                                <% for (String[] requestRow : libraryRequests) { %>
                                    <tr>
                                        <td><%= requestRow[0] %></td>
                                        <td><%= requestRow[1] %></td>
                                        <td><%= requestRow[2] %></td>
                                        <td><span class="status-badge <%= requestRow[3].toLowerCase() %>"><%= requestRow[3] %></span></td>
                                        <td><%= requestRow[4] %></td>
                                        <td><%= requestRow[5] %></td>
                                        <td><%= requestRow[6] %></td>
                                        <td>
                                            <% if ("PENDING".equalsIgnoreCase(requestRow[3])) { %>
                                                <form method="post" action="processLibraryCardRequest" style="display:flex;flex-direction:column;gap:8px;min-width:180px;">
                                                    <input type="hidden" name="requestId" value="<%= requestRow[0] %>">
                                                    <select name="status" required>
                                                        <option value="APPROVED">APPROVED</option>
                                                        <option value="REJECTED">REJECTED</option>
                                                        <option value="ISSUED">ISSUED</option>
                                                    </select>
                                                    <input type="text" name="remarks" placeholder="Remarks (optional)">
                                                    <button type="submit" class="btn btn-primary">Update</button>
                                                </form>
                                            <% } else { %>
                                                <span class="badge success">Processed</span>
                                            <% } %>
                                        </td>
                                    </tr>
                                <% } %>
                            <% } else { %>
                                <tr><td colspan="8">No Data Available</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>

    <script>
        function showSectionById(sectionId) {
            const sections = document.querySelectorAll('.content-section');
            sections.forEach(function(section) {
                section.classList.remove('active');
            });

            const selectedSection = document.getElementById(sectionId);
            if (!selectedSection) {
                return;
            }
            selectedSection.classList.add('active');

            const menuItems = document.querySelectorAll('.menu-item');
            menuItems.forEach(function(item) {
                item.classList.remove('active');
            });

            const activeMenuItem = document.querySelector('.menu-item[href="#' + sectionId + '"]');
            if (activeMenuItem) {
                activeMenuItem.classList.add('active');
            }

            const titleElement = selectedSection.querySelector('.section-header h2');
            const pageTitle = document.querySelector('.page-title');
            if (titleElement && pageTitle) {
                pageTitle.textContent = titleElement.textContent;
            }
        }

        function showSection(event, sectionId) {
            if (event) {
                event.preventDefault();
            }
            showSectionById(sectionId);
            return false;
        }

        document.addEventListener('DOMContentLoaded', function() {
            const queryParams = new URLSearchParams(window.location.search);
            const popupMessage = queryParams.get('popup');

            if (window.location.hash) {
                const initialSection = window.location.hash.replace('#', '');
                if (document.getElementById(initialSection)) {
                    showSectionById(initialSection);
                }
            }

            if (popupMessage) {
                window.alert(popupMessage);
                const cleanUrl = window.location.pathname + (window.location.hash || '');
                window.history.replaceState({}, document.title, cleanUrl);
            }

            const menuLinks = document.querySelectorAll('.sidebar-menu .menu-item[href^="#"]');
            menuLinks.forEach(function(link) {
                const sectionId = link.getAttribute('href').replace('#', '');
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    showSectionById(sectionId);
                    window.location.hash = sectionId;
                });
            });

            const statCards = document.querySelectorAll('.stat-card[data-target-section]');
            statCards.forEach(function(card) {
                card.style.cursor = 'pointer';
                card.addEventListener('click', function() {
                    const target = card.getAttribute('data-target-section');
                    if (target) {
                        showSectionById(target);
                        window.location.hash = target;
                    }
                });
            });

            function bindTableSearch(inputId, tableId) {
                const input = document.getElementById(inputId);
                const table = document.getElementById(tableId);
                if (!input || !table) {
                    return;
                }

                input.addEventListener('input', function() {
                    const query = input.value.trim().toLowerCase();
                    const rows = table.querySelectorAll('tbody tr');
                    rows.forEach(function(row) {
                        const text = row.textContent.toLowerCase();
                        row.style.display = text.indexOf(query) !== -1 ? '' : 'none';
                    });
                });
            }

            bindTableSearch('studentListSearch', 'studentListTable');
            bindTableSearch('facultyListSearch', 'facultyListTable');
            bindTableSearch('courseListSearch', 'courseListTable');

            function filterSelectOptionsByDepartment(selectEl, departmentCode, placeholder) {
                if (!selectEl) {
                    return;
                }
                const targetDept = (departmentCode || '').trim().toUpperCase();
                const options = selectEl.querySelectorAll('option[data-department]');
                let anyVisible = false;

                options.forEach(function(option) {
                    const optionDept = (option.getAttribute('data-department') || '').trim().toUpperCase();
                    const visible = !targetDept || optionDept === targetDept;
                    option.hidden = !visible;
                    option.disabled = !visible;
                    if (visible) {
                        anyVisible = true;
                    }
                });

                selectEl.value = '';
                if (placeholder) {
                    const firstOption = selectEl.querySelector('option');
                    if (firstOption) {
                        firstOption.textContent = anyVisible ? placeholder : 'No options available for selected department';
                    }
                }
            }

            const ttDepartment = document.getElementById('ttDepartment');
            const ttSubject = document.getElementById('ttSubject');
            const ttSubjectCode = document.getElementById('ttSubjectCode');
            const ttFaculty = document.getElementById('ttFaculty');

            if (ttDepartment) {
                ttDepartment.addEventListener('change', function() {
                    const dept = ttDepartment.value;
                    filterSelectOptionsByDepartment(ttSubject, dept, 'Select Subject');
                    filterSelectOptionsByDepartment(ttSubjectCode, dept, 'Select Subject Code');
                    filterSelectOptionsByDepartment(ttFaculty, dept, 'Select Faculty');
                });
            }

            if (ttSubject && ttSubjectCode) {
                ttSubject.addEventListener('change', function() {
                    const selected = ttSubject.options[ttSubject.selectedIndex];
                    const code = selected ? selected.getAttribute('data-code') : '';
                    if (code) {
                        ttSubjectCode.value = code;
                    }
                });

                ttSubjectCode.addEventListener('change', function() {
                    const selected = ttSubjectCode.options[ttSubjectCode.selectedIndex];
                    const subjectName = selected ? selected.getAttribute('data-name') : '';
                    if (subjectName) {
                        ttSubject.value = subjectName;
                    }
                });
            }

            const examDepartment = document.getElementById('examDepartment');
            const examSubject = document.getElementById('examSubject');
            if (examDepartment) {
                examDepartment.addEventListener('change', function() {
                    filterSelectOptionsByDepartment(examSubject, examDepartment.value, 'Select Subject');
                });
            }

            const profileBtn = document.getElementById('adminProfileBtn');
            const profileCard = document.getElementById('adminProfileCard');

            if (profileBtn && profileCard) {
                profileBtn.addEventListener('click', function(e) {
                    e.stopPropagation();
                    const isOpen = profileCard.classList.toggle('open');
                    profileBtn.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
                });

                document.addEventListener('click', function(e) {
                    if (!profileCard.contains(e.target) && !profileBtn.contains(e.target)) {
                        profileCard.classList.remove('open');
                        profileBtn.setAttribute('aria-expanded', 'false');
                    }
                });
            }
        });
    </script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.sql.Connection,java.sql.PreparedStatement,java.sql.ResultSet" %>
<%@ page import="com.project.util.DatabaseUtil" %>
<%
    String classesToday = "0";
    String attendancePercent = "0";
    String pendingAssignments = "0";
    String latestNotices = "0";
    String studentDisplayName = session.getAttribute("userId") != null ? session.getAttribute("userId").toString() : "User";
    String studentIdProfile = studentDisplayName;
    String studentCourse = "Not Available";
    String studentEmail = "Not Available";
    String studentPhone = "Not Available";
    String studentTargetGroup = "ALL_STUDENTS";
    String studentAvatarUrl = null;

    List<String[]> timetableRows = new ArrayList<String[]>();
    List<String[]> attendanceRows = new ArrayList<String[]>();
    List<String[]> assignmentRows = new ArrayList<String[]>();
    List<String[]> noticeRows = new ArrayList<String[]>();
    List<String[]> libraryRows = new ArrayList<String[]>();

    if (session.getAttribute("userId") != null) {
        String studentId = session.getAttribute("userId").toString();
        try (Connection conn = DatabaseUtil.getConnection()) {
            try (PreparedStatement statsStmt = conn.prepareStatement(
                    "SELECT "
                            + "(SELECT COUNT(*) FROM timetable t JOIN students s ON s.department_id = t.department_id WHERE s.student_id = ? AND t.day_name = DAYNAME(CURDATE()) AND t.is_active = 1) AS classes_today, "
                            + "(SELECT ROUND(100 * SUM(CASE WHEN ar.status = 'Present' THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0), 2) FROM attendance_records ar WHERE ar.student_id = ?) AS attendance_percent, "
                            + "(SELECT COUNT(*) FROM assignments a JOIN students s ON s.department_id = a.department_id WHERE s.student_id = ? AND a.due_date >= CURDATE()) AS pending_assignments, "
                            + "(SELECT COUNT(*) FROM notices n WHERE n.is_active = 1) AS latest_notices")) {
                statsStmt.setString(1, studentId);
                statsStmt.setString(2, studentId);
                statsStmt.setString(3, studentId);
                try (ResultSet rs = statsStmt.executeQuery()) {
                    if (rs.next()) {
                        classesToday = String.valueOf(rs.getInt("classes_today"));
                        String attendanceVal = rs.getString("attendance_percent");
                        attendancePercent = attendanceVal != null ? attendanceVal : "0";
                        pendingAssignments = String.valueOf(rs.getInt("pending_assignments"));
                        latestNotices = String.valueOf(rs.getInt("latest_notices"));
                    }
                }
            }

            try (PreparedStatement profileStmt = conn.prepareStatement(
                    "SELECT s.full_name, d.department_code, u.email, u.phone "
                            + "FROM students s "
                            + "JOIN users u ON u.user_id = s.student_id "
                            + "JOIN departments d ON d.department_id = s.department_id "
                            + "WHERE s.student_id = ?")) {
                profileStmt.setString(1, studentId);
                try (ResultSet rs = profileStmt.executeQuery()) {
                    if (rs.next()) {
                        studentDisplayName = rs.getString("full_name");
                        studentCourse = rs.getString("department_code");
                        if (studentCourse != null && !studentCourse.trim().isEmpty()) {
                            studentTargetGroup = "DEPT_" + studentCourse.replace("-", "_");
                        }
                        studentEmail = rs.getString("email");
                        studentPhone = rs.getString("phone") != null ? rs.getString("phone") : "Not Available";
                    }
                }
            }

            try (PreparedStatement timetableStmt = conn.prepareStatement(
                    "SELECT t.day_name, sub.subject_name, CONCAT(TIME_FORMAT(t.start_time, '%H:%i'), ' - ', TIME_FORMAT(t.end_time, '%H:%i')) AS slot, f.full_name AS faculty_name "
                            + "FROM timetable t "
                            + "JOIN subjects sub ON sub.subject_id = t.subject_id "
                            + "JOIN faculty f ON f.faculty_id = t.faculty_id "
                            + "JOIN students s ON s.department_id = t.department_id "
                            + "WHERE s.student_id = ? AND t.is_active = 1 "
                            + "ORDER BY FIELD(t.day_name, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'), t.start_time")) {
                timetableStmt.setString(1, studentId);
                try (ResultSet rs = timetableStmt.executeQuery()) {
                    while (rs.next()) {
                        timetableRows.add(new String[] {
                                rs.getString("day_name"),
                                rs.getString("subject_name"),
                                rs.getString("slot"),
                                rs.getString("faculty_name")
                        });
                    }
                }
            }

            try (PreparedStatement attendanceStmt = conn.prepareStatement(
                    "SELECT sub.subject_name, COUNT(*) AS total_classes, "
                            + "SUM(CASE WHEN ar.status = 'Present' THEN 1 ELSE 0 END) AS present_classes, "
                            + "ROUND(100 * SUM(CASE WHEN ar.status = 'Present' THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0), 2) AS attendance_percent "
                            + "FROM attendance_records ar "
                            + "JOIN attendance_sessions a ON a.attendance_id = ar.attendance_id "
                            + "JOIN subjects sub ON sub.subject_id = a.subject_id "
                            + "WHERE ar.student_id = ? "
                            + "GROUP BY sub.subject_name ORDER BY sub.subject_name")) {
                attendanceStmt.setString(1, studentId);
                try (ResultSet rs = attendanceStmt.executeQuery()) {
                    while (rs.next()) {
                        attendanceRows.add(new String[] {
                                rs.getString("subject_name"),
                                String.valueOf(rs.getInt("total_classes")),
                                String.valueOf(rs.getInt("present_classes")),
                                rs.getString("attendance_percent") != null ? rs.getString("attendance_percent") : "0"
                        });
                    }
                }
            }

            try (PreparedStatement assignmentStmt = conn.prepareStatement(
                    "SELECT a.title, sub.subject_name, a.due_date, "
                            + "CASE WHEN s.assignment_id IS NULL THEN 'Pending' ELSE s.submission_status END AS status, "
                            + "CASE WHEN s.assignment_id IS NULL THEN 'Submit' ELSE 'View' END AS action_text "
                            + "FROM assignments a "
                            + "JOIN subjects sub ON sub.subject_id = a.subject_id "
                            + "JOIN students st ON st.department_id = a.department_id "
                            + "LEFT JOIN assignment_submissions s ON s.assignment_id = a.assignment_id AND s.student_id = st.student_id "
                            + "WHERE st.student_id = ? ORDER BY a.due_date DESC")) {
                assignmentStmt.setString(1, studentId);
                try (ResultSet rs = assignmentStmt.executeQuery()) {
                    while (rs.next()) {
                        assignmentRows.add(new String[] {
                                rs.getString("title"),
                                rs.getString("subject_name"),
                                rs.getString("due_date"),
                                rs.getString("status"),
                                rs.getString("action_text")
                        });
                    }
                }
            }

            try (PreparedStatement noticeStmt = conn.prepareStatement(
                    "SELECT notice_title, notice_text, notice_date FROM notices "
                            + "WHERE is_active = 1 AND (target_group = 'ALL_STUDENTS' OR target_group = ?) "
                            + "ORDER BY notice_date DESC LIMIT 100")) {
                noticeStmt.setString(1, studentTargetGroup);
                try (ResultSet rs = noticeStmt.executeQuery()) {
                    while (rs.next()) {
                        noticeRows.add(new String[] {
                                rs.getString("notice_title"),
                                rs.getString("notice_text"),
                                rs.getString("notice_date")
                        });
                    }
                }
            }

            try (PreparedStatement libraryStmt = conn.prepareStatement(
                    "SELECT request_id, request_date, status, "
                            + "COALESCE(DATE_FORMAT(processed_at, '%Y-%m-%d %H:%i:%s'), '') AS processed_at, "
                            + "COALESCE(remarks, '') AS remarks "
                            + "FROM library_card_requests WHERE student_id = ? ORDER BY created_at DESC LIMIT 100")) {
                libraryStmt.setString(1, studentId);
                try (ResultSet rs = libraryStmt.executeQuery()) {
                    while (rs.next()) {
                        libraryRows.add(new String[] {
                                rs.getString("request_id"),
                                rs.getString("request_date"),
                                rs.getString("status"),
                                rs.getString("processed_at"),
                                rs.getString("remarks")
                        });
                    }
                }
            }
        } catch (Exception ignore) {
            // Keep page usable if DB is unavailable.
        }

        String uploadPath = application.getRealPath("/uploads/student-profiles");
        if (uploadPath != null) {
            File profileDir = new File(uploadPath);
            if (profileDir.exists() && profileDir.isDirectory()) {
                File[] matches = profileDir.listFiles((dir, name) -> name.startsWith(studentId + "_"));
                if (matches != null && matches.length > 0) {
                    Arrays.sort(matches, Comparator.comparingLong(File::lastModified).reversed());
                    studentAvatarUrl = "uploads/student-profiles/" + matches[0].getName();
                    session.setAttribute("studentAvatarPath", studentAvatarUrl);
                }
            }
        }

        if (studentAvatarUrl == null && session.getAttribute("studentAvatarPath") != null) {
            studentAvatarUrl = session.getAttribute("studentAvatarPath").toString();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - UniCore ERP</title>
    <link rel="stylesheet" href="css/dashboard.css?v=20260324-logo">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <div class="student-container">
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="logo"><img src="images/unicore-logo.png" alt="UniCore ERP Logo" class="sidebar-logo-image"><span class="logo-text">UniCore ERP</span></div>
            </div>
            <nav class="sidebar-menu">
                <ul>
                    <li><a href="#dashboard" class="menu-item active" onclick="showSection(event, 'dashboard')"><span class="menu-icon">O</span><span class="menu-text">Dashboard</span></a></li>
                    <li><a href="#timetable" class="menu-item" onclick="showSection(event, 'timetable')"><span class="menu-icon">T</span><span class="menu-text">My Timetable</span></a></li>
                    <li><a href="#attendance" class="menu-item" onclick="showSection(event, 'attendance')"><span class="menu-icon">AT</span><span class="menu-text">Attendance</span></a></li>
                    <li><a href="#assignments" class="menu-item" onclick="showSection(event, 'assignments')"><span class="menu-icon">AS</span><span class="menu-text">Assignments</span></a></li>
                    <li><a href="#notices" class="menu-item" onclick="showSection(event, 'notices')"><span class="menu-icon">N</span><span class="menu-text">Notices</span></a></li>
                    <li><a href="#library-card" class="menu-item" onclick="showSection(event, 'library-card')"><span class="menu-icon">L</span><span class="menu-text">Library Card Issue</span></a></li>
                    <li><a href="logout" class="menu-item logout-item"><span class="menu-icon">X</span><span class="menu-text">Logout</span></a></li>
                </ul>
            </nav>
        </aside>

        <div class="main-content">
            <header class="header">
                <div class="header-left"><h1 class="page-title">Dashboard</h1></div>
                <div class="header-right">
                    <div class="admin-profile-wrapper">
                        <button type="button" class="student-profile student-profile-btn" id="studentProfileBtn" aria-expanded="false" aria-controls="studentProfileCard">
                            <% if (studentAvatarUrl != null) { %>
                                <img class="profile-avatar" src="<%= studentAvatarUrl %>" alt="Profile Photo">
                            <% } else { %>
                                <div class="profile-avatar"><%= studentDisplayName != null && !studentDisplayName.isEmpty() ? studentDisplayName.substring(0, 1).toUpperCase() : "S" %></div>
                            <% } %>
                            <span class="student-name"><%= studentDisplayName %></span>
                        </button>
                        <div class="admin-profile-card" id="studentProfileCard" style="width: 340px;">
                            <h3>My Profile</h3>
                            <div class="admin-profile-row"><span>Name</span><strong><%= studentDisplayName %></strong></div>
                            <div class="admin-profile-row"><span>Student ID</span><strong><%= studentIdProfile %></strong></div>
                            <div class="admin-profile-row"><span>Department</span><strong><%= studentCourse %></strong></div>
                            <div class="admin-profile-row"><span>Email</span><strong><%= studentEmail %></strong></div>

                            <div style="margin-top: 14px; border-top: 1px solid #E2E8F0; padding-top: 12px;">
                                <h3 style="font-size:14px;margin-bottom:8px;">Upload Profile Picture</h3>
                                <form method="post" action="uploadStudentPhoto" enctype="multipart/form-data" style="display:flex;flex-direction:column;gap:8px;">
                                    <input type="file" name="profilePhoto" accept="image/*" required>
                                    <button type="submit" class="btn btn-primary" style="width:100%;">Upload Photo</button>
                                </form>
                            </div>

                            <div style="margin-top: 14px; border-top: 1px solid #E2E8F0; padding-top: 12px;">
                                <h3 style="font-size:14px;margin-bottom:8px;">Change / Forgot Password</h3>
                                <form method="post" action="updateStudentPassword" style="display:flex;flex-direction:column;gap:8px;">
                                    <input type="password" name="currentPassword" placeholder="Current Password" required>
                                    <input type="password" name="newPassword" placeholder="New Password" required>
                                    <input type="password" name="confirmPassword" placeholder="Confirm New Password" required>
                                    <button type="submit" class="btn btn-primary" style="width:100%;">Update Password</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <section id="dashboard" class="content-section active">
                <div class="section-header"><h2>Dashboard Overview</h2><p>Summary based on request attributes</p></div>
                <div class="stats-grid">
                    <div class="stat-card"><div class="stat-content"><p class="stat-label">Total Classes Today</p><h3 class="stat-value"><%= classesToday %></h3></div></div>
                    <div class="stat-card"><div class="stat-content"><p class="stat-label">Attendance Percentage</p><h3 class="stat-value"><%= attendancePercent %></h3></div></div>
                    <div class="stat-card"><div class="stat-content"><p class="stat-label">Pending Assignments</p><h3 class="stat-value"><%= pendingAssignments %></h3></div></div>
                    <div class="stat-card"><div class="stat-content"><p class="stat-label">Latest Notices</p><h3 class="stat-value"><%= latestNotices %></h3></div></div>
                </div>
            </section>

            <section id="timetable" class="content-section">
                <div class="section-header"><h2>My Timetable</h2><p>Rows from request attribute: timetableRows</p></div>
                <div class="table-container">
                    <table class="data-table">
                        <thead><tr><th>Day</th><th>Subject</th><th>Time</th><th>Faculty Name</th></tr></thead>
                        <tbody>
                            <% if (timetableRows != null && !timetableRows.isEmpty()) { %>
                                <% for (String[] row : timetableRows) { %>
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

            <section id="attendance" class="content-section">
                <div class="section-header"><h2>Attendance</h2><p>Rows from request attribute: attendanceRows</p></div>
                <div class="table-container">
                    <table class="data-table">
                        <thead><tr><th>Subject</th><th>Total Classes</th><th>Present Classes</th><th>Attendance %</th></tr></thead>
                        <tbody>
                            <% if (attendanceRows != null && !attendanceRows.isEmpty()) { %>
                                <% for (String[] row : attendanceRows) { %>
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

            <section id="assignments" class="content-section">
                <div class="section-header"><h2>Assignments</h2><p>Rows from request attribute: assignmentRows</p></div>
                <div class="table-container">
                    <table class="data-table">
                        <thead><tr><th>Assignment Title</th><th>Subject</th><th>Due Date</th><th>Status</th><th>Action</th></tr></thead>
                        <tbody>
                            <% if (assignmentRows != null && !assignmentRows.isEmpty()) { %>
                                <% for (String[] row : assignmentRows) { %>
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

            <section id="notices" class="content-section">
                <div class="section-header"><h2>Notices</h2><p>Admin notices and library request confirmations</p></div>

                <div class="table-container" style="margin-bottom: 20px;">
                    <table class="data-table">
                        <thead><tr><th>Library Request ID</th><th>Request Date</th><th>Status</th><th>Processed At</th><th>Remarks</th></tr></thead>
                        <tbody>
                            <% if (libraryRows != null && !libraryRows.isEmpty()) { %>
                                <% for (String[] row : libraryRows) { %>
                                    <tr>
                                        <td><%= row[0] %></td>
                                        <td><%= row[1] %></td>
                                        <td><span class="status-badge <%= row[2].toLowerCase() %>"><%= row[2] %></span></td>
                                        <td><%= row[3] %></td>
                                        <td><%= row[4] %></td>
                                    </tr>
                                <% } %>
                            <% } else { %>
                                <tr><td colspan="5">No library card request updates yet</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <div class="table-container">
                    <table class="data-table">
                        <thead><tr><th>Title</th><th>Description</th><th>Date</th></tr></thead>
                        <tbody>
                            <% if (noticeRows != null && !noticeRows.isEmpty()) { %>
                                <% for (String[] row : noticeRows) { %>
                                    <tr>
                                        <td><%= row[0] %></td>
                                        <td><%= row[1] %></td>
                                        <td><%= row[2] %></td>
                                    </tr>
                                <% } %>
                            <% } else { %>
                                <tr><td colspan="3">No Data Available</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="library-card" class="content-section">
                <div class="section-header"><h2>Library Card Issue</h2><p>Send request to admin for library card issue</p></div>
                <div class="form-container">
                    <div class="form-card">
                        <h3>Issue Library Card Request</h3>
                        <form class="management-form" method="post" action="requestLibraryCard">
                            <div class="form-row">
                                <div class="form-group"><label>Student ID</label><input type="text" value="<%= studentIdProfile %>" readonly></div>
                                <div class="form-group"><label>Name</label><input type="text" value="<%= studentDisplayName %>" readonly></div>
                            </div>
                            <button type="submit" class="btn btn-primary">Send Request To Admin</button>
                        </form>
                    </div>
                </div>
                <div class="table-container">
                    <table class="data-table">
                        <thead><tr><th>Request ID</th><th>Request Date</th><th>Status</th><th>Processed At</th><th>Remarks</th></tr></thead>
                        <tbody>
                            <% if (libraryRows != null && !libraryRows.isEmpty()) { %>
                                <% for (String[] row : libraryRows) { %>
                                    <tr>
                                        <td><%= row[0] %></td>
                                        <td><%= row[1] %></td>
                                        <td><span class="status-badge <%= row[2].toLowerCase() %>"><%= row[2] %></span></td>
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
        </div>
    </div>

    <script>
        function showSectionById(sectionId) {
            const sections = document.querySelectorAll('.content-section');
            sections.forEach(function(section) { section.classList.remove('active'); });
            const selectedSection = document.getElementById(sectionId);
            if (!selectedSection) { return; }
            selectedSection.classList.add('active');

            const menuItems = document.querySelectorAll('.menu-item');
            menuItems.forEach(function(item) { item.classList.remove('active'); });
            const activeMenuItem = document.querySelector('.menu-item[href="#' + sectionId + '"]');
            if (activeMenuItem) { activeMenuItem.classList.add('active'); }

            const titleElement = selectedSection.querySelector('.section-header h2');
            const pageTitle = document.querySelector('.page-title');
            if (titleElement && pageTitle) { pageTitle.textContent = titleElement.textContent; }
        }

        function showSection(event, sectionId) {
            if (event) { event.preventDefault(); }
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

            const profileBtn = document.getElementById('studentProfileBtn');
            const profileCard = document.getElementById('studentProfileCard');
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

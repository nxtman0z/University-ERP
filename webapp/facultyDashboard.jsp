<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%
    Object classesTodayAttr = request.getAttribute("classesToday");
    Object totalStudentsAttr = request.getAttribute("totalStudents");
    Object pendingAssignmentsAttr = request.getAttribute("pendingAssignments");
    Object noticeCountAttr = request.getAttribute("noticeCount");

    String classesToday = classesTodayAttr != null ? classesTodayAttr.toString() : "0";
    String totalStudents = totalStudentsAttr != null ? totalStudentsAttr.toString() : "0";
    String pendingAssignments = pendingAssignmentsAttr != null ? pendingAssignmentsAttr.toString() : "0";
    String noticeCount = noticeCountAttr != null ? noticeCountAttr.toString() : "0";
    String facultyDisplayName = session.getAttribute("userId") != null ? session.getAttribute("userId").toString() : "User";

    List<?> timetableRows = (List<?>) request.getAttribute("timetableRows");
    List<?> studentRows = (List<?>) request.getAttribute("studentRows");
    List<?> assignmentRows = (List<?>) request.getAttribute("assignmentRows");
    List<?> noticeRows = (List<?>) request.getAttribute("noticeRows");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Dashboard - University ERP System</title>
    <link rel="stylesheet" href="css/dashboard.css?v=20260319">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <div class="faculty-container">
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="logo"><span class="logo-icon">F</span><span class="logo-text">EduCore</span></div>
            </div>
            <nav class="sidebar-menu">
                <ul>
                    <li><a href="#dashboard" class="menu-item active" onclick="showSection(event, 'dashboard')"><span class="menu-icon">O</span><span class="menu-text">Dashboard</span></a></li>
                    <li><a href="#timetable" class="menu-item" onclick="showSection(event, 'timetable')"><span class="menu-icon">T</span><span class="menu-text">My Timetable</span></a></li>
                    <li><a href="#attendance" class="menu-item" onclick="showSection(event, 'attendance')"><span class="menu-icon">AT</span><span class="menu-text">Attendance</span></a></li>
                    <li><a href="#assignments" class="menu-item" onclick="showSection(event, 'assignments')"><span class="menu-icon">AS</span><span class="menu-text">Assignments</span></a></li>
                    <li><a href="#students" class="menu-item" onclick="showSection(event, 'students')"><span class="menu-icon">S</span><span class="menu-text">Students</span></a></li>
                    <li><a href="#notices" class="menu-item" onclick="showSection(event, 'notices')"><span class="menu-icon">N</span><span class="menu-text">Notices</span></a></li>
                    <li><a href="logout" class="menu-item logout-item"><span class="menu-icon">X</span><span class="menu-text">Logout</span></a></li>
                </ul>
            </nav>
        </aside>

        <div class="main-content">
            <header class="header">
                <div class="header-left"><h1 class="page-title">Dashboard</h1></div>
                <div class="header-center"><div class="search-box"><input type="text" placeholder="Search"><span class="search-icon">?</span></div></div>
                <div class="header-right"><div class="faculty-profile"><div class="profile-avatar">F</div><span class="faculty-name"><%= facultyDisplayName %></span></div></div>
            </header>

            <section id="dashboard" class="content-section active">
                <div class="section-header"><h2>Dashboard Overview</h2><p>Summary based on request attributes</p></div>
                <div class="stats-grid">
                    <div class="stat-card"><div class="stat-icon">C</div><div class="stat-content"><p class="stat-label">Total Classes Today</p><h3 class="stat-value"><%= classesToday %></h3></div></div>
                    <div class="stat-card"><div class="stat-icon">S</div><div class="stat-content"><p class="stat-label">Total Students</p><h3 class="stat-value"><%= totalStudents %></h3></div></div>
                    <div class="stat-card"><div class="stat-icon">A</div><div class="stat-content"><p class="stat-label">Pending Assignments</p><h3 class="stat-value"><%= pendingAssignments %></h3></div></div>
                    <div class="stat-card"><div class="stat-icon">N</div><div class="stat-content"><p class="stat-label">Notices</p><h3 class="stat-value"><%= noticeCount %></h3></div></div>
                </div>
            </section>

            <section id="timetable" class="content-section">
                <div class="section-header"><h2>My Timetable</h2><p>Timetable rows from request attributes</p></div>
                <div class="table-container">
                    <table class="data-table">
                        <thead><tr><th>Day</th><th>Subject</th><th>Time</th><th>Class/Section</th></tr></thead>
                        <tbody>
                            <% if (timetableRows != null && !timetableRows.isEmpty()) { %>
                                <% for (Object row : timetableRows) { %>
                                    <tr><td colspan="4"><%= row %></td></tr>
                                <% } %>
                            <% } else { %>
                                <tr><td colspan="4">No Data Available</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="attendance" class="content-section">
                <div class="section-header"><h2>Attendance Marking</h2><p>Submit attendance entries</p></div>
                <div class="form-container">
                    <div class="form-card">
                        <h3>Mark Attendance</h3>
                        <form class="attendance-form" method="post" action="markAttendance">
                            <div class="form-row">
                                <div class="form-group"><label>Attendance ID</label><input type="text" name="attendanceId" required></div>
                                <div class="form-group"><label>Student ID</label><input type="text" name="studentId" required></div>
                            </div>
                            <div class="form-row">
                                <div class="form-group"><label>Subject</label><input type="text" name="subject" required></div>
                                <div class="form-group"><label>Date</label><input type="date" name="date" required></div>
                            </div>
                            <div class="form-row">
                                <div class="form-group"><label>Status</label><input type="text" name="status" required></div>
                            </div>
                            <button type="submit" class="btn btn-primary">Save Attendance</button>
                        </form>
                    </div>
                </div>
            </section>

            <section id="assignments" class="content-section">
                <div class="section-header"><h2>Assignments</h2><p>Create and list assignments from request attributes</p></div>
                <div class="form-container">
                    <div class="form-card">
                        <h3>Create Assignment</h3>
                        <form class="management-form" method="post" action="uploadAssignment">
                            <div class="form-row">
                                <div class="form-group"><label>Assignment ID</label><input type="text" name="assignmentId" required></div>
                                <div class="form-group"><label>Subject</label><input type="text" name="subject" required></div>
                            </div>
                            <div class="form-row">
                                <div class="form-group"><label>Title</label><input type="text" name="title" required></div>
                                <div class="form-group"><label>Due Date</label><input type="date" name="dueDate" required></div>
                            </div>
                            <div class="form-row">
                                <div class="form-group"><label>Description</label><textarea name="description" required></textarea></div>
                            </div>
                            <button type="submit" class="btn btn-primary">Save Assignment</button>
                        </form>
                    </div>
                </div>
                <div class="table-container">
                    <table class="data-table">
                        <thead><tr><th>Assignment</th><th>Subject</th><th>Due Date</th><th>Status</th></tr></thead>
                        <tbody>
                            <% if (assignmentRows != null && !assignmentRows.isEmpty()) { %>
                                <% for (Object row : assignmentRows) { %>
                                    <tr><td colspan="4"><%= row %></td></tr>
                                <% } %>
                            <% } else { %>
                                <tr><td colspan="4">No Data Available</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="students" class="content-section">
                <div class="section-header"><h2>Students</h2><p>Student list from request attributes</p></div>
                <div class="table-container">
                    <table class="data-table">
                        <thead><tr><th>Student Name</th><th>ID</th><th>Course</th><th>Email</th><th>Attendance</th></tr></thead>
                        <tbody>
                            <% if (studentRows != null && !studentRows.isEmpty()) { %>
                                <% for (Object row : studentRows) { %>
                                    <tr><td colspan="5"><%= row %></td></tr>
                                <% } %>
                            <% } else { %>
                                <tr><td colspan="5">No Data Available</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </section>

            <section id="notices" class="content-section">
                <div class="section-header"><h2>Notices</h2><p>Notices list from request attributes</p></div>
                <div class="table-container">
                    <table class="data-table">
                        <thead><tr><th>Title</th><th>Description</th><th>Date</th></tr></thead>
                        <tbody>
                            <% if (noticeRows != null && !noticeRows.isEmpty()) { %>
                                <% for (Object row : noticeRows) { %>
                                    <tr><td colspan="3"><%= row %></td></tr>
                                <% } %>
                            <% } else { %>
                                <tr><td colspan="3">No Data Available</td></tr>
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
            const menuLinks = document.querySelectorAll('.sidebar-menu .menu-item[href^="#"]');
            menuLinks.forEach(function(link) {
                const sectionId = link.getAttribute('href').replace('#', '');
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    showSectionById(sectionId);
                });
            });
        });
    </script>
</body>
</html>

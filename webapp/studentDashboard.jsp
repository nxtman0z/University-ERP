<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%
    Object classesTodayAttr = request.getAttribute("classesToday");
    Object attendancePercentAttr = request.getAttribute("attendancePercent");
    Object pendingAssignmentsAttr = request.getAttribute("pendingAssignments");
    Object latestNoticesAttr = request.getAttribute("latestNotices");

    String classesToday = classesTodayAttr != null ? classesTodayAttr.toString() : "0";
    String attendancePercent = attendancePercentAttr != null ? attendancePercentAttr.toString() : "0";
    String pendingAssignments = pendingAssignmentsAttr != null ? pendingAssignmentsAttr.toString() : "0";
    String latestNotices = latestNoticesAttr != null ? latestNoticesAttr.toString() : "0";
    String studentDisplayName = session.getAttribute("userId") != null ? session.getAttribute("userId").toString() : "User";

    List<?> timetableRows = (List<?>) request.getAttribute("timetableRows");
    List<?> attendanceRows = (List<?>) request.getAttribute("attendanceRows");
    List<?> assignmentRows = (List<?>) request.getAttribute("assignmentRows");
    List<?> noticeRows = (List<?>) request.getAttribute("noticeRows");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - University ERP System</title>
    <link rel="stylesheet" href="css/dashboard.css?v=20260320">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <div class="student-container">
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="logo"><span class="logo-icon">S</span><span class="logo-text">EduCore</span></div>
            </div>
            <nav class="sidebar-menu">
                <ul>
                    <li><a href="#dashboard" class="menu-item active" onclick="showSection(event, 'dashboard')"><span class="menu-icon">O</span><span class="menu-text">Dashboard</span></a></li>
                    <li><a href="#timetable" class="menu-item" onclick="showSection(event, 'timetable')"><span class="menu-icon">T</span><span class="menu-text">My Timetable</span></a></li>
                    <li><a href="#attendance" class="menu-item" onclick="showSection(event, 'attendance')"><span class="menu-icon">AT</span><span class="menu-text">Attendance</span></a></li>
                    <li><a href="#assignments" class="menu-item" onclick="showSection(event, 'assignments')"><span class="menu-icon">AS</span><span class="menu-text">Assignments</span></a></li>
                    <li><a href="#notices" class="menu-item" onclick="showSection(event, 'notices')"><span class="menu-icon">N</span><span class="menu-text">Notices</span></a></li>
                    <li><a href="#profile" class="menu-item" onclick="showSection(event, 'profile')"><span class="menu-icon">P</span><span class="menu-text">Profile</span></a></li>
                    <li><a href="logout" class="menu-item logout-item"><span class="menu-icon">X</span><span class="menu-text">Logout</span></a></li>
                </ul>
            </nav>
        </aside>

        <div class="main-content">
            <header class="header">
                <div class="header-left"><h1 class="page-title">Dashboard</h1></div>
                <div class="header-right"><div class="student-profile"><div class="profile-avatar">S</div><span class="student-name"><%= studentDisplayName %></span></div></div>
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
                <div class="section-header"><h2>Attendance</h2><p>Rows from request attribute: attendanceRows</p></div>
                <div class="table-container">
                    <table class="data-table">
                        <thead><tr><th>Subject</th><th>Total Classes</th><th>Present Classes</th><th>Attendance %</th></tr></thead>
                        <tbody>
                            <% if (attendanceRows != null && !attendanceRows.isEmpty()) { %>
                                <% for (Object row : attendanceRows) { %>
                                    <tr><td colspan="4"><%= row %></td></tr>
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
                                <% for (Object row : assignmentRows) { %>
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
                <div class="section-header"><h2>Notices</h2><p>Rows from request attribute: noticeRows</p></div>
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

            <section id="profile" class="content-section">
                <div class="section-header"><h2>Profile</h2><p>Profile details from request attributes</p></div>
                <div class="profile-card">
                    <div class="profile-grid">
                        <div class="profile-field"><span class="label">Name</span><span class="value"><%= request.getAttribute("studentName") != null ? request.getAttribute("studentName") : "No Data Available" %></span></div>
                        <div class="profile-field"><span class="label">ID</span><span class="value"><%= request.getAttribute("studentId") != null ? request.getAttribute("studentId") : "No Data Available" %></span></div>
                        <div class="profile-field"><span class="label">Course</span><span class="value"><%= request.getAttribute("studentCourse") != null ? request.getAttribute("studentCourse") : "No Data Available" %></span></div>
                        <div class="profile-field"><span class="label">Email</span><span class="value"><%= request.getAttribute("studentEmail") != null ? request.getAttribute("studentEmail") : "No Data Available" %></span></div>
                        <div class="profile-field"><span class="label">Phone</span><span class="value"><%= request.getAttribute("studentPhone") != null ? request.getAttribute("studentPhone") : "No Data Available" %></span></div>
                    </div>
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

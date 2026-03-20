<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%
    Object classesTodayAttr = request.getAttribute("classesToday");
    Object totalStudentsAttr = request.getAttribute("totalStudents");
    Object pendingAssignmentsAttr = request.getAttribute("pendingAssignments");
    Object noticeCountAttr = request.getAttribute("noticeCount");
    String errorMessage = request.getParameter("error");
    String successMessage = request.getParameter("success");

    String classesToday = classesTodayAttr != null ? classesTodayAttr.toString() : "0";
    String totalStudents = totalStudentsAttr != null ? totalStudentsAttr.toString() : "0";
    String pendingAssignments = pendingAssignmentsAttr != null ? pendingAssignmentsAttr.toString() : "0";
    String noticeCount = noticeCountAttr != null ? noticeCountAttr.toString() : "0";
    String facultyDisplayName = session.getAttribute("userId") != null ? session.getAttribute("userId").toString() : "User";
    String facultyEmail = session.getAttribute("userEmail") != null ? session.getAttribute("userEmail").toString() : "Will be available after backend integration";

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
    <link rel="stylesheet" href="css/dashboard.css?v=20260326">
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
                    <li><a href="#notices" class="menu-item" onclick="showSection(event, 'notices')"><span class="menu-icon">N</span><span class="menu-text">Notices</span></a></li>
                    <li><a href="logout" class="menu-item logout-item"><span class="menu-icon">X</span><span class="menu-text">Logout</span></a></li>
                </ul>
            </nav>
        </aside>

        <div class="main-content">
            <header class="header">
                <div class="header-left"><h1 class="page-title">Dashboard</h1></div>
                <div class="header-right">
                    <div class="faculty-profile-wrapper">
                        <button type="button" class="faculty-profile-btn" id="openFacultyProfile" title="View Faculty Profile">
                            <div class="faculty-profile">
                                <div class="profile-avatar">F</div>
                                <span class="faculty-name"><%= facultyDisplayName %></span>
                            </div>
                        </button>
                    </div>
                </div>
            </header>

            <% if (errorMessage != null && !errorMessage.trim().isEmpty()) { %>
                <div class="message-strip error"><strong>Error:</strong> <%= errorMessage %></div>
            <% } %>
            <% if (successMessage != null && !successMessage.trim().isEmpty()) { %>
                <div class="message-strip success"><strong>Success:</strong> <%= successMessage %></div>
            <% } %>

            <section id="dashboard" class="content-section active">
                <div class="section-header"><h2>Dashboard Overview</h2><p>Summary based on request attributes</p></div>
                <div class="stats-grid">
                    <div class="stat-card"><div class="stat-content"><p class="stat-label">Total Classes Today</p><h3 class="stat-value"><%= classesToday %></h3></div></div>
                    <div class="stat-card"><div class="stat-content"><p class="stat-label">Total Students</p><h3 class="stat-value"><%= totalStudents %></h3></div></div>
                    <div class="stat-card"><div class="stat-content"><p class="stat-label">Pending Assignments</p><h3 class="stat-value"><%= pendingAssignments %></h3></div></div>
                    <div class="stat-card"><div class="stat-content"><p class="stat-label">Notices</p><h3 class="stat-value"><%= noticeCount %></h3></div></div>
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
                <div class="section-header"><h2>Attendance Marking</h2><p>Select Department, Subject, and Time, then mark attendance from the assigned student list.</p></div>
                <div class="form-container">
                    <div class="form-card attendance-builder-card">
                        <h3>Smart Attendance Workflow</h3>
                        <form class="attendance-form" id="attendanceForm" method="post" action="markAttendance">
                            <input type="hidden" name="attendanceId" id="attendanceLegacyId">
                            <input type="hidden" name="studentId" id="attendanceLegacyStudentId">
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Department</label>
                                    <select name="department" id="attendanceDepartment" required>
                                        <option value="">Select Department</option>
                                        <option value="MCA">MCA</option>
                                        <option value="BCA">BCA</option>
                                        <option value="BTech">BTech</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Subject</label>
                                    <select name="subject" id="attendanceSubject" required>
                                        <option value="">Select Subject</option>
                                        <option value="AI">AI</option>
                                        <option value="DBMS">DBMS</option>
                                        <option value="Operating Systems">Operating Systems</option>
                                        <option value="Data Structures">Data Structures</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Time Slot</label>
                                    <select name="timeSlot" id="attendanceTime" required>
                                        <option value="">Select Time Slot</option>
                                        <option value="09:00-10:00">09:00 - 10:00</option>
                                        <option value="10:00-11:00">10:00 - 11:00</option>
                                        <option value="11:00-12:00">11:00 - 12:00</option>
                                        <option value="13:00-14:00">13:00 - 14:00</option>
                                    </select>
                                </div>
                                <div class="form-group"><label>Date</label><input type="date" name="date" required></div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Default Status</label>
                                    <select name="status" required>
                                        <option value="Present">Present</option>
                                        <option value="Absent">Absent</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>&nbsp;</label>
                                    <button type="button" class="btn btn-secondary" id="loadAssignedStudents">Search Assigned Subject</button>
                                </div>
                            </div>
                            <div class="attendance-workspace">
                                <div class="attendance-summary-panel">
                                    <h4>Assigned Class Details</h4>
                                    <div class="summary-grid">
                                        <div><span>Department</span><strong id="assignedDepartment">-</strong></div>
                                        <div><span>Subject</span><strong id="assignedSubject">-</strong></div>
                                        <div><span>Subject Code</span><strong id="assignedSubjectCode">-</strong></div>
                                        <div><span>Time</span><strong id="assignedTime">-</strong></div>
                                    </div>
                                </div>
                                <div class="attendance-list-panel">
                                    <h4>Student List (Tick and Submit)</h4>
                                    <div class="table-container attendance-table-wrap">
                                        <table class="data-table attendance-table">
                                            <thead>
                                                <tr>
                                                    <th>Mark</th>
                                                    <th>Student</th>
                                                    <th>Live Status</th>
                                                </tr>
                                            </thead>
                                            <tbody id="attendanceStudentRows">
                                                <% if (studentRows != null && !studentRows.isEmpty()) { %>
                                                    <% for (Object row : studentRows) { %>
                                                        <tr class="attendance-student-row" data-department="" data-subject="">
                                                            <td>
                                                                <label class="tick-mark-label">
                                                                    <input type="checkbox" name="studentIds" value="<%= row %>" class="attendance-student-checkbox">
                                                                    <span class="tick-mark-box"></span>
                                                                </label>
                                                            </td>
                                                            <td><%= row %></td>
                                                            <td><span class="status-chip default">Ready</span></td>
                                                        </tr>
                                                    <% } %>
                                                <% } else { %>
                                                    <tr class="attendance-student-row" data-department="MCA" data-subject="AI">
                                                        <td><label class="tick-mark-label"><input type="checkbox" name="studentIds" value="MCA24-001" class="attendance-student-checkbox"><span class="tick-mark-box"></span></label></td>
                                                        <td>MCA24-001 - Priya Sharma</td>
                                                        <td><span class="status-chip default">Ready</span></td>
                                                    </tr>
                                                    <tr class="attendance-student-row" data-department="MCA" data-subject="AI">
                                                        <td><label class="tick-mark-label"><input type="checkbox" name="studentIds" value="MCA24-002" class="attendance-student-checkbox"><span class="tick-mark-box"></span></label></td>
                                                        <td>MCA24-002 - Rahul Verma</td>
                                                        <td><span class="status-chip default">Ready</span></td>
                                                    </tr>
                                                    <tr class="attendance-student-row" data-department="BCA" data-subject="DBMS">
                                                        <td><label class="tick-mark-label"><input type="checkbox" name="studentIds" value="BCA24-031" class="attendance-student-checkbox"><span class="tick-mark-box"></span></label></td>
                                                        <td>BCA24-031 - Neha Yadav</td>
                                                        <td><span class="status-chip default">Ready</span></td>
                                                    </tr>
                                                <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
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
                                <div class="form-group">
                                    <label>Department</label>
                                    <select name="department" required>
                                        <option value="">Select Department</option>
                                        <option value="MCA">MCA</option>
                                        <option value="BCA">BCA</option>
                                        <option value="BTech">BTech</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Subject</label>
                                    <select name="subject" required>
                                        <option value="">Select Subject</option>
                                        <option value="AI">AI</option>
                                        <option value="DBMS">DBMS</option>
                                        <option value="Operating Systems">Operating Systems</option>
                                        <option value="Data Structures">Data Structures</option>
                                    </select>
                                </div>
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

            <section id="profile" class="content-section">
                <div class="section-header"><h2>Faculty Profile</h2><p>Right top profile se open hone wala section. Backend ready hote hi real details auto-fill hongi.</p></div>
                <div class="profile-page-grid">
                    <div class="form-card">
                        <h3>Basic Details</h3>
                        <div class="summary-grid profile-summary-grid">
                            <div><span>Faculty ID</span><strong><%= facultyDisplayName %></strong></div>
                            <div><span>Email</span><strong><%= facultyEmail %></strong></div>
                            <div><span>Department</span><strong>Will be available after backend integration</strong></div>
                            <div><span>Contact</span><strong>Will be available after backend integration</strong></div>
                        </div>
                    </div>
                    <div class="form-card">
                        <h3>Profile Photo</h3>
                        <form class="management-form" method="post" action="#" onsubmit="return false;">
                            <div class="photo-upload-box">
                                <div class="profile-avatar big">F</div>
                                <p>The upload field is ready. The photo will be saved once the backend API is connected.</p>
                                <input type="file" name="facultyPhoto" accept="image/*">
                            </div>
                        </form>
                    </div>
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
            const subjectCodeMap = {
                'AI': 'MCA401',
                'DBMS': 'MCA305',
                'Operating Systems': 'BCA302',
                'Data Structures': 'BTECH210'
            };

            const menuLinks = document.querySelectorAll('.sidebar-menu .menu-item[href^="#"]');
            menuLinks.forEach(function(link) {
                const sectionId = link.getAttribute('href').replace('#', '');
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    showSectionById(sectionId);
                });
            });

            const openFacultyProfileBtn = document.getElementById('openFacultyProfile');
            if (openFacultyProfileBtn) {
                openFacultyProfileBtn.addEventListener('click', function() {
                    showSectionById('profile');
                });
            }

            const loadAssignedStudentsBtn = document.getElementById('loadAssignedStudents');
            if (loadAssignedStudentsBtn) {
                loadAssignedStudentsBtn.addEventListener('click', function() {
                    const department = document.getElementById('attendanceDepartment').value;
                    const subject = document.getElementById('attendanceSubject').value;
                    const time = document.getElementById('attendanceTime').value;

                    if (!department || !subject || !time) {
                        alert('Please select Department, Subject, and Time first.');
                        return;
                    }

                    document.getElementById('assignedDepartment').textContent = department;
                    document.getElementById('assignedSubject').textContent = subject;
                    document.getElementById('assignedSubjectCode').textContent = subjectCodeMap[subject] || 'AUTO';
                    document.getElementById('assignedTime').textContent = time;

                    const studentRowsList = document.querySelectorAll('.attendance-student-row');
                    let anyVisible = false;
                    studentRowsList.forEach(function(row) {
                        const rowDepartment = (row.getAttribute('data-department') || '').trim();
                        const rowSubject = (row.getAttribute('data-subject') || '').trim();
                        const showRow = !rowDepartment || !rowSubject || (rowDepartment === department && rowSubject === subject);
                        row.style.display = showRow ? '' : 'none';
                        if (showRow) {
                            anyVisible = true;
                        }
                    });

                    if (!anyVisible) {
                        alert('Assigned student list is not available for this filter yet.');
                    }
                });
            }

            const studentCheckboxes = document.querySelectorAll('.attendance-student-checkbox');
            studentCheckboxes.forEach(function(checkbox) {
                checkbox.addEventListener('change', function() {
                    const row = checkbox.closest('tr');
                    if (!row) { return; }
                    const statusChip = row.querySelector('.status-chip');
                    if (!statusChip) { return; }

                    if (checkbox.checked) {
                        statusChip.className = 'status-chip submitted';
                        statusChip.textContent = 'Marked';
                    } else {
                        statusChip.className = 'status-chip default';
                        statusChip.textContent = 'Ready';
                    }
                });
            });

            const attendanceForm = document.getElementById('attendanceForm');
            if (attendanceForm) {
                attendanceForm.addEventListener('submit', function(e) {
                    const checkedStudents = document.querySelectorAll('.attendance-student-checkbox:checked');
                    if (checkedStudents.length === 0) {
                        e.preventDefault();
                        alert('Please tick at least one student before submitting attendance.');
                        return;
                    }

                    const legacyId = document.getElementById('attendanceLegacyId');
                    const legacyStudentId = document.getElementById('attendanceLegacyStudentId');
                    if (legacyId) {
                        legacyId.value = 'ATT-' + Date.now();
                    }
                    if (legacyStudentId) {
                        legacyStudentId.value = checkedStudents[0].value;
                    }
                });
            }
        });
    </script>
</body>
</html>

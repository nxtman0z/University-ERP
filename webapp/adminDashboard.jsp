<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%
    Object totalStudentsAttr = request.getAttribute("totalStudents");
    Object totalFacultyAttr = request.getAttribute("totalFaculty");
    Object totalCoursesAttr = request.getAttribute("totalCourses");
    Object totalNoticesAttr = request.getAttribute("totalNotices");

    String totalStudents = totalStudentsAttr != null ? totalStudentsAttr.toString() : "0";
    String totalFaculty = totalFacultyAttr != null ? totalFacultyAttr.toString() : "0";
    String totalCourses = totalCoursesAttr != null ? totalCoursesAttr.toString() : "0";
    String totalNotices = totalNoticesAttr != null ? totalNoticesAttr.toString() : "0";
    String adminDisplayName = session.getAttribute("userId") != null ? session.getAttribute("userId").toString() : "User";
    String adminSessionId = session.getId();

    List<?> courseRows = (List<?>) request.getAttribute("courseRows");
    List<?> libraryRequests = (List<?>) request.getAttribute("libraryRequests");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - University ERP System</title>
    <link rel="stylesheet" href="css/dashboard.css?v=20260325">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <div class="admin-container">
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="logo"><span class="logo-icon">A</span><span class="logo-text">EduCore</span></div>
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
                    <div class="stat-card"><div class="stat-icon">🎓</div><div class="stat-content"><div class="stat-value"><%= totalStudents %></div><div class="stat-label">Total Students</div></div></div>
                    <div class="stat-card"><div class="stat-icon">👨‍🏫</div><div class="stat-content"><div class="stat-value"><%= totalFaculty %></div><div class="stat-label">Total Faculty</div></div></div>
                    <div class="stat-card"><div class="stat-icon">📚</div><div class="stat-content"><div class="stat-value"><%= totalCourses %></div><div class="stat-label">Total Courses</div></div></div>
                    <div class="stat-card"><div class="stat-icon">📢</div><div class="stat-content"><div class="stat-value"><%= totalNotices %></div><div class="stat-label">Total Notices</div></div></div>
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
                                <div class="form-group"><label>Department</label><input type="text" name="department" required></div>
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
                                        <option value="MCA">MCA</option>
                                        <option value="BTECH-CSE">BTECH CSE</option>
                                        <option value="BCA">BCA</option>
                                        <option value="MSC">MSC</option>
                                        <option value="MBA">MBA</option>
                                        <option value="BTECH-IT">BTECH IT</option>
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
                                        <option value="MCA">MCA</option>
                                        <option value="BTECH-CSE">BTECH CSE</option>
                                        <option value="BCA">BCA</option>
                                        <option value="MSC">MSC</option>
                                        <option value="MBA">MBA</option>
                                        <option value="BTECH-IT">BTECH IT</option>
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
                <div class="table-container">
                    <table class="data-table">
                        <thead><tr><th>Department</th><th>Subject Code</th><th>Subject</th><th>Credits</th></tr></thead>
                        <tbody>
                            <% if (courseRows != null && !courseRows.isEmpty()) { %>
                                <% for (Object row : courseRows) { %>
                                    <tr><td colspan="4"><%= row %></td></tr>
                                <% } %>
                            <% } else { %>
                                <tr><td colspan="4">No Data Available</td></tr>
                            <% } %>
                        </tbody>
                    </table>
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
                                    <select name="department" required>
                                        <option value="">Select Department</option>
                                        <option value="MCA">MCA</option>
                                        <option value="BTECH-CSE">BTECH CSE</option>
                                        <option value="BCA">BCA</option>
                                        <option value="MSC">MSC</option>
                                        <option value="MBA">MBA</option>
                                        <option value="BTECH-IT">BTECH IT</option>
                                    </select>
                                </div>
                                <div class="form-group"><label>Subject</label><input type="text" name="subject" required></div>
                            </div>
                            <div class="form-row">
                                <div class="form-group"><label>Day</label><input type="text" name="day" required></div>
                                <div class="form-group"><label>Time</label><input type="text" name="time" required></div>
                            </div>
                            <div class="form-row">
                                <div class="form-group"><label>Subject Code</label><input type="text" name="subjectCode" required></div>
                                <div class="form-group"><label>Faculty Name</label><input type="text" name="facultyName" required></div>
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
                                    <select name="department" required>
                                        <option value="">Select Department</option>
                                        <option value="MCA">MCA</option>
                                        <option value="BTECH-CSE">BTECH CSE</option>
                                        <option value="BCA">BCA</option>
                                        <option value="MSC">MSC</option>
                                        <option value="MBA">MBA</option>
                                        <option value="BTECH-IT">BTECH IT</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group"><label>Subject</label><input type="text" name="subject" required></div>
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
                                        <option value="DEPT_MCA">Department - MCA</option>
                                        <option value="DEPT_BTECH_CSE">Department - BTECH CSE</option>
                                        <option value="DEPT_BCA">Department - BCA</option>
                                        <option value="DEPT_MSC">Department - MSC</option>
                                        <option value="DEPT_MBA">Department - MBA</option>
                                        <option value="DEPT_BTECH_IT">Department - BTECH IT</option>
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
                <div class="section-header"><h2>Library Card Requests</h2><p>Pending request queue</p></div>
                <div class="table-container">
                    <table class="data-table">
                        <thead><tr><th>Request ID</th><th>Student ID</th><th>Request Date</th><th>Status</th></tr></thead>
                        <tbody>
                            <% if (libraryRequests != null && !libraryRequests.isEmpty()) { %>
                                <% for (Object requestRow : libraryRequests) { %>
                                    <tr><td colspan="4"><%= requestRow %></td></tr>
                                <% } %>
                            <% } else { %>
                                <tr><td colspan="4">No Data Available</td></tr>
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
            const menuLinks = document.querySelectorAll('.sidebar-menu .menu-item[href^="#"]');
            menuLinks.forEach(function(link) {
                const sectionId = link.getAttribute('href').replace('#', '');
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    showSectionById(sectionId);
                });
            });

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

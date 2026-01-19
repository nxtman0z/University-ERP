<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Timetable - Student Portal</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="dashboard-container">
        <aside class="sidebar">
            <div class="sidebar-header">
                <h2>🎓 Student Portal</h2>
                <p>University ERP</p>
            </div>
            <ul class="sidebar-menu">
                <li><a href="dashboard.jsp"><i>📊</i> Dashboard</a></li>
                <li><a href="profile.jsp"><i>👤</i> My Profile</a></li>
                <li><a href="attendance.jsp"><i>📅</i> Attendance</a></li>
                <li><a href="timetable.jsp" class="active"><i>🕐</i> Timetable</a></li>
                <li><a href="fees.jsp"><i>💰</i> Fees & Payments</a></li>
                <li><a href="assignments.jsp"><i>📝</i> Assignments</a></li>
                <li><a href="internal-marks.jsp"><i>📊</i> Internal Marks</a></li>
                <li><a href="exam.jsp"><i>📋</i> Exam</a></li>
                <li><a href="results.jsp"><i>🏆</i> Results</a></li>
                <li><a href="requests.jsp"><i>📄</i> Requests</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="#" onclick="logout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>🕐 My Timetable</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">🔔<span class="notification-badge">5</span></div>
                    <div class="user-info">
                        <div class="user-avatar">S</div>
                        <span class="user-name">Student</span>
                    </div>
                </div>
            </nav>
            
            <div class="content-card">
                <div class="card-header">
                    <h3>📅 Weekly Class Schedule</h3>
                    <button class="btn btn-sm btn-primary" onclick="printPage()">🖨️ Print</button>
                </div>
                <div style="overflow-x: auto;">
                    <table style="min-width: 900px;">
                        <thead>
                            <tr style="background: var(--primary-color); color: white;">
                                <th style="padding: 15px;">Time</th>
                                <th style="padding: 15px;">Monday</th>
                                <th style="padding: 15px;">Tuesday</th>
                                <th style="padding: 15px;">Wednesday</th>
                                <th style="padding: 15px;">Thursday</th>
                                <th style="padding: 15px;">Friday</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td style="font-weight: bold; background: var(--light);">09:00-10:00</td>
                                <td style="background: #dbeafe; padding: 15px;">
                                    <strong>Java Programming</strong><br>
                                    <small>Dr. Rajesh Verma</small><br>
                                    <small style="color: var(--text-secondary);">Lab 1</small>
                                </td>
                                <td style="background: #fef3c7; padding: 15px;">
                                    <strong>Web Technologies</strong><br>
                                    <small>Prof. Anita Desai</small><br>
                                    <small style="color: var(--text-secondary);">Lab 2</small>
                                </td>
                                <td style="background: #dbeafe; padding: 15px;">
                                    <strong>Java Programming</strong><br>
                                    <small>Dr. Rajesh Verma</small><br>
                                    <small style="color: var(--text-secondary);">Lab 1</small>
                                </td>
                                <td style="background: #d1fae5; padding: 15px;">
                                    <strong>DBMS</strong><br>
                                    <small>Prof. Anita Desai</small><br>
                                    <small style="color: var(--text-secondary);">Room 102</small>
                                </td>
                                <td style="background: #fce7f3; padding: 15px;">
                                    <strong>Operating Systems</strong><br>
                                    <small>Dr. Suresh Rao</small><br>
                                    <small style="color: var(--text-secondary);">Room 103</small>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; background: var(--light);">10:00-11:00</td>
                                <td style="background: #fee2e2; padding: 15px;">
                                    <strong>Data Structures</strong><br>
                                    <small>Dr. Rajesh Verma</small><br>
                                    <small style="color: var(--text-secondary);">Room 101</small>
                                </td>
                                <td style="background: #fce7f3; padding: 15px;">
                                    <strong>Operating Systems</strong><br>
                                    <small>Dr. Suresh Rao</small><br>
                                    <small style="color: var(--text-secondary);">Room 103</small>
                                </td>
                                <td style="background: #fee2e2; padding: 15px;">
                                    <strong>Data Structures</strong><br>
                                    <small>Dr. Rajesh Verma</small><br>
                                    <small style="color: var(--text-secondary);">Room 101</small>
                                </td>
                                <td style="background: #dbeafe; padding: 15px;">
                                    <strong>Java Lab</strong><br>
                                    <small>Dr. Rajesh Verma</small><br>
                                    <small style="color: var(--text-secondary);">Lab 1</small>
                                </td>
                                <td style="background: #d1fae5; padding: 15px;">
                                    <strong>DBMS</strong><br>
                                    <small>Prof. Anita Desai</small><br>
                                    <small style="color: var(--text-secondary);">Room 102</small>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; background: var(--light);">11:00-12:00</td>
                                <td style="background: #d1fae5; padding: 15px;">
                                    <strong>DBMS</strong><br>
                                    <small>Prof. Anita Desai</small><br>
                                    <small style="color: var(--text-secondary);">Room 102</small>
                                </td>
                                <td style="background: #e0e7ff; padding: 15px;">
                                    <strong>Mathematics</strong><br>
                                    <small>Dr. Suresh Rao</small><br>
                                    <small style="color: var(--text-secondary);">Room 104</small>
                                </td>
                                <td style="background: #fef3c7; padding: 15px;">
                                    <strong>Web Technologies</strong><br>
                                    <small>Prof. Anita Desai</small><br>
                                    <small style="color: var(--text-secondary);">Lab 2</small>
                                </td>
                                <td style="background: #dbeafe; padding: 15px;">
                                    <strong>Java Lab</strong><br>
                                    <small>Dr. Rajesh Verma</small><br>
                                    <small style="color: var(--text-secondary);">Lab 1</small>
                                </td>
                                <td style="background: #fee2e2; padding: 15px;">
                                    <strong>Data Structures</strong><br>
                                    <small>Dr. Rajesh Verma</small><br>
                                    <small style="color: var(--text-secondary);">Room 101</small>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6" style="background: var(--light); text-align: center; padding: 15px; font-weight: bold;">
                                    🍽️ LUNCH BREAK (12:00 - 01:00 PM)
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; background: var(--light);">01:00-02:00</td>
                                <td style="background: #fef3c7; padding: 15px;">
                                    <strong>Web Technologies</strong><br>
                                    <small>Prof. Anita Desai</small><br>
                                    <small style="color: var(--text-secondary);">Lab 2</small>
                                </td>
                                <td style="background: #d1fae5; padding: 15px;">
                                    <strong>DBMS Lab</strong><br>
                                    <small>Prof. Anita Desai</small><br>
                                    <small style="color: var(--text-secondary);">Lab 3</small>
                                </td>
                                <td style="background: #fce7f3; padding: 15px;">
                                    <strong>OS Lab</strong><br>
                                    <small>Dr. Suresh Rao</small><br>
                                    <small style="color: var(--text-secondary);">Lab 4</small>
                                </td>
                                <td style="background: #fee2e2; padding: 15px;">
                                    <strong>DSA Lab</strong><br>
                                    <small>Dr. Rajesh Verma</small><br>
                                    <small style="color: var(--text-secondary);">Lab 5</small>
                                </td>
                                <td style="background: var(--light); padding: 15px; text-align: center;">
                                    <strong>Free Period</strong>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; background: var(--light);">02:00-03:00</td>
                                <td style="background: #fef3c7; padding: 15px;">
                                    <strong>Web Technologies</strong><br>
                                    <small>Prof. Anita Desai</small><br>
                                    <small style="color: var(--text-secondary);">Lab 2</small>
                                </td>
                                <td style="background: #d1fae5; padding: 15px;">
                                    <strong>DBMS Lab</strong><br>
                                    <small>Prof. Anita Desai</small><br>
                                    <small style="color: var(--text-secondary);">Lab 3</small>
                                </td>
                                <td style="background: #fce7f3; padding: 15px;">
                                    <strong>OS Lab</strong><br>
                                    <small>Dr. Suresh Rao</small><br>
                                    <small style="color: var(--text-secondary);">Lab 4</small>
                                </td>
                                <td style="background: #fee2e2; padding: 15px;">
                                    <strong>DSA Lab</strong><br>
                                    <small>Dr. Rajesh Verma</small><br>
                                    <small style="color: var(--text-secondary);">Lab 5</small>
                                </td>
                                <td style="background: var(--light); padding: 15px; text-align: center;">
                                    <strong>Library Time</strong>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Exam Schedule -->
            <div class="content-card">
                <div class="card-header">
                    <h3>📋 Upcoming Exam Schedule</h3>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Subject</th>
                                <th>Exam Type</th>
                                <th>Time</th>
                                <th>Room</th>
                                <th>Syllabus</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>25 Jan 2026</td>
                                <td>Java Programming</td>
                                <td><span class="badge badge-warning">Internal Exam</span></td>
                                <td>10:00 AM - 12:00 PM</td>
                                <td>Hall 1</td>
                                <td><button class="btn btn-sm btn-secondary">📄 View</button></td>
                            </tr>
                            <tr>
                                <td>28 Jan 2026</td>
                                <td>Data Structures</td>
                                <td><span class="badge badge-warning">Internal Exam</span></td>
                                <td>10:00 AM - 12:00 PM</td>
                                <td>Hall 2</td>
                                <td><button class="btn btn-sm btn-secondary">📄 View</button></td>
                            </tr>
                            <tr>
                                <td>01 Feb 2026</td>
                                <td>DBMS</td>
                                <td><span class="badge badge-warning">Internal Exam</span></td>
                                <td>10:00 AM - 12:00 PM</td>
                                <td>Hall 1</td>
                                <td><button class="btn btn-sm btn-secondary">📄 View</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Academic Calendar -->
            <div class="content-card">
                <div class="card-header">
                    <h3>📅 Academic Calendar Highlights</h3>
                </div>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px;">
                    <div style="padding: 15px; background: #dbeafe; border-left: 4px solid var(--primary-color); border-radius: 8px;">
                        <strong>Republic Day</strong><br>
                        <small>26 January 2026 - Holiday</small>
                    </div>
                    <div style="padding: 15px; background: #fef3c7; border-left: 4px solid var(--warning-color); border-radius: 8px;">
                        <strong>Internal Exams</strong><br>
                        <small>25 Jan - 05 Feb 2026</small>
                    </div>
                    <div style="padding: 15px; background: #d1fae5; border-left: 4px solid var(--success-color); border-radius: 8px;">
                        <strong>Cultural Fest</strong><br>
                        <small>10-12 February 2026</small>
                    </div>
                    <div style="padding: 15px; background: #fee2e2; border-left: 4px solid var(--danger-color); border-radius: 8px;">
                        <strong>Semester Exams</strong><br>
                        <small>20 March - 10 April 2026</small>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <script src="../js/main.js"></script>
    <script>
        SessionManager.checkAuth();
    </script>
</body>
</html>

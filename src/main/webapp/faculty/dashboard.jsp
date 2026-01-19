<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Dashboard - University ERP</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="dashboard-container">
        <aside class="sidebar">
            <div class="sidebar-header">
                <h2>👨‍🏫 Faculty Portal</h2>
                <p>University ERP</p>
            </div>
            <ul class="sidebar-menu">
                <li><a href="dashboard.jsp" class="active"><i>📊</i> Dashboard</a></li>
                <li><a href="profile.jsp"><i>👤</i> My Profile</a></li>
                <li><a href="attendance-marking.jsp"><i>📅</i> Mark Attendance</a></li>
                <li><a href="view-attendance.jsp"><i>📊</i> View Attendance</a></li>
                <li><a href="assignments.jsp"><i>📝</i> Assignments</a></li>
                <li><a href="marks-entry.jsp"><i>✏️</i> Marks Entry</a></li>
                <li><a href="students.jsp"><i>👥</i> My Students</a></li>
                <li><a href="timetable.jsp"><i>🕐</i> My Timetable</a></li>
                <li><a href="approvals.jsp"><i>✅</i> Approvals</a></li>
                <li><a href="notices.jsp"><i>📢</i> Notices</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="#" onclick="logout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>Faculty Dashboard</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">🔔<span class="notification-badge">8</span></div>
                    <div class="user-info">
                        <div class="user-avatar">F</div>
                        <span class="user-name">Faculty</span>
                    </div>
                </div>
            </nav>
            
            <div class="content-card">
                <h2 style="color: var(--primary-color); margin-bottom: 10px;">Welcome Back, Dr. Rajesh Verma! 👋</h2>
                <p style="color: var(--text-secondary);">Here's your teaching overview for today.</p>
            </div>
            
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">120</div>
                            <div class="stat-card-label">Total Students</div>
                        </div>
                        <div class="stat-card-icon blue">👥</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">4</div>
                            <div class="stat-card-label">Subjects Assigned</div>
                        </div>
                        <div class="stat-card-icon green">📚</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">15</div>
                            <div class="stat-card-label">Pending Approvals</div>
                        </div>
                        <div class="stat-card-icon orange">⏳</div>
                    </div>
                    <span class="badge badge-warning">Action Required</span>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">8</div>
                            <div class="stat-card-label">Assignments to Check</div>
                        </div>
                        <div class="stat-card-icon red">📝</div>
                    </div>
                </div>
            </div>
            
            <div class="alert alert-warning">
                <strong>⚠️ Reminder:</strong> Please submit internal marks for Semester 4 students by 25th January 2026.
            </div>
            
            <div class="dashboard-grid">
                <div class="content-card">
                    <div class="card-header">
                        <h3>📅 Today's Classes</h3>
                    </div>
                    <div style="padding: 10px 0;">
                        <div style="padding: 12px; background: var(--light); border-radius: 8px; margin-bottom: 10px;">
                            <strong>09:00 - 10:00 AM</strong><br>
                            <span style="color: var(--primary-color);">Java Programming - BCA Sem 4</span><br>
                            <small style="color: var(--text-secondary);">Lab 1 • 30 Students</small><br>
                            <button class="btn btn-sm btn-primary" style="margin-top: 8px;" onclick="markAttendance('Java', 'BCA4')">✓ Mark Attendance</button>
                        </div>
                        <div style="padding: 12px; background: var(--light); border-radius: 8px; margin-bottom: 10px;">
                            <strong>10:00 - 11:00 AM</strong><br>
                            <span style="color: var(--primary-color);">Data Structures - BCA Sem 4</span><br>
                            <small style="color: var(--text-secondary);">Room 101 • 30 Students</small><br>
                            <button class="btn btn-sm btn-primary" style="margin-top: 8px;" onclick="markAttendance('DSA', 'BCA4')">✓ Mark Attendance</button>
                        </div>
                        <div style="padding: 12px; background: var(--light); border-radius: 8px;">
                            <strong>02:00 - 04:00 PM</strong><br>
                            <span style="color: var(--primary-color);">Java Lab - BTech CSE Sem 6</span><br>
                            <small style="color: var(--text-secondary);">Lab 2 • 40 Students</small><br>
                            <button class="btn btn-sm btn-primary" style="margin-top: 8px;" onclick="markAttendance('JavaLab', 'BTECH6')">✓ Mark Attendance</button>
                        </div>
                    </div>
                </div>
                
                <div class="content-card">
                    <div class="card-header">
                        <h3>⏳ Pending Tasks</h3>
                    </div>
                    <div style="padding: 10px 0;">
                        <div style="padding: 12px; border-left: 3px solid var(--danger-color); margin-bottom: 10px; background: var(--light);">
                            <strong>Submit Internal Marks</strong><br>
                            <small style="color: var(--text-secondary);">Due: 25 Jan 2026</small><br>
                            <button class="btn btn-sm btn-danger" style="margin-top: 8px;" onclick="window.location='marks-entry.jsp'">Enter Marks</button>
                        </div>
                        <div style="padding: 12px; border-left: 3px solid var(--warning-color); margin-bottom: 10px; background: var(--light);">
                            <strong>Grade 8 Assignments</strong><br>
                            <small style="color: var(--text-secondary);">Pending since 3 days</small><br>
                            <button class="btn btn-sm btn-warning" style="margin-top: 8px;" onclick="window.location='assignments.jsp'">Grade Now</button>
                        </div>
                        <div style="padding: 12px; border-left: 3px solid var(--info-color); background: var(--light);">
                            <strong>Approve 15 Leave Requests</strong><br>
                            <small style="color: var(--text-secondary);">Student leave applications</small><br>
                            <button class="btn btn-sm btn-primary" style="margin-top: 8px;" onclick="window.location='approvals.jsp'">Review</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="content-card">
                <div class="card-header">
                    <h3>📊 Class-wise Attendance Summary</h3>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Class</th>
                                <th>Subject</th>
                                <th>Total Students</th>
                                <th>Avg Attendance</th>
                                <th>Low Attendance (<75%)</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>BCA Semester 4</td>
                                <td>Java Programming</td>
                                <td>30</td>
                                <td><strong style="color: var(--success-color);">85%</strong></td>
                                <td>2 Students</td>
                                <td><button class="btn btn-sm btn-secondary" onclick="viewClassDetails('BCA4-Java')">View Details</button></td>
                            </tr>
                            <tr>
                                <td>BCA Semester 4</td>
                                <td>Data Structures</td>
                                <td>30</td>
                                <td><strong style="color: var(--success-color);">82%</strong></td>
                                <td>4 Students</td>
                                <td><button class="btn btn-sm btn-secondary" onclick="viewClassDetails('BCA4-DSA')">View Details</button></td>
                            </tr>
                            <tr>
                                <td>BTech CSE Sem 6</td>
                                <td>Java Programming</td>
                                <td>40</td>
                                <td><strong style="color: var(--warning-color);">78%</strong></td>
                                <td>8 Students</td>
                                <td><button class="btn btn-sm btn-secondary" onclick="viewClassDetails('BTECH6-Java')">View Details</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="content-card">
                <div class="card-header">
                    <h3>📢 Recent Announcements</h3>
                    <button class="btn btn-sm btn-primary" onclick="window.location='notices.jsp'">Post Announcement</button>
                </div>
                <div style="padding: 10px 0;">
                    <div style="padding: 12px; border-bottom: 1px solid var(--border-color);">
                        <strong>Assignment Deadline Extended</strong><br>
                        <small style="color: var(--text-secondary);">Posted on 18 Jan 2026 to BCA Sem 4</small>
                    </div>
                    <div style="padding: 12px; border-bottom: 1px solid var(--border-color);">
                        <strong>Extra Class on Saturday</strong><br>
                        <small style="color: var(--text-secondary);">Posted on 17 Jan 2026 to BTech CSE Sem 6</small>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <script src="../js/main.js"></script>
    <script>
        SessionManager.checkAuth();
        
        function markAttendance(subject, className) {
            window.location.href = 'attendance-marking.jsp?subject=' + subject + '&class=' + className;
        }
        
        function viewClassDetails(classId) {
            window.location.href = 'view-attendance.jsp?class=' + classId;
        }
    </script>
</body>
</html>

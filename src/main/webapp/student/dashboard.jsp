<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - University ERP</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <h2>🎓 Student Portal</h2>
                <p>University ERP</p>
            </div>
            <ul class="sidebar-menu">
                <li><a href="dashboard.jsp" class="active"><i>📊</i> Dashboard</a></li>
                <li><a href="profile.jsp"><i>👤</i> My Profile</a></li>
                <li><a href="attendance.jsp"><i>📅</i> Attendance</a></li>
                <li><a href="timetable.jsp"><i>🕐</i> Timetable</a></li>
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
        
        <!-- Main Content -->
        <main class="main-content">
            <!-- Top Navigation -->
            <nav class="top-nav">
                <h1>Student Dashboard</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">
                        🔔
                        <span class="notification-badge">5</span>
                    </div>
                    <div class="user-info">
                        <div class="user-avatar">S</div>
                        <span class="user-name">Student</span>
                    </div>
                </div>
            </nav>
            
            <!-- Welcome Section -->
            <div class="content-card">
                <h2 style="color: var(--primary-color); margin-bottom: 10px;">Welcome Back! 👋</h2>
                <p style="color: var(--text-secondary);">Here's what's happening with your academics today.</p>
            </div>
            
            <!-- Stats Cards -->
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">83.5%</div>
                            <div class="stat-card-label">Overall Attendance</div>
                        </div>
                        <div class="stat-card-icon blue">📅</div>
                    </div>
                    <div class="progress">
                        <div class="progress-bar" style="width: 83.5%"></div>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">8.7</div>
                            <div class="stat-card-label">Current CGPA</div>
                        </div>
                        <div class="stat-card-icon green">🏆</div>
                    </div>
                    <div class="progress">
                        <div class="progress-bar" style="width: 87%; background: linear-gradient(90deg, #10b981, #059669);"></div>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">₹20,000</div>
                            <div class="stat-card-label">Pending Fees</div>
                        </div>
                        <div class="stat-card-icon orange">💰</div>
                    </div>
                    <span class="badge badge-warning">Payment Due</span>
                </div>
                
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">3</div>
                            <div class="stat-card-label">Pending Assignments</div>
                        </div>
                        <div class="stat-card-icon red">📝</div>
                    </div>
                    <span class="badge badge-danger">Urgent</span>
                </div>
            </div>
            
            <!-- Alerts -->
            <div class="alert alert-warning">
                <strong>⚠️ Attendance Warning:</strong> Your attendance in "Web Technologies" is below 75%. Current: 77.78%
            </div>
            
            <!-- Recent Activity -->
            <div class="content-card">
                <div class="card-header">
                    <h3>📋 Recent Activity</h3>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Activity</th>
                                <th>Subject</th>
                                <th>Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Assignment Submitted</td>
                                <td>DBMS</td>
                                <td>18 Jan 2026</td>
                                <td><span class="badge badge-success">Completed</span></td>
                            </tr>
                            <tr>
                                <td>Internal Exam</td>
                                <td>Java Programming</td>
                                <td>15 Jan 2026</td>
                                <td><span class="badge badge-success">Appeared</span></td>
                            </tr>
                            <tr>
                                <td>Assignment Pending</td>
                                <td>Web Technologies</td>
                                <td>Due: 30 Jan 2026</td>
                                <td><span class="badge badge-warning">Pending</span></td>
                            </tr>
                            <tr>
                                <td>Fee Payment</td>
                                <td>Semester 4</td>
                                <td>10 Jan 2026</td>
                                <td><span class="badge badge-success">Paid ₹30,000</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Upcoming Classes & Events -->
            <div class="dashboard-grid">
                <div class="content-card">
                    <div class="card-header">
                        <h3>📚 Today's Classes</h3>
                    </div>
                    <div style="padding: 10px 0;">
                        <div style="padding: 12px; background: var(--light); border-radius: 8px; margin-bottom: 10px;">
                            <strong>09:00 - 10:00 AM</strong><br>
                            <span style="color: var(--primary-color);">Java Programming</span><br>
                            <small style="color: var(--text-secondary);">Dr. Rajesh Verma - Lab 1</small>
                        </div>
                        <div style="padding: 12px; background: var(--light); border-radius: 8px; margin-bottom: 10px;">
                            <strong>10:00 - 11:00 AM</strong><br>
                            <span style="color: var(--primary-color);">Data Structures</span><br>
                            <small style="color: var(--text-secondary);">Dr. Rajesh Verma - Room 101</small>
                        </div>
                        <div style="padding: 12px; background: var(--light); border-radius: 8px;">
                            <strong>11:00 - 12:00 PM</strong><br>
                            <span style="color: var(--primary-color);">DBMS</span><br>
                            <small style="color: var(--text-secondary);">Prof. Anita Desai - Room 102</small>
                        </div>
                    </div>
                </div>
                
                <div class="content-card">
                    <div class="card-header">
                        <h3>📢 Latest Notices</h3>
                    </div>
                    <div style="padding: 10px 0;">
                        <div style="padding: 12px; border-left: 3px solid var(--primary-color); margin-bottom: 10px;">
                            <strong>Semester Exam Schedule Released</strong><br>
                            <small style="color: var(--text-secondary);">Posted on 18 Jan 2026</small>
                        </div>
                        <div style="padding: 12px; border-left: 3px solid var(--warning-color); margin-bottom: 10px;">
                            <strong>Last Date for Fee Payment</strong><br>
                            <small style="color: var(--text-secondary);">Due: 25 Jan 2026</small>
                        </div>
                        <div style="padding: 12px; border-left: 3px solid var(--success-color);">
                            <strong>Cultural Fest Registration Open</strong><br>
                            <small style="color: var(--text-secondary);">Posted on 17 Jan 2026</small>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <script src="../js/main.js"></script>
    <script>
        // Check authentication
        SessionManager.checkAuth();
    </script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Internal Marks - Student Portal</title>
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
                <li><a href="timetable.jsp"><i>🕐</i> Timetable</a></li>
                <li><a href="fees.jsp"><i>💰</i> Fees & Payments</a></li>
                <li><a href="assignments.jsp"><i>📝</i> Assignments</a></li>
                <li><a href="internal-marks.jsp" class="active"><i>📊</i> Internal Marks</a></li>
                <li><a href="exam.jsp"><i>📋</i> Exam</a></li>
                <li><a href="results.jsp"><i>🏆</i> Results</a></li>
                <li><a href="requests.jsp"><i>📄</i> Requests</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="#" onclick="logout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>📊 Internal Marks</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">🔔<span class="notification-badge">5</span></div>
                    <div class="user-info">
                        <div class="user-avatar">S</div>
                        <span class="user-name">Student</span>
                    </div>
                </div>
            </nav>
            
            <div class="alert alert-info">
                <strong>ℹ️ Information:</strong> Internal marks are evaluated based on assignments, class tests, and practical performance.
            </div>
            
            <!-- Summary Cards -->
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-card-value">88/100</div>
                    <div class="stat-card-label">Total Internal Marks</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value" style="color: var(--success-color);">88%</div>
                    <div class="stat-card-label">Internal Percentage</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value">5</div>
                    <div class="stat-card-label">Total Subjects</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value" style="color: var(--success-color);">17.6</div>
                    <div class="stat-card-label">Average per Subject</div>
                </div>
            </div>
            
            <!-- Subject-wise Internal Marks -->
            <div class="content-card">
                <div class="card-header">
                    <h3>📚 Semester 4 - Subject-wise Internal Marks</h3>
                    <button class="btn btn-sm btn-primary" onclick="exportTableToCSV('marksTable', 'internal-marks')">
                        📥 Export
                    </button>
                </div>
                <div class="table-container">
                    <table id="marksTable">
                        <thead>
                            <tr>
                                <th>Subject Code</th>
                                <th>Subject Name</th>
                                <th>Max Marks</th>
                                <th>Marks Obtained</th>
                                <th>Percentage</th>
                                <th>Grade</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>CS101</td>
                                <td><strong>Java Programming</strong></td>
                                <td>20</td>
                                <td><strong style="color: var(--success-color);">18</strong></td>
                                <td>90%</td>
                                <td><span class="badge badge-success">A+</span></td>
                            </tr>
                            <tr>
                                <td>CS102</td>
                                <td><strong>Data Structures</strong></td>
                                <td>20</td>
                                <td><strong style="color: var(--success-color);">17</strong></td>
                                <td>85%</td>
                                <td><span class="badge badge-success">A</span></td>
                            </tr>
                            <tr>
                                <td>CS103</td>
                                <td><strong>Database Management</strong></td>
                                <td>20</td>
                                <td><strong style="color: var(--success-color);">19</strong></td>
                                <td>95%</td>
                                <td><span class="badge badge-success">A+</span></td>
                            </tr>
                            <tr>
                                <td>CS104</td>
                                <td><strong>Web Technologies</strong></td>
                                <td>20</td>
                                <td><strong style="color: var(--warning-color);">16</strong></td>
                                <td>80%</td>
                                <td><span class="badge badge-warning">B+</span></td>
                            </tr>
                            <tr>
                                <td>CS105</td>
                                <td><strong>Operating Systems</strong></td>
                                <td>20</td>
                                <td><strong style="color: var(--success-color);">18</strong></td>
                                <td>90%</td>
                                <td><span class="badge badge-success">A+</span></td>
                            </tr>
                            <tr style="background: var(--light); font-weight: bold;">
                                <td colspan="2">Total</td>
                                <td>100</td>
                                <td style="color: var(--success-color);">88</td>
                                <td>88%</td>
                                <td>-</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Detailed Breakdown -->
            <div class="content-card">
                <div class="card-header">
                    <h3>📝 Marks Breakup - Java Programming (CS101)</h3>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Evaluation Type</th>
                                <th>Max Marks</th>
                                <th>Marks Obtained</th>
                                <th>Percentage</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Internal Test 1</td>
                                <td>10</td>
                                <td>9</td>
                                <td>90%</td>
                                <td>10 Dec 2025</td>
                            </tr>
                            <tr>
                                <td>Internal Test 2</td>
                                <td>10</td>
                                <td>9</td>
                                <td>90%</td>
                                <td>15 Jan 2026</td>
                            </tr>
                            <tr style="background: var(--light); font-weight: bold;">
                                <td>Total Internal Marks</td>
                                <td>20</td>
                                <td style="color: var(--success-color);">18</td>
                                <td>90%</td>
                                <td>-</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Previous Semester Performance -->
            <div class="content-card">
                <div class="card-header">
                    <h3>📈 Internal Marks - Semester-wise Trend</h3>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Semester</th>
                                <th>Total Internal Marks</th>
                                <th>Max Marks</th>
                                <th>Percentage</th>
                                <th>Performance</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Semester 1</td>
                                <td>82</td>
                                <td>100</td>
                                <td>82%</td>
                                <td><span class="badge badge-success">Good</span></td>
                            </tr>
                            <tr>
                                <td>Semester 2</td>
                                <td>85</td>
                                <td>100</td>
                                <td>85%</td>
                                <td><span class="badge badge-success">Very Good</span></td>
                            </tr>
                            <tr>
                                <td>Semester 3</td>
                                <td>88</td>
                                <td>100</td>
                                <td>88%</td>
                                <td><span class="badge badge-success">Excellent</span></td>
                            </tr>
                            <tr style="background: #d1fae5;">
                                <td><strong>Semester 4 (Current)</strong></td>
                                <td><strong>88</strong></td>
                                <td>100</td>
                                <td><strong>88%</strong></td>
                                <td><span class="badge badge-success">Excellent</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Tips Section -->
            <div class="content-card" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                <h3 style="color: white; margin-bottom: 15px;">💡 Tips to Improve Internal Marks</h3>
                <ul style="list-style: none; padding: 0;">
                    <li style="padding: 8px 0;">✅ Attend all classes regularly</li>
                    <li style="padding: 8px 0;">✅ Complete and submit assignments on time</li>
                    <li style="padding: 8px 0;">✅ Participate actively in class discussions</li>
                    <li style="padding: 8px 0;">✅ Prepare well for internal tests</li>
                    <li style="padding: 8px 0;">✅ Maintain good practical performance in labs</li>
                </ul>
            </div>
        </main>
    </div>
    
    <script src="../js/main.js"></script>
    <script>
        SessionManager.checkAuth();
    </script>
</body>
</html>

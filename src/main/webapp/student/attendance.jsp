<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance - Student Portal</title>
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
                <li><a href="dashboard.jsp"><i>📊</i> Dashboard</a></li>
                <li><a href="profile.jsp"><i>👤</i> My Profile</a></li>
                <li><a href="attendance.jsp" class="active"><i>📅</i> Attendance</a></li>
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
                <h1>📅 My Attendance</h1>
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
            
            <!-- Overall Summary -->
            <div class="dashboard-grid" style="grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));">
                <div class="stat-card">
                    <div class="stat-card-value" style="color: var(--success-color);">83.5%</div>
                    <div class="stat-card-label">Overall Attendance</div>
                    <div class="progress">
                        <div class="progress-bar" style="width: 83.5%; background: var(--success-color);"></div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value">210</div>
                    <div class="stat-card-label">Total Classes</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value" style="color: var(--success-color);">175</div>
                    <div class="stat-card-label">Present</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value" style="color: var(--danger-color);">35</div>
                    <div class="stat-card-label">Absent</div>
                </div>
            </div>
            
            <!-- Warning Alert -->
            <div class="alert alert-warning">
                <strong>⚠️ Warning:</strong> Your attendance in Web Technologies (77.78%) is below the required 75%. Attend more classes to avoid detention.
            </div>
            
            <!-- Subject-wise Attendance -->
            <div class="content-card">
                <div class="card-header">
                    <h3>📚 Subject-wise Attendance</h3>
                    <button class="btn btn-sm btn-primary" onclick="exportTableToCSV('attendanceTable', 'my-attendance')">
                        📥 Export CSV
                    </button>
                </div>
                <div class="table-container">
                    <table id="attendanceTable">
                        <thead>
                            <tr>
                                <th>Subject Code</th>
                                <th>Subject Name</th>
                                <th>Total Classes</th>
                                <th>Present</th>
                                <th>Absent</th>
                                <th>Percentage</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>CS101</td>
                                <td>Java Programming</td>
                                <td>50</td>
                                <td>42</td>
                                <td>8</td>
                                <td>
                                    <strong style="color: var(--success-color);">84%</strong>
                                    <div class="progress">
                                        <div class="progress-bar" style="width: 84%; background: var(--success-color);"></div>
                                    </div>
                                </td>
                                <td><span class="badge badge-success">Good</span></td>
                            </tr>
                            <tr>
                                <td>CS102</td>
                                <td>Data Structures</td>
                                <td>48</td>
                                <td>38</td>
                                <td>10</td>
                                <td>
                                    <strong style="color: var(--warning-color);">79.17%</strong>
                                    <div class="progress">
                                        <div class="progress-bar" style="width: 79.17%; background: var(--warning-color);"></div>
                                    </div>
                                </td>
                                <td><span class="badge badge-warning">Average</span></td>
                            </tr>
                            <tr>
                                <td>CS103</td>
                                <td>Database Management</td>
                                <td>50</td>
                                <td>45</td>
                                <td>5</td>
                                <td>
                                    <strong style="color: var(--success-color);">90%</strong>
                                    <div class="progress">
                                        <div class="progress-bar" style="width: 90%; background: var(--success-color);"></div>
                                    </div>
                                </td>
                                <td><span class="badge badge-success">Excellent</span></td>
                            </tr>
                            <tr>
                                <td>CS104</td>
                                <td>Web Technologies</td>
                                <td>45</td>
                                <td>35</td>
                                <td>10</td>
                                <td>
                                    <strong style="color: var(--danger-color);">77.78%</strong>
                                    <div class="progress">
                                        <div class="progress-bar" style="width: 77.78%; background: var(--danger-color);"></div>
                                    </div>
                                </td>
                                <td><span class="badge badge-danger">Low</span></td>
                            </tr>
                            <tr>
                                <td>CS105</td>
                                <td>Operating Systems</td>
                                <td>48</td>
                                <td>40</td>
                                <td>8</td>
                                <td>
                                    <strong style="color: var(--success-color);">83.33%</strong>
                                    <div class="progress">
                                        <div class="progress-bar" style="width: 83.33%; background: var(--success-color);"></div>
                                    </div>
                                </td>
                                <td><span class="badge badge-success">Good</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Monthly Attendance -->
            <div class="content-card">
                <div class="card-header">
                    <h3>📊 Monthly Attendance Summary</h3>
                </div>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 15px;">
                    <div style="padding: 15px; background: var(--light); border-radius: 10px; text-align: center;">
                        <div style="font-size: 24px; font-weight: bold; color: var(--primary-color);">85%</div>
                        <div style="font-size: 14px; color: var(--text-secondary);">September</div>
                    </div>
                    <div style="padding: 15px; background: var(--light); border-radius: 10px; text-align: center;">
                        <div style="font-size: 24px; font-weight: bold; color: var(--primary-color);">82%</div>
                        <div style="font-size: 14px; color: var(--text-secondary);">October</div>
                    </div>
                    <div style="padding: 15px; background: var(--light); border-radius: 10px; text-align: center;">
                        <div style="font-size: 24px; font-weight: bold; color: var(--primary-color);">87%</div>
                        <div style="font-size: 14px; color: var(--text-secondary);">November</div>
                    </div>
                    <div style="padding: 15px; background: var(--light); border-radius: 10px; text-align: center;">
                        <div style="font-size: 24px; font-weight: bold; color: var(--primary-color);">81%</div>
                        <div style="font-size: 14px; color: var(--text-secondary);">December</div>
                    </div>
                    <div style="padding: 15px; background: var(--light); border-radius: 10px; text-align: center;">
                        <div style="font-size: 24px; font-weight: bold; color: var(--success-color);">83%</div>
                        <div style="font-size: 14px; color: var(--text-secondary);">January (Current)</div>
                    </div>
                </div>
            </div>
            
            <!-- Attendance Tips -->
            <div class="content-card" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                <h3 style="color: white; margin-bottom: 15px;">💡 Attendance Tips</h3>
                <ul style="list-style: none; padding: 0;">
                    <li style="padding: 8px 0;">✅ Maintain minimum 75% attendance to be eligible for exams</li>
                    <li style="padding: 8px 0;">✅ Check your attendance regularly to avoid surprises</li>
                    <li style="padding: 8px 0;">✅ Contact faculty if you find any discrepancy in attendance</li>
                    <li style="padding: 8px 0;">✅ Medical leave requires proper documentation</li>
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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance - Student Portal</title>
    <style>
/* Student Portal Common Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    background: linear-gradient(135deg, #0B1F3B 0%, #0d2444 20%, #112a4e 40%, #0e2a50 60%, #091929 80%, #0B1F3B 100%);
    min-height: 100vh;
    color: #fff;
}

.dashboard-container {
    display: flex;
    min-height: 100vh;
}

/* Sidebar Styles */
.sidebar {
    width: 260px;
    background: rgba(11, 31, 59, 0.8);
    -webkit-backdrop-filter: blur(12px);
    backdrop-filter: blur(12px);
    border-right: 1px solid rgba(200, 169, 81, 0.1);
    padding: 20px;
    position: fixed;
    height: 100vh;
    overflow-y: auto;
}

.sidebar-header {
    margin-bottom: 30px;
    padding-bottom: 20px;
    border-bottom: 1px solid rgba(200, 169, 81, 0.2);
}

.sidebar-header h2 {
    color: #C8A951;
    font-size: 1.25rem;
    margin-bottom: 5px;
}

.sidebar-header p {
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.875rem;
}

.sidebar-menu {
    list-style: none;
}

.sidebar-menu li {
    margin-bottom: 8px;
}

.sidebar-menu a {
    display: flex;
    align-items: center;
    padding: 12px 16px;
    color: rgba(255, 255, 255, 0.7);
    text-decoration: none;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.sidebar-menu a:hover,
.sidebar-menu a.active {
    background: rgba(200, 169, 81, 0.15);
    color: #C8A951;
}

.sidebar-menu a i {
    margin-right: 12px;
    font-style: normal;
}

/* Main Content */
.main-content {
    margin-left: 260px;
    flex: 1;
    padding: 20px;
}

.top-nav {
    background: rgba(11, 31, 59, 0.6);
    -webkit-backdrop-filter: blur(12px);
    backdrop-filter: blur(12px);
    border: 1px solid rgba(200, 169, 81, 0.1);
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.top-nav h1 {
    color: #C8A951;
    font-size: 1.75rem;
}

.top-nav-right {
    display: flex;
    align-items: center;
    gap: 20px;
}

.notification-icon {
    position: relative;
    font-size: 1.5rem;
    cursor: pointer;
    transition: transform 0.2s ease, opacity 0.2s ease;
    display: inline-block;
}

.notification-icon:hover {
    transform: scale(1.1);
    opacity: 0.8;
}

.notification-badge {
    position: absolute;
    top: -5px;
    right: -5px;
    background: #ef4444;
    color: white;
    font-size: 0.75rem;
    padding: 2px 6px;
    border-radius: 10px;
}

.user-info {
    display: flex;
    align-items: center;
    gap: 10px;
}

.user-avatar {
    width: 40px;
    height: 40px;
    background: linear-gradient(135deg, #C8A951, #dcc574);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #0B1F3B;
    font-weight: bold;
}

.user-name {
    color: rgba(255, 255, 255, 0.9);
    font-weight: 500;
}

/* Cards */
.content-card {
    background: rgba(11, 31, 59, 0.6);
    -webkit-backdrop-filter: blur(12px);
    backdrop-filter: blur(12px);
    border: 1px solid rgba(200, 169, 81, 0.1);
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 20px;
}

.card-header {
    margin-bottom: 15px;
}

.card-header h3 {
    color: #C8A951;
    font-size: 1.25rem;
}

/* Dashboard Grid */
.dashboard-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 20px;
}

/* Stat Cards */
.stat-card {
    background: rgba(11, 31, 59, 0.6);
    -webkit-backdrop-filter: blur(12px);
    backdrop-filter: blur(12px);
    border: 1px solid rgba(200, 169, 81, 0.1);
    border-radius: 12px;
    padding: 20px;
}

.stat-card-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 15px;
}

.stat-card-value {
    font-size: 2rem;
    font-weight: 700;
    color: #C8A951;
    margin-bottom: 5px;
}

.stat-card-label {
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.875rem;
}

.stat-card-icon {
    width: 50px;
    height: 50px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
}

.stat-card-icon.blue {
    background: rgba(59, 130, 246, 0.2);
}

.stat-card-icon.green {
    background: rgba(16, 185, 129, 0.2);
}

.stat-card-icon.orange {
    background: rgba(251, 146, 60, 0.2);
}

.stat-card-icon.red {
    background: rgba(239, 68, 68, 0.2);
}

.progress {
    height: 8px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 4px;
    overflow: hidden;
}

.progress-bar {
    height: 100%;
    background: linear-gradient(90deg, #3b82f6, #2563eb);
    border-radius: 4px;
    transition: width 0.3s ease;
}

/* Badges */
.badge {
    display: inline-block;
    padding: 4px 12px;
    border-radius: 12px;
    font-size: 0.75rem;
    font-weight: 500;
}

.badge-success {
    background: rgba(16, 185, 129, 0.2);
    color: #10b981;
}

.badge-warning {
    background: rgba(251, 146, 60, 0.2);
    color: #fb923c;
}

.badge-danger {
    background: rgba(239, 68, 68, 0.2);
    color: #ef4444;
}

.badge-info {
    background: rgba(59, 130, 246, 0.2);
    color: #3b82f6;
}

/* Alerts */
.alert {
    padding: 15px 20px;
    border-radius: 12px;
    margin-bottom: 20px;
}

.alert-warning {
    background: rgba(251, 146, 60, 0.15);
    border-left: 4px solid #fb923c;
    color: rgba(255, 255, 255, 0.9);
}

.alert-danger {
    background: rgba(239, 68, 68, 0.15);
    border-left: 4px solid #ef4444;
    color: rgba(255, 255, 255, 0.9);
}

/* Table */
.table-container {
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
}

thead {
    background: rgba(200, 169, 81, 0.1);
}

thead tr {
    background: #C8A951 !important;
}

th {
    padding: 15px;
    text-align: left;
    color: #0B1F3B !important;
    font-weight: 700;
    font-size: 0.95rem;
    text-transform: uppercase;
    background: #C8A951;
    position: sticky;
    top: 0;
    z-index: 10;
    border-bottom: 2px solid #0B1F3B;
}

td {
    padding: 12px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
    color: rgba(255, 255, 255, 0.8);
}

tbody tr:hover {
    background: rgba(200, 169, 81, 0.05);
}

/* Buttons */
.btn {
    padding: 10px 20px;
    border: none;
    border-radius: 8px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s ease;
    text-decoration: none;
    display: inline-block;
}

.btn-primary {
    background: #C8A951;
    color: #0B1F3B;
}

.btn-primary:hover {
    background: #dcc574;
    transform: translateY(-2px);
}

.btn-secondary {
    background: rgba(255, 255, 255, 0.1);
    color: rgba(255, 255, 255, 0.9);
}

.btn-secondary:hover {
    background: rgba(255, 255, 255, 0.15);
}

.btn-success {
    background: rgba(16, 185, 129, 0.2);
    color: #10b981;
}

.btn-success:hover {
    background: rgba(16, 185, 129, 0.3);
}

.btn-danger {
    background: rgba(239, 68, 68, 0.2);
    color: #ef4444;
}

.btn-danger:hover {
    background: rgba(239, 68, 68, 0.3);
}

.btn-sm {
    padding: 6px 12px;
    font-size: 0.875rem;
}

/* CSS Variables Fallback */
:root {
    --primary-color: #C8A951;
    --text-secondary: rgba(255, 255, 255, 0.6);
    --light: rgba(255, 255, 255, 0.05);
    --warning-color: #fb923c;
    --success-color: #10b981;
    --danger-color: #ef4444;
    --border-color: rgba(255, 255, 255, 0.1);
}
    </style>
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
                <li><a href="../index.html" onclick="return confirmLogout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <!-- Top Navigation -->
            <nav class="top-nav">
                <h1>📅 My Attendance</h1>
                <div class="top-nav-right">
                    <a href="notifications.jsp" class="notification-icon" style="text-decoration: none; cursor: pointer;">
                        🔔
                        <span class="notification-badge">5</span>
                    </a>
                    <div class="user-info">
                        <div class="user-avatar">S</div>
                        <span class="user-name">Student</span>
                    </div>
                </div>
            </nav>
            
            <!-- Overall Summary -->
            <div class="dashboard-grid" style="grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));">
                <div class="stat-card">
                    <div class="stat-card-value" id="overallPercentage" style="color: var(--success-color);">--%</div>
                    <div class="stat-card-label">Overall Attendance</div>
                    <div class="progress">
                        <div class="progress-bar" id="overallBar" style="width: 0%; background: var(--success-color);"></div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value" id="totalClasses">--</div>
                    <div class="stat-card-label">Total Classes</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value" id="presentClasses" style="color: var(--success-color);">--</div>
                    <div class="stat-card-label">Present</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value" id="absentClasses" style="color: var(--danger-color);">--</div>
                    <div class="stat-card-label">Absent</div>
                </div>
            </div>
            
            <!-- Warning Alert -->
            <div id="attendanceAlerts"></div>
            
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
                        <tbody id="attendanceTableBody">
                            <tr>
                                <td colspan="7" style="text-align: center; padding: 40px; color: var(--text-secondary);">
                                    <div style="font-size: 3rem; margin-bottom: 10px;">📅</div>
                                    <div>No attendance data available</div>
                                    <small>Your attendance records will appear here</small>
                                </td>
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
                <div style="padding: 40px; text-align: center; color: var(--text-secondary);">
                    <div style="font-size: 3rem; margin-bottom: 10px;">📊</div>
                    <div>No monthly data available</div>
                    <small>Monthly attendance summary will appear here</small>
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
        function confirmLogout() {
            if (confirm('Are you sure you want to logout?')) {
                return true;
            }
            return false;
        }

        function showNotification(message, type = 'info') {
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 20px;
                background: \${type == 'success' ? '#10b981' : type == 'error' ? '#ef4444' : '#3b82f6'};
                color: white;
                border-radius: 8px;
                z-index: 9999;
                animation: slideIn 0.3s ease;
            `;
            notification.textContent = message;
            document.body.appendChild(notification);
            setTimeout(() => notification.remove(), 3000);
        }

        function exportTableToCSV(tableId, filename) {
            const table = document.getElementById(tableId);
            const csv = [];
            const rows = table.querySelectorAll('tr');
            
            rows.forEach(row => {
                const cols = row.querySelectorAll('td, th');
                const csvCols = Array.from(cols).map(col => {
                    const text = col.textContent.trim();
                    return `"\${text.replace(/"/g, '""')}"`;
                });
                csv.push(csvCols.join(','));
            });
            
            const csvContent = csv.join('\n');
            const blob = new Blob([csvContent], { type: 'text/csv' });
            const url = URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.href = url;
            link.download = filename + '.csv';
            link.click();
            URL.revokeObjectURL(url);
        }
    </script>
</body>
</html>

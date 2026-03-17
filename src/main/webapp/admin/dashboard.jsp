<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - University ERP</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        :root {
            --primary-color: #C8A951;
            --dark-bg: #0A1929;
            --card-bg: #1A2332;
            --sidebar-bg: #0D1B2A;
            --light: #2a4570;
            --text-primary: #fff;
            --text-secondary: rgba(255, 255, 255, 0.7);
            --border-color: rgba(200, 169, 81, 0.2);
            --success-color: #4CAF50;
            --danger-color: #f44336;
            --warning-color: #ff9800;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--dark-bg);
            color: var(--text-primary);
            overflow-x: hidden;
        }
        
        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }
        
        .sidebar {
            width: 260px;
            background: var(--sidebar-bg);
            border-right: 1px solid var(--border-color);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }
        
        .sidebar-header {
            padding: 2rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
            text-align: center;
        }
        
        .sidebar-header h2 {
            color: var(--primary-color);
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
        }
        
        .sidebar-header p {
            color: var(--text-secondary);
            font-size: 0.875rem;
        }
        
        .sidebar-menu {
            list-style: none;
            padding: 1rem 0;
        }
        
        .sidebar-menu li a {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.875rem 1.5rem;
            color: var(--text-secondary);
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }
        
        .sidebar-menu li a:hover,
        .sidebar-menu li a.active {
            background: rgba(200, 169, 81, 0.1);
            color: var(--primary-color);
            border-left-color: var(--primary-color);
        }
        
        .main-content {
            margin-left: 260px;
            flex: 1;
            padding: 2rem;
            min-height: 100vh;
        }
        
        .top-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border-color);
        }
        
        .top-nav h1 {
            font-size: 1.75rem;
            color: var(--text-primary);
        }
        
        .top-nav-right {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }
        
        .notification-icon {
            position: relative;
            font-size: 1.5rem;
            cursor: pointer;
            transition: transform 0.3s ease;
        }
        
        .notification-icon:hover {
            transform: scale(1.1);
        }
        
        .notification-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background: var(--danger-color);
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            font-weight: bold;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: var(--dark-bg);
        }
        
        .content-card {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: 1px solid var(--border-color);
        }
        
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .card-header h3 {
            font-size: 1.25rem;
            color: var(--primary-color);
        }
        
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 1.5rem;
        }
        
        .stat-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .stat-card-value {
            font-size: 2rem;
            font-weight: bold;
            color: var(--primary-color);
        }
        
        .stat-card-label {
            color: var(--text-secondary);
            font-size: 0.875rem;
            margin-top: 0.5rem;
        }
        
        .stat-card-icon {
            font-size: 2rem;
            opacity: 0.7;
        }
        
        .stat-card-icon.blue { color: #4A9FF5; }
        .stat-card-icon.green { color: #4CAF50; }
        .stat-card-icon.orange { color: #ff9800; }
        .stat-card-icon.red { color: #f44336; }
        
        .table-container {
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }
        
        th {
            color: var(--primary-color);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.875rem;
        }
        
        .btn {
            padding: 0.625rem 1.25rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 0.875rem;
        }
        
        .btn-primary {
            background: var(--primary-color);
            color: var(--dark-bg);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(200, 169, 81, 0.4);
        }
        
        .btn-success {
            background: var(--success-color);
            color: white;
        }
        
        .btn-warning {
            background: var(--warning-color);
            color: white;
        }
        
        .btn-danger {
            background: var(--danger-color);
            color: white;
        }
        
        .btn-secondary {
            background: var(--light);
            color: white;
        }
        
        .btn-sm {
            padding: 0.375rem 0.75rem;
            font-size: 0.8rem;
        }
        
        .badge {
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .badge-success {
            background: rgba(76, 175, 80, 0.2);
            color: var(--success-color);
        }
        
        .badge-warning {
            background: rgba(255, 152, 0, 0.2);
            color: var(--warning-color);
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <aside class="sidebar">
            <div class="sidebar-header">
                <h2>⚙️ Admin Portal</h2>
                <p>University ERP</p>
            </div>
            <ul class="sidebar-menu">
                <li><a href="dashboard.jsp" class="active"><i>📊</i> Dashboard</a></li>
                <li><a href="students.jsp"><i>👨‍🎓</i> Student Management</a></li>
                <li><a href="faculty.jsp"><i>👨‍🏫</i> Faculty Management</a></li>
                <li><a href="departments.jsp"><i>🏢</i> Departments</a></li>
                <li><a href="courses.jsp"><i>📚</i> Courses & Subjects</a></li>
                <li><a href="fees.jsp"><i>💰</i> Fee Management</a></li>
                <li><a href="exams.jsp"><i>📋</i> Exam Management</a></li>
                <li><a href="library-passes.jsp"><i>📖</i> Library Passes</a></li>
                <li><a href="users.jsp"><i>👤</i> User Accounts</a></li>
                <li><a href="reports.jsp"><i>📈</i> Reports</a></li>
                <li><a href="complaints.jsp"><i>📝</i> Complaints</a></li>
                <li><a href="notices.jsp"><i>📢</i> Notice Board</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="../index.html" onclick="logout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>Admin Dashboard</h1>
                <div class="top-nav-right">
                    <div class="notification-icon" onclick="window.location.href='notifications.jsp'" style="cursor: pointer;">🔔<span class="notification-badge">0</span></div>
                    <div class="user-info">
                        <div class="user-avatar">A</div>
                        <span class="user-name">Admin</span>
                    </div>
                </div>
            </nav>
            
            <div class="content-card">
                <h2 style="color: var(--primary-color); margin-bottom: 10px;">Welcome, System Administrator! 👋</h2>
                <p style="color: var(--text-secondary);">Complete overview of university operations and statistics.</p>
            </div>
            
            <!-- Main Statistics -->
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">0</div>
                            <div class="stat-card-label">Total Students</div>
                        </div>
                        <div class="stat-card-icon blue">👨‍🎓</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">0</div>
                            <div class="stat-card-label">Faculty Members</div>
                        </div>
                        <div class="stat-card-icon green">👨‍🏫</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">0</div>
                            <div class="stat-card-label">Departments</div>
                        </div>
                        <div class="stat-card-icon orange">🏢</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">0</div>
                            <div class="stat-card-label">Active Courses</div>
                        </div>
                        <div class="stat-card-icon red">📚</div>
                    </div>
                </div>
            </div>
            
            <!-- Financial Overview -->
            <div class="content-card">
                <div class="card-header">
                    <h3>💰 Financial Overview</h3>
                </div>
                <div class="dashboard-grid" style="margin-top: 20px;">
                    <div style="padding: 20px; background: var(--light); border-radius: 12px;">
                        <h4 style="color: var(--text-secondary); font-size: 14px;">Total Fee Collection</h4>
                        <div style="font-size: 28px; font-weight: bold; color: var(--success-color);">₹0</div>
                        <div style="font-size: 12px; color: var(--text-secondary); margin-top: 5px;">This Academic Year</div>
                    </div>
                    <div style="padding: 20px; background: var(--light); border-radius: 12px;">
                        <h4 style="color: var(--text-secondary); font-size: 14px;">Pending Fees</h4>
                        <div style="font-size: 28px; font-weight: bold; color: var(--danger-color);">₹0</div>
                        <div style="font-size: 12px; color: var(--text-secondary); margin-top: 5px;">0 Students</div>
                    </div>
                    <div style="padding: 20px; background: var(--light); border-radius: 12px;">
                        <h4 style="color: var(--text-secondary); font-size: 14px;">This Month Collection</h4>
                        <div style="font-size: 28px; font-weight: bold; color: var(--primary-color);">₹0</div>
                        <div style="font-size: 12px; color: var(--text-secondary); margin-top: 5px;">February 2026</div>
                    </div>
                    <div style="padding: 20px; background: var(--light); border-radius: 12px;">
                        <h4 style="color: var(--text-secondary); font-size: 14px;">Collection Rate</h4>
                        <div style="font-size: 28px; font-weight: bold; color: var(--success-color);">0%</div>
                        <div style="font-size: 12px; color: var(--text-secondary); margin-top: 5px;">-</div>
                    </div>
                </div>
            </div>
            
            <!-- Quick Actions -->
            <div class="content-card">
                <div class="card-header">
                    <h3>⚡ Quick Actions</h3>
                </div>
                <div class="dashboard-grid">
                    <button class="btn btn-primary" onclick="window.location='students.jsp'" style="padding: 20px; height: auto;">
                        <div style="font-size: 32px;">➕</div>
                        <div>Add New Student</div>
                    </button>
                    <button class="btn btn-success" onclick="window.location='faculty.jsp'" style="padding: 20px; height: auto;">
                        <div style="font-size: 32px;">👨‍🏫</div>
                        <div>Add New Faculty</div>
                    </button>
                    <button class="btn btn-warning" onclick="window.location='exams.jsp'" style="padding: 20px; height: auto;">
                        <div style="font-size: 32px;">📋</div>
                        <div>Create Exam Schedule</div>
                    </button>
                    <button class="btn btn-danger" onclick="window.location='notices.jsp'" style="padding: 20px; height: auto;">
                        <div style="font-size: 32px;">📢</div>
                        <div>Post Notice</div>
                    </button>
                </div>
            </div>
            
            <!-- Department-wise Statistics -->
            <div class="content-card">
                <div class="card-header">
                    <h3>🏢 Department-wise Student Distribution</h3>
                    <button class="btn btn-sm btn-primary" onclick="exportTableToCSV('deptTable', 'department-stats')">📥 Export</button>
                </div>
                <div class="table-container">
                    <table id="deptTable">
                        <thead>
                            <tr>
                                <th>Department</th>
                                <th>Total Students</th>
                                <th>Faculty Count</th>
                                <th>Active Courses</th>
                                <th>Avg Attendance</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Recent Activities & Pending Tasks -->
            <div class="dashboard-grid">
                <div class="content-card">
                    <div class="card-header">
                        <h3>⏳ Pending Tasks</h3>
                    </div>
                    <div style="padding: 10px 0;">
                    </div>
                </div>
                
                <div class="content-card">
                    <div class="card-header">
                        <h3>📊 Today's Statistics</h3>
                    </div>
                    <div style="padding: 10px 0;">
                        <div style="display: flex; justify-content: space-between; padding: 12px; background: var(--light); border-radius: 8px; margin-bottom: 10px;">
                            <span>Present Today</span>
                            <strong style="color: var(--success-color);">0 / 0</strong>
                        </div>
                        <div style="display: flex; justify-content: space-between; padding: 12px; background: var(--light); border-radius: 8px; margin-bottom: 10px;">
                            <span>New Admissions</span>
                            <strong style="color: var(--primary-color);">0</strong>
                        </div>
                        <div style="display: flex; justify-content: space-between; padding: 12px; background: var(--light); border-radius: 8px;">
                            <span>Fees Collected Today</span>
                            <strong style="color: var(--success-color);">₹0</strong>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <script>
        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                window.location.href = '../index.html';
            }
        }
        
        function viewDept(deptCode) {
            // Navigate to departments page with department filter
            window.location.href = 'departments.jsp?dept=' + deptCode;
        }
        
        function exportTableToCSV(tableId, filename) {
            const table = document.getElementById(tableId);
            if (!table) {
                alert('Table not found!');
                return;
            }
            
            let csv = [];
            const rows = table.querySelectorAll('tr');
            
            for (let i = 0; i < rows.length; i++) {
                const row = [], cols = rows[i].querySelectorAll('td, th');
                
                for (let j = 0; j < cols.length; j++) {
                    // Get text content and clean it
                    let cellText = cols[j].innerText.replace(/"/g, '""');
                    row.push('"' + cellText + '"');
                }
                
                csv.push(row.join(','));
            }
            
            // Create CSV file and trigger download
            const csvContent = csv.join('\n');
            const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            
            if (link.download !== undefined) {
                const url = URL.createObjectURL(blob);
                link.setAttribute('href', url);
                link.setAttribute('download', filename + '.csv');
                link.style.visibility = 'hidden';
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            } else {
                alert('Your browser does not support downloading files.');
            }
        }
    </script>
</body>
</html>

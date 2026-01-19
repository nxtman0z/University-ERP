<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>University Head Dashboard - University ERP</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="dashboard-container">
        <aside class="sidebar">
            <div class="sidebar-header">
                <h2>🎓 Head Portal</h2>
                <p>University ERP</p>
            </div>
            <ul class="sidebar-menu">
                <li><a href="dashboard.jsp" class="active"><i>📊</i> Dashboard</a></li>
                <li><a href="analytics.jsp"><i>📈</i> Analytics</a></li>
                <li><a href="approvals.jsp"><i>✅</i> Approvals</a></li>
                <li><a href="reports.jsp"><i>📋</i> Reports</a></li>
                <li><a href="departments.jsp"><i>🏢</i> Departments</a></li>
                <li><a href="performance.jsp"><i>🏆</i> Performance</a></li>
                <li><a href="policies.jsp"><i>⚙️</i> Policies</a></li>
                <li><a href="notices.jsp"><i>📢</i> Notices</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="#" onclick="logout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>University Head Dashboard</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">🔔<span class="notification-badge">15</span></div>
                    <div class="user-info">
                        <div class="user-avatar">H</div>
                        <span class="user-name">Head</span>
                    </div>
                </div>
            </nav>
            
            <div class="content-card">
                <h2 style="color: var(--primary-color); margin-bottom: 10px;">Welcome, Dr. Principal! 👋</h2>
                <p style="color: var(--text-secondary);">University-wide overview and key performance indicators.</p>
            </div>
            
            <!-- Key Metrics -->
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">2,547</div>
                            <div class="stat-card-label">Total Students</div>
                        </div>
                        <div class="stat-card-icon blue">👨‍🎓</div>
                    </div>
                    <small style="color: var(--success-color);">↑ 8% from last year</small>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">125</div>
                            <div class="stat-card-label">Faculty Members</div>
                        </div>
                        <div class="stat-card-icon green">👨‍🏫</div>
                    </div>
                    <small style="color: var(--success-color);">↑ 5% from last year</small>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">87%</div>
                            <div class="stat-card-label">Overall Attendance</div>
                        </div>
                        <div class="stat-card-icon orange">📅</div>
                    </div>
                    <div class="progress">
                        <div class="progress-bar" style="width: 87%; background: var(--warning-color);"></div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">92%</div>
                            <div class="stat-card-label">Pass Percentage</div>
                        </div>
                        <div class="stat-card-icon red">🏆</div>
                    </div>
                    <small style="color: var(--success-color);">Excellent Performance</small>
                </div>
            </div>
            
            <!-- Financial Summary -->
            <div class="content-card">
                <div class="card-header">
                    <h3>💰 Financial Summary (Academic Year 2025-26)</h3>
                </div>
                <div class="dashboard-grid">
                    <div style="padding: 25px; background: linear-gradient(135deg, #10b981, #059669); border-radius: 15px; color: white;">
                        <h4 style="color: white; opacity: 0.9; font-size: 14px;">Total Revenue</h4>
                        <div style="font-size: 32px; font-weight: bold; margin: 10px 0;">₹1,24,50,000</div>
                        <div style="font-size: 13px; opacity: 0.9;">Fee Collection</div>
                    </div>
                    <div style="padding: 25px; background: linear-gradient(135deg, #ef4444, #dc2626); border-radius: 15px; color: white;">
                        <h4 style="color: white; opacity: 0.9; font-size: 14px;">Pending Amount</h4>
                        <div style="font-size: 32px; font-weight: bold; margin: 10px 0;">₹18,75,000</div>
                        <div style="font-size: 13px; opacity: 0.9;">245 Students</div>
                    </div>
                    <div style="padding: 25px; background: linear-gradient(135deg, #2563eb, #1e40af); border-radius: 15px; color: white;">
                        <h4 style="color: white; opacity: 0.9; font-size: 14px;">Collection Rate</h4>
                        <div style="font-size: 32px; font-weight: bold; margin: 10px 0;">87%</div>
                        <div style="font-size: 13px; opacity: 0.9;">Very Good</div>
                    </div>
                    <div style="padding: 25px; background: linear-gradient(135deg, #f59e0b, #d97706); border-radius: 15px; color: white;">
                        <h4 style="color: white; opacity: 0.9; font-size: 14px;">This Month</h4>
                        <div style="font-size: 32px; font-weight: bold; margin: 10px 0;">₹22,50,000</div>
                        <div style="font-size: 13px; opacity: 0.9;">January 2026</div>
                    </div>
                </div>
            </div>
            
            <!-- Pending Approvals -->
            <div class="content-card">
                <div class="card-header">
                    <h3>⏳ Pending Approvals</h3>
                    <span class="badge badge-danger" style="font-size: 14px;">15 Pending</span>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Type</th>
                                <th>Description</th>
                                <th>Requested By</th>
                                <th>Date</th>
                                <th>Priority</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><span class="badge badge-info">Result</span></td>
                                <td>Semester 4 Result Publication</td>
                                <td>Admin</td>
                                <td>18 Jan 2026</td>
                                <td><span class="badge badge-danger">High</span></td>
                                <td>
                                    <button class="btn btn-sm btn-success" onclick="approveItem('result1')">✅ Approve</button>
                                    <button class="btn btn-sm btn-danger" onclick="rejectItem('result1')">❌ Reject</button>
                                </td>
                            </tr>
                            <tr>
                                <td><span class="badge badge-warning">Faculty</span></td>
                                <td>New Faculty Onboarding - Dr. Amit Sharma</td>
                                <td>HR Admin</td>
                                <td>17 Jan 2026</td>
                                <td><span class="badge badge-warning">Medium</span></td>
                                <td>
                                    <button class="btn btn-sm btn-success" onclick="approveItem('faculty1')">✅ Approve</button>
                                    <button class="btn btn-sm btn-danger" onclick="rejectItem('faculty1')">❌ Reject</button>
                                </td>
                            </tr>
                            <tr>
                                <td><span class="badge badge-success">Notice</span></td>
                                <td>University Holiday Announcement</td>
                                <td>Admin</td>
                                <td>16 Jan 2026</td>
                                <td><span class="badge badge-info">Low</span></td>
                                <td>
                                    <button class="btn btn-sm btn-success" onclick="approveItem('notice1')">✅ Approve</button>
                                    <button class="btn btn-sm btn-danger" onclick="rejectItem('notice1')">❌ Reject</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Department Performance -->
            <div class="content-card">
                <div class="card-header">
                    <h3>🏢 Department Performance Overview</h3>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Department</th>
                                <th>Students</th>
                                <th>Avg Attendance</th>
                                <th>Pass Rate</th>
                                <th>Avg CGPA</th>
                                <th>Rating</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><strong>Computer Science</strong></td>
                                <td>850</td>
                                <td><span class="badge badge-success">85%</span></td>
                                <td><span class="badge badge-success">94%</span></td>
                                <td>8.5</td>
                                <td>⭐⭐⭐⭐⭐</td>
                            </tr>
                            <tr>
                                <td><strong>Business Administration</strong></td>
                                <td>620</td>
                                <td><span class="badge badge-success">82%</span></td>
                                <td><span class="badge badge-success">91%</span></td>
                                <td>8.2</td>
                                <td>⭐⭐⭐⭐</td>
                            </tr>
                            <tr>
                                <td><strong>Electronics</strong></td>
                                <td>540</td>
                                <td><span class="badge badge-success">80%</span></td>
                                <td><span class="badge badge-success">90%</span></td>
                                <td>8.0</td>
                                <td>⭐⭐⭐⭐</td>
                            </tr>
                            <tr>
                                <td><strong>Mechanical</strong></td>
                                <td>537</td>
                                <td><span class="badge badge-warning">78%</span></td>
                                <td><span class="badge badge-warning">88%</span></td>
                                <td>7.8</td>
                                <td>⭐⭐⭐</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Quick Actions -->
            <div class="dashboard-grid">
                <div class="content-card">
                    <h3 style="margin-bottom: 15px;">⚡ Quick Actions</h3>
                    <div style="display: flex; flex-direction: column; gap: 10px;">
                        <button class="btn btn-primary" onclick="window.location='approvals.jsp'">✅ Review Approvals (15)</button>
                        <button class="btn btn-success" onclick="window.location='reports.jsp'">📊 View Reports</button>
                        <button class="btn btn-warning" onclick="window.location='policies.jsp'">⚙️ Update Policies</button>
                        <button class="btn btn-danger" onclick="window.location='notices.jsp'">📢 Post Important Notice</button>
                    </div>
                </div>
                
                <div class="content-card">
                    <h3 style="margin-bottom: 15px;">📊 This Week Summary</h3>
                    <div style="display: flex; flex-direction: column; gap: 10px;">
                        <div style="display: flex; justify-content: space-between; padding: 10px; background: var(--light); border-radius: 8px;">
                            <span>Approvals Given</span>
                            <strong style="color: var(--success-color);">28</strong>
                        </div>
                        <div style="display: flex; justify-content: space-between; padding: 10px; background: var(--light); border-radius: 8px;">
                            <span>Reports Reviewed</span>
                            <strong style="color: var(--primary-color);">12</strong>
                        </div>
                        <div style="display: flex; justify-content: space-between; padding: 10px; background: var(--light); border-radius: 8px;">
                            <span>Meetings Attended</span>
                            <strong style="color: var(--info-color);">5</strong>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <script src="../js/main.js"></script>
    <script>
        SessionManager.checkAuth();
        
        function approveItem(id) {
            if (confirm('Are you sure you want to approve this request?')) {
                alert('✅ Request approved successfully!');
                NotificationManager.add('Request approved successfully!', 'success');
                setTimeout(() => location.reload(), 1500);
            }
        }
        
        function rejectItem(id) {
            if (confirm('Are you sure you want to reject this request?')) {
                const reason = prompt('Please provide rejection reason:');
                if (reason) {
                    alert('❌ Request rejected!');
                    NotificationManager.add('Request rejected!', 'warning');
                    setTimeout(() => location.reload(), 1500);
                }
            }
        }
    </script>
</body>
</html>

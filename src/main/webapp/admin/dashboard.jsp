<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - University ERP</title>
    <link rel="stylesheet" href="../css/style.css">
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
                <li><a href="fees-management.jsp"><i>💰</i> Fee Management</a></li>
                <li><a href="exam-management.jsp"><i>📋</i> Exam Management</a></li>
                <li><a href="users.jsp"><i>👤</i> User Accounts</a></li>
                <li><a href="reports.jsp"><i>📈</i> Reports</a></li>
                <li><a href="complaints.jsp"><i>📝</i> Complaints</a></li>
                <li><a href="notices.jsp"><i>📢</i> Notice Board</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="#" onclick="logout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>Admin Dashboard</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">🔔<span class="notification-badge">12</span></div>
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
                            <div class="stat-card-value">2,547</div>
                            <div class="stat-card-label">Total Students</div>
                        </div>
                        <div class="stat-card-icon blue">👨‍🎓</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">125</div>
                            <div class="stat-card-label">Faculty Members</div>
                        </div>
                        <div class="stat-card-icon green">👨‍🏫</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">12</div>
                            <div class="stat-card-label">Departments</div>
                        </div>
                        <div class="stat-card-icon orange">🏢</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">45</div>
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
                        <div style="font-size: 28px; font-weight: bold; color: var(--success-color);">₹1,24,50,000</div>
                        <div style="font-size: 12px; color: var(--text-secondary); margin-top: 5px;">This Academic Year</div>
                    </div>
                    <div style="padding: 20px; background: var(--light); border-radius: 12px;">
                        <h4 style="color: var(--text-secondary); font-size: 14px;">Pending Fees</h4>
                        <div style="font-size: 28px; font-weight: bold; color: var(--danger-color);">₹18,75,000</div>
                        <div style="font-size: 12px; color: var(--text-secondary); margin-top: 5px;">245 Students</div>
                    </div>
                    <div style="padding: 20px; background: var(--light); border-radius: 12px;">
                        <h4 style="color: var(--text-secondary); font-size: 14px;">This Month Collection</h4>
                        <div style="font-size: 28px; font-weight: bold; color: var(--primary-color);">₹22,50,000</div>
                        <div style="font-size: 12px; color: var(--text-secondary); margin-top: 5px;">January 2026</div>
                    </div>
                    <div style="padding: 20px; background: var(--light); border-radius: 12px;">
                        <h4 style="color: var(--text-secondary); font-size: 14px;">Collection Rate</h4>
                        <div style="font-size: 28px; font-weight: bold; color: var(--success-color);">87%</div>
                        <div style="font-size: 12px; color: var(--text-secondary); margin-top: 5px;">Very Good</div>
                    </div>
                </div>
            </div>
            
            <!-- Quick Actions -->
            <div class="content-card">
                <div class="card-header">
                    <h3>⚡ Quick Actions</h3>
                </div>
                <div class="dashboard-grid">
                    <button class="btn btn-primary" onclick="window.location='students.jsp?action=add'" style="padding: 20px; height: auto;">
                        <div style="font-size: 32px;">➕</div>
                        <div>Add New Student</div>
                    </button>
                    <button class="btn btn-success" onclick="window.location='faculty.jsp?action=add'" style="padding: 20px; height: auto;">
                        <div style="font-size: 32px;">👨‍🏫</div>
                        <div>Add New Faculty</div>
                    </button>
                    <button class="btn btn-warning" onclick="window.location='exam-management.jsp'" style="padding: 20px; height: auto;">
                        <div style="font-size: 32px;">📋</div>
                        <div>Create Exam Schedule</div>
                    </button>
                    <button class="btn btn-danger" onclick="window.location='notices.jsp?action=create'" style="padding: 20px; height: auto;">
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
                            <tr>
                                <td><strong>Computer Science</strong></td>
                                <td>850</td>
                                <td>35</td>
                                <td>12</td>
                                <td><span class="badge badge-success">85%</span></td>
                                <td><button class="btn btn-sm btn-secondary" onclick="viewDept('CS')">View Details</button></td>
                            </tr>
                            <tr>
                                <td><strong>Business Administration</strong></td>
                                <td>620</td>
                                <td>28</td>
                                <td>10</td>
                                <td><span class="badge badge-success">82%</span></td>
                                <td><button class="btn btn-sm btn-secondary" onclick="viewDept('BBA')">View Details</button></td>
                            </tr>
                            <tr>
                                <td><strong>Electronics</strong></td>
                                <td>540</td>
                                <td>22</td>
                                <td>8</td>
                                <td><span class="badge badge-success">80%</span></td>
                                <td><button class="btn btn-sm btn-secondary" onclick="viewDept('ECE')">View Details</button></td>
                            </tr>
                            <tr>
                                <td><strong>Mechanical</strong></td>
                                <td>537</td>
                                <td>20</td>
                                <td>9</td>
                                <td><span class="badge badge-warning">78%</span></td>
                                <td><button class="btn btn-sm btn-secondary" onclick="viewDept('MECH')">View Details</button></td>
                            </tr>
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
                        <div style="padding: 12px; border-left: 3px solid var(--danger-color); margin-bottom: 10px; background: var(--light);">
                            <strong>25 User Accounts Pending Approval</strong><br>
                            <small style="color: var(--text-secondary);">New registrations</small>
                        </div>
                        <div style="padding: 12px; border-left: 3px solid var(--warning-color); margin-bottom: 10px; background: var(--light);">
                            <strong>18 Complaints to Review</strong><br>
                            <small style="color: var(--text-secondary);">Student complaints</small>
                        </div>
                        <div style="padding: 12px; border-left: 3px solid var(--info-color); background: var(--light);">
                            <strong>Publish Semester Results</strong><br>
                            <small style="color: var(--text-secondary);">Semester 4 results ready</small>
                        </div>
                    </div>
                </div>
                
                <div class="content-card">
                    <div class="card-header">
                        <h3>📊 Today's Statistics</h3>
                    </div>
                    <div style="padding: 10px 0;">
                        <div style="display: flex; justify-content: space-between; padding: 12px; background: var(--light); border-radius: 8px; margin-bottom: 10px;">
                            <span>Present Today</span>
                            <strong style="color: var(--success-color);">2,245 / 2,547</strong>
                        </div>
                        <div style="display: flex; justify-content: space-between; padding: 12px; background: var(--light); border-radius: 8px; margin-bottom: 10px;">
                            <span>New Admissions</span>
                            <strong style="color: var(--primary-color);">12</strong>
                        </div>
                        <div style="display: flex; justify-content: space-between; padding: 12px; background: var(--light); border-radius: 8px;">
                            <span>Fees Collected</span>
                            <strong style="color: var(--success-color);">₹2,45,000</strong>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <script src="../js/main.js"></script>
    <script>
        SessionManager.checkAuth();
        
        function viewDept(deptId) {
            window.location.href = 'departments.jsp?dept=' + deptId;
        }
    </script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exam - Student Portal</title>
    <link rel="stylesheet" href="../style.css">
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

.badge-primary {
    background: rgba(200, 169, 81, 0.2);
    color: #C8A951;
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

.alert-info {
    background: rgba(59, 130, 246, 0.15);
    border-left: 4px solid #3b82f6;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
    color: rgba(255, 255, 255, 0.9);
}

.alert-success {
    background: rgba(16, 185, 129, 0.15);
    border-left: 4px solid #10b981;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
    color: rgba(255, 255, 255, 0.9);
}

.alert-danger {
    background: rgba(239, 68, 68, 0.15);
    border-left: 4px solid #ef4444;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
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

/* Modal Styles */
.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.7);
    -webkit-backdrop-filter: blur(8px);
    backdrop-filter: blur(8px);
    z-index: 1000;
    align-items: center;
    justify-content: center;
    animation: fadeIn 0.3s ease;
}

.modal-content {
    background: rgba(11, 31, 59, 0.95);
    border: 1px solid rgba(200, 169, 81, 0.2);
    border-radius: 16px;
    padding: 0;
    width: 90%;
    max-width: 600px;
    max-height: 90vh;
    overflow-y: auto;
    animation: slideUp 0.3s ease;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
}

.modal-header {
    padding: 25px;
    border-bottom: 1px solid rgba(200, 169, 81, 0.2);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.modal-header h3 {
    color: #C8A951;
    font-size: 1.5rem;
    margin: 0;
}

.modal-close {
    cursor: pointer;
    font-size: 2rem;
    color: rgba(255, 255, 255, 0.6);
    line-height: 1;
    transition: color 0.3s ease;
}

.modal-close:hover {
    color: #C8A951;
}

.modal form {
    padding: 25px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: rgba(255, 255, 255, 0.8);
    font-weight: 500;
    font-size: 0.9rem;
}

.form-control {
    width: 100%;
    padding: 12px 15px;
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(200, 169, 81, 0.2);
    border-radius: 8px;
    color: rgba(255, 255, 255, 0.9);
    font-size: 0.95rem;
    transition: all 0.3s ease;
}

.form-control:focus {
    outline: none;
    border-color: #C8A951;
    background: rgba(255, 255, 255, 0.08);
}

.form-control::placeholder {
    color: rgba(255, 255, 255, 0.4);
}

textarea.form-control {
    resize: vertical;
    min-height: 100px;
}

select.form-control {
    cursor: pointer;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23C8A951' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 12px center;
    padding-right: 35px;
}

select.form-control option {
    background: #1a1f36;
    color: #ffffff;
    padding: 10px;
}

select.form-control option:hover,
select.form-control option:checked {
    background: #C8A951;
    color: #0b1f3b;
}

/* Animations */
@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
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
                <li><a href="internal-marks.jsp"><i>📊</i> Internal Marks</a></li>
                <li><a href="exam.jsp" class="active"><i>📋</i> Exam</a></li>
                <li><a href="results.jsp"><i>🏆</i> Results</a></li>
                <li><a href="requests.jsp"><i>📄</i> Requests</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="../index.html" onclick="return confirmLogout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>📋 Examination</h1>
                <div class="top-nav-right">
                    <a href="notifications.jsp" class="notification-icon" style="text-decoration: none; cursor: pointer;">🔔<span class="notification-badge">5</span></a>
                    <div class="user-info">
                        <div class="user-avatar">S</div>
                        <span class="user-name">Student</span>
                    </div>
                </div>
            </nav>
            
            <!-- Exam Form Status -->
            <div id="examFormAlertContainer"></div>
            
            <!-- Quick Actions -->
            <div class="dashboard-grid">
                <div class="stat-card" onclick="window.location='#examForm'" style="cursor: pointer;">
                    <div class="stat-card-icon blue">📝</div>
                    <div style="margin-top: 10px;">
                        <div class="stat-card-value" style="font-size: 16px;">Fill Exam Form</div>
                        <div class="stat-card-label">Semester Examination</div>
                    </div>
                </div>
                <div class="stat-card" onclick="downloadAdmitCard()" style="cursor: pointer;">
                    <div class="stat-card-icon green">🎫</div>
                    <div style="margin-top: 10px;">
                        <div class="stat-card-value" style="font-size: 16px;">Admit Card</div>
                        <div class="stat-card-label">Download Hall Ticket</div>
                    </div>
                </div>
                <div class="stat-card" onclick="window.location='#schedule'" style="cursor: pointer;">
                    <div class="stat-card-icon orange">📅</div>
                    <div style="margin-top: 10px;">
                        <div class="stat-card-value" style="font-size: 16px;">Exam Schedule</div>
                        <div class="stat-card-label">View Timetable</div>
                    </div>
                </div>
                <div class="stat-card" onclick="window.location='results.jsp'" style="cursor: pointer;">
                    <div class="stat-card-icon red">🏆</div>
                    <div style="margin-top: 10px;">
                        <div class="stat-card-value" style="font-size: 16px;">View Results</div>
                        <div class="stat-card-label">Check Marks</div>
                    </div>
                </div>
            </div>
            
            <!-- Exam Form Section -->
            <div class="content-card" id="examForm">
                <div class="card-header">
                    <h3>📝 Exam Form Submission</h3>
                    <span class="badge badge-success">Submitted</span>
                </div>
                <div style="padding: 20px; background: var(--light); border-radius: 10px; margin-top: 15px;" id="examFormContainer">
                    <h4 style="margin-bottom: 15px;">Semester 4 - Regular Examination</h4>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px;">
                        <div>
                            <strong>Form Status:</strong><br>
                            <span class="badge badge-success">Submitted</span>
                        </div>
                        <div>
                            <strong>Submission Date:</strong><br>
                            <span style="color: var(--text-secondary);">10 January 2026</span>
                        </div>
                        <div>
                            <strong>Exam Fee:</strong><br>
                            <span style="color: var(--success-color);">₹2,500 (Paid)</span>
                        </div>
                        <div>
                            <strong>Number of Subjects:</strong><br>
                            <span style="color: var(--text-secondary);">5 Subjects</span>
                        </div>
                    </div>
                    <div style="margin-top: 20px;">
                        <button class="btn btn-secondary" onclick="viewFormDetails()">👁️ View Form Details</button>
                        <button class="btn btn-primary" onclick="downloadReceipt()">📥 Download Receipt</button>
                    </div>
                </div>
            </div>
            
            <!-- Admit Card Section -->
            <div class="content-card">
                <div class="card-header">
                    <h3>🎫 Admit Card</h3>
                </div>
                <div style="padding: 20px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 10px; color: white; margin-top: 15px;" id="admitCardContainer">
                    <h4 style="color: white; margin-bottom: 15px;">Semester 4 Examination - Admit Card</h4>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-bottom: 20px;">
                        <div>
                            <strong>Roll Number:</strong><br>
                            BCA2024001
                        </div>
                        <div>
                            <strong>Examination Center:</strong><br>
                            Main Campus, Hall 1
                        </div>
                        <div>
                            <strong>Exam Dates:</strong><br>
                            20 Mar - 10 Apr 2026
                        </div>
                    </div>
                    <button class="btn" style="background: white; color: var(--primary-color);" onclick="downloadAdmitCard()">
                        📥 Download Admit Card
                    </button>
                </div>
                <div class="alert alert-info" style="margin-top: 15px;">
                    <strong>⚠️ Important:</strong> Please bring your admit card and college ID card to the examination hall. Entry without admit card is strictly prohibited.
                </div>
            </div>
            
            <!-- Exam Schedule -->
            <div class="content-card" id="schedule">
                <div class="card-header">
                    <h3>📅 Examination Schedule - Semester 4</h3>
                    <button class="btn btn-sm btn-primary" onclick="printPage()">🖨️ Print Schedule</button>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Day</th>
                                <th>Subject Code</th>
                                <th>Subject Name</th>
                                <th>Time</th>
                                <th>Duration</th>
                                <th>Max Marks</th>
                            </tr>
                        </thead>
                        <tbody id="examScheduleTableBody">
                            <tr>
                                <td>20 Mar 2026</td>
                                <td>Monday</td>
                                <td>CS101</td>
                                <td><strong>Java Programming</strong></td>
                                <td>10:00 AM</td>
                                <td>3 Hours</td>
                                <td>100</td>
                            </tr>
                            <tr>
                                <td>23 Mar 2026</td>
                                <td>Thursday</td>
                                <td>CS102</td>
                                <td><strong>Data Structures</strong></td>
                                <td>10:00 AM</td>
                                <td>3 Hours</td>
                                <td>100</td>
                            </tr>
                            <tr>
                                <td>27 Mar 2026</td>
                                <td>Monday</td>
                                <td>CS103</td>
                                <td><strong>Database Management</strong></td>
                                <td>10:00 AM</td>
                                <td>3 Hours</td>
                                <td>100</td>
                            </tr>
                            <tr>
                                <td>01 Apr 2026</td>
                                <td>Friday</td>
                                <td>CS104</td>
                                <td><strong>Web Technologies</strong></td>
                                <td>10:00 AM</td>
                                <td>3 Hours</td>
                                <td>100</td>
                            </tr>
                            <tr>
                                <td>05 Apr 2026</td>
                                <td>Tuesday</td>
                                <td>CS105</td>
                                <td><strong>Operating Systems</strong></td>
                                <td>10:00 AM</td>
                                <td>3 Hours</td>
                                <td>100</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Exam Guidelines -->
            <div class="content-card">
                <div class="card-header">
                    <h3>📜 Examination Guidelines</h3>
                </div>
                <div style="padding: 10px 0;">
                    <ul style="list-style: none; padding: 0;">
                        <li style="padding: 10px; background: var(--light); border-radius: 8px; margin-bottom: 10px;">
                            ✅ <strong>Reporting Time:</strong> Students must report 30 minutes before the exam.
                        </li>
                        <li style="padding: 10px; background: var(--light); border-radius: 8px; margin-bottom: 10px;">
                            ✅ <strong>Documents Required:</strong> Admit Card, College ID Card, and Exam Form Receipt.
                        </li>
                        <li style="padding: 10px; background: var(--light); border-radius: 8px; margin-bottom: 10px;">
                            ✅ <strong>Stationery:</strong> Bring your own stationery. Blue/Black pen is mandatory.
                        </li>
                        <li style="padding: 10px; background: var(--light); border-radius: 8px; margin-bottom: 10px;">
                            ⚠️ <strong>Mobile Phones:</strong> Mobile phones and electronic devices are strictly prohibited.
                        </li>
                        <li style="padding: 10px; background: var(--light); border-radius: 8px; margin-bottom: 10px;">
                            ⚠️ <strong>Late Entry:</strong> No entry will be allowed after 30 minutes of exam start.
                        </li>
                        <li style="padding: 10px; background: var(--light); border-radius: 8px;">
                            ⚠️ <strong>Unfair Means:</strong> Use of unfair means will result in cancellation of examination.
                        </li>
                    </ul>
                </div>
            </div>
        </main>
    </div>
    
    <script src="../js/main.js"></script>
    <script>
        SessionManager.checkAuth();

        // Student Portal Common JavaScript Functions

        // Logout confirmation
        function confirmLogout() {
            if (confirm('Are you sure you want to logout?')) {
                // Clear any session data
                sessionStorage.clear();
                localStorage.removeItem('userRole');
                localStorage.removeItem('userId');
                return true; // Allow navigation
            }
            return false; // Cancel navigation
        }

        // Set active menu item based on current page
        document.addEventListener('DOMContentLoaded', function() {
            const currentPage = window.location.pathname.split('/').pop();
            const menuLinks = document.querySelectorAll('.sidebar-menu a');
            
            menuLinks.forEach(link => {
                const linkHref = link.getAttribute('href');
                if (linkHref === currentPage) {
                    // Remove active class from all links
                    menuLinks.forEach(l => l.classList.remove('active'));
                    // Add active class to current link
                    link.classList.add('active');
                }
            });
            
            // Check if user is logged in (basic demo check)
            checkAuth();
        });

        // Basic authentication check (Demo mode)
        function checkAuth() {
            // In demo mode, no authentication required
            // For production, check session/token here
            return true;
        }

        // Format date
        function formatDate(dateString) {
            const date = new Date(dateString);
            const options = { year: 'numeric', month: 'short', day: 'numeric' };
            return date.toLocaleDateString('en-IN', options);
        }

        // Show notification toast
        function showNotification(message, type = 'info') {
            // Create notification element
            const notification = document.createElement('div');
            notification.className = `notification notification-${type}`;
            notification.textContent = message;
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                background: rgba(11, 31, 59, 0.95);
                color: white;
                padding: 15px 20px;
                border-radius: 8px;
                border-left: 4px solid ${type === 'success' ? '#10b981' : type === 'error' ? '#ef4444' : '#3b82f6'};
                z-index: 10000;
                animation: slideInRight 0.3s ease;
            `;
            
            document.body.appendChild(notification);
            
            // Remove after 3 seconds
            setTimeout(() => {
                notification.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => notification.remove(), 300);
            }, 3000);
        }

        // Add CSS animations
        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideInRight {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
            
            @keyframes slideOutRight {
                from {
                    transform: translateX(0);
                    opacity: 1;
                }
                to {
                    transform: translateX(100%);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);

        // Modal Functions
        function openModal(modalId) {
            const modal = document.getElementById(modalId);
            if (modal) {
                modal.style.display = 'flex';
                document.body.style.overflow = 'hidden'; // Prevent background scrolling
            }
        }

        function closeModal(modalId) {
            const modal = document.getElementById(modalId);
            if (modal) {
                modal.style.display = 'none';
                document.body.style.overflow = 'auto'; // Restore scrolling
            }
        }

        // Close modal when clicking outside the modal content
        document.addEventListener('click', function(event) {
            if (event.target.classList.contains('modal')) {
                closeModal(event.target.id);
            }
        });

        // Close modal when pressing Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                const openModals = document.querySelectorAll('.modal');
                openModals.forEach(modal => {
                    if (modal.style.display === 'flex') {
                        closeModal(modal.id);
                    }
                });
            }
        });

        // Export table to CSV
        function exportTableToCSV(tableId, filename) {
            const table = document.getElementById(tableId);
            if (!table) {
                showNotification('Table not found', 'error');
                return;
            }
            
            let csv = [];
            const rows = table.querySelectorAll('tr');
            
            rows.forEach(row => {
                const cols = row.querySelectorAll('td, th');
                const rowData = [];
                cols.forEach(col => {
                    // Get text content and clean it
                    let text = col.textContent.trim();
                    // Handle commas and quotes in data
                    if (text.includes(',') || text.includes('"')) {
                        text = '"' + text.replace(/"/g, '""') + '"';
                    }
                    rowData.push(text);
                });
                csv.push(rowData.join(','));
            });
            
            // Create download link
            const csvContent = csv.join('\n');
            const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            const url = URL.createObjectURL(blob);
            
            link.setAttribute('href', url);
            link.setAttribute('download', filename + '.csv');
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            
            showNotification('Table exported successfully!', 'success');
        }

        // Exam-specific functions
        function downloadAdmitCard() {
            alert('📥 Downloading Admit Card...');
            showNotification('Admit card downloaded successfully!', 'success');
        }
        
        function viewFormDetails() {
            alert('Viewing exam form details...');
        }
        
        function downloadReceipt() {
            alert('📥 Downloading exam fee receipt...');
            showNotification('Receipt downloaded!', 'success');
        }

        function printPage() {
            window.print();
        }
    </script>
</body>
</html>

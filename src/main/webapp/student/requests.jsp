<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Requests - Student Portal</title>
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

/* Additional Badges */
.badge-info {
    background: rgba(59, 130, 246, 0.2);
    color: #3b82f6;
}

.badge-primary {
    background: rgba(200, 169, 81, 0.2);
    color: #C8A951;
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
                <li><a href="assignments.jsp"><i>📝</i> Assignments</a></li>
                <li><a href="internal-marks.jsp"><i>📊</i> Internal Marks</a></li>
                <li><a href="exam.jsp"><i>📋</i> Exam</a></li>
                <li><a href="results.jsp"><i>🏆</i> Results</a></li>
                <li><a href="fees.jsp"><i>💰</i> Fees & Payments</a></li>
                <li><a href="library-pass.jsp"><i>📖</i> Library Pass</a></li>
                <li><a href="requests.jsp" class="active"><i>📄</i> Requests</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="../index.html" onclick="return confirmLogout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>📄 My Requests</h1>
                <div class="top-nav-right">
                    <a href="notifications.jsp" class="notification-icon" style="text-decoration: none; cursor: pointer;">🔔<span class="notification-badge">5</span></a>
                    <div class="user-info">
                        <div class="user-avatar">S</div>
                        <span class="user-name">Student</span>
                    </div>
                </div>
            </nav>
            
            <!-- Request Types -->
            <div class="dashboard-grid">
                <div class="content-card" onclick="openModal('bonafideModal')" style="cursor: pointer; transition: transform 0.3s;">
                    <div style="text-align: center;">
                        <div style="font-size: 48px; margin-bottom: 10px;">📜</div>
                        <h3>Bonafide Certificate</h3>
                        <p style="color: var(--text-secondary); font-size: 14px;">Request student certificate</p>
                    </div>
                </div>
                <div class="content-card" onclick="openModal('leaveModal')" style="cursor: pointer;">
                    <div style="text-align: center;">
                        <div style="font-size: 48px; margin-bottom: 10px;">🏖️</div>
                        <h3>Leave Application</h3>
                        <p style="color: var(--text-secondary); font-size: 14px;">Apply for leave</p>
                    </div>
                </div>
                <div class="content-card" onclick="openModal('complaintModal')" style="cursor: pointer;">
                    <div style="text-align: center;">
                        <div style="font-size: 48px; margin-bottom: 10px;">📝</div>
                        <h3>Complaint</h3>
                        <p style="color: var(--text-secondary); font-size: 14px;">Register complaint</p>
                    </div>
                </div>
                <div class="content-card" onclick="openModal('reevalModal')" style="cursor: pointer;">
                    <div style="text-align: center;">
                        <div style="font-size: 48px; margin-bottom: 10px;">🔄</div>
                        <h3>Re-evaluation</h3>
                        <p style="color: var(--text-secondary); font-size: 14px;">Request re-evaluation</p>
                    </div>
                </div>
            </div>
            
            <!-- My Requests History -->
            <div class="content-card">
                <div class="card-header">
                    <h3>📋 Request History</h3>
                    <select class="form-control" style="width: auto;" onchange="filterRequests(this.value)">
                        <option value="all">All Status</option>
                        <option value="pending">Pending</option>
                        <option value="approved">Approved</option>
                        <option value="rejected">Rejected</option>
                    </select>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Request ID</th>
                                <th>Type</th>
                                <th>Subject</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Remarks</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>#REQ001</td>
                                <td><span class="badge badge-info">Bonafide</span></td>
                                <td>Student Certificate Request</td>
                                <td>15 Jan 2026</td>
                                <td><span class="badge badge-success">Approved</span></td>
                                <td>Approved by HOD</td>
                                <td><button class="btn btn-sm btn-success" onclick="downloadCert('REQ001')">📥 Download</button></td>
                            </tr>
                            <tr>
                                <td>#REQ002</td>
                                <td><span class="badge badge-warning">Leave</span></td>
                                <td>Sick Leave - 3 days</td>
                                <td>12 Jan 2026</td>
                                <td><span class="badge badge-warning">Pending</span></td>
                                <td>Under review by Faculty</td>
                                <td><button class="btn btn-sm btn-secondary" onclick="viewRequest('REQ002')">👁️ View</button></td>
                            </tr>
                            <tr>
                                <td>#REQ003</td>
                                <td><span class="badge badge-danger">Complaint</span></td>
                                <td>Library Book Issue</td>
                                <td>10 Jan 2026</td>
                                <td><span class="badge badge-success">Resolved</span></td>
                                <td>Issue resolved successfully</td>
                                <td><button class="btn btn-sm btn-secondary" onclick="viewRequest('REQ003')">👁️ View</button></td>
                            </tr>
                            <tr>
                                <td>#REQ004</td>
                                <td><span class="badge badge-info">Bonafide</span></td>
                                <td>Bank Loan Certificate</td>
                                <td>08 Jan 2026</td>
                                <td><span class="badge badge-success">Approved</span></td>
                                <td>Issued on 09 Jan 2026</td>
                                <td><button class="btn btn-sm btn-success" onclick="downloadCert('REQ004')">📥 Download</button></td>
                            </tr>
                            <tr>
                                <td>#REQ005</td>
                                <td><span class="badge badge-danger">Complaint</span></td>
                                <td>Classroom AC Not Working</td>
                                <td>05 Jan 2026</td>
                                <td><span class="badge badge-danger">Rejected</span></td>
                                <td>Already reported to maintenance</td>
                                <td><button class="btn btn-sm btn-secondary" onclick="viewRequest('REQ005')">👁️ View</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
    
    <!-- Bonafide Certificate Modal -->
    <div id="bonafideModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>📜 Request Bonafide Certificate</h3>
                <span class="modal-close" onclick="closeModal('bonafideModal')">&times;</span>
            </div>
            <form onsubmit="return submitBonafide(event)">
                <div class="form-group">
                    <label>Purpose</label>
                    <select class="form-control" required>
                        <option value="">-- Select Purpose --</option>
                        <option value="bank">Bank Loan</option>
                        <option value="passport">Passport Application</option>
                        <option value="scholarship">Scholarship</option>
                        <option value="other">Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Additional Details</label>
                    <textarea class="form-control" rows="3" placeholder="Mention any specific requirements..."></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Submit Request</button>
            </form>
        </div>
    </div>
    
    <!-- Leave Application Modal -->
    <div id="leaveModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>🏖️ Leave Application</h3>
                <span class="modal-close" onclick="closeModal('leaveModal')">&times;</span>
            </div>
            <form onsubmit="return submitLeave(event)">
                <div class="form-group">
                    <label>Leave Type</label>
                    <select class="form-control" required>
                        <option value="">-- Select Type --</option>
                        <option value="sick">Sick Leave</option>
                        <option value="casual">Casual Leave</option>
                        <option value="emergency">Emergency Leave</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>From Date</label>
                    <input type="date" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>To Date</label>
                    <input type="date" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Reason</label>
                    <textarea class="form-control" rows="3" placeholder="Explain your reason..." required></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Submit Application</button>
            </form>
        </div>
    </div>
    
    <!-- Complaint Modal -->
    <div id="complaintModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>📝 Register Complaint</h3>
                <span class="modal-close" onclick="closeModal('complaintModal')">&times;</span>
            </div>
            <form onsubmit="return submitComplaint(event)">
                <div class="form-group">
                    <label>Category</label>
                    <select class="form-control" required>
                        <option value="">-- Select Category --</option>
                        <option value="infrastructure">Infrastructure</option>
                        <option value="faculty">Faculty Related</option>
                        <option value="hostel">Hostel</option>
                        <option value="library">Library</option>
                        <option value="canteen">Canteen</option>
                        <option value="other">Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Subject</label>
                    <input type="text" class="form-control" placeholder="Brief subject" required>
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <textarea class="form-control" rows="4" placeholder="Describe your complaint in detail..." required></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Submit Complaint</button>
            </form>
        </div>
    </div>
    
    <!-- Re-evaluation Modal -->
    <div id="reevalModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>🔄 Request Re-evaluation</h3>
                <span class="modal-close" onclick="closeModal('reevalModal')">&times;</span>
            </div>
            <form onsubmit="return submitReeval(event)">
                <div class="form-group">
                    <label>Semester</label>
                    <select class="form-control" required>
                        <option value="">-- Select Semester --</option>
                        <option value="4">Semester 4</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Subject</label>
                    <select class="form-control" required>
                        <option value="">-- Select Subject --</option>
                        <option value="java">Java Programming</option>
                        <option value="dsa">Data Structures</option>
                        <option value="dbms">DBMS</option>
                        <option value="web">Web Technologies</option>
                        <option value="os">Operating Systems</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Reason for Re-evaluation</label>
                    <textarea class="form-control" rows="3" placeholder="Explain why you need re-evaluation..." required></textarea>
                </div>
                <div class="alert alert-info">
                    <strong>Note:</strong> Re-evaluation fee of ₹500 per subject will be applicable.
                </div>
                <button type="submit" class="btn btn-primary">Submit Request</button>
            </form>
        </div>
    </div>
    
    <script>
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

// Request form submissions
function submitBonafide(event) {
    event.preventDefault();
    alert('✅ Bonafide certificate request submitted successfully!');
    closeModal('bonafideModal');
    showNotification('Request submitted! You will be notified once processed.', 'success');
    setTimeout(() => location.reload(), 1500);
    return false;
}

function submitLeave(event) {
    event.preventDefault();
    alert('✅ Leave application submitted successfully!');
    closeModal('leaveModal');
    showNotification('Leave application submitted for approval.', 'success');
    setTimeout(() => location.reload(), 1500);
    return false;
}

function submitComplaint(event) {
    event.preventDefault();
    alert('✅ Complaint registered successfully!');
    closeModal('complaintModal');
    showNotification('Complaint registered. Tracking ID: #CMP' + Date.now(), 'success');
    setTimeout(() => location.reload(), 1500);
    return false;
}

function submitReeval(event) {
    event.preventDefault();
    alert('✅ Re-evaluation request submitted!');
    closeModal('reevalModal');
    showNotification('Re-evaluation request submitted successfully!', 'success');
    setTimeout(() => location.reload(), 1500);
    return false;
}

function downloadCert(id) {
    alert('Downloading certificate for request: ' + id);
    showNotification('Certificate downloaded successfully!', 'success');
}

function viewRequest(id) {
    alert('Viewing request details: ' + id);
}

function filterRequests(status) {
    const rows = document.querySelectorAll('.table-container tbody tr');
    
    rows.forEach(row => {
        const statusCell = row.querySelector('td:nth-child(5)');
        if (!statusCell) return;
        
        const statusBadge = statusCell.querySelector('.badge');
        if (!statusBadge) return;
        
        const statusText = statusBadge.textContent.trim().toLowerCase();
        
        if (status === 'all') {
            row.style.display = '';
        } else if (status === 'pending' && statusText === 'pending') {
            row.style.display = '';
        } else if (status === 'approved' && (statusText === 'approved' || statusText === 'resolved')) {
            row.style.display = '';
        } else if (status === 'rejected' && statusText === 'rejected') {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}
    </script>
</body>
</html>

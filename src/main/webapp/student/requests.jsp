<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Requests - Student Portal</title>
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
                <li><a href="internal-marks.jsp"><i>📊</i> Internal Marks</a></li>
                <li><a href="exam.jsp"><i>📋</i> Exam</a></li>
                <li><a href="results.jsp"><i>🏆</i> Results</a></li>
                <li><a href="requests.jsp" class="active"><i>📄</i> Requests</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="#" onclick="logout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>📄 My Requests</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">🔔<span class="notification-badge">5</span></div>
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
    
    <script src="../js/main.js"></script>
    <script>
        SessionManager.checkAuth();
        
        function submitBonafide(event) {
            event.preventDefault();
            alert('✅ Bonafide certificate request submitted successfully!');
            closeModal('bonafideModal');
            NotificationManager.add('Request submitted! You will be notified once processed.', 'success');
            setTimeout(() => location.reload(), 1500);
            return false;
        }
        
        function submitLeave(event) {
            event.preventDefault();
            alert('✅ Leave application submitted successfully!');
            closeModal('leaveModal');
            NotificationManager.add('Leave application submitted for approval.', 'success');
            setTimeout(() => location.reload(), 1500);
            return false;
        }
        
        function submitComplaint(event) {
            event.preventDefault();
            alert('✅ Complaint registered successfully!');
            closeModal('complaintModal');
            NotificationManager.add('Complaint registered. Tracking ID: #CMP' + Date.now(), 'success');
            setTimeout(() => location.reload(), 1500);
            return false;
        }
        
        function submitReeval(event) {
            event.preventDefault();
            alert('✅ Re-evaluation request submitted!');
            closeModal('reevalModal');
            NotificationManager.add('Re-evaluation request submitted successfully!', 'success');
            setTimeout(() => location.reload(), 1500);
            return false;
        }
        
        function downloadCert(id) {
            alert('Downloading certificate for request: ' + id);
            NotificationManager.add('Certificate downloaded successfully!', 'success');
        }
        
        function viewRequest(id) {
            alert('Viewing request details: ' + id);
        }
        
        function filterRequests(status) {
            console.log('Filtering by:', status);
        }
    </script>
</body>
</html>

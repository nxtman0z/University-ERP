<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exam - Student Portal</title>
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
                <li><a href="exam.jsp" class="active"><i>📋</i> Exam</a></li>
                <li><a href="results.jsp"><i>🏆</i> Results</a></li>
                <li><a href="requests.jsp"><i>📄</i> Requests</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="#" onclick="logout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>📋 Examination</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">🔔<span class="notification-badge">5</span></div>
                    <div class="user-info">
                        <div class="user-avatar">S</div>
                        <span class="user-name">Student</span>
                    </div>
                </div>
            </nav>
            
            <!-- Exam Form Status -->
            <div class="alert alert-success">
                <strong>✅ Exam Form Submitted:</strong> Your Semester 4 exam form has been submitted successfully. Admit card will be available soon.
            </div>
            
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
                <div style="padding: 20px; background: var(--light); border-radius: 10px; margin-top: 15px;">
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
                <div style="padding: 20px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 10px; color: white; margin-top: 15px;">
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
                        <tbody>
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
        
        function downloadAdmitCard() {
            alert('📥 Downloading Admit Card...');
            NotificationManager.add('Admit card downloaded successfully!', 'success');
        }
        
        function viewFormDetails() {
            alert('Viewing exam form details...');
        }
        
        function downloadReceipt() {
            alert('📥 Downloading exam fee receipt...');
            NotificationManager.add('Receipt downloaded!', 'success');
        }
    </script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Student Portal</title>
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
                <li><a href="profile.jsp" class="active"><i>👤</i> My Profile</a></li>
                <li><a href="attendance.jsp"><i>📅</i> Attendance</a></li>
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
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>👤 My Profile</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">🔔<span class="notification-badge">5</span></div>
                    <div class="user-info">
                        <div class="user-avatar">S</div>
                        <span class="user-name">Student</span>
                    </div>
                </div>
            </nav>
            
            <div class="dashboard-grid">
                <!-- Profile Card -->
                <div class="content-card" style="grid-column: span 2;">
                    <div style="display: flex; gap: 30px; align-items: start;">
                        <div style="width: 150px; height: 150px; background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)); border-radius: 15px; display: flex; align-items: center; justify-content: center; color: white; font-size: 64px; flex-shrink: 0;">
                            👨‍🎓
                        </div>
                        <div style="flex: 1;">
                            <h2 style="color: var(--primary-color); margin-bottom: 10px;">Rahul Kumar</h2>
                            <p style="color: var(--text-secondary); margin-bottom: 20px;">BCA Semester 4 • Computer Science Department</p>
                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">
                                <div>
                                    <strong>Roll Number:</strong><br>
                                    <span style="color: var(--text-secondary);">BCA2024001</span>
                                </div>
                                <div>
                                    <strong>Enrollment No:</strong><br>
                                    <span style="color: var(--text-secondary);">UNIV2024BCA001</span>
                                </div>
                                <div>
                                    <strong>Email:</strong><br>
                                    <span style="color: var(--text-secondary);">rahul.kumar@university.edu</span>
                                </div>
                                <div>
                                    <strong>Mobile:</strong><br>
                                    <span style="color: var(--text-secondary);">+91 98765 43210</span>
                                </div>
                            </div>
                            <div style="margin-top: 20px;">
                                <button class="btn btn-primary" onclick="editProfile()">✏️ Edit Profile</button>
                                <button class="btn btn-secondary" onclick="changePassword()">🔒 Change Password</button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Stats -->
                <div class="stat-card">
                    <div class="stat-card-value" style="color: var(--success-color);">8.7</div>
                    <div class="stat-card-label">Current CGPA</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value" style="color: var(--primary-color);">83.5%</div>
                    <div class="stat-card-label">Attendance</div>
                </div>
            </div>
            
            <!-- Personal Information -->
            <div class="content-card">
                <div class="card-header">
                    <h3>📋 Personal Information</h3>
                </div>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin-top: 15px;">
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Full Name</label>
                        <p style="margin-top: 5px; font-size: 15px;">Rahul Kumar</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Date of Birth</label>
                        <p style="margin-top: 5px; font-size: 15px;">15 March 2005</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Gender</label>
                        <p style="margin-top: 5px; font-size: 15px;">Male</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Blood Group</label>
                        <p style="margin-top: 5px; font-size: 15px;">O+ Positive</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Category</label>
                        <p style="margin-top: 5px; font-size: 15px;">General</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Nationality</label>
                        <p style="margin-top: 5px; font-size: 15px;">Indian</p>
                    </div>
                </div>
            </div>
            
            <!-- Contact Information -->
            <div class="content-card">
                <div class="card-header">
                    <h3>📞 Contact Information</h3>
                </div>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin-top: 15px;">
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Email Address</label>
                        <p style="margin-top: 5px; font-size: 15px;">rahul.kumar@university.edu</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Mobile Number</label>
                        <p style="margin-top: 5px; font-size: 15px;">+91 98765 43210</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Alternate Number</label>
                        <p style="margin-top: 5px; font-size: 15px;">+91 98765 43211</p>
                    </div>
                    <div style="grid-column: span 2;">
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Permanent Address</label>
                        <p style="margin-top: 5px; font-size: 15px;">123, MG Road, Sector 15, New Delhi - 110001, India</p>
                    </div>
                    <div style="grid-column: span 2;">
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Current Address</label>
                        <p style="margin-top: 5px; font-size: 15px;">University Hostel, Room 204, Block A</p>
                    </div>
                </div>
            </div>
            
            <!-- Academic Details -->
            <div class="content-card">
                <div class="card-header">
                    <h3>🎓 Academic Details</h3>
                </div>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin-top: 15px;">
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Course</label>
                        <p style="margin-top: 5px; font-size: 15px;">Bachelor of Computer Applications (BCA)</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Department</label>
                        <p style="margin-top: 5px; font-size: 15px;">Computer Science</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Current Semester</label>
                        <p style="margin-top: 5px; font-size: 15px;">Semester 4</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Batch</label>
                        <p style="margin-top: 5px; font-size: 15px;">2024-2027</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Admission Date</label>
                        <p style="margin-top: 5px; font-size: 15px;">01 August 2024</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Current CGPA</label>
                        <p style="margin-top: 5px; font-size: 15px;"><strong style="color: var(--success-color);">8.7 / 10.0</strong></p>
                    </div>
                </div>
            </div>
            
            <!-- Parent/Guardian Details -->
            <div class="content-card">
                <div class="card-header">
                    <h3>👨‍👩‍👦 Parent/Guardian Details</h3>
                </div>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin-top: 15px;">
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Father's Name</label>
                        <p style="margin-top: 5px; font-size: 15px;">Mr. Suresh Kumar</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Father's Occupation</label>
                        <p style="margin-top: 5px; font-size: 15px;">Business</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Father's Mobile</label>
                        <p style="margin-top: 5px; font-size: 15px;">+91 98765 00001</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Mother's Name</label>
                        <p style="margin-top: 5px; font-size: 15px;">Mrs. Sunita Kumar</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Mother's Occupation</label>
                        <p style="margin-top: 5px; font-size: 15px;">Teacher</p>
                    </div>
                    <div>
                        <label style="font-weight: 600; color: var(--text-secondary); font-size: 13px;">Mother's Mobile</label>
                        <p style="margin-top: 5px; font-size: 15px;">+91 98765 00002</p>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <script src="../js/main.js"></script>
    <script>
        SessionManager.checkAuth();
        
        function editProfile() {
            alert('Edit profile functionality - Update limited information');
        }
        
        function changePassword() {
            window.location.href = '../change-password.jsp';
        }
    </script>
</body>
</html>

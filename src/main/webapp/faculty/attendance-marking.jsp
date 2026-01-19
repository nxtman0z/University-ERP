<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mark Attendance - Faculty Portal</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="dashboard-container">
        <aside class="sidebar">
            <div class="sidebar-header">
                <h2>👨‍🏫 Faculty Portal</h2>
                <p>University ERP</p>
            </div>
            <ul class="sidebar-menu">
                <li><a href="dashboard.jsp"><i>📊</i> Dashboard</a></li>
                <li><a href="profile.jsp"><i>👤</i> My Profile</a></li>
                <li><a href="attendance-marking.jsp" class="active"><i>📅</i> Mark Attendance</a></li>
                <li><a href="view-attendance.jsp"><i>📊</i> View Attendance</a></li>
                <li><a href="assignments.jsp"><i>📝</i> Assignments</a></li>
                <li><a href="marks-entry.jsp"><i>✏️</i> Marks Entry</a></li>
                <li><a href="students.jsp"><i>👥</i> My Students</a></li>
                <li><a href="timetable.jsp"><i>🕐</i> My Timetable</a></li>
                <li><a href="approvals.jsp"><i>✅</i> Approvals</a></li>
                <li><a href="notices.jsp"><i>📢</i> Notices</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="#" onclick="logout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>📅 Mark Attendance</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">🔔<span class="notification-badge">8</span></div>
                    <div class="user-info">
                        <div class="user-avatar">F</div>
                        <span class="user-name">Faculty</span>
                    </div>
                </div>
            </nav>
            
            <div class="content-card">
                <h3 style="margin-bottom: 20px;">Select Class & Subject</h3>
                <form id="attendanceForm">
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 20px;">
                        <div class="form-group">
                            <label>Select Class</label>
                            <select class="form-control" id="classSelect" required onchange="loadStudents()">
                                <option value="">-- Select Class --</option>
                                <option value="BCA4">BCA Semester 4</option>
                                <option value="BCA6">BCA Semester 6</option>
                                <option value="BTECH6">BTech CSE Semester 6</option>
                                <option value="BTECH8">BTech CSE Semester 8</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Select Subject</label>
                            <select class="form-control" id="subjectSelect" required onchange="loadStudents()">
                                <option value="">-- Select Subject --</option>
                                <option value="Java">Java Programming</option>
                                <option value="DSA">Data Structures</option>
                                <option value="DBMS">Database Management</option>
                                <option value="Web">Web Technologies</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Date</label>
                            <input type="date" class="form-control" id="attendanceDate" required>
                        </div>
                        <div class="form-group">
                            <label>Lecture Type</label>
                            <select class="form-control" required>
                                <option value="theory">Theory</option>
                                <option value="practical">Practical</option>
                                <option value="tutorial">Tutorial</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            
            <div class="content-card" id="studentsList" style="display: none;">
                <div class="card-header">
                    <h3>👥 Mark Student Attendance</h3>
                    <div>
                        <button class="btn btn-sm btn-success" onclick="markAllPresent()">✅ Mark All Present</button>
                        <button class="btn btn-sm btn-danger" onclick="markAllAbsent()">❌ Mark All Absent</button>
                    </div>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Roll No</th>
                                <th>Student Name</th>
                                <th>Current Attendance %</th>
                                <th style="text-align: center;">Mark Attendance</th>
                            </tr>
                        </thead>
                        <tbody id="studentsTableBody">
                            <!-- Students will be loaded here -->
                        </tbody>
                    </table>
                </div>
                <div style="margin-top: 20px; text-align: center;">
                    <button class="btn btn-primary" onclick="submitAttendance()">💾 Submit Attendance</button>
                    <button class="btn btn-secondary" onclick="resetForm()">🔄 Reset</button>
                </div>
            </div>
        </main>
    </div>
    
    <script src="../js/main.js"></script>
    <script>
        SessionManager.checkAuth();
        
        // Set today's date as default
        document.getElementById('attendanceDate').valueAsDate = new Date();
        
        const demoStudents = [
            { rollNo: 'BCA001', name: 'Rahul Kumar', attendance: 84 },
            { rollNo: 'BCA002', name: 'Priya Sharma', attendance: 90 },
            { rollNo: 'BCA003', name: 'Amit Singh', attendance: 78 },
            { rollNo: 'BCA004', name: 'Sneha Patel', attendance: 88 },
            { rollNo: 'BCA005', name: 'Vijay Reddy', attendance: 72 },
            { rollNo: 'BCA006', name: 'Pooja Gupta', attendance: 85 },
            { rollNo: 'BCA007', name: 'Ravi Kumar', attendance: 80 },
            { rollNo: 'BCA008', name: 'Anjali Mehta', attendance: 92 },
            { rollNo: 'BCA009', name: 'Suresh Yadav', attendance: 76 },
            { rollNo: 'BCA010', name: 'Kavita Jain', attendance: 89 }
        ];
        
        function loadStudents() {
            const classSelect = document.getElementById('classSelect').value;
            const subjectSelect = document.getElementById('subjectSelect').value;
            
            if (classSelect && subjectSelect) {
                document.getElementById('studentsList').style.display = 'block';
                const tbody = document.getElementById('studentsTableBody');
                tbody.innerHTML = '';
                
                demoStudents.forEach((student, index) => {
                    const statusColor = student.attendance >= 75 ? 'var(--success-color)' : 'var(--danger-color)';
                    const row = `
                        <tr>
                            <td>${student.rollNo}</td>
                            <td><strong>${student.name}</strong></td>
                            <td><strong style="color: ${statusColor}">${student.attendance}%</strong></td>
                            <td style="text-align: center;">
                                <label style="margin-right: 20px;">
                                    <input type="radio" name="attendance_${index}" value="present" checked>
                                    <span style="color: var(--success-color); font-weight: bold;"> ✅ Present</span>
                                </label>
                                <label>
                                    <input type="radio" name="attendance_${index}" value="absent">
                                    <span style="color: var(--danger-color); font-weight: bold;"> ❌ Absent</span>
                                </label>
                            </td>
                        </tr>
                    `;
                    tbody.innerHTML += row;
                });
            }
        }
        
        function markAllPresent() {
            document.querySelectorAll('input[type="radio"][value="present"]').forEach(radio => {
                radio.checked = true;
            });
            NotificationManager.add('All students marked present', 'success');
        }
        
        function markAllAbsent() {
            if (confirm('Are you sure you want to mark all students absent?')) {
                document.querySelectorAll('input[type="radio"][value="absent"]').forEach(radio => {
                    radio.checked = true;
                });
                NotificationManager.add('All students marked absent', 'warning');
            }
        }
        
        function submitAttendance() {
            if (!document.getElementById('classSelect').value || !document.getElementById('subjectSelect').value) {
                alert('Please select class and subject first!');
                return;
            }
            
            if (confirm('Are you sure you want to submit this attendance?')) {
                alert('✅ Attendance submitted successfully!');
                NotificationManager.add('Attendance recorded successfully!', 'success');
                setTimeout(() => {
                    window.location.href = 'dashboard.jsp';
                }, 1500);
            }
        }
        
        function resetForm() {
            document.getElementById('attendanceForm').reset();
            document.getElementById('studentsList').style.display = 'none';
            document.getElementById('attendanceDate').valueAsDate = new Date();
        }
    </script>
</body>
</html>

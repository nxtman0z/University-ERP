<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management - Admin Portal</title>
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
                <li><a href="dashboard.jsp"><i>📊</i> Dashboard</a></li>
                <li><a href="students.jsp" class="active"><i>👨‍🎓</i> Student Management</a></li>
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
                <h1>👨‍🎓 Student Management</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">🔔<span class="notification-badge">12</span></div>
                    <div class="user-info">
                        <div class="user-avatar">A</div>
                        <span class="user-name">Admin</span>
                    </div>
                </div>
            </nav>
            
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-card-value">2,547</div>
                    <div class="stat-card-label">Total Students</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value" style="color: var(--success-color);">125</div>
                    <div class="stat-card-label">New Admissions</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value" style="color: var(--danger-color);">15</div>
                    <div class="stat-card-label">Pending Approvals</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value">12</div>
                    <div class="stat-card-label">Departments</div>
                </div>
            </div>
            
            <div class="content-card">
                <div class="card-header">
                    <h3>📋 All Students</h3>
                    <div style="display: flex; gap: 10px;">
                        <input type="text" id="searchInput" class="form-control" placeholder="Search students..." 
                               style="width: 300px;" onkeyup="filterTable('searchInput', 'studentTable')">
                        <button class="btn btn-primary" onclick="openModal('addStudentModal')">➕ Add Student</button>
                        <button class="btn btn-success" onclick="exportTableToCSV('studentTable', 'students')">📥 Export</button>
                    </div>
                </div>
                <div class="table-container">
                    <table id="studentTable">
                        <thead>
                            <tr>
                                <th>Roll No</th>
                                <th>Name</th>
                                <th>Department</th>
                                <th>Semester</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>BCA001</td>
                                <td><strong>Rahul Kumar</strong></td>
                                <td>BCA</td>
                                <td>6</td>
                                <td>rahul@university.edu</td>
                                <td>+91 98765 43210</td>
                                <td><span class="badge badge-success">Active</span></td>
                                <td>
                                    <button class="btn btn-sm btn-secondary" onclick="viewStudent('BCA001')">👁️</button>
                                    <button class="btn btn-sm btn-primary" onclick="editStudent('BCA001')">✏️</button>
                                    <button class="btn btn-sm btn-danger" onclick="deleteStudent('BCA001')">🗑️</button>
                                </td>
                            </tr>
                            <tr>
                                <td>BCA002</td>
                                <td><strong>Priya Sharma</strong></td>
                                <td>BCA</td>
                                <td>6</td>
                                <td>priya@university.edu</td>
                                <td>+91 98765 43211</td>
                                <td><span class="badge badge-success">Active</span></td>
                                <td>
                                    <button class="btn btn-sm btn-secondary" onclick="viewStudent('BCA002')">👁️</button>
                                    <button class="btn btn-sm btn-primary" onclick="editStudent('BCA002')">✏️</button>
                                    <button class="btn btn-sm btn-danger" onclick="deleteStudent('BCA002')">🗑️</button>
                                </td>
                            </tr>
                            <tr>
                                <td>BTECH001</td>
                                <td><strong>Amit Singh</strong></td>
                                <td>B.Tech CSE</td>
                                <td>8</td>
                                <td>amit@university.edu</td>
                                <td>+91 98765 43212</td>
                                <td><span class="badge badge-success">Active</span></td>
                                <td>
                                    <button class="btn btn-sm btn-secondary" onclick="viewStudent('BTECH001')">👁️</button>
                                    <button class="btn btn-sm btn-primary" onclick="editStudent('BTECH001')">✏️</button>
                                    <button class="btn btn-sm btn-danger" onclick="deleteStudent('BTECH001')">🗑️</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
    
    <!-- Add Student Modal -->
    <div id="addStudentModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>➕ Add New Student</h3>
                <span class="modal-close" onclick="closeModal('addStudentModal')">&times;</span>
            </div>
            <form onsubmit="return addStudent(event)">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Phone</label>
                    <input type="tel" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Department</label>
                    <select class="form-control" required>
                        <option value="">Select Department</option>
                        <option value="BCA">BCA</option>
                        <option value="BTECH">B.Tech CSE</option>
                        <option value="MCA">MCA</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Semester</label>
                    <select class="form-control" required>
                        <option value="">Select Semester</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Add Student</button>
            </form>
        </div>
    </div>
    
    <script src="../js/main.js"></script>
    <script>
        SessionManager.checkAuth();
        
        function addStudent(event) {
            event.preventDefault();
            alert('✅ Student added successfully!');
            closeModal('addStudentModal');
            NotificationManager.add('New student registered successfully!', 'success');
            return false;
        }
        
        function viewStudent(id) {
            alert('Viewing student: ' + id);
        }
        
        function editStudent(id) {
            alert('Editing student: ' + id);
        }
        
        function deleteStudent(id) {
            if (confirm('Are you sure you want to delete this student?')) {
                alert('Student deleted: ' + id);
                NotificationManager.add('Student removed successfully!', 'warning');
            }
        }
    </script>
</body>
</html>

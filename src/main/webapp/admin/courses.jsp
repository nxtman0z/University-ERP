<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses & Subjects - Admin Portal</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        :root {
            --primary-color: #C8A951;
            --dark-bg: #0A1929;
            --card-bg: #1A2332;
            --sidebar-bg: #0D1B2A;
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
        
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-secondary);
        }
        
        .empty-state-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
        
        .empty-state-text {
            font-size: 1.125rem;
            margin-bottom: 0.5rem;
        }
        
        .empty-state-subtext {
            font-size: 0.875rem;
            opacity: 0.7;
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
        
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.4);
        }
        
        .form-control {
            padding: 0.625rem;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-primary);
            font-size: 0.875rem;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            background: rgba(255, 255, 255, 0.08);
        }
        
        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--card-bg);
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
            white-space: nowrap;
            background: rgba(200, 169, 81, 0.05);
        }
        
        td {
            color: var(--text-primary);
            font-size: 0.875rem;
            vertical-align: middle;
        }
        
        tr:hover {
            background: rgba(200, 169, 81, 0.03);
        }
        
        tbody tr:last-child td {
            border-bottom: none;
        }
        
        .action-btns button {
            margin-right: 0.5rem;
            cursor: pointer;
            background: transparent;
            border: none;
            font-size: 1.2rem;
            padding: 0.25rem;
        }
        
        .action-btns button:hover {
            transform: scale(1.2);
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
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        
        .modal.active {
            display: flex;
        }
        
        .modal-content {
            background: var(--card-bg);
            border-radius: 12px;
            padding: 0;
            max-width: 600px;
            width: 90%;
            max-height: 85vh;
            display: flex;
            flex-direction: column;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
            border: 1px solid var(--border-color);
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--border-color);
            flex-shrink: 0;
        }
        
        .modal-header h2 {
            color: var(--primary-color);
            margin: 0;
            font-size: 1.5rem;
        }
        
        .modal-close {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--text-secondary);
            padding: 0;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
        }
        
        .modal-close:hover {
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
        }
        
        .modal-body {
            padding: 2rem;
            overflow-y: auto;
            flex: 1;
        }
        
        .info-group {
            margin-bottom: 1.25rem;
        }
        
        .info-label {
            display: block;
            color: var(--text-secondary);
            font-size: 0.75rem;
            text-transform: uppercase;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }
        
        .info-value {
            color: var(--text-primary);
            font-size: 1rem;
            padding: 0.75rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 6px;
            border: 1px solid var(--border-color);
        }
        
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            padding: 1.5rem 2rem;
            border-top: 1px solid var(--border-color);
            flex-shrink: 0;
            background: var(--card-bg);
        }
        
        .form-group {
            margin-bottom: 1.25rem;
        }
        
        .form-label {
            display: block;
            color: var(--text-secondary);
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        
        .form-input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-primary);
            font-size: 0.875rem;
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--primary-color);
            background: rgba(255, 255, 255, 0.08);
        }
        
        select.form-input {
            cursor: pointer;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%23C8A951' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 0.75rem center;
            background-size: 1em;
            padding-right: 2.5rem;
        }
        
        select.form-input option {
            background: var(--card-bg);
            color: var(--text-primary);
            padding: 0.5rem;
        }
        
        select.form-input option:hover,
        select.form-input option:checked {
            background: rgba(200, 169, 81, 0.2);
            color: var(--primary-color);
        }
        
        .modal-body::-webkit-scrollbar {
            width: 8px;
        }
        
        .modal-body::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 4px;
        }
        
        .modal-body::-webkit-scrollbar-thumb {
            background: var(--primary-color);
            border-radius: 4px;
        }

        .badge {
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-block;
        }

        .badge-success {
            background: rgba(76, 175, 80, 0.2);
            color: var(--success-color);
        }

        .badge-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-secondary);
        }

        .badge-warning {
            background: rgba(255, 152, 0, 0.2);
            color: var(--warning-color);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px);
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
                <li><a href="dashboard.html"><i>📊</i> Dashboard</a></li>
                <li><a href="students.html"><i>👨‍🎓</i> Student Management</a></li>
                <li><a href="faculty.html"><i>👨‍🏫</i> Faculty Management</a></li>
                <li><a href="departments.html"><i>🏢</i> Departments</a></li>
                <li><a href="courses.jsp" class="active"><i>📚</i> Courses & Subjects</a></li>
                <li><a href="fees.html"><i>💰</i> Fee Management</a></li>
                <li><a href="exams.html"><i>📋</i> Exam Management</a></li>
                <li><a href="library-passes.html"><i>📚</i> Library Passes</a></li>
                <li><a href="users.html"><i>👤</i> User Accounts</a></li>
                <li><a href="reports.html"><i>📈</i> Reports</a></li>
                <li><a href="complaints.jsp"><i>📝</i> Complaints</a></li>
                <li><a href="notices.html"><i>📢</i> Notice Board</a></li>
                <li><a href="notifications.html"><i>🔔</i> Notifications</a></li>
                <li><a href="../index.html" onclick="return logout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>📚 Courses & Subjects Management</h1>
                <div class="top-nav-right">
                    <div class="notification-icon" onclick="window.location.href='notifications.html'">
                        🔔<span class="notification-badge">0</span>
                    </div>
                    <div class="user-info">
                        <div class="user-avatar">A</div>
                        <span class="user-name">Admin</span>
                    </div>
                </div>
            </nav>
            
            <div class="content-card">
                <div class="card-header">
                    <h3>📚 All Courses</h3>
                    <div style="display: flex; gap: 10px;">
                        <input type="text" id="searchInput" class="form-control" placeholder="Search courses..." style="width: 300px;">
                        <button class="btn btn-primary" onclick="addCourse()">➕ Add Course</button>
                        <button class="btn btn-success" onclick="exportData()">📥 Export</button>
                    </div>
                </div>
                
                <table>
                    <thead>
                        <tr>
                            <th>Course Code</th>
                            <th>Course Name</th>
                            <th>Department</th>
                            <th>Semester</th>
                            <th>Credits</th>
                            <th>Duration</th>
                            <th>Faculty Assigned</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
    
    <!-- View Course Modal -->
    <div id="viewModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>👁️ View Course Details</h2>
                <button class="modal-close" onclick="closeModal('viewModal')">✕</button>
            </div>
            <div class="modal-body">
                <div class="info-group">
                    <span class="info-label">Course Code</span>
                    <div class="info-value" id="viewCourseCode"></div>
                </div>
                <div class="info-group">
                    <span class="info-label">Course Name</span>
                    <div class="info-value" id="viewCourseName"></div>
                </div>
                <div class="info-group">
                    <span class="info-label">Department</span>
                    <div class="info-value" id="viewDept"></div>
                </div>
                <div class="info-group">
                    <span class="info-label">Semester</span>
                    <div class="info-value" id="viewSemester"></div>
                </div>
                <div class="info-group">
                    <span class="info-label">Credits</span>
                    <div class="info-value" id="viewCredits"></div>
                </div>
                <div class="info-group">
                    <span class="info-label">Duration</span>
                    <div class="info-value" id="viewDuration"></div>
                </div>
                <div class="info-group">
                    <span class="info-label">Faculty Assigned</span>
                    <div class="info-value" id="viewFaculty"></div>
                </div>
                <div class="info-group">
                    <span class="info-label">Status</span>
                    <div class="info-value" id="viewStatus"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeModal('viewModal')">Close</button>
            </div>
        </div>
    </div>
    
    <!-- Edit Course Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>✏️ Edit Course Details</h2>
                <button class="modal-close" onclick="closeModal('editModal')">✕</button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label class="form-label">Course Code</label>
                    <input type="text" id="editCourseCode" class="form-input" readonly>
                </div>
                <div class="form-group">
                    <label class="form-label">Course Name</label>
                    <input type="text" id="editCourseName" class="form-input">
                </div>
                <div class="form-group">
                    <label class="form-label">Department</label>
                    <select id="editDept" class="form-input">
                        <option value="Computer Science">Computer Science</option>
                        <option value="Business Administration">Business Administration</option>
                        <option value="Electronics Engineering">Electronics Engineering</option>
                        <option value="Mechanical Engineering">Mechanical Engineering</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Semester</label>
                    <select id="editSemester" class="form-input">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Credits</label>
                    <input type="number" id="editCredits" class="form-input" min="1" max="6">
                </div>
                <div class="form-group">
                    <label class="form-label">Duration</label>
                    <input type="text" id="editDuration" class="form-input">
                </div>
                <div class="form-group">
                    <label class="form-label">Faculty Assigned</label>
                    <input type="text" id="editFaculty" class="form-input">
                </div>
                <div class="form-group">
                    <label class="form-label">Status</label>
                    <select id="editStatus" class="form-input">
                        <option value="Active">Active</option>
                        <option value="Upcoming">Upcoming</option>
                        <option value="Inactive">Inactive</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeModal('editModal')">Cancel</button>
                <button class="btn btn-success" onclick="saveCourse()">💾 Save Changes</button>
            </div>
        </div>
    </div>
    
    <!-- Add Course Modal -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>➕ Add New Course</h2>
                <button class="modal-close" onclick="closeModal('addModal')">✕</button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label class="form-label">Course Code</label>
                    <input type="text" id="addCourseCode" class="form-input" placeholder="e.g., CS102">
                </div>
                <div class="form-group">
                    <label class="form-label">Course Name</label>
                    <input type="text" id="addCourseName" class="form-input" placeholder="Enter course name">
                </div>
                <div class="form-group">
                    <label class="form-label">Department</label>
                    <select id="addDept" class="form-input">
                        <option value="">Select Department</option>
                        <option value="Computer Science">Computer Science</option>
                        <option value="Business Administration">Business Administration</option>
                        <option value="Electronics Engineering">Electronics Engineering</option>
                        <option value="Mechanical Engineering">Mechanical Engineering</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Semester</label>
                    <select id="addSemester" class="form-input">
                        <option value="">Select Semester</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Credits</label>
                    <input type="number" id="addCredits" class="form-input" placeholder="3" min="1" max="6">
                </div>
                <div class="form-group">
                    <label class="form-label">Duration</label>
                    <input type="text" id="addDuration" class="form-input" placeholder="3 Years">
                </div>
                <div class="form-group">
                    <label class="form-label">Faculty Assigned</label>
                    <input type="text" id="addFaculty" class="form-input" placeholder="Faculty name">
                </div>
                <div class="form-group">
                    <label class="form-label">Status</label>
                    <select id="addStatus" class="form-input">
                        <option value="Active">Active</option>
                        <option value="Upcoming">Upcoming</option>
                        <option value="Inactive">Inactive</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeModal('addModal')">Cancel</button>
                <button class="btn btn-success" onclick="saveNewCourse()">➕ Add Course</button>
            </div>
        </div>
    </div>
    
    <script>
        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                window.location.href = '../index.html';
            }
            return false;
        }
        
        function addCourse() {
            document.getElementById('addCourseCode').value = '';
            document.getElementById('addCourseName').value = '';
            document.getElementById('addDept').value = '';
            document.getElementById('addSemester').value = '';
            document.getElementById('addCredits').value = '';
            document.getElementById('addDuration').value = '';
            document.getElementById('addFaculty').value = '';
            document.getElementById('addStatus').value = 'Active';
            document.getElementById('addModal').classList.add('active');
        }
        
        function viewCourse(courseCode) {
            const courseData = {};
            
            const course = courseData[courseCode];
            if (course) {
                document.getElementById('viewCourseCode').textContent = courseCode;
                document.getElementById('viewCourseName').textContent = course.name;
                document.getElementById('viewDept').textContent = course.dept;
                document.getElementById('viewSemester').textContent = course.semester;
                document.getElementById('viewCredits').textContent = course.credits;
                document.getElementById('viewDuration').textContent = course.duration;
                document.getElementById('viewFaculty').textContent = course.faculty;
                document.getElementById('viewStatus').textContent = course.status;
                document.getElementById('viewModal').classList.add('active');
            }
        }
        
        function editCourse(courseCode) {
            const courseData = {};
            
            const course = courseData[courseCode];
            if (course) {
                document.getElementById('editCourseCode').value = courseCode;
                document.getElementById('editCourseName').value = course.name;
                document.getElementById('editDept').value = course.dept;
                document.getElementById('editSemester').value = course.semester;
                document.getElementById('editCredits').value = course.credits;
                document.getElementById('editDuration').value = course.duration;
                document.getElementById('editFaculty').value = course.faculty;
                document.getElementById('editStatus').value = course.status;
                document.getElementById('editModal').classList.add('active');
            }
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('active');
        }
        
        function saveCourse() {
            const courseCode = document.getElementById('editCourseCode').value;
            const courseName = document.getElementById('editCourseName').value;
            const dept = document.getElementById('editDept').value;
            closeModal('editModal');
            alert('✅ Course Updated Successfully!\n\n' +
                  'Course Code: ' + courseCode + '\n' +
                  'Course Name: ' + courseName + '\n' +
                  'Department: ' + dept + '\n\n' +
                  'In production, this will save to database and refresh the table.');
        }
        
        function saveNewCourse() {
            console.log('=== Add New Course ===');
            
            const courseCode = document.getElementById('addCourseCode').value.trim();
            const courseName = document.getElementById('addCourseName').value.trim();
            const dept = document.getElementById('addDept').value;
            const semester = document.getElementById('addSemester').value;
            const credits = document.getElementById('addCredits').value.trim() || '3';
            const duration = document.getElementById('addDuration').value.trim() || '3 Years';
            const faculty = document.getElementById('addFaculty').value.trim() || 'Not Assigned';
            const status = document.getElementById('addStatus').value;
            
            if (!courseCode || !courseName || !dept || !semester) {
                alert('❌ Please fill all required fields (Course Code, Course Name, Department, Semester)!');
                return;
            }
            
            console.log('Adding course:', courseCode, courseName);
            
            // Check if course code already exists
            const rows = document.querySelectorAll('tbody tr');
            let exists = false;
            rows.forEach(row => {
                const courseCodeCell = row.querySelector('td:first-child');
                if (courseCodeCell && courseCodeCell.textContent.trim().toUpperCase() === courseCode.toUpperCase()) {
                    exists = true;
                }
            });
            
            if (exists) {
                alert('❌ Error: A course with code ' + courseCode + ' already exists!');
                return;
            }
            
            // Create new table row
            const tbody = document.querySelector('tbody');
            const newRow = document.createElement('tr');
            
            // Determine status badge class
            let statusClass = 'badge-success';
            let statusText = status;
            if (status === 'Inactive') {
                statusClass = 'badge-secondary';
            } else if (status === 'Under Review') {
                statusClass = 'badge-warning';
            }
            
            // Create cells with data
            newRow.innerHTML = `
                <td>${courseCode}</td>
                <td>${courseName}</td>
                <td>${dept}</td>
                <td>${semester}</td>
                <td>${credits}</td>
                <td>${duration}</td>
                <td>${faculty}</td>
                <td><span class="badge ${statusClass}">${statusText}</span></td>
                <td class="action-btns">
                    <button onclick="viewCourse('${courseCode}')" title="View">👁️</button>
                    <button onclick="editCourse('${courseCode}')" title="Edit">✏️</button>
                    <button onclick="deleteCourse('${courseCode}')" title="Delete">🗑️</button>
                </td>
            `;
            
            // Add row to table
            tbody.appendChild(newRow);
            console.log('New course row added to table');
            
            // Clear form
            document.getElementById('addCourseCode').value = '';
            document.getElementById('addCourseName').value = '';
            document.getElementById('addDept').value = '';
            document.getElementById('addSemester').value = '';
            document.getElementById('addCredits').value = '';
            document.getElementById('addDuration').value = '';
            document.getElementById('addFaculty').value = '';
            document.getElementById('addStatus').value = 'Active';
            
            // Close the modal
            closeModal('addModal');
            
            // Show success message
            alert('✅ New Course Added Successfully!\n\n' +
                  'Course Code: ' + courseCode + '\n' +
                  'Course Name: ' + courseName + '\n' +
                  'Department: ' + dept + '\n' +
                  'Semester: ' + semester + '\n\n' +
                  'The course has been added to the table!');
        }
        
        function deleteCourse(courseCode) {
            const courseNames = {
                'CS101': 'Programming Fundamentals',
                'CS201': 'Data Structures & Algorithms',
                'CS301': 'Database Management Systems',
                'BBA101': 'Principles of Management',
                'BBA202': 'Financial Accounting',
                'BBA301': 'Marketing Management',
                'ECE101': 'Circuit Theory',
                'ECE201': 'Digital Electronics',
                'MECH101': 'Engineering Mechanics',
                'MECH202': 'Thermodynamics',
                'MECH301': 'Machine Design',
                'CS401': 'Artificial Intelligence'
            };
            
            if (confirm('🗑️ DELETE COURSE\n\n' +
                'Are you sure you want to delete ' + courseNames[courseCode] + '?\n\n' +
                '⚠️ This action cannot be undone!')) {
                
                // Find and remove the row from the table
                const rows = document.querySelectorAll('tbody tr');
                rows.forEach(row => {
                    const courseCell = row.querySelector('td:first-child');
                    if (courseCell && courseCell.textContent === courseCode) {
                        row.remove();
                    }
                });
                
                alert('✅ Course Deleted Successfully!\n\n' +
                      courseNames[courseCode] + ' (' + courseCode + ') has been removed from the table.');
            }
        }
        
        function exportData() {
            const table = document.querySelector('table');
            if (!table) {
                alert('No data available to export');
                return;
            }
            
            let csv = [];
            const rows = table.querySelectorAll('tr');
            
            for (let i = 0; i < rows.length; i++) {
                const row = [], cols = rows[i].querySelectorAll('td, th');
                for (let j = 0; j < cols.length - 1; j++) { // Exclude last column (Actions)
                    let cellText = cols[j].textContent.trim().replace(/"/g, '""');
                    row.push('"' + cellText + '"');
                }
                csv.push(row.join(','));
            }
            
            const csvContent = csv.join('\n');
            const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            const url = URL.createObjectURL(blob);
            link.setAttribute('href', url);
            link.setAttribute('download', 'courses_data_' + new Date().toISOString().split('T')[0] + '.csv');
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            
            alert('✅ Export Successful!\n\nCourse data has been exported to CSV.\n\nFile: courses_data_' + new Date().toISOString().split('T')[0] + '.csv');
        }
        
        // Close modal when clicking outside
        document.addEventListener('click', function(event) {
            const viewModal = document.getElementById('viewModal');
            const editModal = document.getElementById('editModal');
            const addModal = document.getElementById('addModal');
            
            if (event.target === viewModal) closeModal('viewModal');
            if (event.target === editModal) closeModal('editModal');
            if (event.target === addModal) closeModal('addModal');
        });
        
        // Search functionality
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchInput');
            if (searchInput) {
                searchInput.addEventListener('input', function() {
                    const searchTerm = this.value.toLowerCase().trim();
                    console.log('Searching for:', searchTerm);
                    
                    const tableRows = document.querySelectorAll('tbody tr');
                    
                    tableRows.forEach(row => {
                        const courseCode = row.cells[0].textContent.toLowerCase();
                        const courseName = row.cells[1].textContent.toLowerCase();
                        const department = row.cells[2].textContent.toLowerCase();
                        const semester = row.cells[3].textContent.toLowerCase();
                        const credits = row.cells[4].textContent.toLowerCase();
                        const duration = row.cells[5].textContent.toLowerCase();
                        const facultyAssigned = row.cells[6].textContent.toLowerCase();
                        const statusBadge = row.cells[7].querySelector('.badge');
                        const status = statusBadge ? statusBadge.textContent.toLowerCase() : '';
                        
                        // Search by Course Code, Course Name, Department, Semester, Credits, Duration, Faculty Assigned, or Status
                        if (courseCode.includes(searchTerm) || 
                            courseName.includes(searchTerm) || 
                            department.includes(searchTerm) || 
                            semester.includes(searchTerm) ||
                            credits.includes(searchTerm) ||
                            duration.includes(searchTerm) ||
                            facultyAssigned.includes(searchTerm) ||
                            status.includes(searchTerm)) {
                            row.style.display = '';
                        } else {
                            row.style.display = 'none';
                        }
                    });
                });
            }
        });
    </script>
</body>
</html>

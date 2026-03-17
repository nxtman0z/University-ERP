<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exam Management - Admin Portal</title>
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
        
        /* Table Styling */
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
            font-size: 0.75rem;
            background: rgba(200, 169, 81, 0.05);
        }
        
        tr:hover {
            background: rgba(200, 169, 81, 0.03);
        }
        
        .action-btns {
            display: flex;
            gap: 0.5rem;
        }
        
        .action-btns button {
            background: transparent;
            border: none;
            font-size: 1.25rem;
            cursor: pointer;
            transition: transform 0.2s;
        }
        
        .action-btns button:hover {
            transform: scale(1.2);
        }
        
        /* Badge Styling */
        .badge {
            padding: 0.25rem 0.75rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .badge-success {
            background: rgba(76, 175, 80, 0.2);
            color: #4CAF50;
        }
        
        .badge-warning {
            background: rgba(255, 152, 0, 0.2);
            color: #ff9800;
        }
        
        .badge-danger {
            background: rgba(244, 67, 54, 0.2);
            color: #f44336;
        }
        
        .badge-info {
            background: rgba(33, 150, 243, 0.2);
            color: #2196F3;
        }

        .badge-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-secondary);
        }
        
        .btn-sm {
            padding: 0.375rem 0.75rem;
            font-size: 0.8125rem;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
        
        .btn-danger {
            background: var(--danger-color);
            color: white;
        }
        
        .btn-danger:hover {
            background: #d32f2f;
            transform: translateY(-2px);
        }
        
        .btn-warning {
            background: var(--warning-color);
            color: white;
        }
        
        .btn-warning:hover {
            background: #e68900;
            transform: translateY(-2px);
        }
        
        /* Modal Styling */
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
            max-width: 700px;
            width: 90%;
            max-height: 90vh;
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
            background: transparent;
            border: none;
            color: var(--text-secondary);
            font-size: 1.5rem;
            cursor: pointer;
            padding: 0;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 6px;
            transition: all 0.3s ease;
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
        
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            padding: 1.5rem 2rem;
            border-top: 1px solid var(--border-color);
            flex-shrink: 0;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            display: block;
            color: var(--text-secondary);
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
            font-weight: 600;
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
            width: 10px;
        }
        
        .modal-body::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 4px;
            margin: 4px;
        }
        
        .modal-body::-webkit-scrollbar-thumb {
            background: var(--primary-color);
            border-radius: 4px;
        }
        
        .modal-body::-webkit-scrollbar-thumb:hover {
            background: #B89841;
        }
        
        .modal-body::after {
            content: '';
            display: block;
            height: 20px;
        }
        
        .scroll-indicator {
            position: absolute;
            bottom: 80px;
            right: 20px;
            background: var(--primary-color);
            color: var(--dark-bg);
            padding: 8px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            opacity: 0.9;
            animation: bounce 2s infinite;
            pointer-events: none;
            z-index: 10;
        }
        
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        
        .modal-body.scrolled .scroll-indicator {
            display: none;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
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
                <li><a href="courses.jsp"><i>📚</i> Courses & Subjects</a></li>
                <li><a href="fees.html"><i>💰</i> Fee Management</a></li>
                <li><a href="exams.jsp" class="active"><i>📋</i> Exam Management</a></li>
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
                <h1>📋 Exam Management</h1>
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
                    <h3>📋 Exam Schedules</h3>
                    <div style="display: flex; gap: 10px;">
                        <button class="btn btn-primary" onclick="createExamSchedule()">➕ Create Schedule</button>
                        <button class="btn btn-success" onclick="viewCalendar()">📅 View Calendar</button>
                    </div>
                </div>
                
                <table>
                    <thead>
                        <tr>
                            <th>Exam Code</th>
                            <th>Course Name</th>
                            <th>Department</th>
                            <th>Semester</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Duration</th>
                            <th>Venue</th>
                            <th>Type</th>
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
    
    <!-- View Exam Modal -->
    <div id="viewModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>👁️ Exam Details</h2>
                <button class="modal-close" onclick="closeModal('viewModal')">✕</button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label class="form-label">Exam Code</label>
                    <input type="text" id="viewExamCode" class="form-input" readonly>
                </div>
                <div class="form-group">
                    <label class="form-label">Course Name</label>
                    <input type="text" id="viewCourseName" class="form-input" readonly>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Department</label>
                        <input type="text" id="viewDept" class="form-input" readonly>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Semester</label>
                        <input type="text" id="viewSemester" class="form-input" readonly>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Date</label>
                        <input type="text" id="viewDate" class="form-input" readonly>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Time</label>
                        <input type="text" id="viewTime" class="form-input" readonly>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Duration</label>
                        <input type="text" id="viewDuration" class="form-input" readonly>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Venue</label>
                        <input type="text" id="viewVenue" class="form-input" readonly>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Type</label>
                        <input type="text" id="viewType" class="form-input" readonly>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Status</label>
                        <input type="text" id="viewStatus" class="form-input" readonly>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeModal('viewModal')">Close</button>
            </div>
        </div>
    </div>
    
    <!-- Edit Exam Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>✏️ Edit Exam Schedule</h2>
                <button class="modal-close" onclick="closeModal('editModal')">✕</button>
            </div>
            <div class="modal-body">
                <div class="scroll-indicator">↓ Scroll for more fields</div>
                <div class="form-group">
                    <label class="form-label">Exam Code</label>
                    <input type="text" id="editExamCode" class="form-input" readonly>
                </div>
                <div class="form-group">
                    <label class="form-label">Course Name</label>
                    <input type="text" id="editCourseName" class="form-input">
                </div>
                <div class="form-row">
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
                            <option value="1">Semester 1</option>
                            <option value="2">Semester 2</option>
                            <option value="3">Semester 3</option>
                            <option value="4">Semester 4</option>
                            <option value="5">Semester 5</option>
                            <option value="6">Semester 6</option>
                            <option value="7">Semester 7</option>
                            <option value="8">Semester 8</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Date</label>
                        <input type="date" id="editDate" class="form-input">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Time</label>
                        <input type="time" id="editTime" class="form-input">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Duration</label>
                        <select id="editDuration" class="form-input">
                            <option value="1 Hour">1 Hour</option>
                            <option value="2 Hours">2 Hours</option>
                            <option value="3 Hours">3 Hours</option>
                            <option value="4 Hours">4 Hours</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Venue</label>
                        <input type="text" id="editVenue" class="form-input" placeholder="e.g., Hall A">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Type</label>
                        <select id="editType" class="form-input">
                            <option value="Theory">Theory</option>
                            <option value="Practical">Practical</option>
                            <option value="Viva">Viva</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Status</label>
                        <select id="editStatus" class="form-input">
                            <option value="Scheduled">Scheduled</option>
                            <option value="Confirmed">Confirmed</option>
                            <option value="Cancelled">Cancelled</option>
                            <option value="Completed">Completed</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeModal('editModal')">Cancel</button>
                <button class="btn btn-primary" onclick="saveExam()">Save Changes</button>
            </div>
        </div>
    </div>
    
    <!-- Add Exam Modal -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>➕ Create Exam Schedule</h2>
                <button class="modal-close" onclick="closeModal('addModal')">✕</button>
            </div>
            <div class="modal-body">
                <div class="scroll-indicator">↓ Scroll for more fields</div>
                <div class="form-group">
                    <label class="form-label">Exam Code</label>
                    <input type="text" id="addExamCode" class="form-input" placeholder="e.g., EX2024011">
                </div>
                <div class="form-group">
                    <label class="form-label">Course Name</label>
                    <input type="text" id="addCourseName" class="form-input" placeholder="Enter course name">
                </div>
                <div class="form-row">
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
                            <option value="1">Semester 1</option>
                            <option value="2">Semester 2</option>
                            <option value="3">Semester 3</option>
                            <option value="4">Semester 4</option>
                            <option value="5">Semester 5</option>
                            <option value="6">Semester 6</option>
                            <option value="7">Semester 7</option>
                            <option value="8">Semester 8</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Date</label>
                        <input type="date" id="addDate" class="form-input">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Time</label>
                        <input type="time" id="addTime" class="form-input">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Duration</label>
                        <select id="addDuration" class="form-input">
                            <option value="">Select Duration</option>
                            <option value="1 Hour">1 Hour</option>
                            <option value="2 Hours">2 Hours</option>
                            <option value="3 Hours">3 Hours</option>
                            <option value="4 Hours">4 Hours</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Venue</label>
                        <input type="text" id="addVenue" class="form-input" placeholder="e.g., Hall A">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Type</label>
                        <select id="addType" class="form-input">
                            <option value="">Select Type</option>
                            <option value="Theory">Theory</option>
                            <option value="Practical">Practical</option>
                            <option value="Viva">Viva</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Status</label>
                        <select id="addStatus" class="form-input">
                            <option value="Scheduled">Scheduled</option>
                            <option value="Confirmed">Confirmed</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeModal('addModal')">Cancel</button>
                <button class="btn btn-success" onclick="saveNewExam()">Create Schedule</button>
            </div>
        </div>
    </div>
    
    <!-- Calendar Modal -->
    <div id="calendarModal" class="modal">
        <div class="modal-content" style="max-width: 1000px;">
            <div class="modal-header">
                <h2>📅 Exam Calendar View</h2>
                <button class="modal-close" onclick="closeModal('calendarModal')">✕</button>
            </div>
            <div class="modal-body" style="max-height: 600px;">
                <div style="background: rgba(200, 169, 81, 0.1); border: 1px solid rgba(200, 169, 81, 0.3); border-radius: 8px; padding: 1rem; margin-bottom: 1.5rem;">
                    <h3 style="color: var(--primary-color); font-size: 1rem; margin-bottom: 0.5rem;">📊 Schedule Overview</h3>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 1rem; margin-top: 1rem;">
                        <div>
                            <div style="color: rgba(255,255,255,0.7); font-size: 0.875rem;">Total Exams</div>
                            <div id="calendarTotalExams" style="color: #fff; font-size: 1.5rem; font-weight: bold;">0</div>
                        </div>
                        <div>
                            <div style="color: rgba(255,255,255,0.7); font-size: 0.875rem;">Theory Exams</div>
                            <div id="calendarTheoryExams" style="color: #fff; font-size: 1.5rem; font-weight: bold;">0</div>
                        </div>
                        <div>
                            <div style="color: rgba(255,255,255,0.7); font-size: 0.875rem;">Practical Exams</div>
                            <div id="calendarPracticalExams" style="color: #fff; font-size: 1.5rem; font-weight: bold;">0</div>
                        </div>
                    </div>
                </div>

                <h3 style="color: var(--primary-color); font-size: 1rem; margin-bottom: 1rem;">Upcoming Exam Schedule</h3>
                <div id="calendarExamList" style="display: flex; flex-direction: column; gap: 0.75rem;">
                    <!-- Exam items will be dynamically inserted here -->
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" onclick="closeModal('calendarModal')">Close</button>
                <button class="btn btn-success" onclick="exportData()">📥 Export Calendar</button>
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
        
        function createExamSchedule() {
            // Clear all fields
            document.getElementById('addExamCode').value = '';
            document.getElementById('addCourseName').value = '';
            document.getElementById('addDept').value = '';
            document.getElementById('addSemester').value = '';
            document.getElementById('addDate').value = '';
            document.getElementById('addTime').value = '';
            document.getElementById('addDuration').value = '';
            document.getElementById('addVenue').value = '';
            document.getElementById('addType').value = '';
            document.getElementById('addStatus').value = 'Scheduled';
            document.getElementById('addModal').classList.add('active');
        }
        
        function viewExam(examCode) {
            const examData = {
                'EX2024001': { course: 'Programming Fundamentals', dept: 'Computer Science', semester: '1', date: 'Feb 15, 2024', time: '10:00 AM', duration: '3 Hours', venue: 'Hall A', type: 'Theory', status: 'Scheduled' },
                'EX2024002': { course: 'Data Structures & Algorithms', dept: 'Computer Science', semester: '3', date: 'Feb 16, 2024', time: '10:00 AM', duration: '3 Hours', venue: 'Hall B', type: 'Theory', status: 'Scheduled' },
                'EX2024003': { course: 'Database Management Systems', dept: 'Computer Science', semester: '5', date: 'Feb 17, 2024', time: '10:00 AM', duration: '3 Hours', venue: 'Hall A', type: 'Theory', status: 'Scheduled' },
                'EX2024004': { course: 'Principles of Management', dept: 'Business Administration', semester: '1', date: 'Feb 15, 2024', time: '2:00 PM', duration: '3 Hours', venue: 'Hall C', type: 'Theory', status: 'Scheduled' },
                'EX2024005': { course: 'Financial Accounting', dept: 'Business Administration', semester: '3', date: 'Feb 16, 2024', time: '2:00 PM', duration: '3 Hours', venue: 'Hall C', type: 'Theory', status: 'Scheduled' },
                'EX2024006': { course: 'Circuit Theory', dept: 'Electronics Engineering', semester: '1', date: 'Feb 18, 2024', time: '10:00 AM', duration: '3 Hours', venue: 'Hall D', type: 'Theory', status: 'Scheduled' },
                'EX2024007': { course: 'Digital Electronics', dept: 'Electronics Engineering', semester: '3', date: 'Feb 19, 2024', time: '10:00 AM', duration: '3 Hours', venue: 'Hall D', type: 'Theory', status: 'Scheduled' },
                'EX2024008': { course: 'Engineering Mechanics', dept: 'Mechanical Engineering', semester: '1', date: 'Feb 18, 2024', time: '2:00 PM', duration: '3 Hours', venue: 'Hall E', type: 'Theory', status: 'Scheduled' },
                'EX2024009': { course: 'Thermodynamics', dept: 'Mechanical Engineering', semester: '3', date: 'Feb 19, 2024', time: '2:00 PM', duration: '3 Hours', venue: 'Hall E', type: 'Theory', status: 'Scheduled' },
                'EX2024010': { course: 'Programming Lab', dept: 'Computer Science', semester: '1', date: 'Feb 20, 2024', time: '10:00 AM', duration: '2 Hours', venue: 'Lab 101', type: 'Practical', status: 'Confirmed' }
            };
            
            const exam = examData[examCode];
            if (exam) {
                document.getElementById('viewExamCode').value = examCode;
                document.getElementById('viewCourseName').value = exam.course;
                document.getElementById('viewDept').value = exam.dept;
                document.getElementById('viewSemester').value = 'Semester ' + exam.semester;
                document.getElementById('viewDate').value = exam.date;
                document.getElementById('viewTime').value = exam.time;
                document.getElementById('viewDuration').value = exam.duration;
                document.getElementById('viewVenue').value = exam.venue;
                document.getElementById('viewType').value = exam.type;
                document.getElementById('viewStatus').value = exam.status;
                document.getElementById('viewModal').classList.add('active');
            }
        }
        
        function editExam(examCode) {
            console.log('=== Edit Exam Schedule ===');
            console.log('Exam Code:', examCode);
            
            // Find the exam row in the table by locating the edit button
            const rows = document.querySelectorAll('tbody tr');
            let examFound = false;
            
            rows.forEach(row => {
                const editButton = row.querySelector('button[onclick*="editExam(\'' + examCode + '\')\"]');
                if (editButton) {
                    examFound = true;
                    
                    // Extract data from table row
                    const courseName = row.cells[1].textContent.trim();
                    const dept = row.cells[2].textContent.trim();
                    const semester = row.cells[3].textContent.trim();
                    const dateText = row.cells[4].textContent.trim();
                    const timeText = row.cells[5].textContent.trim();
                    const duration = row.cells[6].textContent.trim();
                    const venue = row.cells[7].textContent.trim();
                    const type = row.cells[8].textContent.trim();
                    const statusBadge = row.cells[9].querySelector('.badge');
                    const status = statusBadge ? statusBadge.textContent.trim() : 'Scheduled';
                    
                    // Convert date format from "Feb 15, 2024" to "2024-02-15" for input field
                    let formattedDate = '';
                    try {
                        const dateObj = new Date(dateText);
                        if (!isNaN(dateObj.getTime())) {
                            const year = dateObj.getFullYear();
                            const month = String(dateObj.getMonth() + 1).padStart(2, '0');
                            const day = String(dateObj.getDate()).padStart(2, '0');
                            formattedDate = `${year}-${month}-${day}`;
                        }
                    } catch (e) {
                        formattedDate = '';
                    }
                    
                    // Convert time format from "10:00 AM" to "10:00" for input field
                    let formattedTime = timeText.replace(/(AM|PM)/i, '').trim();
                    
                    console.log('Found exam:', courseName, dept);
                    
                    // Fill the edit modal with data
                    document.getElementById('editExamCode').value = examCode;
                    document.getElementById('editCourseName').value = courseName;
                    document.getElementById('editDept').value = dept;
                    document.getElementById('editSemester').value = 'Semester ' + semester;
                    document.getElementById('editDate').value = formattedDate;
                    document.getElementById('editTime').value = formattedTime;
                    document.getElementById('editDuration').value = duration;
                    document.getElementById('editVenue').value = venue;
                    document.getElementById('editType').value = type;
                    document.getElementById('editStatus').value = status;
                    
                    // Show the modal
                    document.getElementById('editModal').classList.add('active');
                }
            });
            
            if (!examFound) {
                console.error('Exam schedule not found:', examCode);
                alert('❌ Error: Exam schedule not found!');
            }
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('active');
        }
        
        // Hide scroll indicator on scroll
        document.addEventListener('DOMContentLoaded', function() {
            const modalBodies = document.querySelectorAll('.modal-body');
            modalBodies.forEach(body => {
                body.addEventListener('scroll', function() {
                    if (this.scrollTop > 20) {
                        this.classList.add('scrolled');
                    } else {
                        this.classList.remove('scrolled');
                    }
                });
            });
            
            // Close modal when clicking outside
            const modals = document.querySelectorAll('.modal');
            modals.forEach(modal => {
                modal.addEventListener('click', function(e) {
                    if (e.target === this) {
                        this.classList.remove('active');
                    }
                });
            });
        });
        
        function saveExam() {
            console.log('=== Save Exam Schedule Changes ===');
            
            const examCode = document.getElementById('editExamCode').value;
            const courseName = document.getElementById('editCourseName').value;
            const dept = document.getElementById('editDept').value;
            const semester = document.getElementById('editSemester').value;
            const date = document.getElementById('editDate').value;
            const time = document.getElementById('editTime').value;
            const duration = document.getElementById('editDuration').value;
            const venue = document.getElementById('editVenue').value;
            const type = document.getElementById('editType').value;
            const status = document.getElementById('editStatus').value;
            
            console.log('Updating exam schedule:', examCode);
            
            // Find and update the row in the table
            const rows = document.querySelectorAll('tbody tr');
            let updated = false;
            
            rows.forEach(row => {
                const editButton = row.querySelector('button[onclick*="editExam(\'' + examCode + '\')\"]');
                if (editButton) {
                    console.log('Found row for exam code:', examCode);
                    
                    // Format date from "2024-02-15" to "Feb 15, 2024"
                    let formattedDate = date;
                    try {
                        const dateObj = new Date(date);
                        if (!isNaN(dateObj.getTime())) {
                            formattedDate = dateObj.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
                        }
                    } catch (e) {
                        formattedDate = date;
                    }
                    
                    // Format time to include AM/PM if not present
                    let formattedTime = time;
                    if (time && !time.match(/(AM|PM)/i)) {
                        const [hours, minutes] = time.split(':');
                        const hour = parseInt(hours);
                        if (hour >= 0 && hour < 24) {
                            const period = hour >= 12 ? 'PM' : 'AM';
                            const displayHour = hour === 0 ? 12 : (hour > 12 ? hour - 12 : hour);
                            formattedTime = `${displayHour}:${minutes || '00'} ${period}`;
                        }
                    }
                    
                    // Extract just the semester number from "Semester 1" format
                    const semesterNum = semester.replace(/[^0-9]/g, '');
                    
                    // Update all cells
                    row.cells[1].textContent = courseName;
                    row.cells[2].textContent = dept;
                    row.cells[3].textContent = semesterNum;
                    row.cells[4].textContent = formattedDate;
                    row.cells[5].textContent = formattedTime;
                    row.cells[6].textContent = duration;
                    row.cells[7].textContent = venue;
                    row.cells[8].textContent = type;
                    
                    // Update status badge
                    const statusCell = row.cells[9];
                    if (status === 'Scheduled') {
                        statusCell.innerHTML = '<span class="badge badge-warning">Scheduled</span>';
                    } else if (status === 'Confirmed') {
                        statusCell.innerHTML = '<span class="badge badge-success">Confirmed</span>';
                    } else if (status === 'Postponed') {
                        statusCell.innerHTML = '<span class="badge badge-danger">Postponed</span>';
                    } else if (status === 'Completed') {
                        statusCell.innerHTML = '<span class="badge badge-secondary">Completed</span>';
                    } else {
                        statusCell.innerHTML = '<span class="badge badge-warning">' + status + '</span>';
                    }
                    
                    updated = true;
                    console.log('Exam schedule data updated in table');
                }
            });
            
            // Close the modal
            closeModal('editModal');
            
            if (updated) {
                alert('✅ Exam Schedule Updated Successfully!\n\n' +
                      'Exam Code: ' + examCode + '\n' +
                      'Course: ' + courseName + '\n' +
                      'Department: ' + dept + '\n' +
                      'Date: ' + date + '\n' +
                      'Venue: ' + venue + '\n\n' +
                      'Students will be notified of the changes.');
            } else {
                alert('❌ Error: Could not find exam schedule to update');
            }
        }
        
        function saveNewExam() {
            console.log('=== Create New Exam Schedule ===');
            
            const examCode = document.getElementById('addExamCode').value.trim();
            const courseName = document.getElementById('addCourseName').value.trim();
            const dept = document.getElementById('addDept').value;
            const semester = document.getElementById('addSemester').value;
            const date = document.getElementById('addDate').value;
            const time = document.getElementById('addTime').value.trim();
            const duration = document.getElementById('addDuration').value;
            const venue = document.getElementById('addVenue').value.trim();
            const type = document.getElementById('addType').value;
            const status = document.getElementById('addStatus').value || 'Scheduled';
            
            if (!examCode || !courseName || !dept || !semester || !date || !time || !duration || !venue || !type) {
                alert('❌ Please fill all required fields!');
                return;
            }
            
            console.log('Creating exam schedule:', examCode, courseName);
            
            // Check if exam code already exists
            const rows = document.querySelectorAll('tbody tr');
            let exists = false;
            rows.forEach(row => {
                const examCodeCell = row.querySelector('td:first-child');
                if (examCodeCell && examCodeCell.textContent.trim().toUpperCase() === examCode.toUpperCase()) {
                    exists = true;
                }
            });
            
            if (exists) {
                alert('❌ Error: An exam with code ' + examCode + ' already exists!');
                return;
            }
            
            // Create new table row
            const tbody = document.querySelector('tbody');
            const newRow = document.createElement('tr');
            
            // Format date from "2024-02-15" to "Feb 15, 2024"
            let formattedDate = date;
            try {
                const dateObj = new Date(date);
                if (!isNaN(dateObj.getTime())) {
                    formattedDate = dateObj.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
                }
            } catch (e) {
                formattedDate = date;
            }
            
            // Format time to include AM/PM if not present
            let formattedTime = time;
            if (time && !time.match(/(AM|PM)/i)) {
                const [hours, minutes] = time.split(':');
                const hour = parseInt(hours);
                if (hour >= 0 && hour < 24) {
                    const period = hour >= 12 ? 'PM' : 'AM';
                    const displayHour = hour === 0 ? 12 : (hour > 12 ? hour - 12 : hour);
                    formattedTime = `${displayHour}:${minutes || '00'} ${period}`;
                }
            }
            
            // Extract semester number from "Semester 1" format
            const semesterNum = semester.replace(/[^0-9]/g, '');
            
            // Determine status badge class
            let statusClass = 'badge-warning';
            if (status === 'Confirmed') {
                statusClass = 'badge-success';
            } else if (status === 'Postponed') {
                statusClass = 'badge-danger';
            } else if (status === 'Completed') {
                statusClass = 'badge-secondary';
            }
            
            // Create cells with data
            newRow.innerHTML = `
                <td>${examCode}</td>
                <td>${courseName}</td>
                <td>${dept}</td>
                <td>${semesterNum}</td>
                <td>${formattedDate}</td>
                <td>${formattedTime}</td>
                <td>${duration}</td>
                <td>${venue}</td>
                <td>${type}</td>
                <td><span class="badge ${statusClass}">${status}</span></td>
                <td class="action-btns">
                    <button onclick="viewExam('${examCode}')" title="View">👁️</button>
                    <button onclick="editExam('${examCode}')" title="Edit">✏️</button>
                    <button onclick="deleteExam('${examCode}')" title="Delete">🗑️</button>
                </td>
            `;
            
            // Add row to table
            tbody.appendChild(newRow);
            console.log('New exam schedule row added to table');
            
            // Clear form
            document.getElementById('addExamCode').value = '';
            document.getElementById('addCourseName').value = '';
            document.getElementById('addDept').value = '';
            document.getElementById('addSemester').value = '';
            document.getElementById('addDate').value = '';
            document.getElementById('addTime').value = '';
            document.getElementById('addDuration').value = '';
            document.getElementById('addVenue').value = '';
            document.getElementById('addType').value = '';
            document.getElementById('addStatus').value = 'Scheduled';
            
            // Close the modal
            closeModal('addModal');
            
            // Show success message
            alert('✅ New Exam Schedule Created Successfully!\n\n' +
                  'Exam Code: ' + examCode + '\n' +
                  'Course: ' + courseName + '\n' +
                  'Department: ' + dept + '\n' +
                  'Date: ' + formattedDate + '\n' +
                  'Time: ' + formattedTime + '\n' +
                  'Venue: ' + venue + '\n\n' +
                  'Students will be notified via email and SMS.\n' +
                  'The schedule has been added to the table!');
        }
        
        function deleteExam(examCode) {
            if (confirm('Are you sure you want to delete exam ' + examCode + '?\n\nStudents will be notified.\nThis action cannot be undone.')) {
                
                // Find and remove the row from the table
                const rows = document.querySelectorAll('tbody tr');
                rows.forEach(row => {
                    const examCell = row.querySelector('td:first-child');
                    if (examCell && examCell.textContent === examCode) {
                        row.remove();
                    }
                });
                
                alert('✅ Exam Schedule Deleted Successfully!\n\n' +
                      'Exam Code: ' + examCode + '\n\n' +
                      'The exam has been removed from the table.');
            }
        }
        
        function viewCalendar() {
            console.log('=== Opening Exam Calendar View ===');
            
            // Get all exam rows from the table
            const rows = document.querySelectorAll('tbody tr');
            const exams = [];
            
            rows.forEach(row => {
                const exam = {
                    code: row.cells[0].textContent.trim(),
                    course: row.cells[1].textContent.trim(),
                    dept: row.cells[2].textContent.trim(),
                    semester: row.cells[3].textContent.trim(),
                    date: row.cells[4].textContent.trim(),
                    time: row.cells[5].textContent.trim(),
                    duration: row.cells[6].textContent.trim(),
                    venue: row.cells[7].textContent.trim(),
                    type: row.cells[8].textContent.trim(),
                    status: row.cells[9].querySelector('.badge').textContent.trim()
                };
                exams.push(exam);
            });
            
            // Sort exams by date
            exams.sort((a, b) => {
                const dateA = new Date(a.date);
                const dateB = new Date(b.date);
                return dateA - dateB;
            });
            
            // Calculate statistics
            const totalExams = exams.length;
            const theoryExams = exams.filter(e => e.type === 'Theory').length;
            const practicalExams = exams.filter(e => e.type === 'Practical').length;
            
            // Update statistics
            document.getElementById('calendarTotalExams').textContent = totalExams;
            document.getElementById('calendarTheoryExams').textContent = theoryExams;
            document.getElementById('calendarPracticalExams').textContent = practicalExams;
            
            // Build exam list HTML
            const calendarList = document.getElementById('calendarExamList');
            calendarList.innerHTML = '';
            
            if (exams.length === 0) {
                calendarList.innerHTML = '<div style="text-align: center; color: rgba(255,255,255,0.5); padding: 2rem;">No exams scheduled</div>';
            } else {
                exams.forEach(exam => {
                    const examItem = document.createElement('div');
                    examItem.style.cssText = 'background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 8px; padding: 1rem;';
                    
                    // Determine status color
                    let statusColor = '#ff9800'; // warning/scheduled
                    if (exam.status === 'Confirmed') statusColor = '#4CAF50';
                    else if (exam.status === 'Postponed') statusColor = '#f44336';
                    else if (exam.status === 'Completed') statusColor = '#999';
                    
                    examItem.innerHTML = `
                        <div style="display: flex; justify-content: space-between; align-items: flex-start; gap: 1rem;">
                            <div style="flex: 1;">
                                <div style="display: flex; align-items: center; gap: 0.75rem; margin-bottom: 0.5rem;">
                                    <span style="background: var(--primary-color); color: var(--dark-bg); font-weight: bold; padding: 0.25rem 0.5rem; border-radius: 4px; font-size: 0.75rem;">${exam.code}</span>
                                    <h4 style="color: #fff; font-size: 1rem; font-weight: 600; margin: 0;">${exam.course}</h4>
                                    <span style="background: ${statusColor}; color: #fff; padding: 0.25rem 0.5rem; border-radius: 4px; font-size: 0.75rem;">${exam.status}</span>
                                </div>
                                <div style="color: rgba(255,255,255,0.7); font-size: 0.875rem; margin-bottom: 0.25rem;">
                                    ${exam.dept} • Semester ${exam.semester} • ${exam.type}
                                </div>
                                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 0.5rem; margin-top: 0.75rem; color: rgba(255,255,255,0.8); font-size: 0.875rem;">
                                    <div><strong>📅 Date:</strong> ${exam.date}</div>
                                    <div><strong>🕐 Time:</strong> ${exam.time}</div>
                                    <div><strong>⏱️ Duration:</strong> ${exam.duration}</div>
                                    <div><strong>📍 Venue:</strong> ${exam.venue}</div>
                                </div>
                            </div>
                        </div>
                    `;
                    
                    calendarList.appendChild(examItem);
                });
            }
            
            // Show the modal
            document.getElementById('calendarModal').classList.add('active');
        }
        
        function exportData() {
            // Export the exam calendar data
            const modal = document.getElementById('calendarModal');
            if (!modal || !modal.classList.contains('active')) {
                // If calendar modal is not open, export main table
                const table = document.querySelector('table');
                if (!table) {
                    alert('No data available to export');
                    return;
                }
                
                let csv = [];
                const rows = table.querySelectorAll('tr');
                
                for (let i = 0; i < rows.length; i++) {
                    const row = [], cols = rows[i].querySelectorAll('td, th');
                    for (let j = 0; j < cols.length - 1; j++) { // Exclude action column
                        let cellText = cols[j].innerText.replace(/"/g, '""');
                        row.push('"' + cellText + '"');
                    }
                    csv.push(row.join(','));
                }
                
                const csvContent = csv.join('\n');
                const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
                const link = document.createElement('a');
                const url = URL.createObjectURL(blob);
                link.setAttribute('href', url);
                link.setAttribute('download', 'exams_data_' + new Date().toISOString().split('T')[0] + '.csv');
                link.style.visibility = 'hidden';
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
                
                setTimeout(() => alert('Exam data exported successfully!'), 100);
            } else {
                // Export calendar view data
                let csv = [['Exam Code', 'Course Name', 'Department', 'Semester', 'Type', 'Date', 'Time', 'Duration', 'Venue', 'Status']];
                
                const tbody = document.querySelector('table tbody');
                if (tbody) {
                    const rows = tbody.querySelectorAll('tr');
                    rows.forEach(row => {
                        const cells = row.querySelectorAll('td');
                        if (cells.length >= 10) {
                            const rowData = [
                                cells[0].textContent.trim(),
                                cells[1].textContent.trim(),
                                cells[2].textContent.trim(),
                                cells[3].textContent.trim(),
                                cells[4].textContent.trim(),
                                cells[5].textContent.trim(),
                                cells[6].textContent.trim(),
                                cells[7].textContent.trim(),
                                cells[8].textContent.trim(),
                                cells[9].textContent.trim()
                            ];
                            csv.push(rowData.map(cell => '"' + cell.replace(/"/g, '""') + '"'));
                        }
                    });
                }
                
                const csvContent = csv.map(row => row.join(',')).join('\n');
                const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
                const link = document.createElement('a');
                const url = URL.createObjectURL(blob);
                link.setAttribute('href', url);
                link.setAttribute('download', 'exam_calendar_' + new Date().toISOString().split('T')[0] + '.csv');
                link.style.visibility = 'hidden';
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
                
                setTimeout(() => alert('Exam calendar exported successfully!'), 100);
            }
        }
    </script>
</body>
</html>
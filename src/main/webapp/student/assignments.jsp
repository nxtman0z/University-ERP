<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignments - Student Portal</title>
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
                <li><a href="assignments.jsp" class="active"><i>📝</i> Assignments</a></li>
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
                <h1>📝 My Assignments</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">🔔<span class="notification-badge">5</span></div>
                    <div class="user-info">
                        <div class="user-avatar">S</div>
                        <span class="user-name">Student</span>
                    </div>
                </div>
            </nav>
            
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-card-value">12</div>
                    <div class="stat-card-label">Total Assignments</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value" style="color: var(--success-color);">9</div>
                    <div class="stat-card-label">Submitted</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value" style="color: var(--danger-color);">3</div>
                    <div class="stat-card-label">Pending</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value" style="color: var(--warning-color);">2</div>
                    <div class="stat-card-label">Due This Week</div>
                </div>
            </div>
            
            <div class="alert alert-danger">
                <strong>⚠️ Urgent:</strong> Java Programming assignment due on 22nd January 2026 (3 days left)
            </div>
            
            <div class="content-card">
                <div class="card-header">
                    <h3>📋 All Assignments</h3>
                    <div>
                        <select class="form-control" style="width: auto; display: inline-block;" onchange="filterAssignments(this.value)">
                            <option value="all">All Status</option>
                            <option value="pending">Pending</option>
                            <option value="submitted">Submitted</option>
                            <option value="graded">Graded</option>
                        </select>
                    </div>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Assignment</th>
                                <th>Subject</th>
                                <th>Assigned Date</th>
                                <th>Due Date</th>
                                <th>Status</th>
                                <th>Marks</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><strong>Create Banking System in Java</strong></td>
                                <td>Java Programming</td>
                                <td>15 Jan 2026</td>
                                <td>22 Jan 2026</td>
                                <td><span class="badge badge-danger">Pending</span></td>
                                <td>-</td>
                                <td><button class="btn btn-sm btn-primary" onclick="submitAssignment(1)">📤 Submit</button></td>
                            </tr>
                            <tr>
                                <td><strong>Design ER Diagram for Library</strong></td>
                                <td>DBMS</td>
                                <td>12 Jan 2026</td>
                                <td>20 Jan 2026</td>
                                <td><span class="badge badge-success">Submitted</span></td>
                                <td>-</td>
                                <td><button class="btn btn-sm btn-secondary" onclick="viewSubmission(2)">👁️ View</button></td>
                            </tr>
                            <tr>
                                <td><strong>Responsive Portfolio Website</strong></td>
                                <td>Web Technologies</td>
                                <td>18 Jan 2026</td>
                                <td>30 Jan 2026</td>
                                <td><span class="badge badge-danger">Pending</span></td>
                                <td>-</td>
                                <td><button class="btn btn-sm btn-primary" onclick="submitAssignment(3)">📤 Submit</button></td>
                            </tr>
                            <tr>
                                <td><strong>Stack & Queue Implementation</strong></td>
                                <td>Data Structures</td>
                                <td>08 Jan 2026</td>
                                <td>18 Jan 2026</td>
                                <td><span class="badge badge-info">Graded</span></td>
                                <td><strong style="color: var(--success-color);">18/20</strong></td>
                                <td><button class="btn btn-sm btn-secondary" onclick="viewFeedback(4)">📋 Feedback</button></td>
                            </tr>
                            <tr>
                                <td><strong>CPU Scheduling Algorithms</strong></td>
                                <td>Operating Systems</td>
                                <td>10 Jan 2026</td>
                                <td>25 Jan 2026</td>
                                <td><span class="badge badge-warning">Pending</span></td>
                                <td>-</td>
                                <td><button class="btn btn-sm btn-primary" onclick="submitAssignment(5)">📤 Submit</button></td>
                            </tr>
                            <tr>
                                <td><strong>Normalization Examples</strong></td>
                                <td>DBMS</td>
                                <td>05 Jan 2026</td>
                                <td>15 Jan 2026</td>
                                <td><span class="badge badge-info">Graded</span></td>
                                <td><strong style="color: var(--success-color);">19/20</strong></td>
                                <td><button class="btn btn-sm btn-secondary" onclick="viewFeedback(6)">📋 Feedback</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
    
    <!-- Submit Assignment Modal -->
    <div id="submitModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>📤 Submit Assignment</h3>
                <span class="modal-close" onclick="closeModal('submitModal')">&times;</span>
            </div>
            <form onsubmit="return handleSubmit(event)">
                <div class="form-group">
                    <label>Assignment Title</label>
                    <input type="text" id="assignmentTitle" class="form-control" readonly>
                </div>
                <div class="form-group">
                    <label>Upload File</label>
                    <input type="file" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Comments (Optional)</label>
                    <textarea class="form-control" rows="3" placeholder="Any comments for faculty..."></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Submit Assignment</button>
            </form>
        </div>
    </div>
    
    <script src="../js/main.js"></script>
    <script>
        SessionManager.checkAuth();
        
        function submitAssignment(id) {
            document.getElementById('assignmentTitle').value = 'Assignment #' + id;
            openModal('submitModal');
        }
        
        function handleSubmit(event) {
            event.preventDefault();
            alert('Assignment submitted successfully!');
            closeModal('submitModal');
            NotificationManager.add('Assignment submitted successfully!', 'success');
            setTimeout(() => location.reload(), 1500);
            return false;
        }
        
        function viewSubmission(id) {
            alert('Viewing submission for assignment #' + id);
        }
        
        function viewFeedback(id) {
            alert('Faculty Feedback: Excellent work! Keep it up.');
        }
        
        function filterAssignments(status) {
            // Filter logic here
            console.log('Filtering by:', status);
        }
    </script>
</body>
</html>

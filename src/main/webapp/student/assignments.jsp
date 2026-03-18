<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignments - Student Portal</title>
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

.alert-danger {
    background: rgba(239, 68, 68, 0.15);
    border-left: 4px solid #ef4444;
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
                <li><a href="assignments.jsp" class="active"><i>📝</i> Assignments</a></li>
                <li><a href="internal-marks.jsp"><i>📊</i> Internal Marks</a></li>
                <li><a href="exam.jsp"><i>📋</i> Exam</a></li>
                <li><a href="results.jsp"><i>🏆</i> Results</a></li>
                <li><a href="requests.jsp"><i>📄</i> Requests</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="../index.html" onclick="return confirmLogout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>📝 My Assignments</h1>
                <div class="top-nav-right">
                    <a href="notifications.jsp" class="notification-icon" style="text-decoration: none; cursor: pointer;">🔔<span class="notification-badge">5</span></a>
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

// Modal Functions
function openModal(modalId) {
    var modal = document.getElementById(modalId);
    if (modal) {
        modal.style.display = 'flex';
        document.body.style.overflow = 'hidden'; // Prevent background scrolling
    }
}

function closeModal(modalId) {
    var modal = document.getElementById(modalId);
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
        var openModals = document.querySelectorAll('.modal');
        openModals.forEach(function(modal) {
            if (modal.style.display === 'flex') {
                closeModal(modal.id);
            }
        });
    }
});

// Show notification toast
function showNotification(message, type) {
    type = type || 'info';
    // Create notification element
    var notification = document.createElement('div');
    notification.className = "notification notification-" + type;
    notification.textContent = message;
    var borderColor = type === 'success' ? '#10b981' : type === 'error' ? '#ef4444' : '#3b82f6';
    notification.style.cssText = "position: fixed; top: 20px; right: 20px; background: rgba(11, 31, 59, 0.95); color: white; padding: 15px 20px; border-radius: 8px; border-left: 4px solid " + borderColor + "; z-index: 10000; animation: slideInRight 0.3s ease;";
    
    document.body.appendChild(notification);
    
    // Remove after 3 seconds
    setTimeout(function() {
        notification.style.animation = 'slideOutRight 0.3s ease';
        setTimeout(function() { notification.remove(); }, 300);
    }, 3000);
}
    </script>
    <script>
        function submitAssignment(id) {
            document.getElementById('assignmentTitle').value = 'Assignment #' + id;
            openModal('submitModal');
        }
        
        function handleSubmit(event) {
            event.preventDefault();
            alert('Assignment submitted successfully!');
            closeModal('submitModal');
            showNotification('Assignment submitted successfully!', 'success');
            setTimeout(function() { location.reload(); }, 1500);
            return false;
        }
        
        function viewSubmission(id) {
            alert('Viewing submission for assignment #' + id);
        }
        
        function viewFeedback(id) {
            alert('Faculty Feedback: Excellent work! Keep it up.');
        }
        
        function filterAssignments(status) {
            var rows = document.querySelectorAll('.table-container tbody tr');
            
            rows.forEach(function(row) {
                var statusCell = row.querySelector('td:nth-child(5)');
                if (!statusCell) return;
                
                var statusBadge = statusCell.querySelector('.badge');
                if (!statusBadge) return;
                
                var statusText = statusBadge.textContent.trim().toLowerCase();
                
                if (status === 'all') {
                    row.style.display = '';
                } else if (status === 'pending' && statusText === 'pending') {
                    row.style.display = '';
                } else if (status === 'submitted' && statusText === 'submitted') {
                    row.style.display = '';
                } else if (status === 'graded' && statusText === 'graded') {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>

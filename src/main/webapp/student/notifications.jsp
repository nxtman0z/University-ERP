<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications - Student Portal</title>
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

/* Notification Card */
.notification-card {
    background: rgba(11, 31, 59, 0.6);
    border: 1px solid rgba(200, 169, 81, 0.2);
    border-left: 4px solid #C8A951;
    border-radius: 8px;
    padding: 16px;
    margin-bottom: 12px;
    transition: all 0.3s ease;
}

.notification-card[data-status="read"] {
    border-left-color: rgba(200, 169, 81, 0.1);
    opacity: 0.7;
}

.notification-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 8px;
}

.notification-title {
    font-weight: 600;
    color: #C8A951;
    font-size: 1rem;
}

.notification-time {
    color: rgba(255, 255, 255, 0.5);
    font-size: 0.85rem;
}

.notification-content {
    color: rgba(255, 255, 255, 0.8);
    line-height: 1.5;
    margin-bottom: 12px;
    font-size: 0.95rem;
}

.notification-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.notification-meta {
    display: flex;
    gap: 12px;
    align-items: center;
    font-size: 0.85rem;
    color: rgba(255, 255, 255, 0.6);
}

/* CSS Variables */
:root {
    --primary-color: #C8A951;
    --text-secondary: rgba(255, 255, 255, 0.6);
    --light: rgba(255, 255, 255, 0.05);
    --warning-color: #fb923c;
    --success-color: #10b981;
    --danger-color: #ef4444;
    --border-color: rgba(255, 255, 255, 0.1);
}

/* Animations */
@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
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
                <li><a href="requests.jsp"><i>📄</i> Requests</a></li>
                <li><a href="notifications.jsp" class="active"><i>🔔</i> Notifications</a></li>
                <li><a href="../index.html" onclick="return confirmLogout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>🔔 Notifications</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">🔔<span class="notification-badge">5</span></div>
                    <div class="user-info">
                        <div class="user-avatar">S</div>
                        <span class="user-name">Student</span>
                    </div>
                </div>
            </nav>
            
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <div>
                    <button class="btn btn-sm btn-primary" onclick="markAllRead()">✅ Mark All as Read</button>
                    <button class="btn btn-sm btn-secondary" onclick="clearAll()">🗑️ Clear All</button>
                </div>
                <select class="form-control" style="width: 200px;" onchange="filterNotifications(this.value)">
                    <option value="all">All Notifications</option>
                    <option value="unread">Unread</option>
                    <option value="read">Read</option>
                </select>
            </div>
            
            <!-- Notification List -->
            <div style="display: flex; flex-direction: column; gap: 15px;">
                <!-- Unread Notification -->
                <div class="content-card" style="border-left: 4px solid var(--primary-color); background: #eff6ff;">
                    <div style="display: flex; justify-content: space-between; align-items: start;">
                        <div style="flex: 1;">
                            <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                                <div style="width: 40px; height: 40px; background: var(--primary-color); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 20px;">
                                    📢
                                </div>
                                <div>
                                    <h4 style="margin: 0; color: var(--primary-color);">New Notice Posted</h4>
                                    <small style="color: var(--text-secondary);">2 hours ago</small>
                                </div>
                            </div>
                            <p style="margin: 10px 0; padding-left: 50px;">
                                Semester exam schedule has been released. Please check the exam section for detailed timetable.
                            </p>
                        </div>
                        <button class="btn btn-sm btn-secondary" onclick="markRead(this)">✅</button>
                    </div>
                </div>
                
                <!-- Success Notification -->
                <div class="content-card" style="border-left: 4px solid var(--success-color); background: #f0fdf4;">
                    <div style="display: flex; justify-content: space-between; align-items: start;">
                        <div style="flex: 1;">
                            <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                                <div style="width: 40px; height: 40px; background: var(--success-color); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 20px;">
                                    ✅
                                </div>
                                <div>
                                    <h4 style="margin: 0; color: var(--success-color);">Assignment Graded</h4>
                                    <small style="color: var(--text-secondary);">5 hours ago</small>
                                </div>
                            </div>
                            <p style="margin: 10px 0; padding-left: 50px;">
                                Your DBMS assignment has been graded. You scored 19/20. Excellent work!
                            </p>
                        </div>
                        <button class="btn btn-sm btn-secondary" onclick="markRead(this)">✅</button>
                    </div>
                </div>
                
                <!-- Warning Notification -->
                <div class="content-card" style="border-left: 4px solid var(--warning-color); background: #fffbeb;">
                    <div style="display: flex; justify-content: space-between; align-items: start;">
                        <div style="flex: 1;">
                            <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                                <div style="width: 40px; height: 40px; background: var(--warning-color); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 20px;">
                                    ⚠️
                                </div>
                                <div>
                                    <h4 style="margin: 0; color: var(--warning-color);">Attendance Warning</h4>
                                    <small style="color: var(--text-secondary);">1 day ago</small>
                                </div>
                            </div>
                            <p style="margin: 10px 0; padding-left: 50px;">
                                Your attendance in Web Technologies is 77.78%, which is below the required 75%. Please attend more classes.
                            </p>
                        </div>
                        <button class="btn btn-sm btn-secondary" onclick="markRead(this)">✅</button>
                    </div>
                </div>
                
                <!-- Danger Notification -->
                <div class="content-card" style="border-left: 4px solid var(--danger-color); background: #fef2f2;">
                    <div style="display: flex; justify-content: space-between; align-items: start;">
                        <div style="flex: 1;">
                            <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                                <div style="width: 40px; height: 40px; background: var(--danger-color); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 20px;">
                                    💰
                                </div>
                                <div>
                                    <h4 style="margin: 0; color: var(--danger-color);">Fee Payment Reminder</h4>
                                    <small style="color: var(--text-secondary);">1 day ago</small>
                                </div>
                            </div>
                            <p style="margin: 10px 0; padding-left: 50px;">
                                Your Semester 5 fee payment of ₹50,000 is due on 25th January 2026. Please pay before the deadline to avoid late fees.
                            </p>
                        </div>
                        <button class="btn btn-sm btn-secondary" onclick="markRead(this)">✅</button>
                    </div>
                </div>
                
                <!-- Read Notification -->
                <div class="content-card" style="border-left: 4px solid var(--border-color); opacity: 0.7;">
                    <div style="display: flex; justify-content: space-between; align-items: start;">
                        <div style="flex: 1;">
                            <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                                <div style="width: 40px; height: 40px; background: var(--text-secondary); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 20px;">
                                    📝
                                </div>
                                <div>
                                    <h4 style="margin: 0; color: var(--text-secondary);">New Assignment Posted</h4>
                                    <small style="color: var(--text-secondary);">2 days ago • Read</small>
                                </div>
                            </div>
                            <p style="margin: 10px 0; padding-left: 50px;">
                                New assignment for Java Programming has been posted. Submission deadline: 30th January 2026.
                            </p>
                        </div>
                    </div>
                </div>
                
                <div class="content-card" style="border-left: 4px solid var(--border-color); opacity: 0.7;">
                    <div style="display: flex; justify-content: space-between; align-items: start;">
                        <div style="flex: 1;">
                            <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                                <div style="width: 40px; height: 40px; background: var(--text-secondary); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 20px;">
                                    ✅
                                </div>
                                <div>
                                    <h4 style="margin: 0; color: var(--text-secondary);">Request Approved</h4>
                                    <small style="color: var(--text-secondary);">3 days ago • Read</small>
                                </div>
                            </div>
                            <p style="margin: 10px 0; padding-left: 50px;">
                                Your Bonafide certificate request has been approved. You can download it from the requests section.
                            </p>
                        </div>
                    </div>
                </div>
                
                <div class="content-card" style="border-left: 4px solid var(--border-color); opacity: 0.7;">
                    <div style="display: flex; justify-content: space-between; align-items: start;">
                        <div style="flex: 1;">
                            <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px;">
                                <div style="width: 40px; height: 40px; background: var(--text-secondary); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 20px;">
                                    🎉
                                </div>
                                <div>
                                    <h4 style="margin: 0; color: var(--text-secondary);">Results Published</h4>
                                    <small style="color: var(--text-secondary);">5 days ago • Read</small>
                                </div>
                            </div>
                            <p style="margin: 10px 0; padding-left: 50px;">
                                Your Semester 4 results have been published. Congratulations on your excellent performance!
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Empty State (Hidden by default) -->
            <div id="emptyState" class="content-card" style="display: none; text-align: center; padding: 60px 20px;">
                <div style="font-size: 64px; margin-bottom: 20px;">🔔</div>
                <h3 style="color: var(--text-secondary);">No Notifications</h3>
                <p style="color: var(--text-secondary);">You're all caught up! No new notifications.</p>
            </div>
        </main>
    </div>
    
    <script src="../js/main.js"></script>
    <script>
        function markRead(button) {
            const card = button.closest('.content-card');
            card.style.opacity = '0.7';
            card.style.borderLeftColor = 'var(--border-color)';
            const badge = card.querySelector('small');
            if (badge) {
                badge.textContent += ' • Read';
            }
            button.remove();
            showNotification('Notification marked as read', 'success');
        }
        
        function markAllRead() {
            const buttons = document.querySelectorAll('.content-card button');
            buttons.forEach(btn => {
                const card = btn.closest('.content-card');
                card.style.opacity = '0.7';
                card.style.borderLeftColor = 'var(--border-color)';
                btn.remove();
            });
            const badge = document.querySelector('.notification-badge');
            if (badge) {
                badge.textContent = '0';
            }
            showNotification('All notifications marked as read', 'success');
        }
        
        function clearAll() {
            if (confirm('Are you sure you want to clear all notifications?')) {
                const cards = document.querySelectorAll('[style*="border-left"]');
                cards.forEach(card => {
                    if (card.classList.contains('content-card')) {
                        card.remove();
                    }
                });
                document.getElementById('emptyState').style.display = 'block';
                const badge = document.querySelector('.notification-badge');
                if (badge) {
                    badge.textContent = '0';
                }
                showNotification('All notifications cleared', 'warning');
            }
        }
        
        function filterNotifications(filter) {
            console.log('Filtering by:', filter);
        }
        
        function showNotification(message, type) {
            const toast = document.createElement('div');
            toast.textContent = message;
            toast.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 12px 20px;
                background: ${type === 'success' ? '#10b981' : type === 'warning' ? '#fb923c' : '#3b82f6'};
                color: white;
                border-radius: 8px;
                z-index: 9999;
                animation: slideInRight 0.3s ease;
            `;
            document.body.appendChild(toast);
            setTimeout(() => toast.remove(), 3000);
        }
    </script>
</body>
</html>

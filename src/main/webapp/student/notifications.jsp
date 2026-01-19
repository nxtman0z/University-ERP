<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications - Student Portal</title>
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
                <li><a href="requests.jsp"><i>📄</i> Requests</a></li>
                <li><a href="notifications.jsp" class="active"><i>🔔</i> Notifications</a></li>
                <li><a href="#" onclick="logout()"><i>🚪</i> Logout</a></li>
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
        SessionManager.checkAuth();
        
        function markRead(button) {
            const card = button.closest('.content-card');
            card.style.opacity = '0.7';
            card.style.borderLeftColor = 'var(--border-color)';
            const badge = card.querySelector('small');
            if (badge) {
                badge.textContent += ' • Read';
            }
            button.remove();
            NotificationManager.add('Notification marked as read', 'success');
        }
        
        function markAllRead() {
            const buttons = document.querySelectorAll('.content-card button');
            buttons.forEach(btn => {
                const card = btn.closest('.content-card');
                card.style.opacity = '0.7';
                card.style.borderLeftColor = 'var(--border-color)';
                btn.remove();
            });
            document.querySelector('.notification-badge').textContent = '0';
            NotificationManager.add('All notifications marked as read', 'success');
        }
        
        function clearAll() {
            if (confirm('Are you sure you want to clear all notifications?')) {
                const cards = document.querySelectorAll('.content-card');
                cards.forEach(card => card.remove());
                document.getElementById('emptyState').style.display = 'block';
                document.querySelector('.notification-badge').textContent = '0';
                NotificationManager.add('All notifications cleared', 'warning');
            }
        }
        
        function filterNotifications(filter) {
            // Filter logic here
            console.log('Filtering by:', filter);
        }
    </script>
</body>
</html>

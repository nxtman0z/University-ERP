<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Attendance - Faculty Portal</title>
    <link rel="stylesheet" href="../style.css">
    <style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body { font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; background: linear-gradient(135deg, #0B1F3B 0%, #0d2444 20%, #112a4e 40%, #0e2a50 60%, #091929 80%, #0B1F3B 100%); min-height: 100vh; color: #fff; }
.dashboard-container { display: flex; min-height: 100vh; }
.sidebar { width: 260px; background: rgba(11, 31, 59, 0.8); backdrop-filter: blur(12px); border-right: 1px solid rgba(200, 169, 81, 0.1); padding: 20px; position: fixed; height: 100vh; overflow-y: auto; }
.sidebar-header { margin-bottom: 30px; padding-bottom: 20px; border-bottom: 1px solid rgba(200, 169, 81, 0.2); }
.sidebar-header h2 { color: #C8A951; font-size: 1.25rem; margin-bottom: 5px; }
.sidebar-header p { color: rgba(255, 255, 255, 0.6); font-size: 0.875rem; }
.sidebar-menu { list-style: none; }
.sidebar-menu li { margin-bottom: 8px; }
.sidebar-menu a { display: flex; align-items: center; padding: 12px 16px; color: rgba(255, 255, 255, 0.7); text-decoration: none; border-radius: 8px; transition: all 0.3s ease; }
.sidebar-menu a:hover, .sidebar-menu a.active { background: rgba(200, 169, 81, 0.15); color: #C8A951; }
.sidebar-menu a i { margin-right: 12px; font-style: normal; }
.main-content { margin-left: 260px; flex: 1; padding: 20px; }
.top-nav { background: rgba(11, 31, 59, 0.6); backdrop-filter: blur(12px); border: 1px solid rgba(200, 169, 81, 0.1); border-radius: 12px; padding: 20px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
.top-nav h1 { color: #C8A951; font-size: 1.75rem; }
.top-nav-right { display: flex; align-items: center; gap: 20px; }
.notification-icon { position: relative; font-size: 1.5rem; cursor: pointer; }
.notification-badge { position: absolute; top: -5px; right: -5px; background: #ef4444; color: white; font-size: 0.75rem; padding: 2px 6px; border-radius: 10px; }
.user-info { display: flex; align-items: center; gap: 10px; }
.user-avatar { width: 40px; height: 40px; background: linear-gradient(135deg, #C8A951, #dcc574); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: #0B1F3B; font-weight: bold; }
.user-name { color: rgba(255, 255, 255, 0.9); font-weight: 500; }
.content-card { background: rgba(11, 31, 59, 0.6); backdrop-filter: blur(12px); border: 1px solid rgba(200, 169, 81, 0.1); border-radius: 12px; padding: 20px; margin-bottom: 20px; }
.card-header { margin-bottom: 15px; display: flex; justify-content: space-between; align-items: center; }
.card-header h3 { color: #C8A951; font-size: 1.25rem; }
.form-control { width: 100%; padding: 12px 15px; background: rgba(255, 255, 255, 0.08); border: 1px solid rgba(200, 169, 81, 0.3); border-radius: 8px; color: rgba(255, 255, 255, 0.95); font-size: 0.95rem; }
.form-control:focus { outline: none; border-color: #C8A951; }
table { width: 100%; border-collapse: collapse; }
thead tr { background: #C8A951; }
th { padding: 15px; text-align: left; color: #0B1F3B; font-weight: 700; background: #C8A951; }
td { padding: 12px; border-bottom: 1px solid rgba(255, 255, 255, 0.05); color: rgba(255, 255, 255, 0.8); }
tbody tr:hover { background: rgba(200, 169, 81, 0.05); }
.btn { padding: 10px 20px; border: none; border-radius: 8px; font-weight: 500; cursor: pointer; transition: all 0.3s ease; display: inline-block; }
.btn-primary { background: #C8A951; color: #0B1F3B; }
.btn-primary:hover { background: #dcc574; transform: translateY(-2px); }
.btn-secondary { background: rgba(255, 255, 255, 0.1); color: rgba(255, 255, 255, 0.9); }
.btn-secondary:hover { background: rgba(255, 255, 255, 0.15); }
    </style>
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
                <li><a href="attendance-marking.jsp"><i>📅</i> Mark Attendance</a></li>
                <li><a href="view-attendance.jsp" class="active"><i>📊</i> View Attendance</a></li>
                <li><a href="assignments.jsp"><i>📝</i> Assignments</a></li>
                <li><a href="marks-entry.jsp"><i>✏️</i> Marks Entry</a></li>
                <li><a href="students.jsp"><i>👥</i> My Students</a></li>
                <li><a href="timetable.jsp"><i>🕐</i> My Timetable</a></li>
                <li><a href="approvals.jsp"><i>✅</i> Approvals</a></li>
                <li><a href="notices.jsp"><i>📢</i> Notices</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="../index.html"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        <main class="main-content">
            <nav class="top-nav">
                <h1>📊 View Attendance</h1>
                <div class="top-nav-right">
                    <div class="notification-icon" onclick="window.location.href='notifications.jsp'" style="cursor: pointer;">🔔<span class="notification-badge">0</span></div>
                    <div class="user-info">
                        <div class="user-avatar">F</div>
                        <span class="user-name">Faculty</span>
                    </div>
                </div>
            </nav>
            <div class="content-card">
                <div class="card-header">
                    <h3>📊 Attendance Report</h3>
                </div>
                <div style="text-align: center; padding: 40px;">
                    <div style="font-size: 3rem; margin-bottom: 10px;">📅</div>
                    <div style="color: rgba(255,255,255,0.6);">Attendance data will appear here</div>
                </div>
            </div>
        </main>
    </div>
    
    <script>
        function logout() {
            if(confirm('Are you sure you want to logout?')) {
                window.location.href = '../index.html';
            }
        }
    </script>
</body>
</html>
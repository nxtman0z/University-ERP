<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: Arial, sans-serif; 
            background: #0B1F3B; 
            color: #fff; 
            min-height: 100vh;
        }
        .container { 
            max-width: 1200px; 
            margin: 0 auto; 
            padding: 20px; 
        }
        h1 { 
            color: #C8A951; 
            margin: 20px 0; 
            text-align: center;
        }
        .sidebar {
            background: rgba(11, 31, 59, 0.9);
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .sidebar h2 {
            color: #C8A951;
            margin-bottom: 15px;
        }
        .sidebar ul {
            list-style: none;
        }
        .sidebar li {
            padding: 8px 0;
            border-bottom: 1px solid rgba(200, 169, 81, 0.1);
        }
        .sidebar a {
            color: #fff;
            text-decoration: none;
            font-size: 14px;
        }
        .sidebar a:hover {
            color: #C8A951;
        }
        .content {
            background: rgba(11, 31, 59, 0.6);
            padding: 20px;
            border-radius: 8px;
            border: 1px solid rgba(200, 169, 81, 0.1);
        }
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin: 20px 0;
        }
        .stat-card {
            background: rgba(11, 31, 59, 0.8);
            padding: 15px;
            border-radius: 8px;
            border: 1px solid rgba(200, 169, 81, 0.2);
            text-align: center;
        }
        .stat-value {
            font-size: 24px;
            color: #C8A951;
            font-weight: bold;
        }
        .stat-label {
            font-size: 12px;
            color: rgba(255, 255, 255, 0.7);
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📊 Student Dashboard</h1>
        
        <div class="sidebar">
            <h2>Navigation</h2>
            <ul>
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li><a href="profile.jsp">My Profile</a></li>
                <li><a href="attendance.jsp">Attendance</a></li>
                <li><a href="timetable.jsp">Timetable</a></li>
                <li><a href="fees.jsp">Fees & Payments</a></li>
                <li><a href="assignments.jsp">Assignments</a></li>
                <li><a href="internal-marks.jsp">Internal Marks</a></li>
                <li><a href="exam.jsp">Exam</a></li>
                <li><a href="results.jsp">Results</a></li>
                <li><a href="library-pass.jsp">Library Pass</a></li>
                <li><a href="requests.jsp">Requests</a></li>
                <li><a href="notifications.jsp">Notifications</a></li>
                <li><a href="../index.html">Logout</a></li>
            </ul>
        </div>
        
        <div class="content">
            <h2 style="color: #C8A951; margin-bottom: 15px;">Welcome Back! 👋</h2>
            <p style="color: rgba(255, 255, 255, 0.8); margin-bottom: 20px;">Here's your academic overview for this semester.</p>
            
            <div class="stats">
                <div class="stat-card">
                    <div class="stat-value">85%</div>
                    <div class="stat-label">Overall Attendance</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">8.2</div>
                    <div class="stat-label">Current CGPA</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">4/5</div>
                    <div class="stat-label">Assignments Done</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">3</div>
                    <div class="stat-label">New Messages</div>
                </div>
            </div>
            
            <h3 style="color: #C8A951; margin-top: 25px; margin-bottom: 15px;">📅 Upcoming Events</h3>
            <ul style="list-style: none; color: rgba(255, 255, 255, 0.8);">
                <li>✓ Mid-term Exams - March 25, 2026</li>
                <li>✓ Assignment Submission Deadline - March 20, 2026</li>
                <li>✓ Class Starts - March 18, 2026</li>
            </ul>
        </div>
    </div>
</body>
</html>

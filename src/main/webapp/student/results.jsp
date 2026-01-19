<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Results - Student Portal</title>
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
                <li><a href="results.jsp" class="active"><i>🏆</i> Results</a></li>
                <li><a href="requests.jsp"><i>📄</i> Requests</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="#" onclick="logout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <main class="main-content">
            <nav class="top-nav">
                <h1>🏆 My Results</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">🔔<span class="notification-badge">5</span></div>
                    <div class="user-info">
                        <div class="user-avatar">S</div>
                        <span class="user-name">Student</span>
                    </div>
                </div>
            </nav>
            
            <div class="alert alert-success">
                <strong>🎉 Congratulations!</strong> Your Semester 4 results have been declared. You've scored excellent marks!
            </div>
            
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value" style="color: var(--success-color);">8.7</div>
                            <div class="stat-card-label">Current CGPA</div>
                        </div>
                        <div class="stat-card-icon green">🏆</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value">9.1</div>
                    <div class="stat-card-label">Semester 4 SGPA</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value">451/500</div>
                    <div class="stat-card-label">Total Marks</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-value">90.2%</div>
                    <div class="stat-card-label">Percentage</div>
                </div>
            </div>
            
            <div class="content-card">
                <div class="card-header">
                    <h3>📊 Semester 4 Result - Detailed Marks</h3>
                    <div>
                        <button class="btn btn-sm btn-success" onclick="downloadMarksheet()">📥 Download Marksheet</button>
                        <button class="btn btn-sm btn-primary" onclick="printPage()">🖨️ Print</button>
                    </div>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Subject Code</th>
                                <th>Subject Name</th>
                                <th>Internal (20)</th>
                                <th>External (80)</th>
                                <th>Total (100)</th>
                                <th>Grade</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>CS101</td>
                                <td>Java Programming</td>
                                <td>18</td>
                                <td>75</td>
                                <td><strong>93</strong></td>
                                <td><span class="badge badge-success">A+</span></td>
                                <td><span class="badge badge-success">Pass</span></td>
                            </tr>
                            <tr>
                                <td>CS102</td>
                                <td>Data Structures</td>
                                <td>17</td>
                                <td>70</td>
                                <td><strong>87</strong></td>
                                <td><span class="badge badge-success">A</span></td>
                                <td><span class="badge badge-success">Pass</span></td>
                            </tr>
                            <tr>
                                <td>CS103</td>
                                <td>Database Management</td>
                                <td>19</td>
                                <td>78</td>
                                <td><strong>97</strong></td>
                                <td><span class="badge badge-success">A+</span></td>
                                <td><span class="badge badge-success">Pass</span></td>
                            </tr>
                            <tr>
                                <td>CS104</td>
                                <td>Web Technologies</td>
                                <td>16</td>
                                <td>68</td>
                                <td><strong>84</strong></td>
                                <td><span class="badge badge-success">A</span></td>
                                <td><span class="badge badge-success">Pass</span></td>
                            </tr>
                            <tr>
                                <td>CS105</td>
                                <td>Operating Systems</td>
                                <td>18</td>
                                <td>72</td>
                                <td><strong>90</strong></td>
                                <td><span class="badge badge-success">A+</span></td>
                                <td><span class="badge badge-success">Pass</span></td>
                            </tr>
                            <tr style="background: var(--light); font-weight: bold;">
                                <td colspan="2">Total</td>
                                <td>88/100</td>
                                <td>363/400</td>
                                <td>451/500</td>
                                <td>90.2%</td>
                                <td><span class="badge badge-success">PASS</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="content-card">
                <div class="card-header">
                    <h3>📈 Semester-wise Performance</h3>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Semester</th>
                                <th>Total Marks</th>
                                <th>Obtained</th>
                                <th>Percentage</th>
                                <th>SGPA</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Semester 1</td>
                                <td>500</td>
                                <td>410</td>
                                <td>82.0%</td>
                                <td>8.2</td>
                                <td><span class="badge badge-success">Pass</span></td>
                            </tr>
                            <tr>
                                <td>Semester 2</td>
                                <td>500</td>
                                <td>425</td>
                                <td>85.0%</td>
                                <td>8.5</td>
                                <td><span class="badge badge-success">Pass</span></td>
                            </tr>
                            <tr>
                                <td>Semester 3</td>
                                <td>500</td>
                                <td>440</td>
                                <td>88.0%</td>
                                <td>8.8</td>
                                <td><span class="badge badge-success">Pass</span></td>
                            </tr>
                            <tr style="background: #d1fae5;">
                                <td>Semester 4</td>
                                <td>500</td>
                                <td>451</td>
                                <td>90.2%</td>
                                <td>9.1</td>
                                <td><span class="badge badge-success">Pass</span></td>
                            </tr>
                            <tr style="font-weight: bold; background: var(--light);">
                                <td>Overall</td>
                                <td>2000</td>
                                <td>1726</td>
                                <td>86.3%</td>
                                <td><strong style="color: var(--success-color); font-size: 18px;">8.7 CGPA</strong></td>
                                <td>-</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="dashboard-grid">
                <div class="content-card">
                    <h3 style="margin-bottom: 15px;">🎯 Grade Distribution</h3>
                    <div style="display: flex; flex-direction: column; gap: 10px;">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span>A+ Grade</span>
                            <span style="font-weight: bold; color: var(--success-color);">3 Subjects</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span>A Grade</span>
                            <span style="font-weight: bold; color: var(--info-color);">2 Subjects</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span>B+ Grade</span>
                            <span style="font-weight: bold;">0 Subjects</span>
                        </div>
                    </div>
                </div>
                
                <div class="content-card">
                    <h3 style="margin-bottom: 15px;">📋 Re-evaluation</h3>
                    <p style="color: var(--text-secondary); margin-bottom: 15px;">Apply for re-evaluation if you're not satisfied with your marks.</p>
                    <button class="btn btn-warning" onclick="applyReeval()">Apply for Re-evaluation</button>
                </div>
            </div>
        </main>
    </div>
    
    <script src="../js/main.js"></script>
    <script>
        SessionManager.checkAuth();
        
        function downloadMarksheet() {
            alert('Downloading marksheet...');
            NotificationManager.add('Marksheet downloaded successfully!', 'success');
        }
        
        function applyReeval() {
            window.location.href = 'requests.jsp?type=reeval';
        }
    </script>
</body>
</html>

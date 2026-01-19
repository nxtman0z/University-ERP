<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fees & Payments - Student Portal</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
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
                <li><a href="fees.jsp" class="active"><i>💰</i> Fees & Payments</a></li>
                <li><a href="assignments.jsp"><i>📝</i> Assignments</a></li>
                <li><a href="internal-marks.jsp"><i>📊</i> Internal Marks</a></li>
                <li><a href="exam.jsp"><i>📋</i> Exam</a></li>
                <li><a href="results.jsp"><i>🏆</i> Results</a></li>
                <li><a href="requests.jsp"><i>📄</i> Requests</a></li>
                <li><a href="notifications.jsp"><i>🔔</i> Notifications</a></li>
                <li><a href="#" onclick="logout()"><i>🚪</i> Logout</a></li>
            </ul>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <!-- Top Navigation -->
            <nav class="top-nav">
                <h1>💰 Fees & Payments</h1>
                <div class="top-nav-right">
                    <div class="notification-icon">
                        🔔
                        <span class="notification-badge">5</span>
                    </div>
                    <div class="user-info">
                        <div class="user-avatar">S</div>
                        <span class="user-name">Student</span>
                    </div>
                </div>
            </nav>
            
            <!-- Fee Summary Cards -->
            <div class="dashboard-grid">
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">₹2,50,000</div>
                            <div class="stat-card-label">Total Fees</div>
                        </div>
                        <div class="stat-card-icon blue">📊</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value" style="color: var(--success-color);">₹1,80,000</div>
                            <div class="stat-card-label">Paid Amount</div>
                        </div>
                        <div class="stat-card-icon green">✅</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value" style="color: var(--danger-color);">₹70,000</div>
                            <div class="stat-card-label">Pending Amount</div>
                        </div>
                        <div class="stat-card-icon red">⚠️</div>
                    </div>
                    <span class="badge badge-danger">Action Required</span>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">
                        <div>
                            <div class="stat-card-value">25 Jan</div>
                            <div class="stat-card-label">Next Due Date</div>
                        </div>
                        <div class="stat-card-icon orange">📅</div>
                    </div>
                </div>
            </div>
            
            <!-- Payment Alert -->
            <div class="alert alert-danger">
                <strong>⚠️ Payment Due:</strong> Your Semester 5 fee payment is due on 25th January 2026. Please pay ₹50,000 before the deadline.
            </div>
            
            <!-- Fee Structure -->
            <div class="content-card">
                <div class="card-header">
                    <h3>📋 Semester-wise Fee Details</h3>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Semester</th>
                                <th>Total Fee</th>
                                <th>Tuition Fee</th>
                                <th>Other Charges</th>
                                <th>Paid Amount</th>
                                <th>Pending</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Semester 1</td>
                                <td>₹50,000</td>
                                <td>₹40,000</td>
                                <td>₹10,000</td>
                                <td>₹50,000</td>
                                <td>₹0</td>
                                <td><span class="badge badge-success">Paid</span></td>
                                <td><button class="btn btn-sm btn-secondary" onclick="downloadReceipt(1)">📥 Receipt</button></td>
                            </tr>
                            <tr>
                                <td>Semester 2</td>
                                <td>₹50,000</td>
                                <td>₹40,000</td>
                                <td>₹10,000</td>
                                <td>₹50,000</td>
                                <td>₹0</td>
                                <td><span class="badge badge-success">Paid</span></td>
                                <td><button class="btn btn-sm btn-secondary" onclick="downloadReceipt(2)">📥 Receipt</button></td>
                            </tr>
                            <tr>
                                <td>Semester 3</td>
                                <td>₹50,000</td>
                                <td>₹40,000</td>
                                <td>₹10,000</td>
                                <td>₹50,000</td>
                                <td>₹0</td>
                                <td><span class="badge badge-success">Paid</span></td>
                                <td><button class="btn btn-sm btn-secondary" onclick="downloadReceipt(3)">📥 Receipt</button></td>
                            </tr>
                            <tr style="background: #fef3c7;">
                                <td>Semester 4</td>
                                <td>₹50,000</td>
                                <td>₹40,000</td>
                                <td>₹10,000</td>
                                <td>₹30,000</td>
                                <td>₹20,000</td>
                                <td><span class="badge badge-warning">Partial</span></td>
                                <td><button class="btn btn-sm btn-warning" onclick="payFee(4)">💳 Pay Now</button></td>
                            </tr>
                            <tr style="background: #fee2e2;">
                                <td>Semester 5</td>
                                <td>₹50,000</td>
                                <td>₹40,000</td>
                                <td>₹10,000</td>
                                <td>₹0</td>
                                <td>₹50,000</td>
                                <td><span class="badge badge-danger">Pending</span></td>
                                <td><button class="btn btn-sm btn-danger" onclick="payFee(5)">💳 Pay Now</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Payment History -->
            <div class="content-card">
                <div class="card-header">
                    <h3>📜 Recent Payment History</h3>
                    <button class="btn btn-sm btn-primary" onclick="exportTableToCSV('paymentHistory', 'payment-history')">
                        📥 Export
                    </button>
                </div>
                <div class="table-container">
                    <table id="paymentHistory">
                        <thead>
                            <tr>
                                <th>Transaction ID</th>
                                <th>Date</th>
                                <th>Semester</th>
                                <th>Amount</th>
                                <th>Payment Mode</th>
                                <th>Status</th>
                                <th>Receipt</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>TXN2026010001</td>
                                <td>10 Jan 2026</td>
                                <td>Semester 4</td>
                                <td>₹30,000</td>
                                <td>Online Banking</td>
                                <td><span class="badge badge-success">Success</span></td>
                                <td><button class="btn btn-sm btn-secondary" onclick="downloadReceipt('TXN2026010001')">📥</button></td>
                            </tr>
                            <tr>
                                <td>TXN2025120015</td>
                                <td>15 Dec 2025</td>
                                <td>Semester 3</td>
                                <td>₹50,000</td>
                                <td>UPI</td>
                                <td><span class="badge badge-success">Success</span></td>
                                <td><button class="btn btn-sm btn-secondary" onclick="downloadReceipt('TXN2025120015')">📥</button></td>
                            </tr>
                            <tr>
                                <td>TXN2025080020</td>
                                <td>20 Aug 2025</td>
                                <td>Semester 2</td>
                                <td>₹50,000</td>
                                <td>Credit Card</td>
                                <td><span class="badge badge-success">Success</span></td>
                                <td><button class="btn btn-sm btn-secondary" onclick="downloadReceipt('TXN2025080020')">📥</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Fee Breakup -->
            <div class="content-card">
                <div class="card-header">
                    <h3>💵 Fee Structure Breakup</h3>
                </div>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px;">
                    <div style="padding: 20px; background: var(--light); border-radius: 12px;">
                        <h4 style="color: var(--primary-color); margin-bottom: 10px;">Tuition Fee</h4>
                        <div style="font-size: 24px; font-weight: bold;">₹40,000</div>
                        <div style="font-size: 13px; color: var(--text-secondary); margin-top: 5px;">Per Semester</div>
                    </div>
                    <div style="padding: 20px; background: var(--light); border-radius: 12px;">
                        <h4 style="color: var(--primary-color); margin-bottom: 10px;">Library Fee</h4>
                        <div style="font-size: 24px; font-weight: bold;">₹3,000</div>
                        <div style="font-size: 13px; color: var(--text-secondary); margin-top: 5px;">Per Semester</div>
                    </div>
                    <div style="padding: 20px; background: var(--light); border-radius: 12px;">
                        <h4 style="color: var(--primary-color); margin-bottom: 10px;">Lab Fee</h4>
                        <div style="font-size: 24px; font-weight: bold;">₹5,000</div>
                        <div style="font-size: 13px; color: var(--text-secondary); margin-top: 5px;">Per Semester</div>
                    </div>
                    <div style="padding: 20px; background: var(--light); border-radius: 12px;">
                        <h4 style="color: var(--primary-color); margin-bottom: 10px;">Other Charges</h4>
                        <div style="font-size: 24px; font-weight: bold;">₹2,000</div>
                        <div style="font-size: 13px; color: var(--text-secondary); margin-top: 5px;">Per Semester</div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <!-- Payment Modal -->
    <div id="paymentModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>💳 Make Payment</h3>
                <span class="modal-close" onclick="closeModal('paymentModal')">&times;</span>
            </div>
            <form onsubmit="return processPayment(event)">
                <div class="form-group">
                    <label>Semester</label>
                    <input type="text" id="paySemester" class="form-control" readonly>
                </div>
                <div class="form-group">
                    <label>Amount to Pay</label>
                    <input type="text" id="payAmount" class="form-control" readonly>
                </div>
                <div class="form-group">
                    <label>Payment Mode</label>
                    <select class="form-control" required>
                        <option value="">Select Mode</option>
                        <option value="upi">UPI</option>
                        <option value="netbanking">Net Banking</option>
                        <option value="card">Credit/Debit Card</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Proceed to Pay</button>
            </form>
        </div>
    </div>
    
    <script src="../js/main.js"></script>
    <script>
        SessionManager.checkAuth();
        
        function payFee(semester) {
            document.getElementById('paySemester').value = 'Semester ' + semester;
            if (semester === 4) {
                document.getElementById('payAmount').value = '₹20,000';
            } else if (semester === 5) {
                document.getElementById('payAmount').value = '₹50,000';
            }
            openModal('paymentModal');
        }
        
        function processPayment(event) {
            event.preventDefault();
            alert('Payment Successful! Transaction ID: TXN' + Date.now());
            closeModal('paymentModal');
            NotificationManager.add('Payment completed successfully!', 'success');
            setTimeout(() => location.reload(), 1500);
            return false;
        }
        
        function downloadReceipt(id) {
            alert('Downloading receipt for: ' + id);
            NotificationManager.add('Receipt downloaded successfully!', 'success');
        }
    </script>
</body>
</html>

// ========================================
// UNIVERSITY ERP - Main JavaScript File
// ========================================

// Session Management
const SessionManager = {
    setUser: function(user) {
        sessionStorage.setItem('user', JSON.stringify(user));
    },
    
    getUser: function() {
        const user = sessionStorage.getItem('user');
        return user ? JSON.parse(user) : null;
    },
    
    logout: function() {
        sessionStorage.clear();
        window.location.href = 'login.jsp';
    },
    
    checkAuth: function() {
        const user = this.getUser();
        if (!user) {
            window.location.href = 'login.jsp';
        }
        return user;
    }
};

// Notification System
const NotificationManager = {
    notifications: [],
    
    add: function(message, type = 'info') {
        const notification = {
            id: Date.now(),
            message: message,
            type: type,
            timestamp: new Date()
        };
        this.notifications.unshift(notification);
        this.updateBadge();
        this.show(notification);
    },
    
    show: function(notification) {
        const alertDiv = document.createElement('div');
        alertDiv.className = `alert alert-${notification.type}`;
        alertDiv.style.position = 'fixed';
        alertDiv.style.top = '20px';
        alertDiv.style.right = '20px';
        alertDiv.style.zIndex = '9999';
        alertDiv.style.minWidth = '300px';
        alertDiv.innerHTML = notification.message;
        
        document.body.appendChild(alertDiv);
        
        setTimeout(() => {
            alertDiv.remove();
        }, 3000);
    },
    
    updateBadge: function() {
        const badge = document.querySelector('.notification-badge');
        if (badge) {
            badge.textContent = this.notifications.length;
        }
    },
    
    getAll: function() {
        return this.notifications;
    }
};

// Modal Handler
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.add('show');
    }
}

function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.remove('show');
    }
}

// Form Validation
function validateForm(formId) {
    const form = document.getElementById(formId);
    if (!form) return false;
    
    const inputs = form.querySelectorAll('input[required], select[required], textarea[required]');
    let isValid = true;
    
    inputs.forEach(input => {
        if (!input.value.trim()) {
            input.style.borderColor = 'var(--danger-color)';
            isValid = false;
        } else {
            input.style.borderColor = 'var(--border-color)';
        }
    });
    
    return isValid;
}

// Login Handler
function handleLogin(event) {
    event.preventDefault();
    
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const role = document.getElementById('role').value;
    
    if (!username || !password || !role) {
        alert('Please fill all fields!');
        return false;
    }
    
    // Demo authentication (No database)
    const user = {
        username: username,
        role: role,
        name: username.charAt(0).toUpperCase() + username.slice(1),
        loginTime: new Date().toISOString()
    };
    
    SessionManager.setUser(user);
    
    // Redirect based on role
    switch(role) {
        case 'student':
            window.location.href = 'student/dashboard.jsp';
            break;
        case 'faculty':
            window.location.href = 'faculty/dashboard.jsp';
            break;
        case 'admin':
            window.location.href = 'admin/dashboard.jsp';
            break;
        case 'head':
            window.location.href = 'head/dashboard.jsp';
            break;
        default:
            alert('Invalid role!');
    }
    
    return false;
}

// Attendance Calculator
function calculateAttendance(present, total) {
    if (total === 0) return 0;
    return ((present / total) * 100).toFixed(2);
}

// Fee Calculator
function calculatePendingFees(totalFee, paidFee) {
    return totalFee - paidFee;
}

// CGPA Calculator
function calculateCGPA(marks) {
    if (!marks || marks.length === 0) return 0;
    
    const total = marks.reduce((sum, mark) => sum + mark, 0);
    const average = total / marks.length;
    const cgpa = (average / 10).toFixed(2);
    return cgpa;
}

// Date Formatter
function formatDate(date) {
    const d = new Date(date);
    const day = String(d.getDate()).padStart(2, '0');
    const month = String(d.getMonth() + 1).padStart(2, '0');
    const year = d.getFullYear();
    return `${day}/${month}/${year}`;
}

// Search Filter
function filterTable(inputId, tableId) {
    const input = document.getElementById(inputId);
    const filter = input.value.toLowerCase();
    const table = document.getElementById(tableId);
    const rows = table.getElementsByTagName('tr');
    
    for (let i = 1; i < rows.length; i++) {
        const row = rows[i];
        const cells = row.getElementsByTagName('td');
        let found = false;
        
        for (let j = 0; j < cells.length; j++) {
            const cell = cells[j];
            if (cell) {
                const textValue = cell.textContent || cell.innerText;
                if (textValue.toLowerCase().indexOf(filter) > -1) {
                    found = true;
                    break;
                }
            }
        }
        
        row.style.display = found ? '' : 'none';
    }
}

// Export to CSV
function exportTableToCSV(tableId, filename) {
    const table = document.getElementById(tableId);
    const rows = table.querySelectorAll('tr');
    const csv = [];
    
    rows.forEach(row => {
        const cols = row.querySelectorAll('td, th');
        const rowData = [];
        cols.forEach(col => rowData.push(col.textContent));
        csv.push(rowData.join(','));
    });
    
    const csvContent = csv.join('\n');
    const blob = new Blob([csvContent], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = filename + '.csv';
    a.click();
}

// Print Page
function printPage() {
    window.print();
}

// Toggle Sidebar (Mobile)
function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    if (sidebar) {
        sidebar.classList.toggle('show');
    }
}

// Initialize Page
document.addEventListener('DOMContentLoaded', function() {
    // Check if on dashboard page
    if (window.location.pathname.includes('dashboard.jsp')) {
        const user = SessionManager.getUser();
        if (user) {
            // Update user info in nav
            const userNameElem = document.querySelector('.user-name');
            if (userNameElem) {
                userNameElem.textContent = user.name;
            }
            
            const userAvatarElem = document.querySelector('.user-avatar');
            if (userAvatarElem) {
                userAvatarElem.textContent = user.name.charAt(0);
            }
        }
    }
    
    // Close modal on outside click
    window.addEventListener('click', function(e) {
        if (e.target.classList.contains('modal')) {
            e.target.classList.remove('show');
        }
    });
});

// Logout Handler
function logout() {
    if (confirm('Are you sure you want to logout?')) {
        SessionManager.logout();
    }
}

// Demo Data Generators (For frontend testing)
const DemoData = {
    students: [
        { rollNo: 'BCA001', name: 'Rahul Kumar', dept: 'BCA', semester: '6', email: 'rahul@university.edu' },
        { rollNo: 'BCA002', name: 'Priya Sharma', dept: 'BCA', semester: '6', email: 'priya@university.edu' },
        { rollNo: 'BCA003', name: 'Amit Singh', dept: 'BCA', semester: '4', email: 'amit@university.edu' },
        { rollNo: 'BTECH001', name: 'Sneha Patel', dept: 'B.Tech CSE', semester: '8', email: 'sneha@university.edu' },
        { rollNo: 'BTECH002', name: 'Vijay Reddy', dept: 'B.Tech CSE', semester: '6', email: 'vijay@university.edu' }
    ],
    
    faculty: [
        { id: 'FAC001', name: 'Dr. Rajesh Verma', dept: 'Computer Science', subjects: ['Java', 'DSA'] },
        { id: 'FAC002', name: 'Prof. Anita Desai', dept: 'Computer Science', subjects: ['DBMS', 'Web Tech'] },
        { id: 'FAC003', name: 'Dr. Suresh Rao', dept: 'Mathematics', subjects: ['Discrete Math', 'Statistics'] }
    ],
    
    subjects: [
        { code: 'CS101', name: 'Java Programming', credits: 4 },
        { code: 'CS102', name: 'Data Structures', credits: 4 },
        { code: 'CS103', name: 'Database Management', credits: 4 },
        { code: 'CS104', name: 'Web Technologies', credits: 3 },
        { code: 'CS105', name: 'Operating Systems', credits: 4 }
    ],
    
    attendance: [
        { subject: 'Java Programming', present: 42, total: 50, percentage: 84 },
        { subject: 'Data Structures', present: 38, total: 48, percentage: 79.17 },
        { subject: 'DBMS', present: 45, total: 50, percentage: 90 },
        { subject: 'Web Technologies', present: 35, total: 45, percentage: 77.78 },
        { subject: 'Operating Systems', present: 40, total: 48, percentage: 83.33 }
    ],
    
    fees: [
        { semester: '1', amount: 50000, paid: 50000, pending: 0, status: 'Paid' },
        { semester: '2', amount: 50000, paid: 50000, pending: 0, status: 'Paid' },
        { semester: '3', amount: 50000, paid: 50000, pending: 0, status: 'Paid' },
        { semester: '4', amount: 50000, paid: 30000, pending: 20000, status: 'Partial' },
        { semester: '5', amount: 50000, paid: 0, pending: 50000, status: 'Pending' }
    ],
    
    assignments: [
        { id: 1, subject: 'Java', title: 'Create Banking System', dueDate: '2026-01-25', status: 'Pending' },
        { id: 2, subject: 'DBMS', title: 'Design ER Diagram', dueDate: '2026-01-22', status: 'Submitted' },
        { id: 3, subject: 'Web Tech', title: 'Responsive Website', dueDate: '2026-01-30', status: 'Pending' }
    ],
    
    results: [
        { subject: 'Java Programming', internal: 18, external: 75, total: 93, grade: 'A+' },
        { subject: 'Data Structures', internal: 17, external: 70, total: 87, grade: 'A' },
        { subject: 'DBMS', internal: 19, external: 78, total: 97, grade: 'A+' },
        { subject: 'Web Technologies', internal: 16, external: 68, total: 84, grade: 'A' },
        { subject: 'Operating Systems', internal: 18, external: 72, total: 90, grade: 'A+' }
    ],
    
    timetable: {
        Monday: [
            { time: '09:00-10:00', subject: 'Java Programming', faculty: 'Dr. Rajesh Verma', room: 'Lab 1' },
            { time: '10:00-11:00', subject: 'Data Structures', faculty: 'Dr. Rajesh Verma', room: 'Room 101' },
            { time: '11:00-12:00', subject: 'DBMS', faculty: 'Prof. Anita Desai', room: 'Room 102' }
        ],
        Tuesday: [
            { time: '09:00-10:00', subject: 'Web Technologies', faculty: 'Prof. Anita Desai', room: 'Lab 2' },
            { time: '10:00-11:00', subject: 'Operating Systems', faculty: 'Dr. Suresh Rao', room: 'Room 103' },
            { time: '11:00-12:00', subject: 'Mathematics', faculty: 'Dr. Suresh Rao', room: 'Room 104' }
        ]
    }
};

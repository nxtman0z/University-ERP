<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniCore ERP - Management Portal</title>
    <link rel="stylesheet" href="css/style.css?v=20260324-5">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body class="home-page">
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="nav-logo">
                <img src="images/unicore-logo-banner.png" alt="UniCore ERP Logo" class="logo-image logo-image-wide">
            </div>
            <ul class="nav-menu">
                <li><a href="#home" class="nav-link">Home</a></li>
                <li><a href="#features" class="nav-link">Features</a></li>
                <li><a href="#contact" class="nav-link">Contact</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Home/Login Cards Section -->
        <section class="login-section" id="home">
            <div class="section-header">
                <h1>UniCore ERP</h1>
                <p class="section-subtitle">Select your role to access the portal</p>
            </div>
            
            <!-- Login Cards -->
            <div class="login-options">
                <!-- Admin Card -->
                <div class="login-card admin-card">
                    <div class="card-icon">👨‍💼</div>
                    <h2>Administrator</h2>
                    <p class="card-role">System Administrator</p>
                    <a href="adminLogin.jsp" class="btn btn-admin">
                        <span class="btn-text">Login as Admin</span>
                        <span class="btn-arrow">→</span>
                    </a>
                </div>
                
                <!-- Faculty Card -->
                <div class="login-card faculty-card">
                    <div class="card-icon">👨‍🏫</div>
                    <h2>Faculty</h2>
                    <p class="card-role">Instructor/Professor</p>
                    <a href="facultyLogin.jsp" class="btn btn-faculty">
                        <span class="btn-text">Login as Faculty</span>
                        <span class="btn-arrow">→</span>
                    </a>
                </div>
                
                <!-- Student Card -->
                <div class="login-card student-card">
                    <div class="card-icon">👨‍🎓</div>
                    <h2>Student</h2>
                    <p class="card-role">Registered Student</p>
                    <a href="studentLogin.jsp" class="btn btn-student">
                        <span class="btn-text">Login as Student</span>
                        <span class="btn-arrow">→</span>
                    </a>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="features-section" id="features">
            <div class="section-container">
                <div class="section-header">
                    <h2 class="features-title">Features</h2>
                    <p class="features-subtitle">Everything you need for university management</p>
                </div>
                
                <div class="features-grid">
                    <div class="feature-card card-student">
                        <div class="feature-icon">📊</div>
                        <h3>Student Management</h3>
                        <p>Manage student records, enrollment, and personal information efficiently</p>
                    </div>
                    
                    <div class="feature-card card-faculty">
                        <div class="feature-icon">👥</div>
                        <h3>Faculty Management</h3>
                        <p>Handle faculty assignments, schedules, and performance tracking</p>
                    </div>
                    
                    <div class="feature-card card-timetable">
                        <div class="feature-icon">📅</div>
                        <h3>Timetable Management</h3>
                        <p>Create and manage class schedules with automatic conflict detection</p>
                    </div>
                    
                    <div class="feature-card card-exams">
                        <div class="feature-icon">📝</div>
                        <h3>Assignment & Exams</h3>
                        <p>Upload assignments and schedule exams with automated grading</p>
                    </div>
                    
                    <div class="feature-card card-attendance">
                        <div class="feature-icon">✓</div>
                        <h3>Attendance Tracking</h3>
                        <p>Real-time attendance management and reporting for all stakeholders</p>
                    </div>
                    
                    <div class="feature-card card-announce">
                        <div class="feature-icon">📢</div>
                        <h3>Announcements</h3>
                        <p>Send notifications and announcements to students and faculty instantly</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Contact Section -->
        <section class="contact-section" id="contact">
            <div class="section-container">
                <div class="section-header">
                    <h2 class="contact-title">Contact Us</h2>
                    <p class="contact-subtitle">Have questions? We'd love to hear from you</p>
                </div>
                
                <div class="contact-content contact-wrapper">
                    <div class="contact-info">
                        <div class="info-card contact-info-card card-address">
                            <div class="info-icon contact-icon-box icon-address">📍</div>
                            <div>
                                <h4>Address</h4>
                                <p>University Campus<br>Educational District<br>City, Country 123456</p>
                            </div>
                        </div>
                        
                        <div class="info-card contact-info-card card-phone">
                            <div class="info-icon contact-icon-box icon-phone">📞</div>
                            <div>
                                <h4>Phone</h4>
                                <p>+1 (555) 123-4567<br>+1 (555) 987-6543<br><small>Mon - Fri, 9AM - 6PM</small></p>
                            </div>
                        </div>
                        
                        <div class="info-card contact-info-card card-email">
                            <div class="info-icon contact-icon-box icon-email">✉️</div>
                            <div>
                                <h4>Email</h4>
                                <p>support@universityerp.edu<br>info@universityerp.edu<br><small>Response within 24 hours</small></p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="contact-form contact-form-panel">
                        <form onsubmit="handleContactSubmit(event)">
                            <div class="form-group">
                                <input type="text" placeholder="Full Name" required>
                            </div>
                            <div class="form-group">
                                <input type="email" placeholder="Email Address" required>
                            </div>
                            <div class="form-group">
                                <input type="text" placeholder="Subject" required>
                            </div>
                            <div class="form-group">
                                <textarea placeholder="Your Message" required></textarea>
                            </div>
                            <button type="submit" class="btn btn-contact btn-send">Send Message</button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer Section -->
        <footer class="main-footer">
            <p>&copy; 2024 UniCore ERP | All rights reserved</p>
        </footer>
    </div>

    <script>
        // Smooth scroll for navigation
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
            });
        });

        // Handle contact form submission
        function handleContactSubmit(event) {
            event.preventDefault();
            alert('Thank you for your message! We will get back to you soon.');
            event.target.reset();
        }

        // Add animation on scroll
        const cards = document.querySelectorAll('.login-card, .feature-card, .info-card');
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('fade-in');
                }
            });
        });
        cards.forEach(card => observer.observe(card));
    </script>
</body>
</html>

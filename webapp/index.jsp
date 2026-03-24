<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>University ERP System - Management Portal</title>
    <link rel="stylesheet" href="css/style.css?v=20260324-3">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=Sora:wght@400;600;700;800&display=swap" rel="stylesheet">
</head>
<body class="home-page">
    <nav class="neo-nav">
        <div class="neo-nav-inner">
            <a class="neo-brand" href="index.jsp">
                <span class="neo-brand-dot"></span>
                <span class="neo-brand-text">University ERP</span>
            </a>
            <div class="neo-nav-label">Academic Command Center</div>
        </div>
    </nav>

    <main class="hero-stage" id="home">
        <section class="hero-copy">
            <p class="eyebrow">Digital Campus Infrastructure</p>
            <h1>University ERP<br>System</h1>
            <p class="hero-subtitle">One intelligent portal for administration, faculty workflows, and student operations.</p>

            <div class="signal-row" aria-hidden="true">
                <span class="signal-pill">Live Timetable</span>
                <span class="signal-pill">Attendance Engine</span>
                <span class="signal-pill">Exam Hub</span>
            </div>

            <div class="micro-stats" aria-hidden="true">
                <div class="stat-box">
                    <strong>24/7</strong>
                    <span>Portal Uptime</span>
                </div>
                <div class="stat-box">
                    <strong>Unified</strong>
                    <span>Role Dashboard</span>
                </div>
                <div class="stat-box">
                    <strong>Secure</strong>
                    <span>Session Access</span>
                </div>
            </div>
        </section>

        <section class="role-board" aria-label="Role Access">
            <article class="role-tile role-admin" data-tilt>
                <div class="role-kicker">Control</div>
                <div class="role-icon">⚙️</div>
                <h2>Administrator</h2>
                <p>System governance, users, policy operations.</p>
                <a href="adminLogin.jsp" class="role-cta">Enter Admin Console</a>
            </article>

            <article class="role-tile role-faculty" data-tilt>
                <div class="role-kicker">Teaching</div>
                <div class="role-icon">🧠</div>
                <h2>Faculty</h2>
                <p>Class plans, attendance cycles, and assessments.</p>
                <a href="facultyLogin.jsp" class="role-cta">Enter Faculty Workspace</a>
            </article>

            <article class="role-tile role-student" data-tilt>
                <div class="role-kicker">Learning</div>
                <div class="role-icon">🚀</div>
                <h2>Student</h2>
                <p>Courses, notices, submissions, and daily progress.</p>
                <a href="studentLogin.jsp" class="role-cta">Enter Student Portal</a>
            </article>
        </section>
    </main>

    <script>
        document.body.classList.add('ready-ui');

        const tiles = document.querySelectorAll('[data-tilt]');
        tiles.forEach((tile) => {
            tile.addEventListener('mousemove', (event) => {
                const rect = tile.getBoundingClientRect();
                const x = event.clientX - rect.left;
                const y = event.clientY - rect.top;
                const rotateX = ((y / rect.height) - 0.5) * -8;
                const rotateY = ((x / rect.width) - 0.5) * 8;
                tile.style.transform = 'rotateX(' + rotateX.toFixed(2) + 'deg) rotateY(' + rotateY.toFixed(2) + 'deg) translateY(-8px)';
            });

            tile.addEventListener('mouseleave', () => {
                tile.style.transform = '';
            });
        });
    </script>

</body>
</html>

@echo off
echo ================================================
echo   UNIVERSITY ERP - Quick Start Guide
echo ================================================
echo.
echo Project Status: READY TO RUN
echo Location: C:\Users\HP\eclipse-workspace\University ERP
echo.
echo ================================================
echo   HOW TO RUN IN ECLIPSE
echo ================================================
echo.
echo STEP 1: Open Eclipse IDE
echo    - Launch Eclipse IDE
echo.
echo STEP 2: Import Project (if not already imported)
echo    - File ^> Import ^> Existing Projects into Workspace
echo    - Browse to: C:\Users\HP\eclipse-workspace\University ERP
echo    - Click Finish
echo.
echo STEP 3: Configure Tomcat Server (if not configured)
echo    - Window ^> Preferences ^> Server ^> Runtime Environments
echo    - Click Add ^> Apache Tomcat v9.0
echo    - Browse to your Tomcat installation folder
echo    - Click OK
echo.
echo STEP 4: Run Project
echo    - Right-click on "University ERP" project
echo    - Select "Run As" ^> "Run on Server"
echo    - Select "Tomcat v9.0 Server at localhost"
echo    - Click Finish
echo.
echo STEP 5: Access Application
echo    - Browser will auto-open OR
echo    - Open browser manually and go to:
echo    - URL: http://localhost:8080/University_ERP/
echo.
echo ================================================
echo   DEMO LOGIN CREDENTIALS
echo ================================================
echo.
echo STUDENT LOGIN:
echo    Username: student
echo    Password: password
echo.
echo FACULTY LOGIN:
echo    Username: faculty
echo    Password: password
echo.
echo ADMIN LOGIN:
echo    Username: admin
echo    Password: password
echo.
echo UNIVERSITY HEAD LOGIN:
echo    Username: head
echo    Password: password
echo.
echo ================================================
echo   QUICK TOMCAT COMMANDS (Alternative Method)
echo ================================================
echo.
echo If you have standalone Tomcat installed:
echo.
echo 1. Copy WAR file to Tomcat webapps:
echo    xcopy "C:\Users\HP\eclipse-workspace\University ERP\build" "C:\path\to\tomcat\webapps\UniversityERP" /E /I /Y
echo.
echo 2. Start Tomcat:
echo    cd C:\path\to\tomcat\bin
echo    startup.bat
echo.
echo 3. Access:
echo    http://localhost:8080/UniversityERP/
echo.
echo 4. Stop Tomcat:
echo    cd C:\path\to\tomcat\bin
echo    shutdown.bat
echo.
echo ================================================
echo   TROUBLESHOOTING
echo ================================================
echo.
echo Problem: Port 8080 already in use
echo Solution: Change port in server.xml or stop other apps
echo.
echo Problem: 404 Error
echo Solution: Check project name in URL should be "University_ERP"
echo.
echo Problem: CSS not loading
echo Solution: Hard refresh browser (Ctrl + F5)
echo.
echo Problem: Server won't start
echo Solution: Clean Tomcat work directory and restart
echo.
echo ================================================
echo   PROJECT STRUCTURE
echo ================================================
echo.
echo University ERP/
echo   ^|-- src/main/webapp/
echo   ^|   ^|-- css/style.css
echo   ^|   ^|-- js/main.js
echo   ^|   ^|-- login.jsp
echo   ^|   ^|-- index.jsp
echo   ^|   ^|-- student/     (11 pages)
echo   ^|   ^|-- faculty/     (2 pages)
echo   ^|   ^|-- admin/       (2 pages)
echo   ^|   ^|-- head/        (1 page)
echo   ^|   ^|-- WEB-INF/web.xml
echo   ^|-- README.md
echo   ^|-- PROJECT_SUMMARY.md
echo.
echo ================================================
echo   FEATURES TO TEST
echo ================================================
echo.
echo Student Portal:
echo   - Dashboard with stats
echo   - Attendance tracking
echo   - Fee payment
echo   - Assignments
echo   - Results viewing
echo   - Request services
echo.
echo Faculty Portal:
echo   - Mark attendance
echo   - View student list
echo   - Manage assignments
echo.
echo Admin Portal:
echo   - Student management
echo   - System analytics
echo   - Reports
echo.
echo Head Portal:
echo   - University analytics
echo   - Approvals
echo   - Performance monitoring
echo.
echo ================================================
echo   SUPPORT
echo ================================================
echo.
echo For detailed documentation, see:
echo   - README.md
echo   - PROJECT_SUMMARY.md
echo.
echo ================================================
echo   Ready to Start!
echo ================================================
echo.
echo Press any key to open project folder in Explorer...
pause >nul
explorer "C:\Users\HP\eclipse-workspace\University ERP"

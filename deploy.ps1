# University ERP Deployment Script for Windows PowerShell
# This script helps deploy the application to Tomcat

Write-Host "`n" -ForegroundColor Green
Write-Host "╔════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  University ERP - Deployment Helper    ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host "`n"

# Configuration
$TOMCAT_HOME = "C:\apache-tomcat-10.1.5"
$PROJECT_PATH = "d:\University-Erp"
$WEBAPP_PATH = "$TOMCAT_HOME\webapps\UniversityERP"
$CLASSES_PATH = "$WEBAPP_PATH\WEB-INF\classes"

# Check if Tomcat exists
Write-Host "Checking Tomcat installation..." -ForegroundColor Yellow
if (-not (Test-Path $TOMCAT_HOME)) {
    Write-Host "ERROR: Tomcat not found at $TOMCAT_HOME" -ForegroundColor Red
    Write-Host "Please download Tomcat and update the `$TOMCAT_HOME variable in this script" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}

Write-Host "✓ Tomcat found at: $TOMCAT_HOME" -ForegroundColor Green

# Create directories
Write-Host "`nCreating directory structure..." -ForegroundColor Yellow
@(
    "$WEBAPP_PATH",
    "$CLASSES_PATH",
    "$WEBAPP_PATH\css",
    "$WEBAPP_PATH\js",
    "$WEBAPP_PATH\WEB-INF"
) | ForEach-Object {
    if (-not (Test-Path $_)) {
        New-Item -ItemType Directory -Path $_ -Force | Out-Null
        Write-Host "✓ Created: $_" -ForegroundColor Green
    }
}

# Check for Java
Write-Host "`nChecking Java installation..." -ForegroundColor Yellow
$javac = Get-Command javac -ErrorAction SilentlyContinue
if (-not $javac) {
    Write-Host "ERROR: javac not found. Please install Java JDK" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit
}
Write-Host "✓ Java found: $($javac.Source)" -ForegroundColor Green

# Compile Java files
Write-Host "`nCompiling Java source files..." -ForegroundColor Yellow

$CLASSPATH = @(
    "$TOMCAT_HOME\lib\servlet-api.jar",
    "$TOMCAT_HOME\lib\jsp-api.jar",
    "$CLASSES_PATH"
) -join ";"

# Change to project directory
Push-Location $PROJECT_PATH

try {
    # Compile model classes
    Write-Host "  → Compiling model classes..." -ForegroundColor Cyan
    javac -cp "$CLASSPATH" -d "$CLASSES_PATH" src\com\project\model\*.java 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "    ✓ Model classes compiled" -ForegroundColor Green
    } else {
        Write-Host "    ✗ Failed to compile model classes" -ForegroundColor Red
    }

    # Compile utility classes
    Write-Host "  → Compiling utility classes..." -ForegroundColor Cyan
    javac -cp "$CLASSPATH" -d "$CLASSES_PATH" src\com\project\util\*.java 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "    ✓ Utility classes compiled" -ForegroundColor Green
    } else {
        Write-Host "    ✗ Failed to compile utility classes" -ForegroundColor Red
    }

    # Compile servlet classes
    Write-Host "  → Compiling servlet classes..." -ForegroundColor Cyan
    javac -cp "$CLASSPATH" -d "$CLASSES_PATH" src\com\project\servlet\*.java 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "    ✓ Servlet classes compiled" -ForegroundColor Green
    } else {
        Write-Host "    ✗ Failed to compile servlet classes" -ForegroundColor Red
    }

    # Copy JSP files
    Write-Host "`nCopying JSP files..." -ForegroundColor Yellow
    Get-ChildItem "$PROJECT_PATH\webapp\*.jsp" | Copy-Item -Destination $WEBAPP_PATH -Force
    Write-Host "✓ JSP files copied" -ForegroundColor Green

    # Copy CSS
    Write-Host "`nCopying CSS files..." -ForegroundColor Yellow
    Get-ChildItem "$PROJECT_PATH\webapp\css\*" | Copy-Item -Destination "$WEBAPP_PATH\css\" -Force
    Write-Host "✓ CSS files copied" -ForegroundColor Green

    # Copy JavaScript
    Write-Host "`nCopying JavaScript files..." -ForegroundColor Yellow
    Get-ChildItem "$PROJECT_PATH\webapp\js\*" | Copy-Item -Destination "$WEBAPP_PATH\js\" -Force
    Write-Host "✓ JavaScript files copied" -ForegroundColor Green

    # Copy web.xml
    Write-Host "`nCopying web.xml..." -ForegroundColor Yellow
    Copy-Item "$PROJECT_PATH\webapp\WEB-INF\web.xml" -Destination "$WEBAPP_PATH\WEB-INF\" -Force
    Write-Host "✓ web.xml copied" -ForegroundColor Green

    Write-Host "`n╔════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║  Deployment Complete!                  ║" -ForegroundColor Green
    Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Green

    Write-Host "`nApplication deployed to:" -ForegroundColor Cyan
    Write-Host "$WEBAPP_PATH" -ForegroundColor Yellow

    Write-Host "`nNext steps:" -ForegroundColor Cyan
    Write-Host "1. Start Tomcat: $TOMCAT_HOME\bin\startup.bat" -ForegroundColor White
    Write-Host "2. Visit: http://localhost:8080/UniversityERP" -ForegroundColor White

    Write-Host "`nLogin Credentials:" -ForegroundColor Cyan
    Write-Host "Admin: admin / admin123" -ForegroundColor White
    Write-Host "Faculty: faculty / faculty123" -ForegroundColor White
    Write-Host "Student: S001 / any password" -ForegroundColor White

} catch {
    Write-Host "ERROR: $_" -ForegroundColor Red
} finally {
    Pop-Location
}

Write-Host "`n"
Read-Host "Press Enter to exit"

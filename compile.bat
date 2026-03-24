@echo off
REM Compilation script for UniCore ERP
REM This script compiles all Java files for deployment to Tomcat

echo.
echo ====================================
echo UniCore ERP - Java Compilation
echo ====================================
echo.

REM Set Tomcat home (CHANGE THIS to your Tomcat path)
set TOMCAT_HOME=C:\apache-tomcat-10.1.5

REM Create output directory
set OUTPUT_DIR=%TOMCAT_HOME%\webapps\UniversityERP\WEB-INF\classes
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM Set classpath with Tomcat JAR files
set CLASSPATH=%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar

echo Compiling Java files...
echo Output directory: %OUTPUT_DIR%
echo Tomcat Directory: %TOMCAT_HOME%
echo.

REM Compile model classes
echo Compiling model classes...
javac -cp "%CLASSPATH%" -d "%OUTPUT_DIR%" src\com\project\model\*.java
if %errorlevel% neq 0 goto error

REM Compile utility classes
echo Compiling utility classes...
javac -cp "%CLASSPATH%;%OUTPUT_DIR%" -d "%OUTPUT_DIR%" src\com\project\util\*.java
if %errorlevel% neq 0 goto error

REM Compile servlet classes
echo Compiling servlet classes...
javac -cp "%CLASSPATH%;%OUTPUT_DIR%" -d "%OUTPUT_DIR%" src\com\project\servlet\*.java
if %errorlevel% neq 0 goto error

echo.
echo ====================================
echo Copying JSP files...
mkdir "%TOMCAT_HOME%\webapps\UniversityERP" >nul 2>&1
copy webapp\*.jsp "%TOMCAT_HOME%\webapps\UniversityERP\" >nul 2>&1

echo Copying CSS files...
mkdir "%TOMCAT_HOME%\webapps\UniversityERP\css" >nul 2>&1
copy webapp\css\*.css "%TOMCAT_HOME%\webapps\UniversityERP\css\" >nul 2>&1

echo Copying JavaScript files...
mkdir "%TOMCAT_HOME%\webapps\UniversityERP\js" >nul 2>&1
copy webapp\js\*.js "%TOMCAT_HOME%\webapps\UniversityERP\js\" >nul 2>&1

echo Copying web.xml...
copy webapp\WEB-INF\web.xml "%TOMCAT_HOME%\webapps\UniversityERP\WEB-INF\" >nul 2>&1

echo.
echo ====================================
echo Compilation Successful!
echo ====================================
echo.
echo Your application is ready at:
echo %TOMCAT_HOME%\webapps\UniversityERP
echo.
echo Start Tomcat and visit:
echo http://localhost:8080/UniversityERP
echo.
pause
goto end

:error
echo.
echo ====================================
echo ERROR: Compilation Failed!
echo ====================================
echo Please check:
echo 1. Java is installed (javac)
echo 2. TOMCAT_HOME path is correct
echo 3. All source files are in correct location
echo.
pause
goto end

:end

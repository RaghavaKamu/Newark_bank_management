@echo off
echo === Newark Community Bank Application Setup ===
echo.

REM Check if MySQL is installed
mysql --version > nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Error: MySQL is not installed or not in your PATH.
    echo Please install MySQL and try again.
    exit /b 1
)

REM Prompt for MySQL credentials
set /p MYSQL_USER=Enter MySQL username: 
set /p MYSQL_PASS=Enter MySQL password: 

REM Set up the database
echo Setting up database...
mysql -u "%MYSQL_USER%" -p"%MYSQL_PASS%" < setup_database.sql

if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to set up the database. Please check your MySQL credentials.
    exit /b 1
)

echo Database setup completed!
echo.

REM Check for Tomcat
echo Checking for Tomcat...
set /p TOMCAT_PATH=Enter the path to your Tomcat installation (e.g., C:\tomcat): 

if not exist "%TOMCAT_PATH%" (
    echo Error: The specified Tomcat directory does not exist.
    echo Please download and install Apache Tomcat 9 from: https://tomcat.apache.org/download-90.cgi
    exit /b 1
)

if not exist "%TOMCAT_PATH%\webapps" (
    echo Error: The specified Tomcat directory does not contain a 'webapps' directory.
    echo Please ensure you've provided the correct Tomcat path.
    exit /b 1
)

REM Copy the WAR file to Tomcat
echo Deploying application to Tomcat...
copy newark-community-bank\newark-community-bank.war "%TOMCAT_PATH%\webapps\"

if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to copy the WAR file to Tomcat webapps directory.
    exit /b 1
)

REM Start Tomcat
echo Starting Tomcat...
call "%TOMCAT_PATH%\bin\startup.bat"

if %ERRORLEVEL% NEQ 0 (
    echo Error: Failed to start Tomcat.
    exit /b 1
)

echo.
echo === Setup Complete! ===
echo.
echo The Newark Community Bank application is now deployed!
echo You can access it at: http://localhost:8080/newark-community-bank/
echo.
echo Login credentials:
echo Username: raghava
echo Password: rr123
echo.
echo To stop Tomcat when you're done, run: %TOMCAT_PATH%\bin\shutdown.bat
pause 
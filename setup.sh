#!/bin/bash

echo "=== Newark Community Bank Application Setup ==="
echo ""

# Check if MySQL is installed
if ! command -v mysql &> /dev/null; then
    echo "Error: MySQL is not installed or not in your PATH."
    echo "Please install MySQL and try again."
    exit 1
fi

# Prompt for MySQL credentials
read -p "Enter MySQL username: " MYSQL_USER
read -sp "Enter MySQL password: " MYSQL_PASS
echo ""

# Set up the database
echo "Setting up database..."
mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" < setup_database.sql

if [ $? -ne 0 ]; then
    echo "Error: Failed to set up the database. Please check your MySQL credentials."
    exit 1
fi

echo "Database setup completed!"
echo ""

# Check for Tomcat
echo "Checking for Tomcat..."
read -p "Enter the path to your Tomcat installation (e.g., /opt/tomcat): " TOMCAT_PATH

if [ ! -d "$TOMCAT_PATH" ]; then
    echo "Error: The specified Tomcat directory does not exist."
    echo "Please download and install Apache Tomcat 9 from: https://tomcat.apache.org/download-90.cgi"
    exit 1
fi

if [ ! -d "$TOMCAT_PATH/webapps" ]; then
    echo "Error: The specified Tomcat directory does not contain a 'webapps' directory."
    echo "Please ensure you've provided the correct Tomcat path."
    exit 1
fi

# Copy the WAR file to Tomcat
echo "Deploying application to Tomcat..."
cp newark-community-bank/newark-community-bank.war "$TOMCAT_PATH/webapps/"

if [ $? -ne 0 ]; then
    echo "Error: Failed to copy the WAR file to Tomcat webapps directory."
    exit 1
fi

# Start Tomcat
echo "Starting Tomcat..."
"$TOMCAT_PATH/bin/startup.sh"

if [ $? -ne 0 ]; then
    echo "Error: Failed to start Tomcat."
    exit 1
fi

echo ""
echo "=== Setup Complete! ==="
echo ""
echo "The Newark Community Bank application is now deployed!"
echo "You can access it at: http://localhost:8080/newark-community-bank/"
echo ""
echo "Login credentials:"
echo "Username: raghava"
echo "Password: rr123"
echo ""
echo "To stop Tomcat when you're done, run: $TOMCAT_PATH/bin/shutdown.sh" 
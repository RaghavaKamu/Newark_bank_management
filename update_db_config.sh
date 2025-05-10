#!/bin/bash

# Extract the WAR file
mkdir -p extracted
unzip -o simple-bank-app.war -d extracted

# Update the database connection in generateReport.jsp
sed -i.bak 's/localhost:3306/mysql:3306/g' extracted/generateReport.jsp
sed -i.bak 's/"root", ""/\"root\", \"rootpassword\"/g' extracted/generateReport.jsp

# Repackage the WAR file
cd extracted
jar -cvf ../simple-bank-app-docker.war *
cd ..

echo "Updated WAR file created as simple-bank-app-docker.war" 
#!/bin/bash

# Extract the WAR file
rm -rf extracted
mkdir -p extracted
unzip -o simple-bank-app.war -d extracted

# Update database connection in all JSP files
find extracted -name "*.jsp" -type f -exec sed -i.bak 's/localhost:3306/mysql:3306/g' {} \;
find extracted -name "*.jsp" -type f -exec sed -i.bak 's/"root", ""/\"root\", \"rootpassword\"/g' {} \;

# Update context.xml
sed -i.bak 's/localhost:3306/mysql:3306/g' extracted/META-INF/context.xml
sed -i.bak 's/password=""/password="rootpassword"/g' extracted/META-INF/context.xml

# Repackage the WAR file
cd extracted
jar -cvf ../simple-bank-app-docker.war *
cd ..

echo "Updated WAR file created as simple-bank-app-docker.war" 
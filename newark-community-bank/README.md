# Newark Community Bank Web Application

This is a Java Servlet-based web application for Newark Community Bank with three modules:
1. Admin Login
2. Account Management
3. EOD Reporting

## Prerequisites

- Java 8 or higher
- Apache Tomcat 9.x
- MySQL 5.7 or higher
- Maven (optional, for dependency management)

## Setup Instructions

### 1. Database Setup

1. Log in to MySQL:
   ```
   mysql -u root -p
   ```

2. Run the SQL script to create the database and tables:
   ```
   source /path/to/admin_info.sql
   ```

### 2. Configure Database Connection

1. Open `src/main/java/com/newark/util/DBConnection.java`
2. Update the database connection details if needed:
   ```java
   private static final String JDBC_URL = "jdbc:mysql://localhost:3306/newark_community_bank";
   private static final String USERNAME = "root";
   private static final String PASSWORD = ""; // Add your MySQL password here
   ```

### 3. Build and Deploy

#### Using Tomcat directly:

1. Create a WAR file:
   ```
   jar -cvf newark-community-bank.war -C src/main/webapp/ .
   ```

2. Copy the WAR file to Tomcat's webapps directory:
   ```
   cp newark-community-bank.war /path/to/tomcat/webapps/
   ```

3. Start Tomcat:
   ```
   /path/to/tomcat/bin/startup.sh
   ```

#### Using Maven:

1. Add the following dependencies to your pom.xml:
   ```xml
   <dependencies>
     <dependency>
       <groupId>javax.servlet</groupId>
       <artifactId>javax.servlet-api</artifactId>
       <version>4.0.1</version>
       <scope>provided</scope>
     </dependency>
     <dependency>
       <groupId>mysql</groupId>
       <artifactId>mysql-connector-java</artifactId>
       <version>8.0.28</version>
     </dependency>
   </dependencies>
   ```

2. Build the project:
   ```
   mvn clean package
   ```

3. Deploy the WAR file to Tomcat.

## Application Structure

- `src/main/java/com/newark/controller/`: Contains servlets
  - `AdminServlet.java`: Handles admin login and module selection
  - `AccountServlet.java`: Handles account creation
  - `ReportServlet.java`: Generates EOD reports

- `src/main/java/com/newark/model/`: Contains model classes
  - `Admin.java`: Admin data model
  - `Account.java`: Account data model

- `src/main/java/com/newark/util/`: Contains utility classes
  - `DBConnection.java`: Database connection utility

- `src/main/webapp/`: Web resources
  - `index.jsp`: Homepage
  - `login.jsp`: Admin login page
  - `account.jsp`: Account creation page
  - `report.jsp`: EOD report generation page
  - `WEB-INF/web.xml`: Web application configuration

## Usage

1. Access the application at: http://localhost:8080/newark-community-bank/
2. Login using the default admin credentials:
   - Username: raghava
   - Password: rr123
3. Choose a module (Create New Account or EOD Report)
4. Follow the on-screen instructions to complete tasks

## Business Rules

- Deposit amount must be at least $1,000
- Deposits ≥ $10,000 receive a $500 bonus
- Deposits ≥ $5,000 and < $10,000 receive a $300 bonus
- Deposits < $5,000 are eligible for a lottery ($100 prize) 
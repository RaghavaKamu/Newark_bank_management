# Newark Community Bank Web Application - Setup Instructions

This file contains step-by-step instructions to set up and run the Newark Community Bank web application.

## Prerequisites
- Java 11 or higher
- MySQL (already installed)
- Apache Tomcat 9.x

## Step 1: Configure MySQL Database
1. Start MySQL and create the database and tables:
```sql
mysql -u [your_mysql_username] -p < newark-community-bank/admin_info.sql
```

2. If you prefer to run the SQL commands directly, you can connect to MySQL and execute:
```sql
CREATE DATABASE IF NOT EXISTS newark_community_bank;
USE newark_community_bank;

-- Create admin_info table
CREATE TABLE admin_info (
    adminID INT AUTO_INCREMENT PRIMARY KEY,
    adminName VARCHAR(50) NOT NULL,
    username VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(30) NOT NULL
) AUTO_INCREMENT = 100;

-- Insert admin data
INSERT INTO admin_info (adminName, username, password) VALUES
('raghava reddy', 'raghava', 'rr123');

-- Create new_accounts table
CREATE TABLE new_accounts (
    acct_number INT AUTO_INCREMENT PRIMARY KEY,
    acct_name VARCHAR(50),
    acct_deposit DOUBLE,
    acct_bonus DOUBLE,
    acct_lottery_win DOUBLE
) AUTO_INCREMENT = 2510;
```

3. Update MySQL connection details in `newark-community-bank/src/main/java/com/newark/util/DBConnection.java` if necessary.

## Step 2: Download and Install Tomcat
1. Download Apache Tomcat 9.x from the official website: https://tomcat.apache.org/download-90.cgi
2. Extract the downloaded archive to a directory of your choice
3. Set execution permissions on the Tomcat scripts:
```sh
chmod +x [tomcat-directory]/bin/*.sh
```

## Step 3: Deploy the Web Application
1. Copy the generated WAR file to Tomcat's webapps directory:
```sh
cp newark-community-bank/newark-community-bank.war [tomcat-directory]/webapps/
```

2. Start Tomcat:
```sh
[tomcat-directory]/bin/startup.sh
```

3. Verify Tomcat is running by visiting: http://localhost:8080

## Step 4: Access the Application
1. Open your web browser and navigate to: http://localhost:8080/newark-community-bank/

2. Login with the following credentials:
   - Username: raghava
   - Password: rr123

3. After successful login, you'll see options to:
   - Create a new account
   - Generate EOD report

## Step 5: Using the Application

### Creating an Account
1. Select "Create New Account" after login
2. Enter account holder details:
   - Account Holder Name
   - Deposit Amount (minimum $1,000)
3. Click "Submit"
4. The system will:
   - Add a bonus for deposits ≥ $5,000
   - Potentially award a $100 lottery win for deposits < $5,000
5. View the created account details

### Generating EOD Report
1. Select "EOD Report" after login
2. Click "Generate Report"
3. View the total number of accounts and total deposits

## Troubleshooting
- If the application fails to connect to the database, check:
  - MySQL service is running
  - Database credentials in DBConnection.java are correct
  - The database and tables exist

- If you can't access the web application, check:
  - Tomcat is running properly
  - The WAR file was deployed correctly
  - No conflicts with other applications on port 8080

## Business Rules
- Deposit amount must be at least $1,000
- Deposits ≥ $10,000 receive a $500 bonus
- Deposits ≥ $5,000 and < $10,000 receive a $300 bonus
- Deposits < $5,000 are eligible for a lottery ($100 prize) 
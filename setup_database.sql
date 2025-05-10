-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS newark_community_bank;

-- Use the database
USE newark_community_bank;

-- Create admin_info table
CREATE TABLE IF NOT EXISTS admin_info (
    adminID INT AUTO_INCREMENT PRIMARY KEY,
    adminName VARCHAR(50) NOT NULL,
    username VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(30) NOT NULL
) AUTO_INCREMENT = 100;

-- Check if admin data already exists, if not insert it
INSERT INTO admin_info (adminName, username, password) 
SELECT 'raghava reddy', 'raghava', 'rr123'
WHERE NOT EXISTS (SELECT 1 FROM admin_info WHERE username = 'raghava');

-- Create new_accounts table
CREATE TABLE IF NOT EXISTS new_accounts (
    acct_number INT AUTO_INCREMENT PRIMARY KEY,
    acct_name VARCHAR(50),
    acct_deposit DOUBLE,
    acct_bonus DOUBLE,
    acct_lottery_win DOUBLE
) AUTO_INCREMENT = 2510;

-- Print success message
SELECT 'Database setup completed successfully!' AS Message; 
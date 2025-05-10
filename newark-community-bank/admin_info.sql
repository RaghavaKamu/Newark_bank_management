-- Create the database
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
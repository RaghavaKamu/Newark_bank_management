# Newark Community Bank Web Application

A Java Servlet-based web application for Newark Community Bank with three modules:
1. Admin Login
2. Account Management
3. EOD Reporting

## Features

- Admin authentication system
- Account creation with business rules for bonuses:
  - $500 bonus for deposits ≥ $10,000
  - $300 bonus for deposits ≥ $5,000 and < $10,000
  - Deposits < $5,000 are eligible for a lottery ($100 prize)
- Minimum deposit requirement of $1.00
- End-of-day reporting with visualization
- Modern, responsive UI using Bootstrap

## Technologies Used

- Java Servlets
- JSP (JavaServer Pages)
- MySQL Database
- Bootstrap 5 for modern UI
- Docker for containerization

## Project Structure

- `src/main/java/com/newark/controller/`: Servlet controllers
- `src/main/java/com/newark/model/`: Data models
- `src/main/java/com/newark/util/`: Utility classes (DB connection)
- `src/main/webapp/`: JSP pages and web resources
- `setup_database.sql`: Database setup script
- `docker-compose.yml`: Docker configuration

## Running the Application

### Prerequisites
- Docker and Docker Compose
- Web browser

### Steps to Run
1. Clone this repository
2. Run `docker-compose up -d`
3. Access the application at: http://localhost:8081/simple-bank-app/
4. Login with default credentials:
   - Username: raghava
   - Password: rr123

## Application Flow

1. Admin logs in with credentials
2. Admin selects a module (Account Creation or EOD Report)
3. For Account Creation:
   - Enter account holder details and deposit amount (min $1.00)
   - System applies bonus rules and lottery
   - View all accounts with details
4. For EOD Report:
   - Generate a summary report of all accounts
   - View total accounts and deposit amount
   - Visualize account distribution by deposit amount

## Screenshots

(Add screenshots here)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

Raghava Reddy 
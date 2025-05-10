package com.newark.controller;

import com.newark.model.Account;
import com.newark.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@WebServlet("/account")
public class AccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("authenticated") != null && (boolean) session.getAttribute("authenticated")) {
            request.getRequestDispatcher("/account.jsp").forward(request, response);
        } else {
            response.sendRedirect("admin");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("authenticated") == null || !(boolean) session.getAttribute("authenticated")) {
            response.sendRedirect("admin");
            return;
        }

        String acctName = request.getParameter("acctName");
        double acctDeposit = 0;
        try {
            acctDeposit = Double.parseDouble(request.getParameter("acctDeposit"));
        } catch (NumberFormatException e) {
            response.setContentType("text/html");
            response.getWriter().write("Invalid deposit amount. Please enter a valid number.");
            return;
        }

        // Apply business logic for deposit validation
        if (acctDeposit < 1000) {
            response.setContentType("text/html");
            response.getWriter().write("Deposit amount must be at least $1,000.00");
            return;
        }

        // Calculate bonus
        double acctBonus = 0;
        if (acctDeposit >= 10000) {
            acctBonus = 500;
        } else if (acctDeposit >= 5000) {
            acctBonus = 300;
        }

        // Insert into database
        Connection connection = null;
        try {
            connection = DBConnection.getConnection();
            String query = "INSERT INTO new_accounts (acct_name, acct_deposit, acct_bonus, acct_lottery_win) VALUES (?, ?, ?, 0)";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, acctName);
            statement.setDouble(2, acctDeposit);
            statement.setDouble(3, acctBonus);
            statement.executeUpdate();

            // Handle lottery
            if (acctDeposit < 5000) {
                // This account is eligible for lottery
                List<Account> eligibleAccounts = getEligibleAccounts(connection);
                if (!eligibleAccounts.isEmpty()) {
                    // Randomly select one account for lottery
                    Random random = new Random();
                    int winnerIndex = random.nextInt(eligibleAccounts.size());
                    Account winner = eligibleAccounts.get(winnerIndex);
                    
                    // Award lottery amount
                    updateLotteryWinner(connection, winner.getAcctNumber(), 100.0);
                }
            }

            // Display final list of accounts
            List<Account> allAccounts = getAllAccounts(connection);
            displayAccountsList(response, allAccounts);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().write("Database error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(connection);
        }
    }

    private List<Account> getEligibleAccounts(Connection connection) throws SQLException {
        List<Account> eligibleAccounts = new ArrayList<>();
        String query = "SELECT * FROM new_accounts WHERE acct_deposit < 5000 AND acct_lottery_win = 0";
        PreparedStatement statement = connection.prepareStatement(query);
        ResultSet resultSet = statement.executeQuery();
        
        while (resultSet.next()) {
            Account account = new Account();
            account.setAcctNumber(resultSet.getInt("acct_number"));
            account.setAcctName(resultSet.getString("acct_name"));
            account.setAcctDeposit(resultSet.getDouble("acct_deposit"));
            account.setAcctBonus(resultSet.getDouble("acct_bonus"));
            account.setAcctLotteryWin(resultSet.getDouble("acct_lottery_win"));
            eligibleAccounts.add(account);
        }
        
        return eligibleAccounts;
    }

    private void updateLotteryWinner(Connection connection, int acctNumber, double lotteryAmount) throws SQLException {
        String query = "UPDATE new_accounts SET acct_lottery_win = ? WHERE acct_number = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setDouble(1, lotteryAmount);
        statement.setInt(2, acctNumber);
        statement.executeUpdate();
    }
    
    private List<Account> getAllAccounts(Connection connection) throws SQLException {
        List<Account> accounts = new ArrayList<>();
        String query = "SELECT * FROM new_accounts ORDER BY acct_number";
        PreparedStatement statement = connection.prepareStatement(query);
        ResultSet resultSet = statement.executeQuery();
        
        while (resultSet.next()) {
            Account account = new Account();
            account.setAcctNumber(resultSet.getInt("acct_number"));
            account.setAcctName(resultSet.getString("acct_name"));
            account.setAcctDeposit(resultSet.getDouble("acct_deposit"));
            account.setAcctBonus(resultSet.getDouble("acct_bonus"));
            account.setAcctLotteryWin(resultSet.getDouble("acct_lottery_win"));
            accounts.add(account);
        }
        
        return accounts;
    }
    
    private void displayAccountsList(HttpServletResponse response, List<Account> accounts) throws IOException {
        response.setContentType("text/html");
        PrintWriter writer = response.getWriter();
        
        writer.write("<html><head>");
        writer.write("<title>Newark Community Bank - Accounts</title>");
        writer.write("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css' rel='stylesheet'>");
        writer.write("</head><body>");
        writer.write("<div class='container mt-5'>");
        writer.write("<h2>Account Creation Successful</h2>");
        writer.write("<table class='table table-striped'>");
        writer.write("<thead><tr><th>Account Number</th><th>Account Name</th><th>Deposit</th><th>Bonus</th><th>Lottery Win</th></tr></thead>");
        writer.write("<tbody>");
        
        for (Account account : accounts) {
            writer.write("<tr>");
            writer.write("<td>" + account.getAcctNumber() + "</td>");
            writer.write("<td>" + account.getAcctName() + "</td>");
            writer.write("<td>$" + String.format("%.2f", account.getAcctDeposit()) + "</td>");
            writer.write("<td>$" + String.format("%.2f", account.getAcctBonus()) + "</td>");
            writer.write("<td>$" + String.format("%.2f", account.getAcctLotteryWin()) + "</td>");
            writer.write("</tr>");
        }
        
        writer.write("</tbody></table>");
        writer.write("<a href='admin' class='btn btn-primary'>Back to Admin</a>");
        writer.write("</div>");
        writer.write("<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js'></script>");
        writer.write("</body></html>");
    }
} 
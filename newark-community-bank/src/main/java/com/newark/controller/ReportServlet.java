package com.newark.controller;

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
import java.text.DecimalFormat;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("authenticated") != null && (boolean) session.getAttribute("authenticated")) {
            request.getRequestDispatcher("/report.jsp").forward(request, response);
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

        Connection connection = null;
        try {
            connection = DBConnection.getConnection();
            
            // Get total accounts and sum of deposits
            String query = "SELECT COUNT(*) as total_accounts, SUM(acct_deposit) as total_deposit FROM new_accounts";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            
            int totalAccounts = 0;
            double totalDeposit = 0.0;
            
            if (resultSet.next()) {
                totalAccounts = resultSet.getInt("total_accounts");
                totalDeposit = resultSet.getDouble("total_deposit");
            }
            
            // Display the EOD report
            displayEODReport(response, totalAccounts, totalDeposit);
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().write("Database error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(connection);
        }
    }
    
    private void displayEODReport(HttpServletResponse response, int totalAccounts, double totalDeposit) throws IOException {
        response.setContentType("text/html");
        PrintWriter writer = response.getWriter();
        
        DecimalFormat df = new DecimalFormat("#,##0.00");
        
        writer.write("<html><head>");
        writer.write("<title>Newark Community Bank - EOD Report</title>");
        writer.write("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css' rel='stylesheet'>");
        writer.write("</head><body>");
        writer.write("<div class='container mt-5'>");
        writer.write("<h2>EOD Report</h2>");
        writer.write("<div class='alert alert-info'>");
        writer.write("<p>" + totalAccounts + " accounts created today and the total deposit received: $" + df.format(totalDeposit) + "</p>");
        writer.write("</div>");
        writer.write("<a href='admin' class='btn btn-primary'>Back to Admin</a>");
        writer.write("</div>");
        writer.write("<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js'></script>");
        writer.write("</body></html>");
    }
} 
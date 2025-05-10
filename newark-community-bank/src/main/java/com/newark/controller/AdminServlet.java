package com.newark.controller;

import com.newark.model.Admin;
import com.newark.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String action = request.getParameter("action");

        if (action == null) {
            // This is a login attempt
            Connection connection = null;
            try {
                connection = DBConnection.getConnection();
                String query = "SELECT * FROM admin_info WHERE username = ? AND password = ?";
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, username);
                statement.setString(2, password);
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    // Login successful
                    Admin admin = new Admin();
                    admin.setAdminID(resultSet.getInt("adminID"));
                    admin.setAdminName(resultSet.getString("adminName"));
                    admin.setUsername(resultSet.getString("username"));

                    HttpSession session = request.getSession();
                    session.setAttribute("admin", admin);
                    session.setAttribute("authenticated", true);

                    response.getWriter().write("Your authentication is successful");
                } else {
                    // Login failed
                    response.getWriter().write("Your authentication has failed, please try again");
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                response.getWriter().write("Database error: " + e.getMessage());
            } finally {
                DBConnection.closeConnection(connection);
            }
        } else {
            // This is a module selection
            HttpSession session = request.getSession();
            if (session.getAttribute("authenticated") != null && (boolean) session.getAttribute("authenticated")) {
                if ("account".equals(action)) {
                    // Redirect to account creation page
                    response.sendRedirect("account");
                } else if ("report".equals(action)) {
                    // Redirect to EOD report page
                    response.sendRedirect("report");
                }
            } else {
                // Not authenticated, redirect to login
                response.sendRedirect("admin");
            }
        }
    }
} 
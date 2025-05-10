<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newark Community Bank - Account Created</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h2 class="text-center">Newark Community Bank</h2>
                    </div>
                    <div class="card-body">
                        <%
                        String acctName = request.getParameter("acctName");
                        String acctDepositStr = request.getParameter("acctDeposit");
                        double acctDeposit = 0;
                        String message = "";
                        boolean success = false;
                        
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        
                        try {
                            // Parse deposit amount
                            if (acctDepositStr != null && !acctDepositStr.isEmpty()) {
                                acctDeposit = Double.parseDouble(acctDepositStr);
                            }
                            
                            // Validate deposit amount
                            if (acctDeposit < 1) {
                                message = "Error: Deposit amount must be at least $1.00";
                            } else if (acctName == null || acctName.trim().isEmpty()) {
                                message = "Error: Account holder name is required";
                            } else {
                                // Calculate bonus based on deposit amount
                                double acctBonus = 0;
                                if (acctDeposit >= 10000) {
                                    acctBonus = 500;
                                } else if (acctDeposit >= 5000) {
                                    acctBonus = 300;
                                }
                                
                                // Insert into database
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                String url = "jdbc:mysql://mysql:3306/newark_community_bank";
                                String user = "root";
                                String password = "rootpassword";
                                
                                conn = DriverManager.getConnection(url, user, password);
                                
                                String sql = "INSERT INTO new_accounts (acct_name, acct_deposit, acct_bonus, acct_lottery_win) VALUES (?, ?, ?, 0)";
                                pstmt = conn.prepareStatement(sql);
                                pstmt.setString(1, acctName);
                                pstmt.setDouble(2, acctDeposit);
                                pstmt.setDouble(3, acctBonus);
                                pstmt.executeUpdate();
                                
                                // Handle lottery for deposits < 5000
                                if (acctDeposit < 5000) {
                                    // Get all eligible accounts
                                    sql = "SELECT acct_number FROM new_accounts WHERE acct_deposit < 5000 AND acct_lottery_win = 0";
                                    pstmt = conn.prepareStatement(sql);
                                    rs = pstmt.executeQuery();
                                    
                                    // Count eligible accounts
                                    int count = 0;
                                    int[] eligibleAccounts = new int[100]; // Assume max 100 eligible accounts
                                    
                                    while (rs.next()) {
                                        eligibleAccounts[count++] = rs.getInt("acct_number");
                                    }
                                    
                                    if (count > 0) {
                                        // Randomly select a winner
                                        Random random = new Random();
                                        int winnerIndex = random.nextInt(count);
                                        int winnerAcctNumber = eligibleAccounts[winnerIndex];
                                        
                                        // Award lottery win
                                        sql = "UPDATE new_accounts SET acct_lottery_win = 100 WHERE acct_number = ?";
                                        pstmt = conn.prepareStatement(sql);
                                        pstmt.setInt(1, winnerAcctNumber);
                                        pstmt.executeUpdate();
                                    }
                                }
                                
                                message = "Account created successfully!";
                                success = true;
                            }
                            
                        } catch (NumberFormatException e) {
                            message = "Error: Invalid deposit amount. Please enter a valid number.";
                        } catch (Exception e) {
                            message = "Error: " + e.getMessage();
                        } finally {
                            // Close resources
                            if (rs != null) try { rs.close(); } catch (Exception e) {}
                            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
                            if (conn != null) try { conn.close(); } catch (Exception e) {}
                        }
                        %>
                        
                        <div class="alert <%= success ? "alert-success" : "alert-danger" %>">
                            <%= message %>
                        </div>
                        
                        <div class="text-center mt-4">
                            <a href="index.jsp" class="btn btn-primary">Back to Main Page</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 
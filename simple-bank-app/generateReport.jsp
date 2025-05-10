<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newark Community Bank - EOD Report Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1e40af;
            --accent-color: #60a5fa;
            --background-color: #f0f9ff;
            --text-color: #0f172a;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --error-color: #ef4444;
        }
        
        body {
            background: var(--background-color);
            background-image: linear-gradient(135deg, #dbeafe 0%, #eff6ff 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            color: var(--text-color);
        }
        
        .bank-header {
            color: var(--primary-color);
            font-weight: 700;
            letter-spacing: -0.5px;
        }
        
        .report-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 2.5rem;
            background-color: #ffffff;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
            transform: translateY(-2px);
        }
        
        .page-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }
        
        .page-subtitle {
            color: #64748b;
            margin-bottom: 2rem;
        }
        
        .report-summary {
            text-align: center;
            margin-bottom: 2rem;
            padding: 1.5rem;
            background-color: rgba(96, 165, 250, 0.1);
            border-radius: 0.75rem;
            border-left: 4px solid var(--primary-color);
        }
        
        .stat-cards {
            display: flex;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            flex: 1;
            background-color: #fff;
            border-radius: 0.75rem;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            text-align: center;
            transition: all 0.3s ease;
            border: 1px solid #e2e8f0;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            background-color: rgba(96, 165, 250, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
        }
        
        .stat-icon i {
            font-size: 1.75rem;
            color: var(--primary-color);
        }
        
        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            font-size: 0.95rem;
            color: #64748b;
            margin-bottom: 0;
        }
        
        .chart-container {
            height: 300px;
            margin-bottom: 2rem;
            position: relative;
        }
        
        .data-table {
            margin-top: 2rem;
        }
        
        .data-table th {
            font-weight: 600;
            background-color: #f8fafc;
        }
        
        .counter {
            display: inline-block;
        }
        
        .animate-value {
            transition: all 2s ease;
        }
        
        /* Loading animation placeholder */
        .skeleton {
            display: block;
            background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
            background-size: 200% 100%;
            animation: loading 1.5s infinite;
            border-radius: 0.25rem;
        }
        
        @keyframes loading {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }
        
        .print-button {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--primary-color);
            color: white;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .print-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.25);
        }
        
        .print-button i {
            font-size: 1.5rem;
        }
        
        @media print {
            body {
                background: white;
                font-size: 12pt;
            }
            
            .print-button {
                display: none;
            }
            
            .no-print {
                display: none;
            }
            
            .report-container {
                box-shadow: none;
                padding: 0;
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="text-center mb-4 animate__animated animate__fadeInDown">
                    <h1 class="bank-header display-5 mb-0">Newark Community Bank</h1>
                    <p class="text-muted">Administration Portal</p>
                </div>
                
                <div class="report-container animate__animated animate__fadeIn">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="page-title">EOD Report Results</h2>
                            <p class="page-subtitle mb-0">End-of-day account and deposit summary</p>
                        </div>
                        <div class="badge bg-primary p-2">
                            <i class="fas fa-calendar-day me-1"></i> 
                            <%= new java.text.SimpleDateFormat("MMMM d, yyyy").format(new java.util.Date()) %>
                        </div>
                    </div>
                    
                    <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    
                    int totalAccounts = 0;
                    double totalDeposit = 0.0;
                    double totalBonus = 0.0;
                    double avgDeposit = 0.0;
                    
                    try {
                        // Load the MySQL JDBC driver
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        
                        // Connect to the database
                        String url = "jdbc:mysql://mysql:3306/newark_community_bank";
                        String user = "root";
                        String password = "rootpassword";
                        
                        conn = DriverManager.getConnection(url, user, password);
                        
                        // Query total accounts and deposits
                        String sql = "SELECT COUNT(*) as total_accounts, SUM(acct_deposit) as total_deposit, " +
                                    "SUM(acct_bonus) as total_bonus, AVG(acct_deposit) as avg_deposit FROM new_accounts";
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();
                        
                        if (rs.next()) {
                            totalAccounts = rs.getInt("total_accounts");
                            totalDeposit = rs.getDouble("total_deposit");
                            totalBonus = rs.getDouble("total_bonus");
                            avgDeposit = rs.getDouble("avg_deposit");
                        }
                        
                        DecimalFormat df = new DecimalFormat("#,##0.00");
                    %>
                    
                    <div class="report-summary animate__animated animate__fadeInUp">
                        <h3 class="mb-3">Summary Report</h3>
                        <p class="lead mb-0">
                            <span class="counter" data-target="<%= totalAccounts %>">0</span> accounts created today 
                            with a total deposit of <strong>$<span class="counter" data-target="<%= totalDeposit %>">0</span></strong>
                        </p>
                    </div>
                    
                    <div class="stat-cards animate__animated animate__fadeInUp animate__delay-1s">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-value">
                                <span class="counter" data-target="<%= totalAccounts %>">0</span>
                            </div>
                            <p class="stat-label">Total Accounts</p>
                        </div>
                        
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <div class="stat-value">
                                $<span class="counter" data-target="<%= totalDeposit %>">0</span>
                            </div>
                            <p class="stat-label">Total Deposits</p>
                        </div>
                        
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-gift"></i>
                            </div>
                            <div class="stat-value">
                                $<span class="counter" data-target="<%= totalBonus %>">0</span>
                            </div>
                            <p class="stat-label">Total Bonuses</p>
                        </div>
                    </div>
                    
                    <div class="chart-container animate__animated animate__fadeIn animate__delay-2s">
                        <canvas id="depositChart"></canvas>
                    </div>
                    
                    <div class="data-table animate__animated animate__fadeIn animate__delay-2s">
                        <h4 class="mb-3">Account Details</h4>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Account #</th>
                                        <th>Account Name</th>
                                        <th>Deposit</th>
                                        <th>Bonus</th>
                                        <th>Lottery</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    // Query account details
                                    sql = "SELECT * FROM new_accounts ORDER BY acct_number";
                                    pstmt = conn.prepareStatement(sql);
                                    rs = pstmt.executeQuery();
                                    
                                    while (rs.next()) {
                                        int acctNumber = rs.getInt("acct_number");
                                        String acctName = rs.getString("acct_name");
                                        double acctDeposit = rs.getDouble("acct_deposit");
                                        double acctBonus = rs.getDouble("acct_bonus");
                                        double acctLotteryWin = rs.getDouble("acct_lottery_win");
                                    %>
                                    <tr>
                                        <td><%= acctNumber %></td>
                                        <td><%= acctName %></td>
                                        <td>$<%= df.format(acctDeposit) %></td>
                                        <td>$<%= df.format(acctBonus) %></td>
                                        <td>$<%= df.format(acctLotteryWin) %></td>
                                    </tr>
                                    <%
                                    }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <%
                    } catch (Exception e) {
                    %>
                    <div class="alert alert-danger">
                        <p>Error generating report: <%= e.getMessage() %></p>
                    </div>
                    <%
                    } finally {
                        // Close resources
                        if (rs != null) try { rs.close(); } catch (Exception e) {}
                        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
                        if (conn != null) try { conn.close(); } catch (Exception e) {}
                    }
                    %>
                    
                    <div class="d-flex justify-content-between mt-4 no-print">
                        <a href="report.jsp" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Back to Report
                        </a>
                        <a href="success.jsp" class="btn btn-primary">
                            <i class="fas fa-home me-2"></i>Return to Dashboard
                        </a>
                    </div>
                </div>
                
                <div class="text-center mt-4 text-muted animate__animated animate__fadeIn animate__delay-2s no-print">
                    <small>&copy; 2025 Newark Community Bank. All rights reserved.</small>
                </div>
            </div>
        </div>
    </div>
    
    <div class="print-button animate__animated animate__bounceIn animate__delay-3s" onclick="window.print()" title="Print Report">
        <i class="fas fa-print"></i>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Counter animation
            const counters = document.querySelectorAll('.counter');
            
            counters.forEach(counter => {
                const target = parseFloat(counter.getAttribute('data-target'));
                const duration = 1500; // Animation duration in milliseconds
                const increment = target / (duration / 10); // Increment per step
                let current = 0;
                
                const updateCounter = () => {
                    current += increment;
                    
                    if (current < target) {
                        // Format the display value
                        if (target < 100) {
                            // For small numbers, show decimals
                            counter.innerText = current.toFixed(2);
                        } else {
                            // For larger numbers, show with commas and no decimals
                            counter.innerText = Math.floor(current).toLocaleString();
                        }
                        setTimeout(updateCounter, 10);
                    } else {
                        // Ensure we end up with the exact target value
                        if (target < 100) {
                            counter.innerText = target.toFixed(2);
                        } else {
                            counter.innerText = Math.floor(target).toLocaleString();
                        }
                    }
                };
                
                setTimeout(() => {
                    updateCounter();
                }, 500); // Delay start of animation
            });
            
            // Setup Chart.js
            <% if (totalAccounts > 0) { %>
            const ctx = document.getElementById('depositChart').getContext('2d');
            
            fetch('getChartData.jsp')
                .then(response => {
                    const depositChart = new Chart(ctx, {
                        type: 'doughnut',
                        data: {
                            labels: [
                                'Deposits ≥ $10,000',
                                'Deposits $5,000-$9,999',
                                'Deposits < $5,000'
                            ],
                            datasets: [{
                                data: [
                                    <%= 
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        Connection c = DriverManager.getConnection("jdbc:mysql://mysql:3306/newark_community_bank", "root", "rootpassword");
                                        Statement s = c.createStatement();
                                        ResultSet r = s.executeQuery("SELECT COUNT(*) FROM new_accounts WHERE acct_deposit >= 10000");
                                        r.next();
                                        out.print(r.getInt(1));
                                        r.close(); s.close(); c.close();
                                    } catch (Exception e) {
                                        out.print(0);
                                    }
                                    %>,
                                    <%= 
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        Connection c = DriverManager.getConnection("jdbc:mysql://mysql:3306/newark_community_bank", "root", "rootpassword");
                                        Statement s = c.createStatement();
                                        ResultSet r = s.executeQuery("SELECT COUNT(*) FROM new_accounts WHERE acct_deposit >= 5000 AND acct_deposit < 10000");
                                        r.next();
                                        out.print(r.getInt(1));
                                        r.close(); s.close(); c.close();
                                    } catch (Exception e) {
                                        out.print(0);
                                    }
                                    %>,
                                    <%= 
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        Connection c = DriverManager.getConnection("jdbc:mysql://mysql:3306/newark_community_bank", "root", "rootpassword");
                                        Statement s = c.createStatement();
                                        ResultSet r = s.executeQuery("SELECT COUNT(*) FROM new_accounts WHERE acct_deposit < 5000");
                                        r.next();
                                        out.print(r.getInt(1));
                                        r.close(); s.close(); c.close();
                                    } catch (Exception e) {
                                        out.print(0);
                                    }
                                    %>
                                ],
                                backgroundColor: [
                                    '#3b82f6',
                                    '#60a5fa',
                                    '#93c5fd'
                                ],
                                borderColor: '#ffffff',
                                borderWidth: 2
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'bottom',
                                    labels: {
                                        padding: 20,
                                        font: {
                                            size: 12
                                        }
                                    }
                                },
                                title: {
                                    display: true,
                                    text: 'Account Distribution by Deposit Amount',
                                    font: {
                                        size: 16
                                    },
                                    padding: {
                                        top: 10,
                                        bottom: 20
                                    }
                                }
                            },
                            animation: {
                                animateScale: true,
                                animateRotate: true
                            }
                        }
                    });
                });
            <% } %>
        });
    </script>
</body>
</html> 
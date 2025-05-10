<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newark Community Bank - EOD Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1e40af;
            --accent-color: #60a5fa;
            --background-color: #f0f9ff;
            --text-color: #0f172a;
            --success-color: #10b981;
            --warning-color: #f59e0b;
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
            max-width: 700px;
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
        
        .btn-secondary {
            background-color: #f1f5f9;
            border-color: #e2e8f0;
            color: #475569;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .btn-secondary:hover {
            background-color: #e2e8f0;
            border-color: #cbd5e1;
            color: #334155;
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
        
        .report-card {
            background-color: #f8fafc;
            border-radius: 0.75rem;
            padding: 2rem;
            margin-bottom: 2rem;
            border: 1px solid #e2e8f0;
            text-align: center;
        }
        
        .report-icon {
            width: 80px;
            height: 80px;
            background-color: rgba(96, 165, 250, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
        }
        
        .report-icon i {
            font-size: 2.5rem;
            color: var(--primary-color);
        }
        
        .report-description {
            font-size: 1.1rem;
            color: #334155;
            line-height: 1.6;
            margin-bottom: 2rem;
        }
        
        .loading-spinner {
            display: none;
            margin-left: 0.75rem;
        }
        
        .generate-btn {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        /* Pulse animation for the report icon */
        .pulse {
            animation: pulse-animation 2s infinite;
        }
        
        @keyframes pulse-animation {
            0% {
                box-shadow: 0 0 0 0 rgba(96, 165, 250, 0.4);
            }
            70% {
                box-shadow: 0 0 0 15px rgba(96, 165, 250, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(96, 165, 250, 0);
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
                            <h2 class="page-title">EOD Report</h2>
                            <p class="page-subtitle mb-0">Generate end-of-day account and deposit summaries</p>
                        </div>
                        <a href="success.jsp" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Back
                        </a>
                    </div>
                    
                    <div class="report-card animate__animated animate__fadeInUp">
                        <div class="report-icon pulse">
                            <i class="fas fa-chart-pie"></i>
                        </div>
                        
                        <h3 class="mb-3">End of Day Report</h3>
                        
                        <p class="report-description">
                            Generate a comprehensive report showing the total number of accounts created today 
                            and the cumulative deposit amount. This helps track daily banking activities and 
                            financial performance.
                        </p>
                        
                        <form action="generateReport.jsp" method="post" id="reportForm">
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary generate-btn" id="generateBtn">
                                    <span><i class="fas fa-file-alt me-2"></i>Generate Report</span>
                                    <div class="loading-spinner" id="loadingSpinner">
                                        <div class="spinner-border spinner-border-sm" role="status">
                                            <span class="visually-hidden">Loading...</span>
                                        </div>
                                    </div>
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <div class="mt-4 animate__animated animate__fadeIn animate__delay-1s">
                        <div class="card border-0 bg-light">
                            <div class="card-body">
                                <h5 class="mb-3"><i class="fas fa-info-circle me-2 text-primary"></i>Report Information</h5>
                                <ul class="list-unstyled mb-0">
                                    <li class="mb-2"><i class="fas fa-check-circle me-2 text-success"></i>Shows total number of accounts created</li>
                                    <li class="mb-2"><i class="fas fa-check-circle me-2 text-success"></i>Displays total deposit amount received</li>
                                    <li><i class="fas fa-check-circle me-2 text-success"></i>Updated in real-time with latest data</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="text-center mt-4 text-muted animate__animated animate__fadeIn animate__delay-1s">
                    <small>&copy; 2025 Newark Community Bank. All rights reserved.</small>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const reportForm = document.getElementById('reportForm');
            const generateBtn = document.getElementById('generateBtn');
            const loadingSpinner = document.getElementById('loadingSpinner');
            
            reportForm.addEventListener('submit', function(e) {
                // Show loading state
                generateBtn.disabled = true;
                loadingSpinner.style.display = 'flex';
                
                // Add a class to change button text
                generateBtn.querySelector('span').innerHTML = '<i class="fas fa-cog fa-spin me-2"></i>Generating...';
                
                // Continue with form submission (we don't prevent default)
                // The loading state will show until the new page loads
            });
        });
    </script>
</body>
</html> 
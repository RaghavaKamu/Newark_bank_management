<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newark Community Bank - EOD Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .report-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 2rem;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="text-center mb-4">
            <h1>Newark Community Bank</h1>
            <h4>Generate EOD Report</h4>
        </div>
        
        <div class="report-container">
            <form action="report" method="post">
                <p class="text-center mb-4">Click the button below to generate an End of Day report showing the total number of accounts created and the total amount deposited.</p>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">Generate Report</button>
                    <a href="admin" class="btn btn-secondary">Back to Admin</a>
                </div>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 
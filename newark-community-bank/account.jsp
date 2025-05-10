<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newark Community Bank - Create Account</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .account-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 2rem;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .error-message {
            display: none;
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="text-center mb-4">
            <h1>Newark Community Bank</h1>
            <h4>Create New Account</h4>
        </div>
        
        <div class="account-container">
            <form action="account" method="post" id="accountForm">
                <div class="mb-3">
                    <label for="acctName" class="form-label">Account Holder Name</label>
                    <input type="text" class="form-control" id="acctName" name="acctName" required>
                </div>
                <div class="mb-3">
                    <label for="acctDeposit" class="form-label">Deposit Amount ($)</label>
                    <input type="number" step="0.01" min="1000" class="form-control" id="acctDeposit" name="acctDeposit" required>
                    <div class="form-text">Minimum deposit is $1,000.00</div>
                </div>
                
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">Submit</button>
                    <a href="admin" class="btn btn-secondary">Back to Admin</a>
                </div>
            </form>
            <div id="errorMessage" class="error-message text-center mt-3"></div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('accountForm').addEventListener('submit', function(e) {
            const acctName = document.getElementById('acctName').value;
            const acctDeposit = parseFloat(document.getElementById('acctDeposit').value);
            
            if (!acctName) {
                e.preventDefault();
                document.getElementById('errorMessage').innerText = 'Please enter account holder name';
                document.getElementById('errorMessage').style.display = 'block';
                return;
            }
            
            if (isNaN(acctDeposit) || acctDeposit < 1000) {
                e.preventDefault();
                document.getElementById('errorMessage').innerText = 'Deposit amount must be at least $1,000.00';
                document.getElementById('errorMessage').style.display = 'block';
                return;
            }
        });
    </script>
</body>
</html> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newark Community Bank - Admin Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 400px;
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
            <h4>Admin page, please login</h4>
        </div>
        
        <div class="login-container">
            <div id="loginForm">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <button type="button" class="btn btn-primary w-100" id="loginBtn">Login</button>
                <div id="errorMessage" class="error-message text-center"></div>
            </div>
            
            <div id="moduleSelection" style="display: none;">
                <h5 class="text-center mb-4">Authentication Successful</h5>
                <form action="admin" method="post">
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="radio" name="action" id="account" value="account" checked>
                        <label class="form-check-label" for="account">
                            Create New Account
                        </label>
                    </div>
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="radio" name="action" id="report" value="report">
                        <label class="form-check-label" for="report">
                            EOD Report
                        </label>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Submit</button>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('loginBtn').addEventListener('click', function() {
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            
            if (!username || !password) {
                document.getElementById('errorMessage').innerText = 'Please enter both username and password';
                document.getElementById('errorMessage').style.display = 'block';
                return;
            }
            
            // Send login request using AJAX
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'admin', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.responseText.includes('successful')) {
                        // Show module selection form
                        document.getElementById('loginForm').style.display = 'none';
                        document.getElementById('moduleSelection').style.display = 'block';
                    } else {
                        // Show error message
                        document.getElementById('errorMessage').innerText = 'Your authentication has failed, please try again';
                        document.getElementById('errorMessage').style.display = 'block';
                        document.getElementById('username').value = '';
                        document.getElementById('password').value = '';
                    }
                }
            };
            xhr.send('username=' + encodeURIComponent(username) + '&password=' + encodeURIComponent(password));
        });
    </script>
</body>
</html> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newark Community Bank - Admin Login</title>
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
            --error-color: #ef4444;
        }
        
        body {
            background: var(--background-color);
            background-image: linear-gradient(135deg, #dbeafe 0%, #eff6ff 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            color: var(--text-color);
        }
        
        .bank-header {
            color: var(--primary-color);
            font-weight: 700;
            letter-spacing: -0.5px;
        }
        
        .login-container {
            max-width: 450px;
            margin: 0 auto;
            padding: 2.5rem;
            background-color: #ffffff;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            transform: translateY(0);
            transition: all 0.3s ease;
        }
        
        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }
        
        .form-control {
            border: 2px solid #e2e8f0;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 3px rgba(96, 165, 250, 0.25);
        }
        
        .input-icon {
            position: relative;
        }
        
        .input-icon i {
            position: absolute;
            top: 50%;
            left: 1rem;
            transform: translateY(-50%);
            color: #94a3b8;
        }
        
        .input-icon input {
            padding-left: 2.75rem;
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
        
        .error-message {
            display: none;
            color: var(--error-color);
            background-color: rgba(239, 68, 68, 0.1);
            border-radius: 0.5rem;
            padding: 0.75rem;
            margin-top: 1rem;
            font-size: 0.9rem;
        }
        
        .logo-container {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            background-color: var(--primary-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .logo-container i {
            font-size: 2.5rem;
            color: white;
        }
        
        .loading {
            display: none;
            margin-left: 0.5rem;
        }
        
        /* Shimmer effect */
        .shimmer {
            background: linear-gradient(
                to right,
                rgba(255, 255, 255, 0) 0%,
                rgba(255, 255, 255, 0.5) 50%,
                rgba(255, 255, 255, 0) 100%
            );
            background-size: 200% 100%;
            animation: shimmer 1.5s infinite;
        }
        
        @keyframes shimmer {
            0% {
                background-position: -200% 0;
            }
            100% {
                background-position: 200% 0;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="text-center mb-4 animate__animated animate__fadeInDown">
                    <h1 class="bank-header display-5 mb-0">Newark Community Bank</h1>
                    <p class="text-muted">Secure Admin Portal</p>
                </div>
                
                <div class="login-container animate__animated animate__fadeIn">
                    <div class="logo-container animate__animated animate__bounceIn animate__delay-1s">
                        <i class="fas fa-landmark"></i>
                    </div>
                    
                    <h4 class="text-center mb-4">Admin Login</h4>
                    
                    <div id="loginForm">
                        <div class="mb-4 input-icon">
                            <i class="fas fa-user"></i>
                            <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
                        </div>
                        
                        <div class="mb-4 input-icon">
                            <i class="fas fa-lock"></i>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                        </div>
                        
                        <button type="button" class="btn btn-primary w-100 d-flex align-items-center justify-content-center" id="loginBtn">
                            <span>Login</span>
                            <div class="loading" id="loginSpinner">
                                <div class="spinner-border spinner-border-sm" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>
                        </button>
                        
                        <div id="errorMessage" class="error-message text-center mt-3">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            <span id="errorText"></span>
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
            const loginBtn = document.getElementById('loginBtn');
            const loginSpinner = document.getElementById('loginSpinner');
            const errorMessage = document.getElementById('errorMessage');
            const errorText = document.getElementById('errorText');
            const usernameInput = document.getElementById('username');
            const passwordInput = document.getElementById('password');
            
            // Auto-focus on username field
            usernameInput.focus();
            
            // Enable enter key to submit
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Enter') {
                    loginBtn.click();
                }
            });
            
            loginBtn.addEventListener('click', function() {
                const username = usernameInput.value.trim();
                const password = passwordInput.value.trim();
                
                if (!username || !password) {
                    showError('Please enter both username and password');
                    return;
                }
                
                // Show loading spinner
                loginBtn.disabled = true;
                loginSpinner.style.display = 'flex';
                
                // Simulate server request
                setTimeout(function() {
                    // Verify credentials
                    if (username === 'raghava' && password === 'rr123') {
                        // Success - show animation before redirect
                        errorMessage.style.display = 'none';
                        
                        // Add success animation
                        loginBtn.innerHTML = '<i class="fas fa-check-circle me-2"></i> Success!';
                        loginBtn.classList.remove('btn-primary');
                        loginBtn.classList.add('btn-success');
                        
                        // Redirect after animation
                        setTimeout(function() {
                            window.location.href = 'success.jsp';
                        }, 1000);
                    } else {
                        // Failed login
                        loginBtn.disabled = false;
                        loginSpinner.style.display = 'none';
                        showError('Your authentication has failed, please try again');
                        passwordInput.value = '';
                        passwordInput.focus();
                    }
                }, 800);
            });
            
            function showError(message) {
                errorText.textContent = message;
                errorMessage.style.display = 'block';
                
                // Add shake animation
                errorMessage.classList.add('animate__animated', 'animate__shakeX');
                
                // Remove animation class after animation completes
                setTimeout(function() {
                    errorMessage.classList.remove('animate__animated', 'animate__shakeX');
                }, 1000);
            }
        });
    </script>
</body>
</html> 
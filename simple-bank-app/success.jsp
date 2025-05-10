<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newark Community Bank - Admin Portal</title>
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
        
        .selection-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 2.5rem;
            background-color: #ffffff;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        
        .alert-success-custom {
            background-color: rgba(16, 185, 129, 0.1);
            border-left: 4px solid var(--success-color);
            border-radius: 0.5rem;
            color: #065f46;
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
        
        .module-card {
            border: 2px solid #e2e8f0;
            border-radius: 0.75rem;
            padding: 1.5rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .module-card:hover {
            border-color: var(--accent-color);
            transform: translateY(-3px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }
        
        .module-card.selected {
            border-color: var(--primary-color);
            background-color: rgba(96, 165, 250, 0.05);
        }
        
        .module-card input[type="radio"] {
            position: absolute;
            opacity: 0;
        }
        
        .module-icon {
            width: 50px;
            height: 50px;
            background-color: rgba(96, 165, 250, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }
        
        .module-card:hover .module-icon, 
        .module-card.selected .module-icon {
            background-color: var(--primary-color);
            transform: scale(1.1);
        }
        
        .module-icon i {
            font-size: 1.5rem;
            color: var(--primary-color);
            transition: all 0.3s ease;
        }
        
        .module-card:hover .module-icon i,
        .module-card.selected .module-icon i {
            color: #ffffff;
        }
        
        .module-title {
            font-weight: 600;
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
        }
        
        .module-description {
            color: #64748b;
            font-size: 0.95rem;
            margin-bottom: 0;
        }
        
        .user-welcome {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        .user-avatar {
            width: 50px;
            height: 50px;
            background-color: var(--primary-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            font-weight: 600;
            color: white;
            font-size: 1.25rem;
        }
        
        .welcome-text h4 {
            margin-bottom: 0.25rem;
        }
        
        .welcome-text p {
            margin-bottom: 0;
            color: #64748b;
        }
        
        .checkmark {
            position: absolute;
            top: 1rem;
            right: 1rem;
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background-color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transform: scale(0);
            transition: all 0.3s ease;
        }
        
        .checkmark i {
            color: white;
            font-size: 0.75rem;
        }
        
        .module-card.selected .checkmark {
            opacity: 1;
            transform: scale(1);
        }
        
        .ripple {
            position: absolute;
            border-radius: 50%;
            background-color: rgba(96, 165, 250, 0.3);
            animation: ripple-animation 0.6s linear;
            transform: scale(0);
            pointer-events: none;
        }
        
        @keyframes ripple-animation {
            100% {
                transform: scale(2.5);
                opacity: 0;
            }
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="text-center mb-4 animate__animated animate__fadeInDown">
                    <h1 class="bank-header display-5 mb-0">Newark Community Bank</h1>
                    <p class="text-muted">Administration Portal</p>
                </div>
                
                <div class="selection-container animate__animated animate__fadeIn">
                    <div class="alert alert-success-custom mb-4 animate__animated animate__fadeIn animate__delay-1s">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-check-circle me-3" style="font-size: 1.5rem;"></i>
                            <div>
                                <h6 class="mb-0 fw-bold">Authentication Successful</h6>
                                <p class="mb-0">Welcome to the Newark Community Bank admin portal.</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="user-welcome animate__animated animate__fadeIn animate__delay-1s">
                        <div class="user-avatar">
                            <span>R</span>
                        </div>
                        <div class="welcome-text">
                            <h4>Hello, Raghava!</h4>
                            <p>Please select a module to continue</p>
                        </div>
                    </div>
                    
                    <form action="processSelection.jsp" method="post" id="moduleForm">
                        <div class="mb-4">
                            <label for="module-options" class="form-label visually-hidden">Please select an option:</label>
                            
                            <div id="module-options">
                                <label class="module-card w-100 mb-3 animate__animated animate__fadeInUp animate__delay-1s" id="card-createAccount">
                                    <input type="radio" name="action" id="createAccount" value="createAccount" checked>
                                    <div class="d-flex">
                                        <div class="module-icon">
                                            <i class="fas fa-user-plus"></i>
                                        </div>
                                        <div class="ms-3 flex-grow-1">
                                            <h5 class="module-title">Create New Account</h5>
                                            <p class="module-description">Open a new customer account and apply bonus rules</p>
                                        </div>
                                    </div>
                                    <div class="checkmark">
                                        <i class="fas fa-check"></i>
                                    </div>
                                </label>
                                
                                <label class="module-card w-100 animate__animated animate__fadeInUp animate__delay-1s" id="card-eodReport">
                                    <input type="radio" name="action" id="eodReport" value="eodReport">
                                    <div class="d-flex">
                                        <div class="module-icon">
                                            <i class="fas fa-chart-line"></i>
                                        </div>
                                        <div class="ms-3 flex-grow-1">
                                            <h5 class="module-title">EOD Report</h5>
                                            <p class="module-description">Generate end-of-day reports and summary statistics</p>
                                        </div>
                                    </div>
                                    <div class="checkmark">
                                        <i class="fas fa-check"></i>
                                    </div>
                                </label>
                            </div>
                        </div>
                        
                        <div class="d-grid gap-2 animate__animated animate__fadeIn animate__delay-2s">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-arrow-right me-2"></i>Continue
                            </button>
                        </div>
                    </form>
                </div>
                
                <div class="text-center mt-4 text-muted animate__animated animate__fadeIn animate__delay-2s">
                    <small>&copy; 2025 Newark Community Bank. All rights reserved.</small>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const createAccountCard = document.getElementById('card-createAccount');
            const eodReportCard = document.getElementById('card-eodReport');
            const createAccountRadio = document.getElementById('createAccount');
            const eodReportRadio = document.getElementById('eodReport');
            
            // Set initial selection
            createAccountCard.classList.add('selected');
            
            // Handle card selection 
            createAccountCard.addEventListener('click', function(e) {
                createAccountRadio.checked = true;
                updateSelection();
                createRippleEffect(e, this);
            });
            
            eodReportCard.addEventListener('click', function(e) {
                eodReportRadio.checked = true;
                updateSelection();
                createRippleEffect(e, this);
            });
            
            // Update UI for selection
            function updateSelection() {
                if (createAccountRadio.checked) {
                    createAccountCard.classList.add('selected');
                    eodReportCard.classList.remove('selected');
                } else {
                    eodReportCard.classList.add('selected');
                    createAccountCard.classList.remove('selected');
                }
            }
            
            // Create ripple effect
            function createRippleEffect(e, element) {
                const rect = element.getBoundingClientRect();
                const x = e.clientX - rect.left;
                const y = e.clientY - rect.top;
                
                const ripple = document.createElement('span');
                ripple.classList.add('ripple');
                ripple.style.left = x + 'px';
                ripple.style.top = y + 'px';
                
                element.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 600);
            }
        });
    </script>
</body>
</html> 
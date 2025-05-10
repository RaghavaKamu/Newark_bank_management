<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Newark Community Bank - Create Account</title>
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
        
        .account-container {
            max-width: 700px;
            margin: 0 auto;
            padding: 2.5rem;
            background-color: #ffffff;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
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
            transform: translateY(-50%);
            left: 1rem;
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
        
        .error-message {
            display: none;
            color: var(--error-color);
            background-color: rgba(239, 68, 68, 0.1);
            border-radius: 0.5rem;
            padding: 0.75rem;
            margin-top: 1rem;
            font-size: 0.95rem;
        }
        
        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #334155;
        }
        
        .form-text {
            color: #64748b;
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
        
        .form-section {
            background-color: #f8fafc;
            border-radius: 0.75rem;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: 1px solid #e2e8f0;
        }
        
        .form-section-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: #334155;
            display: flex;
            align-items: center;
        }
        
        .form-section-title i {
            margin-right: 0.75rem;
            color: var(--primary-color);
        }
        
        /* Bonus information tooltip */
        .bonus-info {
            position: relative;
            display: inline-block;
            margin-left: 0.5rem;
            cursor: pointer;
        }
        
        .bonus-info i {
            color: var(--accent-color);
            font-size: 0.9rem;
        }
        
        .bonus-tooltip {
            position: absolute;
            bottom: 100%;
            left: 50%;
            transform: translateX(-50%);
            background-color: #1e293b;
            color: white;
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            width: 300px;
            font-size: 0.85rem;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            z-index: 100;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }
        
        .bonus-info:hover .bonus-tooltip {
            opacity: 1;
            visibility: visible;
        }
        
        .bonus-tooltip::after {
            content: '';
            position: absolute;
            top: 100%;
            left: 50%;
            transform: translateX(-50%);
            border-width: 8px;
            border-style: solid;
            border-color: #1e293b transparent transparent transparent;
        }
        
        .bonus-list {
            list-style: none;
            padding: 0;
            margin: 0.5rem 0 0;
        }
        
        .bonus-list li {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
        }
        
        .bonus-list li i {
            color: var(--success-color);
            margin-right: 0.5rem;
        }
        
        /* Amount slider customization */
        .range-container {
            margin-top: 2rem;
        }
        
        .range-slider {
            -webkit-appearance: none;
            width: 100%;
            height: 10px;
            border-radius: 5px;
            background: #e2e8f0;
            outline: none;
            margin-bottom: 1.25rem;
        }
        
        .range-slider::-webkit-slider-thumb {
            -webkit-appearance: none;
            appearance: none;
            width: 25px;
            height: 25px;
            border-radius: 50%;
            background: var(--primary-color);
            cursor: pointer;
            border: 3px solid white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: all 0.2s ease;
        }
        
        .range-slider::-webkit-slider-thumb:hover {
            transform: scale(1.1);
        }
        
        .range-values {
            display: flex;
            justify-content: space-between;
            font-size: 0.9rem;
            color: #64748b;
        }
        
        .bonus-indicator {
            margin-top: 1rem;
            padding: 1rem;
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            background-color: rgba(96, 165, 250, 0.1);
            border-left: 4px solid var(--accent-color);
        }
        
        .bonus-indicator i {
            font-size: 1.5rem;
            margin-right: 1rem;
            color: var(--primary-color);
        }
        
        .bonus-indicator-text {
            font-size: 0.95rem;
            color: #334155;
        }
        
        .bonus-amount {
            font-weight: 600;
            color: var(--primary-color);
        }
        
        .eligibility-text {
            font-weight: 600;
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
                
                <div class="account-container animate__animated animate__fadeIn">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2 class="page-title">Create New Account</h2>
                            <p class="page-subtitle mb-0">Open a new account for a customer with initial deposit</p>
                        </div>
                        <a href="success.jsp" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Back
                        </a>
                    </div>
                    
                    <form action="createAccount.jsp" method="post" id="accountForm">
                        <div class="form-section animate__animated animate__fadeInUp">
                            <h3 class="form-section-title">
                                <i class="fas fa-user"></i>Customer Information
                            </h3>
                            
                            <div class="row g-3">
                                <div class="col-md-12">
                                    <div class="mb-3 input-icon">
                                        <i class="fas fa-user"></i>
                                        <input type="text" class="form-control" id="acctName" name="acctName" placeholder="Full Name" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-section animate__animated animate__fadeInUp animate__delay-1s">
                            <h3 class="form-section-title">
                                <i class="fas fa-dollar-sign"></i>Deposit Information
                                <div class="bonus-info">
                                    <i class="fas fa-info-circle"></i>
                                    <div class="bonus-tooltip">
                                        <strong>Bonus Rules:</strong>
                                        <ul class="bonus-list">
                                            <li><i class="fas fa-check"></i>$500 bonus for deposits ≥ $10,000</li>
                                            <li><i class="fas fa-check"></i>$300 bonus for deposits ≥ $5,000</li>
                                            <li><i class="fas fa-check"></i>Deposits < $5,000 eligible for lottery ($100)</li>
                                        </ul>
                                    </div>
                                </div>
                            </h3>
                            
                            <div class="mb-3 input-icon">
                                <i class="fas fa-dollar-sign"></i>
                                <input type="number" step="100" min="1000" class="form-control" id="acctDeposit" name="acctDeposit" placeholder="Deposit Amount" value="5000" required>
                                <div class="form-text">Minimum deposit is $1,000.00</div>
                            </div>
                            
                            <div class="range-container">
                                <input type="range" class="range-slider" id="depositRange" min="1000" max="20000" step="100" value="5000">
                                <div class="range-values">
                                    <span>$1,000</span>
                                    <span>$5,000</span>
                                    <span>$10,000</span>
                                    <span>$20,000</span>
                                </div>
                                
                                <div class="bonus-indicator">
                                    <i class="fas fa-gift"></i>
                                    <div class="bonus-indicator-text">
                                        <span id="bonusMessage">With a deposit of $5,000, this account will receive a <span class="bonus-amount">$300 bonus</span>.</span>
                                        <div id="lotteryMessage" style="display: none;">This deposit amount is <span class="eligibility-text">eligible for the $100 lottery</span>.</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-grid gap-2 animate__animated animate__fadeInUp animate__delay-2s">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Create Account
                            </button>
                        </div>
                    </form>
                    
                    <div id="errorMessage" class="error-message text-center mt-3">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <span id="errorText"></span>
                    </div>
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
            const accountForm = document.getElementById('accountForm');
            const errorMessage = document.getElementById('errorMessage');
            const errorText = document.getElementById('errorText');
            const acctNameInput = document.getElementById('acctName');
            const acctDepositInput = document.getElementById('acctDeposit');
            const depositRange = document.getElementById('depositRange');
            const bonusMessage = document.getElementById('bonusMessage');
            const lotteryMessage = document.getElementById('lotteryMessage');
            
            // Auto-focus on name field
            acctNameInput.focus();
            
            // Sync deposit input and range slider
            depositRange.addEventListener('input', function() {
                acctDepositInput.value = this.value;
                updateBonusMessage(this.value);
            });
            
            acctDepositInput.addEventListener('input', function() {
                if (this.value >= 1 if (this.value >= 1000 && this.value <= 20000) {if (this.value >= 1000 && this.value <= 20000) { this.value <= 20000) {
                    depositRange.value = this.value;
                }
                updateBonusMessage(this.value);
            });
            
            // Update bonus message based on deposit amount
            function updateBonusMessage(amount) {
                amount = parseFloat(amount);
                if (amount >= 10000) {
                    bonusMessage.innerHTML = `With a deposit of $${amount.toLocaleString()}, this account will receive a <span class="bonus-amount">$500 bonus</span>.`;
                    lotteryMessage.style.display = 'none';
                } else if (amount >= 5000) {
                    bonusMessage.innerHTML = `With a deposit of $${amount.toLocaleString()}, this account will receive a <span class="bonus-amount">$300 bonus</span>.`;
                    lotteryMessage.style.display = 'none';
                } else if (amount >= 1000) {
                    bonusMessage.innerHTML = `With a deposit of $${amount.toLocaleString()}, this account will not receive a bonus.`;
                    lotteryMessage.style.display = 'block';
                } else {
                    bonusMessage.innerHTML = `The minimum deposit amount is $1,000.`;
                    lotteryMessage.style.display = 'none';
                }
            }
            
            // Form validation
            accountForm.addEventListener('submit', function(e) {
                const acctName = acctNameInput.value.trim();
                const acctDeposit = parseFloat(acctDepositInput.value);
                
                if (!acctName) {
                    e.preventDefault();
                    showError('Please enter the account holder name');
                    acctNameInput.focus();
                    return;
                }
                
                if (isNaN(acctDeposit) || acctDeposit < 1000) {
                    e.preventDefault();
                    showError('Deposit amount must be at least $1,000.00');
                    acctDepositInput.focus();
                    return;
                }
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
            
            // Initialize the bonus message
            updateBonusMessage(acctDepositInput.value);
        });
    </script>
</body>
</html> 
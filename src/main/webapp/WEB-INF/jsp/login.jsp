<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Logistics - Courier Tracking System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            overflow-x: hidden;
        }

        .login-container {
            min-height: 100vh;
            width: 100%;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Purple Gradient Background */
        .gradient-bg {
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, #581c87 0%, #7e22ce 50%, #a855f7 100%);
        }

        /* World Map Pattern Overlay */
        .map-pattern {
            position: absolute;
            inset: 0;
            opacity: 0.1;
            background-image: url("data:image/svg+xml,%3Csvg width='100' height='100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M20 20h10v10H20zM40 30h15v8H40zM60 25h12v12H60zM15 45h8v12h-8zM35 50h18v15H35zM70 55h10v10H70z' fill='%23ffffff' fill-opacity='0.3'/%3E%3Ccircle cx='25' cy='25' r='2' fill='%23ffffff'/%3E%3Ccircle cx='48' cy='34' r='2' fill='%23ffffff'/%3E%3Ccircle cx='66' cy='31' r='2' fill='%23ffffff'/%3E%3C/svg%3E");
            background-size: 200px 200px;
        }

        /* Floating Elements */
        .floating-elements {
            position: absolute;
            inset: 0;
            overflow: hidden;
            pointer-events: none;
        }

        .truck-icon {
            position: absolute;
            color: white;
            opacity: 0.2;
        }

        .truck-1 {
            top: 5rem;
            left: 2.5rem;
            animation: float 6s ease-in-out infinite;
        }

        .truck-2 {
            top: 10rem;
            right: 5rem;
            opacity: 0.15;
            animation: float 6s ease-in-out infinite 2s;
        }

        .truck-3 {
            bottom: 8rem;
            left: 25%;
            opacity: 0.2;
            animation: float 6s ease-in-out infinite;
        }

        .pin-icon {
            position: absolute;
            color: white;
            opacity: 0.15;
            animation: pulse 2s ease-in-out infinite;
        }

        .pin-1 {
            top: 33%;
            right: 25%;
        }

        .pin-2 {
            bottom: 5rem;
            right: 2.5rem;
            opacity: 0.2;
        }

        /* Route Lines SVG */
        .route-lines {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            opacity: 0.1;
        }

        /* Login Card */
        .login-card {
            position: relative;
            z-index: 10;
            width: 100%;
            max-width: 28rem;
            padding: 0 1.5rem;
        }

        .glass-card {
            position: relative;
            backdrop-filter: blur(40px);
            -webkit-backdrop-filter: blur(40px);
            background: rgba(255, 255, 255, 0.1);
            border-radius: 1.5rem;
            padding: 2.5rem;
            box-shadow: 0 8px 32px 0 rgba(139, 92, 246, 0.37), 
                        0 0 60px rgba(168, 85, 247, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .glass-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, transparent 100%);
            border-radius: 1.5rem;
            pointer-events: none;
        }

        .card-content {
            position: relative;
        }

        /* Logo Container */
        .logo-container {
            display: flex;
            justify-content: center;
            margin-bottom: 1.5rem;
        }

        .logo-box {
            padding: 1rem;
            background: linear-gradient(135deg, #c084fc 0%, #9333ea 100%);
            border-radius: 1rem;
            box-shadow: 0 10px 25px -5px rgba(168, 85, 247, 0.4);
        }

        /* Truck SVG Icon */
        .truck-svg {
            width: 3rem;
            height: 3rem;
            color: white;
        }

        /* Heading */
        .heading-container {
            text-align: center;
            margin-bottom: 2rem;
        }

        .main-heading {
            font-size: 1.875rem;
            font-weight: bold;
            color: white;
            margin-bottom: 0.5rem;
            letter-spacing: 0.05em;
        }

        .sub-heading {
            color: #e9d5ff;
            font-size: 1.125rem;
        }

        /* Form */
        .login-form {
            margin-bottom: 2rem;
        }

        .form-group {
            position: relative;
            margin-bottom: 1.25rem;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            z-index: 10;
            color: #e9d5ff;
            width: 1.25rem;
            height: 1.25rem;
        }

        .form-input {
            width: 100%;
            padding: 1rem 1rem 1rem 3rem;
            border-radius: 1rem;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 2px solid rgba(255, 255, 255, 0.2);
            color: white;
            font-size: 1rem;
            transition: all 0.3s ease;
            outline: none;
        }

        .form-input::placeholder {
            color: #e9d5ff;
        }

        .form-input:focus {
            border-color: #d8b4fe;
            box-shadow: 0 0 20px rgba(216, 180, 254, 0.5);
        }

        /* Error Message */
        .error-message {
            background: rgba(239, 68, 68, 0.2);
            border: 1px solid rgba(239, 68, 68, 0.4);
            color: #fecaca;
            padding: 0.75rem;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
            font-size: 0.875rem;
        }

        /* Login Button */
        .login-button {
            width: 100%;
            padding: 1rem;
            border-radius: 1rem;
            background: linear-gradient(90deg, #a855f7 0%, #7e22ce 100%);
            color: white;
            font-weight: 600;
            font-size: 1.125rem;
            border: none;
            cursor: pointer;
            box-shadow: 0 10px 25px -5px rgba(168, 85, 247, 0.4);
            transition: all 0.3s ease;
            margin-top: 1.5rem;
        }

        .login-button:hover {
            box-shadow: 0 0 30px rgba(168, 85, 247, 0.6);
            transform: scale(1.02);
        }

        .login-button:active {
            transform: scale(0.98);
        }

        /* Footer Links */
        .footer-links {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.75rem;
        }

        .forgot-link {
            color: #e9d5ff;
            text-decoration: none;
            font-size: 0.875rem;
            transition: color 0.2s ease;
            background: none;
            border: none;
            cursor: pointer;
        }

        .forgot-link:hover {
            color: white;
        }

        .signup-container {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .signup-text {
            color: #e9d5ff;
            font-size: 0.875rem;
        }

        .signup-link {
            color: white;
            font-weight: 600;
            text-decoration: none;
            font-size: 0.875rem;
            transition: color 0.2s ease;
        }

        .signup-link:hover {
            color: #e9d5ff;
        }

        /* Animations */
        @keyframes float {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-20px);
            }
        }

        @keyframes pulse {
            0%, 100% {
                opacity: 0.15;
            }
            50% {
                opacity: 0.3;
            }
        }

        /* Responsive Design */
        @media (max-width: 640px) {
            .glass-card {
                padding: 2rem 1.5rem;
            }

            .main-heading {
                font-size: 1.5rem;
            }

            .sub-heading {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <!-- Purple Gradient Background -->
        <div class="gradient-bg"></div>
        
        <!-- World Map Pattern Overlay -->
        <div class="map-pattern"></div>

        <!-- Floating Delivery Trucks and Route Lines -->
        <div class="floating-elements">
            <!-- Truck Icons -->
            <div class="truck-icon truck-1">
                <svg class="truck-svg" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 3v12m0 0l3-3m-3 3l-3-3m12-6v12m0 0l3-3m-3 3l-3-3M3 21h18"/>
                    <rect x="1" y="3" width="15" height="13" rx="2" ry="2"></rect>
                    <path d="M16 8h5l3 3v5h-2.5m-13.5 0h-3v-13"></path>
                    <circle cx="5.5" cy="18.5" r="2.5"></circle>
                    <circle cx="18.5" cy="18.5" r="2.5"></circle>
                </svg>
            </div>
            
            <div class="truck-icon truck-2">
                <svg class="truck-svg" fill="none" stroke="currentColor" viewBox="0 0 24 24" style="width: 2.5rem; height: 2.5rem;">
                    <rect x="1" y="3" width="15" height="13" rx="2" ry="2"></rect>
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 8h5l3 3v5h-2.5m-13.5 0h-3v-13"></path>
                    <circle cx="5.5" cy="18.5" r="2.5"></circle>
                    <circle cx="18.5" cy="18.5" r="2.5"></circle>
                </svg>
            </div>
            
            <div class="truck-icon truck-3">
                <svg class="truck-svg" fill="none" stroke="currentColor" viewBox="0 0 24 24" style="width: 1.5rem; height: 1.5rem;">
                    <rect x="1" y="3" width="15" height="13" rx="2" ry="2"></rect>
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 8h5l3 3v5h-2.5m-13.5 0h-3v-13"></path>
                    <circle cx="5.5" cy="18.5" r="2.5"></circle>
                    <circle cx="18.5" cy="18.5" r="2.5"></circle>
                </svg>
            </div>
            
            <!-- Map Pin Icons -->
            <div class="pin-icon pin-1">
                <svg class="truck-svg" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                </svg>
            </div>
            
            <div class="pin-icon pin-2">
                <svg class="truck-svg" fill="none" stroke="currentColor" viewBox="0 0 24 24" style="width: 1.5rem; height: 1.5rem;">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                </svg>
            </div>

            <!-- Route Lines SVG -->
            <svg class="route-lines">
                <defs>
                    <linearGradient id="routeGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                        <stop offset="0%" style="stop-color: #ffffff; stop-opacity: 0.5" />
                        <stop offset="100%" style="stop-color: #ffffff; stop-opacity: 0.1" />
                    </linearGradient>
                </defs>
                <path d="M 100 150 Q 300 100, 500 200 T 900 250" stroke="url(#routeGradient)" stroke-width="3" fill="none" stroke-dasharray="10,5" />
                <path d="M 200 400 Q 400 350, 600 450 T 1000 500" stroke="url(#routeGradient)" stroke-width="2" fill="none" stroke-dasharray="8,4" />
            </svg>
        </div>

        <!-- Login Card with Glassmorphism -->
        <div class="login-card">
            <div class="glass-card">
                <!-- Layered Depth Effect -->
                <div class="glass-overlay"></div>
                
                <div class="card-content">
                    <!-- Logo/Icon -->
                    <div class="logo-container">
                        <div class="logo-box">
                            <svg class="truck-svg" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <rect x="1" y="3" width="15" height="13" rx="2" ry="2"></rect>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 8h5l3 3v5h-2.5m-13.5 0h-3v-13"></path>
                                <circle cx="5.5" cy="18.5" r="2.5"></circle>
                                <circle cx="18.5" cy="18.5" r="2.5"></circle>
                            </svg>
                        </div>
                    </div>

                    <!-- Heading -->
                    <div class="heading-container">
                        <h1 class="main-heading">SMART LOGISTICS</h1>
                    </div>

                    <!-- Error Message (JSP Placeholder) -->
                    <c:if test="${not empty error}">
                        <div class="error-message">
                            ${error}
                        </div>
                    </c:if>

                    <!-- Login Form -->
                    <form action="${pageContext.request.contextPath}/login" method="POST" class="login-form">
                        <!-- Username Input -->
                        <div class="form-group">
                            <svg class="input-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                            </svg>
                            <input 
                                type="text" 
                                name="username" 
                                placeholder="Username" 
                                class="form-input"
                                required
                                autocomplete="username"
                            />
                        </div>

                        <!-- Password Input -->
                        <div class="form-group">
                            <svg class="input-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                            </svg>
                            <input 
                                type="password" 
                                name="password" 
                                placeholder="Password" 
                                class="form-input"
                                required
                                autocomplete="current-password"
                            />
                        </div>

                        <!-- Login Button -->
                        <button type="submit" class="login-button">
                            Login
                        </button>
                    </form>

                    <!-- Footer Links -->
                    <div class="footer-links">
                        <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-link">
                            Forgot Password?
                        </a>
                        <div class="signup-container">
                            <span class="signup-text">Don't have an account?</span>
                            <a href="${pageContext.request.contextPath}/register" class="signup-link">
                                Create Account
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

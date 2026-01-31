<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Logistics - Courier Tracking System</title>
    <link rel="stylesheet" href="/assets/css/login.css">
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

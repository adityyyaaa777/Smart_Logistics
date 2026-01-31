<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- SESSION + ROLE PROTECTION -->
<c:if test="${empty sessionScope.loggedUser ||
             (sessionScope.loggedUser.roleId != 0 &&
              sessionScope.loggedUser.roleId != 2)}">
    <c:redirect url="/login"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="/assets/css/dashboard.css">
</head>

<body>

<!-- BACKGROUND -->
<div class="animated-gradient"></div>
<div class="blob blob--one"></div>
<div class="blob blob--two"></div>

<svg class="curved-lines" viewBox="0 0 1200 800" preserveAspectRatio="none">
    <path d="M0,200 C300,100 600,300 1200,150" />
    <path d="M0,400 C400,250 800,450 1200,300" />
    <path d="M0,600 C350,500 750,650 1200,520" />
</svg>

<div class="page-wrapper">

    <!-- HEADER -->
    <header class="header glass-card">
        <div class="header-left">
            <span class="app-name">Smart Logistics</span>
        </div>

        <div class="header-right">
            <span class="user-name">
                ${sessionScope.loggedUser.username}
            </span>
            <a href="/logout" class="logout-btn">Logout</a>
        </div>
    </header>

    <div class="body-wrapper">

        <!-- SIDEBAR -->
        <aside class="sidebar glass-card">
            <nav class="nav-menu">

                <a href="/admin/dashboard" class="nav-item">Dashboard</a>

                <!-- SUPER ADMIN MENU -->
                <c:if test="${sessionScope.loggedUser.roleId == 0}">
                    <a href="/admin/add-user?role=ADMIN" class="nav-item">Add Admin</a>
                    <a href="/admin/view-admins" class="nav-item">View Admins</a>
                </c:if>

                <!-- ADMIN MENU -->
                <c:if test="${sessionScope.loggedUser.roleId == 2}">
                    <a href="/admin/add-user?role=AGENT">Add Agent</a>
                    <a href="/admin/view-agents" class="nav-item">View Agents</a>
                    <a href="/admin/users" class="nav-item">Manage Users</a>
                    <a href="/admin/orders" class="nav-item">Manage Orders</a>
                </c:if>

            </nav>
        </aside>

        <!-- MAIN CONTENT -->
        <main class="main-content">

            <!-- DASHBOARD HEADER -->
            <div class="dashboard-header">
                <h2>
                    <c:choose>
                        <c:when test="${sessionScope.loggedUser.roleId == 1}">
                            Super Admin Dashboard
                        </c:when>
                        <c:otherwise>
                            Admin Dashboard
                        </c:otherwise>
                    </c:choose>
                </h2>
                <p>Welcome back, manage the system from here</p>
            </div>

            <!-- ADMIN ONLY CONTENT -->
            <c:if test="${sessionScope.loggedUser.roleId == 2}">

                <!-- STATS -->
                <div class="stats-grid">

                    <div class="stat-card">
                        <h4>Total Users</h4>
                        <div class="stat-value">${totalUsers}</div>
                    </div>

                    <div class="stat-card">
                        <h4>Active Agents</h4>
                        <div class="stat-value">${activeAgents}</div>
                    </div>

                    <div class="stat-card">
                        <h4>Total Orders</h4>
                        <div class="stat-value">${totalOrders}</div>
                    </div>

                    <div class="stat-card">
                        <h4>Pending Orders</h4>
                        <div class="stat-value">${pendingOrders}</div>
                    </div>

                </div>

                <!-- LOWER PANELS -->
                <div class="dashboard-lower">

                    <div class="panel">
                        <h3>Quick Actions</h3>

                        <a href="/admin/add-user?role=AGENT" class="action-button">
                            Add Agent
                        </a>

                        <a href="/admin/orders" class="action-button">
                            Manage Orders
                        </a>

                        <a href="/admin/users" class="action-button">
                            View Users
                        </a>
                    </div>

                    <div class="panel">
                        <h3>System Overview</h3>
                        <p style="color:#c7d2fe;font-size:0.9rem;">
                            Monitor users, agents, and logistics operations from one place.
                            Ensure smooth workflow and timely deliveries.
                        </p>
                    </div>

                </div>

            </c:if>

            <!-- SUPER ADMIN INFO ONLY -->
            <c:if test="${sessionScope.loggedUser.roleId == 1}">
                <div class="panel">
                    <h3>Super Admin Controls</h3>
                    <p style="color:#c7d2fe;font-size:0.9rem;">
                        You are responsible for managing administrators and system governance.
                        Operational tasks are delegated to admins.
                    </p>
                </div>
            </c:if>

        </main>

    </div>
</div>

</body>
</html>

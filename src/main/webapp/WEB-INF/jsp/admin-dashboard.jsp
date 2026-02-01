<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- SESSION + ROLE PROTECTION -->
<c:if test="${empty sessionScope.loggedUser ||
             sessionScope.loggedUser.roleId == 1 ||
             sessionScope.loggedUser.roleId == 3}">
    <c:redirect url="/login"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="/assets/css/dashboard.css">
</head>

<body>

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
                    <a href="/admin/view-admins" class="nav-item">View Admins</a>
                    <a href="/admin/add-user?role=AGENT" class="nav-item">Add Agent</a>
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
                        <c:when test="${sessionScope.loggedUser.roleId == 0}">
                            Super Admin Dashboard
                        </c:when>
                        <c:otherwise>
                            Admin Dashboard
                        </c:otherwise>
                    </c:choose>
                </h2>
                <p>Welcome back manage the system from here</p>
            </div>

            <!-- ADMIN STATS -->
            <c:if test="${sessionScope.loggedUser.roleId == 2}">
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

                <!-- QUICK ACTIONS -->
                <div class="panel">
                    <h3>Quick Actions</h3>

                    <a href="/admin/view-admins" class="quick-card">
                        <strong>View Admins</strong>
                        <small>See system administrators</small>
                    </a>

                    <a href="/admin/orders" class="quick-card">
                        <strong>Manage Orders</strong>
                        <small>View update order status</small>
                    </a>

                    <a href="/admin/users" class="quick-card">
                        <strong>View Users</strong>
                        <small>Monitor registered users</small>
                    </a>
                </div>
            </c:if>

            <!-- SUPER ADMIN PANEL -->
            <c:if test="${sessionScope.loggedUser.roleId == 0}">
                <div class="panel">
                    <h3>Super Admin Controls</h3>
                    <p style="color:#c7d2fe;font-size:0.9rem;">
                        You manage administrators and governance.
                        Operational tasks handled by admins.
                    </p>
                </div>
            </c:if>

            <!-- SYSTEM OVERVIEW -->
            <div class="panel">
                <h3>System Overview</h3>
                <p style="color:#c7d2fe;font-size:0.9rem;">
                    Monitor users agents orders deliveries from one place.
                    Ensure smooth logistics workflow.
                </p>
            </div>

        </main>

    </div>
</div>

</body>
</html>

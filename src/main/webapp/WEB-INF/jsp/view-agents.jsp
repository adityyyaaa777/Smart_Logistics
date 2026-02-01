<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>View Agents</title>
    <link rel="stylesheet" href="/assets/css/dashboard.css">
</head>

<body class="orders-page-dark">

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
    <header class="header">
        <div class="header-left">
            <span class="app-name">Smart Logistics</span>
        </div>

        <div class="header-right">
            <span class="user-name">
                ${sessionScope.customerName}
            </span>

            <a href="/logout" class="logout-btn">Logout</a>
        </div>
    </header>

    <div class="body-wrapper">

        <!-- SIDEBAR -->
        <aside class="sidebar">
         <nav class="nav-menu">

            <!-- ADMIN -->
            <c:if test="${sessionScope.loggedUser.roleId == 2}">
                <a href="/admin/view-admins" class="nav-item">View Admins</a>
                <a href="/admin/view-agents" class="nav-item">View Agents</a>
                <a href="/admin/add-user?role=AGENT" class="nav-item">Add Agent</a>
                <a href="/admin/manage-users" class="nav-item">Manage Users</a>
                <a href="/admin/manage-orders" class="nav-item">Manage Orders</a>
            </c:if>

            <!-- SUPER ADMIN -->
            <c:if test="${sessionScope.loggedUser.roleId == 0}">
                <a href="/admin/view-admins?role=ADMIN" class="nav-item">View Admins</a>
            </c:if>

         </nav>
        </aside>

        <!-- MAIN CONTENT -->
        <main class="main-content">

            <div class="panel orders-panel">

                <h2 style="margin-bottom:1.5rem;">All Agents</h2>

                <table class="glass-table dark-table">
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                    </tr>

                    <c:forEach var="agent" items="${agents}">
                        <tr>
                            <td>${agent.userId}</td>
                            <td>${agent.username}</td>
                        </tr>
                    </c:forEach>
                </table>

                <br>

                <a href="/admin/dashboard" class="quick-card">
                    <strong>Back to Dashboard</strong>
                    <small>Return to admin overview</small>
                </a>

            </div>

        </main>

    </div>
</div>

</body>
</html>

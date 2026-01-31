<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
    <link rel="stylesheet" href="/assets/css/dashboard.css">
</head>
<body>

<c:if test="${empty sessionScope.loggedUser}">
    <c:redirect url="/login"/>
</c:if>


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
                <a href="/customer/dashboard" class="nav-item">Dashboard</a>
                <a href="/customer/my-orders" class="nav-item">My Orders</a>
                <a href="/customer/place-order" class="nav-item">Place New Order</a>
                <a href="/customer/track" class="nav-item">Track Package</a>
                <a href="/customer/settings" class="nav-item">Settings</a>
            </nav>
        </aside>

        <!-- MAIN CONTENT -->
        <main class="main-content">
            <div class="dashboard-section">

    <!-- Page header -->
    <div class="dashboard-header">
        <h2>Dashboard</h2>
        <p>Welcome back. Here is an overview of your shipments.</p>
    </div>

    <!-- Stat cards -->
    <div class="stats-grid">

        <div class="stat-card">
            <h4>Active Orders</h4>
            <div class="stat-value">${activeOrders}</div>
            <small>Updated recently</small>
        </div>

        <div class="stat-card">
            <h4>In Transit</h4>
            <div class="stat-value">${inTransitOrders}</div>
            <small>On schedule</small>
        </div>

        <div class="stat-card">
            <h4>Delivered</h4>
            <div class="stat-value">${deliveredOrders}</div>
            <small>Completed shipments</small>
        </div>

        <div class="stat-card">
            <h4>Total Savings</h4>
            <div class="stat-value">${totalSavings}</div>
            <small>This month</small>
        </div>

    </div>

    <!-- Lower section -->
    <div class="dashboard-lower">

        <!-- Recent activity -->
        <div class="panel">
            <h3>Recent Activity</h3>

            <c:forEach var="order" items="${recentOrders}">
                <div class="activity-row">
                    <div>
                        <strong>${order.orderId}</strong><br>
                        <span>${order.deliveryAddress}</span>
                    </div>
                    <div class="activity-right">
                        <span>${order.status}</span><br>
                        <small>${order.orderDate}</small>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty recentOrders}">
                <p>No recent activity found</p>
            </c:if>
        </div>

        <!-- Quick actions -->
        <div class="panel">
            <h3>Quick Actions</h3>

            <a href="/customer/place-order" class="action-button">
                <strong>Schedule a Pickup</strong><br>
                <small>Arrange pickup for your shipment</small>
            </a>

            <a href="/customer/track" class="action-button">
                <strong>Track Shipment</strong><br>
                <small>Locate your package easily</small>
            </a>

            <a href="/customer/place-order" class="action-button">
                <strong>Get Quote</strong><br>
                <small>Estimate shipping cost</small>
            </a>
        </div>

    </div>

</div>

        </main>

    </div>

</div>

</body>

<!-- Curved animated background lines -->
<svg class="curved-lines" viewBox="0 0 1200 800" preserveAspectRatio="none">
    <path d="M0,200 C300,100 600,300 1200,150" />
    <path d="M0,400 C400,250 800,450 1200,300" />
    <path d="M0,600 C350,500 750,650 1200,520" />
</svg>

</html>

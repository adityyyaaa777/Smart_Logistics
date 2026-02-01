<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Orders</title>
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
                ${sessionScope.loggedUser.username}
            </span>
            <a href="/logout" class="logout-btn">Logout</a>
        </div>
    </header>

    <div class="body-wrapper">

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <nav class="nav-menu">
                <a href="/admin/dashboard" class="nav-item">Dashboard</a>
                <a href="/admin/manage-orders" class="nav-item">Manage Orders</a>
            </nav>
        </aside>

        <!-- MAIN CONTENT -->
        <main class="main-content">

            <div class="panel orders-panel">

                <h2 style="margin-bottom:1.5rem;">Manage Orders</h2>

                <table class="dark-table">
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Pickup</th>
                        <th>Delivery</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>

                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td>#${o.orderId}</td>
                            <td>${o.customerName}</td>
                            <td>${o.pickupAddress}</td>
                            <td>${o.deliveryAddress}</td>
                            <td>
                                <span class="badge placed">
                                    ${o.orderStatus}
                                </span>
                            </td>

                            <td>
                                <a href="/admin/assign/${o.orderId}"
                                   class="quick-card"
                                   style="display:inline-block;padding:6px 10px;font-size:12px;">
                                    Assign
                                </a>

                                <a href="/admin/delete-order/${o.orderId}"
                                   class="danger-btn"
                                   onclick="return confirm('Delete this order?');">
                                    Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty orders}">
                        <tr>
                            <td colspan="6" style="text-align:center;color:#c7d2fe;">
                                No orders found
                            </td>
                        </tr>
                    </c:if>
                </table>

            </div>

        </main>

    </div>
</div>

</body>
</html>

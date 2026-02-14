<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.loggedUser}">
    <c:redirect url="/login"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>My Orders</title>
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
                <a href="/customer/dashboard" class="nav-item">Dashboard</a>
                <a href="/customer/my-orders" class="nav-item">My Orders</a>
                <a href="/customer/place-order" class="nav-item">Place New Order</a>
                <a href="/customer/track" class="nav-item">Track Package</a>
                <a href="/customer/settings" class="nav-item">Settings</a>
            </nav>
        </aside>

        <!-- MAIN CONTENT -->
        <main class="main-content">

            <div class="panel orders-panel">

                <!-- PAGE HEADER -->
                <div class="page-header">
                    <h2>My Orders</h2>
                    <p>Track and manage all your shipments in one place</p>
                </div>

                <!-- FILTER -->
                <form method="get" action="/customer/my-orders" class="filter-bar">
                    <div class="search-box">
                        <input type="text" name="search" placeholder="Search order id or location">
                    </div>

                    
                    <select name="status">
                        <option value="">All Status</option>
                        <option>PLACED</option>
                        <option>ASSIGNED</option>
                        <option>DELIVERED</option>
                    </select>

                    <button type="submit">Search</button>
                </form>

                <!-- TABLE -->
                <table class="glass-table dark-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Date</th>
                            <th>Pickup</th>
                            <th>Delivery</th>
                            <th>Package</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody>

                        <c:forEach var="o" items="${orders}">
                            <tr>
                                <td>${o.orderId}</td>
                                <td>${o.orderDate}</td>
                                <td>${o.pickupAddress},${o.pickupCity}</td>
                                <td>${o.deliveryAddress},${o.deliveryCity}</td>
                                <td>
                                    <c:choose>

                                        <c:when test="${o.quantity > 0}">
                                            ${o.itemName}<br>
                                            Qty: ${o.quantity}<br>
                                            ${o.weight} kg
                                        </c:when>

                                        <c:otherwise>
                                            <span style="opacity:0.7;">No package details</span>
                                        </c:otherwise>

                                    </c:choose>
                                </td>

                                <td>
                                    <span class="badge ${o.orderStatus.toLowerCase()}">
                                        ${o.orderStatus}
                                    </span>
                                </td>

                                <td>
                                    <a href="/map?orderId=${o.orderId}" class="track-btn">
                                        Track
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty orders}">
                            <tr>
                                <td colspan="7" style="text-align:center;">
                                    No orders found
                                </td>
                            </tr>
                        </c:if>

                    </tbody>
                </table>

            </div>

        </main>

    </div>
</div>

</body>
</html>

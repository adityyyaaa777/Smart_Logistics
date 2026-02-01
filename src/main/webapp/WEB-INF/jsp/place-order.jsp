<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.loggedUser}">
    <c:redirect url="/login"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>Place Order</title>
    <link rel="stylesheet" href="/assets/css/dashboard.css">
</head>

<body>

<div class="animated-gradient"></div>
<div class="blob blob--one"></div>
<div class="blob blob--two"></div>

<svg class="curved-lines" viewBox="0 0 1200 800" preserveAspectRatio="none">
    <path d="M0,200 C300,100 600,300 1200,150" />
    <path d="M0,400 C400,250 800,450 1200,300" />
    <path d="M0,600 C350,500 750,650 1200,520" />
</svg>

<div class="page-wrapper">

    <div class="header glass-card">
        <span class="app-name">Smart Logistics</span>
        <div>
            <span class="user-name">${sessionScope.customerName}</span>
            <a href="/logout" class="logout-btn">Logout</a>
        </div>
    </div>

    <div class="body-wrapper">

        <aside class="sidebar glass-card">
            <nav class="nav-menu">
                <a href="/customer/dashboard" class="nav-item">Dashboard</a>
                <a href="/customer/my-orders" class="nav-item">My Orders</a>
                <a href="/customer/place-order" class="nav-item">Place Order</a>
            </nav>
        </aside>

        <main class="main-content">

            <div class="place-order-page glass-card">

                <h2>Place New Order</h2>
                <p class="page-subtitle">Fill in the details below</p>

                <form method="post" action="/customer/place-order">

                    <fieldset>  
                        <legend>Pickup</legend>
                        <select name="pickupAddressId">
                            <c:forEach var="addr" items="${addressList}">
                                <option value="${addr.addressId}">
                                    ${addr.addressLine}, ${addr.city}
                                </option>
                            </c:forEach>
                        </select>
                    </fieldset>

                    <fieldset>
                        <legend>Delivery</legend>
                        <select name="deliveryAddressId">
                            <c:forEach var="addr" items="${addressList}">
                                <option value="${addr.addressId}">
                                    ${addr.addressLine}, ${addr.city}
                                </option>
                            </c:forEach>
                        </select>
                    </fieldset>

                    <fieldset>
                         <legend>Package</legend>

                         <div class="package-row">
                             <select name="packageType">
                             <option>Envelope</option>
                             <option>Small Box</option>
                             <option>Medium Box</option>
                             <option>Large Box</option>
                             </select>

                            <input type="number" name="weight" step="0.1" placeholder="Weight (kg)">
                         </div>

                         <textarea name="description" rows="3" placeholder="Description"></textarea>
                    </fieldset>


                    <fieldset>
                        <legend>Shipping</legend>
                        <select name="serviceType">
                            <option>STANDARD</option>
                            <option>EXPRESS</option>
                            <option>OVERNIGHT</option>
                        </select>
                        <input type="date" name="pickupDate">
                    </fieldset>

                    <button class="primary-btn">Place Order</button>
                </form>

            </div>

        </main>
    </div>
</div>

</body>
</html>

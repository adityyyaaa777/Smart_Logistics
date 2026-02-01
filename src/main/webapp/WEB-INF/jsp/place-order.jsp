<%@ page contentType="text/html;charset=UTF-8" %>
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

        <!-- MAIN -->
        <main class="main-content">

            <div class="place-order-page glass-card">

                <h2>Place New Order</h2>
               

                <form method="post" action="/customer/place-order">

                    <!-- PICKUP -->
                    <fieldset>
                        <legend>Pickup Address</legend>

                        <c:choose>

                            <c:when test="${not empty addressList}">

                                <div class="address-header">
                                    <label>Select Address</label>

                                    <a href="/customer/add-address" class="add-address-chip">
                                        + Add New Address
                                    </a>
                                </div>

                                <select name="pickupAddressId" required>
                                    <c:forEach var="addr" items="${addressList}">
                                        <option value="${addr.addressId}">
                                            ${addr.addressLine}, ${addr.city}
                                        </option>
                                    </c:forEach>
                                </select>

                            </c:when>

                            <c:otherwise>
                                <p style="color:#cbd5f5;">No addresses found.</p>
                                <a href="/customer/add-address" class="primary-btn">
                                    Add Address
                                </a>
                            </c:otherwise>

                        </c:choose>
                    </fieldset>



                    <!-- DELIVERY -->
                    <fieldset>
                        <legend>Delivery Address</legend>

                        <c:choose>

                            <c:when test="${not empty addressList}">
                                <select name="deliveryAddressId" required>
                                    <c:forEach var="addr" items="${addressList}">
                                        <option value="${addr.addressId}">
                                            ${addr.addressLine}, ${addr.city}
                                        </option>
                                    </c:forEach>
                                </select>
                            </c:when>

                            <c:otherwise>
                                <p style="color:#cbd5f5;">No addresses found.</p>
                            </c:otherwise>

                        </c:choose>
                    </fieldset>


                    <!-- PACKAGE -->
                    <fieldset>
                        <legend>Package Details</legend>

                        <select name="packageType" required>
                            <option value="Envelope">Envelope</option>
                            <option value="Small Box">Small Box</option>
                            <option value="Medium Box">Medium Box</option>
                            <option value="Large Box">Large Box</option>
                        </select>

                        <input type="number" name="quantity"
                               min="1" value="1" required
                               placeholder="Quantity">

                        <input type="number" name="weight"
                               step="0.1" min="0.1" required
                               placeholder="Weight (kg)">

                        <textarea name="description"
                                  rows="3"
                                  placeholder="Description (optional)"></textarea>
                    </fieldset>

                    <!-- SHIPPING -->
                    <fieldset>
                        <legend>Shipping Type</legend>
                        <select name="shippingType" required>
                            <option value="STANDARD">Standard</option>
                            <option value="EXPRESS">Express</option>
                            <option value="OVERNIGHT">Overnight</option>
                        </select>
                    </fieldset>
                    
                    <div class="btn-center">
                        <c:if test="${not empty addressList}">
                             <button class="outline-btn">Place Order</button>
                         </c:if>
                    </div>

                </form>

                <!-- FLASH MESSAGES -->
                <c:if test="${not empty success}">
                    <p style="color:green;">${success}</p>
                </c:if>

                <c:if test="${not empty error}">
                    <p style="color:red;">${error}</p>
                </c:if>

            </div>

        </main>

    </div>
</div>

</body>
</html>

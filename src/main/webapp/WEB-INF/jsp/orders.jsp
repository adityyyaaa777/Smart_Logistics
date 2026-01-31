<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.loggedUser}">
    <c:redirect url="/login"/>
</c:if>

<div class="orders-page">

    <div class="page-header">
        <h2>My Orders</h2>
        <p>Track and manage all your shipments in one place</p>
    </div>

    <!-- Search and filter -->
    <form method="get" action="/customer/my-orders" class="filter-bar">

        <input
            type="text"
            name="search"
            placeholder="Search by order id or location"
            value="${param.search}"
        />

        <select name="status">
            <option value="">All Status</option>
            <option value="PLACED">Placed</option>
            <option value="IN_TRANSIT">In Transit</option>
            <option value="OUT_FOR_DELIVERY">Out for Delivery</option>
            <option value="DELIVERED">Delivered</option>
            <option value="CANCELLED">Cancelled</option>
        </select>

        <button type="submit">Search</button>
    </form>

    <!-- Orders list -->
    <div class="orders-list">

        <c:forEach var="order" items="${orders}">
            <div class="order-card">

                <div class="order-header">
                    <div>
                        <h3>${order.orderId}</h3>
                        <small>${order.trackingNumber}</small>
                    </div>

                    <c:choose>
                        <c:when test="${order.orderStatus == 'DELIVERED'}">
                            <span class="badge delivered">Delivered</span>
                        </c:when>
                        <c:when test="${order.orderStatus == 'IN_TRANSIT'}">
                            <span class="badge transit">In Transit</span>
                        </c:when>
                        <c:when test="${order.orderStatus == 'OUT_FOR_DELIVERY'}">
                            <span class="badge out">Out for Delivery</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge placed">Placed</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="order-body">

                    <div class="info">
                        <strong>From</strong>
                        <span>${order.pickupAddress}</span>
                    </div>

                    <div class="info">
                        <strong>To</strong>
                        <span>${order.deliveryAddress}</span>
                    </div>

                    <div class="info">
                        <strong>Order Date</strong>
                        <span>${order.orderDate}</span>
                    </div>

                </div>

                <div class="order-actions">
                    <a href="/customer/track?orderId=${order.orderId}" class="btn">
                        Track Package
                    </a>
                    <a href="/customer/order-details?orderId=${order.orderId}" class="btn">
                        View Details
                    </a>
                </div>

            </div>
        </c:forEach>

        <c:if test="${empty orders}">
            <div class="empty-state">
                <p>No orders found</p>
                <small>Try adjusting your search or filter</small>
            </div>
        </c:if>

    </div>

</div>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>Manage Orders</h2>

<table border="1">
<tr>
    <th>Order ID</th>
    <th>Customer Name</th>
    <th>Pickup</th>
    <th>Delivery</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<c:forEach var="o" items="${orders}">
<tr>
    <td>${o.orderId}</td>
    <td>${o.customerName}</td>
    <td>${o.pickupAddress}</td>
    <td>${o.deliveryAddress}</td>
    <td>${o.orderStatus}</td>

    <td>
        <a href="/admin/assign/${o.orderId}">
            Assign Agent
        </a>
    </td>
</tr>
</c:forEach>

</table>

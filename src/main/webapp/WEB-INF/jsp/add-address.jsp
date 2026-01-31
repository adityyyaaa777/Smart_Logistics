<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Add Address</title>
</head>
<body>

<h2>Add New Address</h2>

<form method="post" action="/customer/add-address">
    <input name="addressLine" placeholder="Address Line" required /><br><br>
    <input name="city" placeholder="City" /><br><br>
    <input name="state" placeholder="State" /><br><br>
    <input name="pincode" placeholder="Pincode" /><br><br>

    <button type="submit">Save Address</button>
</form>

<c:if test="${not empty success}">
    <p style="color:green">${success}</p>
</c:if>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<br>
<a href="/customer/place-order">Place Order</a>

</body>
</html>

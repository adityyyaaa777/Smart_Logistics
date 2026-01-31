<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty sessionScope.loggedUser}">
    <c:redirect url="/login"/>
</c:if>

<div class="place-order-page">

    <h2>Place New Order</h2>
    <p>Fill in the details below to create a new shipment</p>

    <form method="post" action="/customer/place-order">

        <!-- PICKUP DETAILS -->
        <fieldset>
            <legend>Pickup Details</legend>

            <label>Pickup Address</label>
            <select name="pickupAddressId" required>
                <c:forEach var="addr" items="${addressList}">
                    <option value="${addr.addressId}">
                        ${addr.addressLine}, ${addr.city}
                    </option>
                </c:forEach>
            </select>
        </fieldset>

        <!-- DELIVERY DETAILS -->
        <fieldset>
            <legend>Delivery Details</legend>

            <label>Delivery Address</label>
            <select name="deliveryAddressId" required>
                <c:forEach var="addr" items="${addressList}">
                    <option value="${addr.addressId}">
                        ${addr.addressLine}, ${addr.city}
                    </option>
                </c:forEach>
            </select>
        </fieldset>

        <!-- PACKAGE DETAILS -->
        <fieldset>
            <legend>Package Details</legend>

            <label>Package Type</label>
            <select name="packageType" required>
                <option value="Envelope">Envelope</option>
                <option value="Small Box">Small Box</option>
                <option value="Medium Box">Medium Box</option>
                <option value="Large Box">Large Box</option>
            </select>

            <label>Weight (kg)</label>
            <input type="number" name="weight" step="0.1" required />

            <label>Description</label>
            <textarea name="description" rows="3"></textarea>
        </fieldset>

        <!-- SHIPPING OPTIONS -->
        <fieldset>
            <legend>Shipping Options</legend>

            <label>Service Type</label>
            <select name="serviceType" required>
                <option value="STANDARD">Standard</option>
                <option value="EXPRESS">Express</option>
                <option value="OVERNIGHT">Overnight</option>
            </select>

            <label>Pickup Date</label>
            <input type="date" name="pickupDate" required />
        </fieldset>

        <!-- SUBMIT -->
        <button type="submit">Place Order</button>

    </form>

    <c:if test="${not empty success}">
        <p class="success">${success}</p>
    </c:if>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

</div>

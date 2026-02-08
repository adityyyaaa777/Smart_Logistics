<table border="1">
<tr>
    <th>ID</th>
    <th>Tracking</th>
    <th>Type</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<c:forEach var="s" items="${shipments}">
<tr>
    <td>${s.shipmentId}</td>
    <td>${s.trackingNumber}</td>
    <td>${s.shipmentType}</td>
    <td>${s.currentStatus}</td>
    <td>
        <a href="/shipment/details?id=${s.shipmentId}">
            View
        </a>
    </td>
</tr>
</c:forEach>
</table>

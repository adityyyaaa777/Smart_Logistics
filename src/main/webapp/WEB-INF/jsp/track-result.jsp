<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tracking Result</title>
    <link rel="stylesheet" href="/assets/css/main.css">
</head>
<body>

<div class="navbar">
    Shipment <span>Status</span>
</div>

<div class="container">
    <div class="card">
        <h2>Tracking Details</h2>

        <div class="result-box">
            <p><strong>Tracking Number:</strong> ${tracking.trackingNumber}</p>
            <p><strong>Status:</strong> ${tracking.status}</p>
            <p><strong>Current Location:</strong> ${tracking.location}</p>
        </div>

        <br>
        <a href="/track" class="btn">Track Another</a>
    </div>
</div>

</body>
</html>

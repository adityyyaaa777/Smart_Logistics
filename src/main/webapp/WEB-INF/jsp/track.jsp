<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Track Shipment</title>
    <link rel="stylesheet" href="/assets/css/main.css">
</head>
<body>

<div class="navbar">
    Track <span>Shipment</span>
</div>

<div class="container">
    <div class="card">
        <h2>Tracking</h2>

        <form action="/track" method="get">
            <div class="form-group">
                <label>Tracking Number</label>
                <input type="text" name="trackingNumber" required>
            </div>

            <button class="btn">Track Shipment</button>
        </form>
    </div>
</div>

</body>
</html>

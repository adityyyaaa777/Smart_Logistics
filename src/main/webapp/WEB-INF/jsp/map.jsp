<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shipment Tracking Map</title>

    <!-- Leaflet CSS -->
    <link rel="stylesheet"
          href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: #0f172a;
            color: white;
        }

        .page-container {
            padding: 20px;
            max-width: 1000px;
            margin: auto;
        }

        .title {
            text-align: center;
            margin-bottom: 15px;
            font-size: 24px;
            font-weight: bold;
        }

        #map {
            height: 450px;
            width: 100%;
            border-radius: 14px;
            box-shadow: 0 0 30px rgba(168, 85, 247, 0.5);
        }

        .status-box {
            margin-top: 15px;
            padding: 12px;
            border-radius: 10px;
            background: rgba(168, 85, 247, 0.15);
            text-align: center;
            font-size: 18px;
            font-weight: 600;
        }

        .legend {
            margin-top: 15px;
            display: flex;
            justify-content: space-around;
            font-size: 14px;
        }

        .legend span {
            padding: 6px 12px;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
        }
    </style>
</head>

<body>

<div class="page-container">

    <div class="title">
        Shipment Tracking Simulation
    </div>

    <!-- Map Container -->
    <div id="map"></div>

    <!-- Status Text -->
    <div class="status-box" id="statusText">
        Status: Picked Up
    </div>

    <!-- Legend -->
    <div class="legend">
        <span>Hub Locations</span>
        <span>Moving Shipment</span>
        <span>Simulated Route</span>
    </div>

</div>

<script>
    // Initialize map
    var map = L.map("map").setView([19.0760, 72.8777], 6);

    // OpenStreetMap tiles
    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: "Map data OpenStreetMap contributors"
    }).addTo(map);

    // Simulated hubs
    var route = [
        { name: "Mumbai Hub", lat: 19.0760, lng: 72.8777, status: "Picked Up" },
        { name: "Pune Hub", lat: 18.5204, lng: 73.8567, status: "In Transit" },
        { name: "Bengaluru Hub", lat: 12.9716, lng: 77.5946, status: "Out for Delivery" },
        { name: "Delivery Location", lat: 12.2958, lng: 76.6394, status: "Delivered" }
    ];

    // Draw route line
    var routeLine = route.map(function (p) {
        return [p.lat, p.lng];
    });

    L.polyline(routeLine, {
        color: "violet",
        weight: 4,
        dashArray: "10 8"
    }).addTo(map);

    // Add hub markers
    route.forEach(function (point) {
        L.circleMarker([point.lat, point.lng], {
            radius: 6,
            color: "#e9d5ff",
            fillColor: "#c084fc",
            fillOpacity: 1
        }).addTo(map).bindPopup(point.name);
    });

    // Shipment marker
    var marker = L.marker([route[0].lat, route[0].lng])
        .addTo(map)
        .bindPopup("Shipment Picked Up")
        .openPopup();

    var index = 0;

    function moveShipment() {
        if (index < route.length - 1) {
            index++;

            marker.setLatLng([route[index].lat, route[index].lng]);

            marker.bindPopup(
                route[index].name + "<br>Status: " + route[index].status
            ).openPopup();

            document.getElementById("statusText").innerText =
                "Status: " + route[index].status;

            map.setView([route[index].lat, route[index].lng], 6);
        }
    }

    // Move shipment every 5 seconds
    setInterval(moveShipment, 5000);
</script>

</body>
</html>

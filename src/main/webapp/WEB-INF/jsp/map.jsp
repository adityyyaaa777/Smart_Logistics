<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>Shipment Tracking Map</title>

<link rel="stylesheet"
 href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
 <link rel="stylesheet" href="/assets/css/dashboard.css">

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

<style>
body{
 background:#0f172a;
 color:white;
 font-family:Arial;
 text-align:center;
}
#map{
 height:600px;
 border-radius:16px;
 margin:auto;
 width:90%;
}
#statusText{
 margin-top:15px;
 font-size:18px;
 background:rgba(124,58,237,0.2);
 padding:10px 18px;
 border-radius:12px;
 display:inline-block;
 backdrop-filter:blur(10px);
 box-shadow:0 0 20px rgba(124,58,237,0.3);
}
</style>
</head>

<body>

<h2>Shipment Tracking Simulation</h2>
<div id="map"></div>
<div id="statusText"></div>
<a href="/customer/dashboard" class="dash-btn">
 ← Back to Dashboard
</a>


<script>

// ---------- ORDER ID ----------
var orderId = new URLSearchParams(window.location.search).get("orderId");
orderId = parseInt(orderId);

// ---------- ROUTES ----------
function getRoute(id){

 if(id % 4 === 0){
  return [
   {name:"Mumbai",lat:19.07,lng:72.87,status:"PLACED"},
   {name:"Pune Hub",lat:18.52,lng:73.85,status:"IN_TRANSIT_1"},
   {name:"Kolhapur Hub",lat:16.70,lng:74.24,status:"IN_TRANSIT_2"},
   {name:"Hubli Hub",lat:15.36,lng:75.12,status:"IN_TRANSIT_3"},
   {name:"Bangalore",lat:12.97,lng:77.59,status:"DELIVERED"}
  ];
 }

 if(id % 4 === 1){
  return [
   {name:"Delhi",lat:28.70,lng:77.10,status:"PLACED"},
   {name:"Jaipur Hub",lat:26.91,lng:75.78,status:"IN_TRANSIT_1"},
   {name:"Udaipur Hub",lat:24.58,lng:73.68,status:"IN_TRANSIT_2"},
   {name:"Ahmedabad Hub",lat:23.02,lng:72.57,status:"IN_TRANSIT_3"},
   {name:"Surat",lat:21.17,lng:72.83,status:"DELIVERED"}
  ];
 }

 if(id % 4 === 2){
  return [
   {name:"Chennai",lat:13.08,lng:80.27,status:"PLACED"},
   {name:"Vellore Hub",lat:12.92,lng:79.13,status:"IN_TRANSIT_1"},
   {name:"Bangalore Hub",lat:12.97,lng:77.59,status:"IN_TRANSIT_2"},
   {name:"Hyderabad Hub",lat:17.38,lng:78.48,status:"IN_TRANSIT_3"},
   {name:"Nagpur",lat:21.14,lng:79.08,status:"DELIVERED"}
  ];
 }

 return [
  {name:"Kolkata",lat:22.57,lng:88.36,status:"PLACED"},
  {name:"Bhubaneswar Hub",lat:20.29,lng:85.82,status:"IN_TRANSIT_1"},
  {name:"Raipur Hub",lat:21.25,lng:81.63,status:"IN_TRANSIT_2"},
  {name:"Bhopal Hub",lat:23.25,lng:77.41,status:"IN_TRANSIT_3"},
  {name:"Indore",lat:22.71,lng:75.85,status:"DELIVERED"}
 ];
}

var route = getRoute(orderId);

// ---------- MAP ----------
var map = L.map("map").setView([route[0].lat, route[0].lng], 5);

L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png")
.addTo(map);

// ---------- ROUTE GLOW ----------
var glow = L.polyline(route.map(r => [r.lat, r.lng]), {
 color:'#c084fc',
 weight:12,
 opacity:0.2
}).addTo(map);

var polyline = L.polyline(route.map(r => [r.lat, r.lng]), {
 color:'#8b5cf6',
 weight:5,
 dashArray:'8,12'
}).addTo(map);

// ---------- HUB ICON ----------
var hubIcon = L.icon({
 iconUrl:"https://cdn-icons-png.flaticon.com/512/854/854878.png",
 iconSize:[26,26],
 iconAnchor:[13,26]
});

// DRAW HUBS
route.forEach(function(p,i){
 if(i !== 0 && i !== route.length-1){
   L.marker([p.lat,p.lng],{icon:hubIcon})
    .addTo(map)
    .bindPopup(p.name);
 }
});

// ---------- DELIVERY ICON ----------
var deliveryIcon = L.icon({
 iconUrl:"https://cdn-icons-png.flaticon.com/512/190/190411.png",
 iconSize:[32,32],
 iconAnchor:[16,32]
});

L.marker(
 [route[route.length-1].lat,route[route.length-1].lng],
 {icon:deliveryIcon}
).addTo(map).bindPopup("Delivery Point");

// ---------- TRUCK ICON ----------
var truckIcon = L.icon({
 iconUrl:"https://cdn-icons-png.flaticon.com/512/1995/1995574.png",
 iconSize:[40,40],
 iconAnchor:[20,40]
});

var marker = L.marker(
 [route[0].lat,route[0].lng],
 {icon:truckIcon}
).addTo(map);

// ---------- STATUS ----------
document.getElementById("statusText").innerText =
 "Status: "+route[0].status;

var index = 0;

// ---------- MOVE ----------
function moveShipment(){

 if(index < route.length-1){
  index++;
  var step = route[index];

  marker.setLatLng([step.lat,step.lng]);
  map.flyTo([step.lat,step.lng],6,{duration:2});

  document.getElementById("statusText").innerText =
   "Status: "+step.status;

  // BACKEND UPDATE
  fetch("/customer/update",{
   method:"POST",
   headers:{"Content-Type":"application/json"},
   body:JSON.stringify({
    orderId:orderId,
    location:step.name,
    lat:step.lat,
    lng:step.lng,
    status:step.status
   })
  });
 }
}

// ---------- TIMER ----------
var timer = setInterval(function(){
 moveShipment();
 if(index === route.length-1){
  clearInterval(timer);
 }
},5000);

</script>
</body>
</html>

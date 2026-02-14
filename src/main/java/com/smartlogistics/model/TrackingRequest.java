package com.smartlogistics.model;

public class TrackingRequest {

    private Integer orderId;
    private String location;
    private Double lat;
    private Double lng;
    private String status;

    public Integer getOrderId() { return orderId; }
    public void setOrderId(Integer orderId) { this.orderId = orderId; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public Double getLat() { return lat; }
    public void setLat(Double lat) { this.lat = lat; }

    public Double getLng() { return lng; }
    public void setLng(Double lng) { this.lng = lng; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}

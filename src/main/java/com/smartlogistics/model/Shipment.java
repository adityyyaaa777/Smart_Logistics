package com.smartlogistics.model;

public class Shipment {

    private int shipmentId;
    private String trackingNumber;
    private String shipmentType;
    private String shipmentStatus;
 

    public int getShipmentId()
    {
        return shipmentId;
    }

    public void setShipmentId(int shipmentId)
    {
         this.shipmentId = shipmentId;
    }

    public String getTrackingNumber()
    {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber)
    {
        this.trackingNumber = trackingNumber;
    }

     public String getShipmentType()
    {
        return shipmentType;
    }

    public void setShipmentType(String shipmentType)
    {
        this.shipmentType = shipmentType;
    }

     public String getShipmentStatus()
    {
        return shipmentStatus;
    }

    public void setShipmentStatus(String shipmentStatus)
    {
        this.shipmentStatus = shipmentStatus;
    }
}

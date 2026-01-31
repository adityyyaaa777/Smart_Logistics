package com.smartlogistics.model;
import java.sql.Timestamp;

public class Order {
    
    private int orderId;
    private int customerId;
    private int pickupAddressId;
    private int deliveryAddressId;
    private String orderStatus;
    private Timestamp orderDate;
    private String pickupAddress;
    private String deliveryAddress;



    public int getOrderId(){
        return orderId;
    }

    public void setOrderId(int orderId){
        this.orderId = orderId;
    }


    public int getCustomerId(){
        return customerId;
    }

    public void setCustomerId(int customerId){
        this.customerId = customerId;
    }


    public int getPickupAddressId(){
        return pickupAddressId;
    }

    public void setPickupAddressId(int pickupAddressId){
        this.pickupAddressId = pickupAddressId;
    }


    public int getDeliveryAddressId(){
        return deliveryAddressId;
    }

     public void setDeliveryAddressId(int deliveryAddressId){
        this.deliveryAddressId = deliveryAddressId;
    }

    public String getOrderStatus(){
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus){
        this.orderStatus=orderStatus;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }


    public String getPickupAddress() {
        return pickupAddress;
    }

    public void setPickupAddress(String pickupAddress) {
        this.pickupAddress = pickupAddress;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

}

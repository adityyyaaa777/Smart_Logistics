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
    private String pickupCity;
    private String deliveryCity;
    private String itemName;
    private int quantity;
    private double weight;
    private String description;
    private String shippingType;



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

    public String getPickupCity(){
        return pickupCity;
    }

     public void setPickupCity(String pickupCity){
        this.pickupCity = pickupCity;
    }

    public String getDeliveryCity(){
        return deliveryCity;
    }

     public void setDeliveryCity(String deliveryCity){
        this.deliveryCity = deliveryCity;
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

    public String getItemName(){
        return itemName;
    }

    public void setItemName(String itemName){
        this.itemName = itemName;
    }

    public int getQuantity(){
        return quantity;
    }

    public void setQuantity(int quantity){
        this.quantity = quantity;
    }

    public double getWeight(){
        return weight;
    }

    public void setWeight(double weight){
        this.weight = weight;
    }

    public String getDescription(){
        return description;
    }

    public void setDescription(String description){
        this.description = description;
    }

     public String getShippingType(){
        return shippingType;
    }

    public void setShippingType(String shippingType){
        this.shippingType = shippingType;
    }

    

}

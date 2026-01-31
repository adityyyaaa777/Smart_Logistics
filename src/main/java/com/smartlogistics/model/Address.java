package com.smartlogistics.model;

public class Address {
    private int addressId;
    private int customerId;
    private String addressLine;
    private String city;
    private String state;
    private String pincode;
    
    
    public int getAddressId(){
        return addressId;
    }

    public void setAddressId(int addressId){
        this.addressId = addressId;
    }


    public int getCustomerId(){
        return customerId;
    }

    public void setCustomerId(int customerId){
        this.customerId = customerId;
    }


    public String getAddressLine(){
        return addressLine;
    }

    public void setAddressLine(String addressLine){
        this.addressLine = addressLine;
    }

     public String getCity(){
        return city;
    }

    public void setCity(String city){
        this.city = city;
    }

     public String getState(){
        return state;
    }

    public void setState(String state){
        this.state = state;
    }

    public String getPincode(){
        return pincode;
    }

    public void setPincode(String pincode){
        this.pincode = pincode;
    }

}

package com.smartlogistics.service;

import com.smartlogistics.dao.OrderDAO;

public class OrderService {
    
    private OrderDAO orderDAO = new OrderDAO();

    public void progressOrderStatus(int orderId){
        String current = orderDAO.getOrderStatus(orderId);
        String next = getNextStatus(current);

        if(!current.equals("DELIVERED")){
            orderDAO.updateOrderStatus(orderId, next);
        }
    }

    private String getNextStatus(String current){

        if(current == null) return "PLACED";

        switch (current) {
            case "PLACED": return "IN_SHIPMENT";
            case "IN_SHIPMENT": return "IN_TRANSIT";
            case "IN_TRANSIT": return "AT_HUB";
            case "AT_HUB": return "OUT_FOR_DELIVERY";
            case "OUT_FOR_DELIVERY": return "DELIVERED";
            default: return "DELIVERED";
        }
    }
}

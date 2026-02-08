package com.smartlogistics.service;

import com.smartlogistics.dao.ShipmentDAO;
import com.smartlogistics.dao.OrderDAO;

public class ShipmentService {

    private ShipmentDAO shipmentDAO;
    private OrderDAO orderDAO;

    public ShipmentService() {
        shipmentDAO = new ShipmentDAO();
        orderDAO = new OrderDAO();
    }

    public void updateShipmentStatus(int shipmentId , String  shipmentStatus)
    {
        shipmentDAO.updateStatus(shipmentId , shipmentStatus);

        orderDAO.updateOrdersByShipment(shipmentId , shipmentStatus);
    }

}

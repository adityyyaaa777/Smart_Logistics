package com.smartlogistics.service;

import com.smartlogistics.dao.ShipmentDAO;
import com.smartlogistics.model.Shipment;

import java.util.List;

import com.smartlogistics.dao.OrderDAO;

public class ShipmentService {

    private ShipmentDAO shipmentDAO;
    private OrderDAO orderDAO;

    public ShipmentService() {
        shipmentDAO = new ShipmentDAO();
        orderDAO = new OrderDAO();
    }

    public List<Shipment> getAllShipments() {
        return shipmentDAO.getAllShipments();
    }

    public void autoAssignOrder(int orderId, String city) {

        Integer shipmentId = orderDAO.findOpenShipmentByCity(city);

        if (shipmentId == null) {
            shipmentId = shipmentDAO.createShipment(city);
        }

        orderDAO.assignOrderToShipment(orderId, shipmentId);
    }


    public void updateShipmentStatus(int shipmentId , String  shipmentStatus)
    {
        shipmentDAO.updateStatus(shipmentId , shipmentStatus);

        orderDAO.updateOrdersByShipment(shipmentId , shipmentStatus);
    }

}

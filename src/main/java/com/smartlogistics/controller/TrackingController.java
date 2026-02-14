package com.smartlogistics.controller;

import com.smartlogistics.dao.OrderDAO;
import com.smartlogistics.dao.TrackingDAO;
import com.smartlogistics.model.Order;
import com.smartlogistics.model.TrackingRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class TrackingController {

    private OrderDAO orderDAO = new OrderDAO();
    private TrackingDAO trackingDAO = new TrackingDAO();

    @PostMapping("/customer/update")
    @ResponseBody
    public String updateTracking(@RequestBody TrackingRequest req) {

        if(req.getOrderId() == null){
            return "NO_ORDER_ID";
        }

        Order order = orderDAO.getOrderById(req.getOrderId());

        if(order == null){
            return "ORDER_NOT_FOUND";
        }

        if(req.getStatus() != null){
            orderDAO.updateOrderStatus(req.getOrderId(), req.getStatus());
        }

        if(order.getShipmentId() > 0){
            trackingDAO.updateLocation(
                    order.getShipmentId(),
                    req.getLocation(),
                    req.getLat(),
                    req.getLng()
            );
        }

        return "OK";
    }
}

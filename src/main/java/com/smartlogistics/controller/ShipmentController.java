package com.smartlogistics.controller;

import com.smartlogistics.service.ShipmentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

@Controller
@RequestMapping("/shipment")
public class ShipmentController {

    private ShipmentService shipmentService = new ShipmentService();

    // 1. Update Shipment Status
    @PostMapping("/updateStatus")
    public String updateShipmentStatus(
            @RequestParam("shipmentId") int shipmentId,
            @RequestParam("status") String status) {

        shipmentService.updateShipmentStatus(shipmentId, status);

        return "redirect:/agent/shipments";
    }
}

package com.smartlogistics.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/place-order")
    public String placeOrder() {
        return "place-order";
    }

    @GetMapping("/track")
    public String track() {
        return "track";
    }
    
    @GetMapping("/map")
    public String map() {
        return "map";
    }
}
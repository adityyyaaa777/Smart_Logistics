package com.smartlogistics.controller;

import com.smartlogistics.dao.AddressDAO;
import com.smartlogistics.model.Address;
import com.smartlogistics.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AddressController {

    private AddressDAO addressDAO = new AddressDAO();

    @GetMapping("/customer/add-address")
    public String showAddAddress(HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");

        if (user == null || user.getRoleId() != User.ROLE_CUSTOMER) {
            return "redirect:/login";
        }

        return "add-address";   
    }

    @PostMapping("/customer/add-address")
    public String addAddress(
            @RequestParam String addressLine,
            @RequestParam String city,
            @RequestParam String state,
            @RequestParam String pincode,
            HttpSession session,
            Model model) {

        User user = (User) session.getAttribute("loggedUser");

        Address a = new Address();
        a.setCustomerId(user.getCustomerId());
        a.setAddressLine(addressLine);
        a.setCity(city);
        a.setState(state);
        a.setPincode(pincode);

        boolean success = addressDAO.addAddress(a);

        if (success) {
            model.addAttribute("success", "Address added successfully");
        } else {
            model.addAttribute("error", "Failed to add address");
        }

        return "redirect:/customer/place-order";
    }
}

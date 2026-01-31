package com.smartlogistics.controller;

import com.smartlogistics.dao.CustomerDAO;
import com.smartlogistics.dao.UserDAO;
import com.smartlogistics.model.User;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RegisterController {

    // Show register page
    @GetMapping("/register")
    public String showRegisterPage() {
        return "register";
    }

    // Handle register form submit
    @PostMapping("/register")
    public String handleRegister(
            @RequestParam("customer_name") String customerName,
            @RequestParam("email") String email,
            @RequestParam("phone") String phone,
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            
            Model model
    ) {

        UserDAO userDAO = new UserDAO();
        CustomerDAO customerDAO = new CustomerDAO();

        //  Check duplicate username
        if (userDAO.usernameExists(username)) {
            model.addAttribute("error", "Username already exists");
            return "register";
        }

        //  Insert customer and get REAL customer_id
        int customerId = customerDAO.insertCustomer(customerName, email , phone);
        if (customerId == -1) {
            model.addAttribute("error", "Customer registration failed");
            return "register";
        }

        //  Get role_id dynamically (CUSTOMER)
        int roleId = userDAO.getRoleIdByName("CUSTOMER");
        if (roleId == -1) {
            model.addAttribute("error", "User role not found");
            return "register";
        }

        // Create user
        User user = new User();
        user.setCustomerId(customerId);
        user.setRoleId(roleId);
        user.setUsername(username);
        user.setPassword(password);

        boolean success = userDAO.register(user);

        if (success) {
            return "redirect:/login";
        } else {
            model.addAttribute("error", "Registration failed. Please try again.");
            return "register";
        }
    }
}

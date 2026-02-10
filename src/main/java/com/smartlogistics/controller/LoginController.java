package com.smartlogistics.controller;

import com.smartlogistics.dao.UserDAO;
import com.smartlogistics.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    private UserDAO userDAO = new UserDAO();

    // SHOW LOGIN
    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

    // HANDLE LOGIN
    @PostMapping("/login")
    public String login(
            @RequestParam String username,
            @RequestParam String password,
            HttpSession session) {

        User user = userDAO.login(username, password);

        if (user == null) {
            session.setAttribute("loginError", "Invalid username or password");
            return "redirect:/login";
        }

        session.setAttribute("loggedUser", user);
        session.setAttribute("customerId", user.getUserId());
        session.setAttribute("customerName", user.getUsername());

        if (user.getRoleId() == User.ROLE_CUSTOMER)
            return "redirect:/customer/dashboard";

        if (user.getRoleId() == User.ROLE_ADMIN || user.getRoleId() == User.ROLE_SUPER_ADMIN)
            return "redirect:/admin/dashboard";

        if (user.getRoleId() == User.ROLE_AGENT)
            return "redirect:/agent/dashboard";

        return "redirect:/";
    }
}

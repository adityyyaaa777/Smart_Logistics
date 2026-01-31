package com.smartlogistics.controller;

import com.smartlogistics.dao.UserDAO;
import com.smartlogistics.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    private UserDAO userDAO;

    public LoginController() {
        this.userDAO = new UserDAO();
    }

    // =========================
    // SHOW LOGIN PAGE
    // =========================
    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // login.jsp
    }

    // =========================
    // HANDLE LOGIN
    // =========================
    @PostMapping("/login")
    public String login(
            @RequestParam String username,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        // authenticate user
        User user = userDAO.login(username, password);

        // invalid credentials
        if (user == null) {
            model.addAttribute("error", "Invalid username or password");
            return "login";
        }

        // store logged-in user in session
        session.setAttribute("loggedUser", user);
        session.setAttribute("customerId", user.getUserId());
        session.setAttribute("customerName", user.getUsername());

        // =========================
        // ROLE BASED REDIRECT
        // =========================
        if (user.getRoleId() == User.ROLE_CUSTOMER) {
            return "redirect:/customer/dashboard";  
        }

        if (user.getRoleId() == User.ROLE_ADMIN || user.getRoleId() == User.ROLE_SUPER_ADMIN) {
            return "redirect:/admin/dashboard";
        }

        if (user.getRoleId() == User.ROLE_AGENT) {
            return "redirect:/agent/dashboard";
        }

        // fallback (should never hit)
        return "redirect:/";
    }
}

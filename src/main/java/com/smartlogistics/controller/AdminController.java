package com.smartlogistics.controller;

import com.smartlogistics.dao.UserDAO;
import com.smartlogistics.dao.OrderDAO;
import com.smartlogistics.model.User;
import com.smartlogistics.model.Order;
import jakarta.servlet.http.HttpSession;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AdminController {

    private UserDAO userDAO = new UserDAO();

    // =========================
    // ADMIN / SUPER ADMIN DASHBOARD
    // =========================
    @GetMapping("/admin/dashboard")
    public String adminDashboard(HttpSession session, Model model) {

        User user = (User) session.getAttribute("loggedUser");

        if (user == null ||
            (user.getRoleId() != User.ROLE_ADMIN &&
             user.getRoleId() != User.ROLE_SUPER_ADMIN)) {
            return "redirect:/login";
        }

        model.addAttribute("adminName", user.getUsername());
        int totalUsers = userDAO.getTotalUserCount();
        model.addAttribute("totalUsers", totalUsers);
        int activeAgents = userDAO.getActiveAgentCount();
        model.addAttribute("activeAgents", activeAgents);

        return "admin-dashboard";
    }

    // =========================
    // VIEW ADMINS AND AGENTS
    // =========================
    @GetMapping("/admin/users")
    public String viewAdminsAndAgents(HttpSession session, Model model) {

        User logged = (User) session.getAttribute("loggedUser");

        if (logged == null ||
            (logged.getRoleId() != User.ROLE_SUPER_ADMIN)) {
            return "redirect:/login";
        }

        List<User> users = userDAO.getAdminsAndAgents();
        model.addAttribute("users", users);

        return "admin-users";
    }

    // =========================
    // SHOW ADD USER PAGE
    // =========================
    @GetMapping("/admin/add-user")
    public String showAddUser(
            @RequestParam(required = false) String role,
            HttpSession session,
            Model model) {

        User logged = (User) session.getAttribute("loggedUser");

        if (logged == null || role == null) {
            return "redirect:/login";
        }

        // SUPER ADMIN → ADMIN
        if ("ADMIN".equalsIgnoreCase(role) &&
            logged.getRoleId() != User.ROLE_SUPER_ADMIN) {
            return "redirect:/admin/dashboard";
        }

        // ADMIN → AGENT
        if ("AGENT".equalsIgnoreCase(role) &&
            logged.getRoleId() != User.ROLE_ADMIN) {
            return "redirect:/admin/dashboard";
        }

        model.addAttribute("role", role);
        return "add-user";
    }

    // =========================
    // HANDLE ADD USER
    // =========================
    @PostMapping("/admin/add-user")
    public String addUser(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam String role,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User logged = (User) session.getAttribute("loggedUser");

        if (logged == null) {
            return "redirect:/login";
        }

        int roleId;

        // SUPER ADMIN → ADMIN
        if ("ADMIN".equalsIgnoreCase(role) &&
            logged.getRoleId() == User.ROLE_SUPER_ADMIN) {
            roleId = User.ROLE_ADMIN;
        }
        // ADMIN → AGENT
        else if ("AGENT".equalsIgnoreCase(role) &&
                 logged.getRoleId() == User.ROLE_ADMIN) {
            roleId = User.ROLE_AGENT;
        }
        // INVALID ACCESS
        else {
            return "redirect:/login";
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRoleId(roleId);

        boolean success = userDAO.createAdminOrAgent(user);

        if (success) {
            redirectAttributes.addFlashAttribute(
                    "success", "User created successfully");
        } else {
            redirectAttributes.addFlashAttribute(
                    "error", "Failed to create user");
        }

        return "redirect:/admin/view-agents";
    }

    @GetMapping("/admin/view-admins")
    public String viewAdmins(HttpSession session, Model model) {

        User logged = (User) session.getAttribute("loggedUser");

        if (logged == null ||
                (logged.getRoleId() != User.ROLE_ADMIN &&
                        logged.getRoleId() != User.ROLE_SUPER_ADMIN)) {
            return "redirect:/login";
        }

        List<User> admins = userDAO.getAdmins(); // create DAO method
        model.addAttribute("admins", admins);

        return "view-admins";
    }

    // AGENTS
    @GetMapping("/admin/view-agents")
    public String viewAgents(HttpSession session, Model model) {

        User logged = (User) session.getAttribute("loggedUser");

        if (logged == null ||
                (logged.getRoleId() != User.ROLE_ADMIN &&
                        logged.getRoleId() != User.ROLE_SUPER_ADMIN)) {
            return "redirect:/login";
        }

        List<User> agents = userDAO.getAgents();
        model.addAttribute("agents", agents);

        return "view-agents";
    }

    // MANAGE USERS
    @GetMapping("/admin/manage-users")
    public String manageUsers(HttpSession session) {

        User logged = (User) session.getAttribute("loggedUser");

        if (logged == null ||
                logged.getRoleId() != User.ROLE_ADMIN) {
            return "redirect:/login";
        }

        return "manage-users";
    }


     // MANAGE ORDERS
    @GetMapping("/admin/manage-orders")
    public String manageOrders(HttpSession session,Model model) {

        User logged = (User) session.getAttribute("loggedUser");
        OrderDAO orderDAO = new OrderDAO();
        if (logged == null ||
                logged.getRoleId() != User.ROLE_ADMIN) {
            return "redirect:/login";
        }

        List <Order> orders = orderDAO.getAllOrders();
        model.addAttribute("orders", orders);
        return "manage-orders";
    }


    

}

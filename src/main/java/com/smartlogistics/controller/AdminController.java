package com.smartlogistics.controller;

import com.smartlogistics.dao.UserDAO;
import com.smartlogistics.model.User;
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

    @GetMapping("/admin/dashboard")
    public String adminDashboard(HttpSession session, Model model) {

        User user = (User) session.getAttribute("loggedUser");

        // only admin or super admin allowed
        if (user == null ||
           (user.getRoleId() != User.ROLE_ADMIN &&
            user.getRoleId() != User.ROLE_SUPER_ADMIN)) {
            return "redirect:/login";
        }

        model.addAttribute("adminName", user.getUsername());

        return "admin-dashboard";
    }


    @GetMapping("/admin/users")
    public String viewAdminsAndAgents(HttpSession session, Model model) {

        User admin = (User) session.getAttribute("loggedUser");

        if (admin == null ||
                (admin.getRoleId() != User.ROLE_ADMIN &&
                        admin.getRoleId() != User.ROLE_SUPER_ADMIN)) {
            return "redirect:/login";
        }

        List<User> users = userDAO.getAdminsAndAgents();
        model.addAttribute("users", users);

        return "admin-users";
    }

    @GetMapping("/admin/add-user")
    public String showAddUser(HttpSession session) {

        User admin = (User) session.getAttribute("loggedUser");

        if (admin == null || admin.getRoleId() != User.ROLE_SUPER_ADMIN) {
            return "redirect:/login";
        }

        return "add-user"; // add-user.jsp
    }


    @PostMapping("/admin/add-user")
    public String addUser(
            @RequestParam String username,
            @RequestParam String password,
            @RequestParam int roleId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User admin = (User) session.getAttribute("loggedUser");

        if (admin == null || admin.getRoleId() != User.ROLE_SUPER_ADMIN) {
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

        return "redirect:/admin/users";
    }

}

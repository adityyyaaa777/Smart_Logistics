package com.smartlogistics.controller;

import com.smartlogistics.dao.AddressDAO;
import com.smartlogistics.model.Address;
import com.smartlogistics.dao.OrderDAO;
import com.smartlogistics.model.Order;
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
public class OrderController {

    private OrderDAO orderDAO;
    private AddressDAO addressDAO = new AddressDAO();
    
    public OrderController() {
        this.orderDAO = new OrderDAO();
    }
    
    @GetMapping("/customer/dashboard")
    public String customerDashboard(HttpSession session, Model model) {

        User user = (User) session.getAttribute("loggedUser");

        if (user == null || user.getRoleId() != User.ROLE_CUSTOMER) {
            return "redirect:/login";
        }

        // Get recent orders (reuse DAO)
        List<Order> orders = orderDAO.getOrdersByCustomerId(user.getCustomerId());

        model.addAttribute("customerName", user.getUsername());
        model.addAttribute("orders", orders);

        return "customer-dashboard"; // customer-dashboard.jsp
    }

    // =========================
    // SHOW PLACE ORDER PAGE
    // =========================
    @GetMapping("/customer/place-order")
public String showPlaceOrderPage(HttpSession session, Model model) {

    User user = (User) session.getAttribute("loggedUser");

    if (user == null || user.getRoleId() != User.ROLE_CUSTOMER) {
        return "redirect:/login";
    }
    List<Address> addressList =
            addressDAO.getAddressesByCustomerId(user.getCustomerId());

    model.addAttribute("addressList", addressList);

    return "place-order";
}


    // =========================
    // HANDLE PLACE ORDER
    // =========================
    @PostMapping("/customer/place-order")
    public String placeOrder(
        @RequestParam int pickupAddressId,
        @RequestParam int deliveryAddressId,
        @RequestParam String packageType,
        @RequestParam int quantity,
        @RequestParam double weight,
        @RequestParam(required = false) String description,
        @RequestParam String shippingType,
        HttpSession session,
        Model model,
        RedirectAttributes ra) 
 {

        User user = (User) session.getAttribute("loggedUser");

        if (user == null || user.getRoleId() != User.ROLE_CUSTOMER) {
            return "redirect:/login";
        }

        System.out.println("Customer ID from session = " + user.getCustomerId());

        Order order = new Order();
        order.setCustomerId(user.getCustomerId());
        order.setPickupAddressId(pickupAddressId);
        order.setDeliveryAddressId(deliveryAddressId);
        order.setOrderStatus("PLACED");
        order.setItemName(packageType);
        order.setQuantity(quantity);
        order.setWeight(weight);
        order.setDescription(description);
        order.setShippingType(shippingType);


        boolean success = orderDAO.placeOrder(order);

        if (success) {
            ra.addFlashAttribute("success", "Order placed successfully");
        } else {
            ra.addFlashAttribute("error", "Failed to place order");
        }

        return "redirect:/customer/place-order";
    }

    // =========================
    // VIEW MY ORDERS
    // =========================
    @GetMapping("/customer/my-orders")
    public String viewMyOrders(
            HttpSession session,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String status,
            Model model) {

        User user = (User) session.getAttribute("loggedUser");

        if (user == null || user.getRoleId() != User.ROLE_CUSTOMER) {
            return "redirect:/login";
        }

        List<Order> orders = orderDAO.getOrdersByCustomerId(user.getCustomerId());

        if (search != null && !search.isEmpty()) {
            orders = orders.stream()
                    .filter(o -> String.valueOf(o.getOrderId()).contains(search) ||
                            o.getPickupAddress().contains(search) ||
                            o.getDeliveryAddress().contains(search))
                    .toList();
        }

        if (status != null && !status.isEmpty()) {
            orders = orders.stream()
                    .filter(o -> o.getOrderStatus().equals(status))
                    .toList();
        }

        model.addAttribute("orders", orders);

        return "orders";
    }

}

package com.smartlogistics.dao;

import com.smartlogistics.model.Order;
import com.smartlogistics.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // ================= PLACE ORDER =================
    public int placeOrder(Order order) {

        String orderSql = "INSERT INTO orders " +
                "(customer_id, pickup_address_id, delivery_address_id, order_status) " +
                "VALUES(?,?,?,?)";

        String itemSql = "INSERT INTO order_items " +
                "(order_id, item_name, quantity, weight, description, shipping_type) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        Connection con = null;

        try {
            con = DBUtil.getConnection();
            con.setAutoCommit(false); // START TRANSACTION

            PreparedStatement orderPs = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);

            // INSERT ORDER
            orderPs.setInt(1, order.getCustomerId());
            orderPs.setInt(2, order.getPickupAddressId());
            orderPs.setInt(3, order.getDeliveryAddressId());
            orderPs.setString(4, order.getOrderStatus());

            orderPs.executeUpdate();

            ResultSet keys = orderPs.getGeneratedKeys();
            if (!keys.next()) {
                con.rollback();
                return -1;
            }

            int orderId = keys.getInt(1);

            // INSERT ORDER ITEM
            PreparedStatement itemPs = con.prepareStatement(itemSql);
            itemPs.setInt(1, orderId);
            itemPs.setString(2, order.getItemName());
            itemPs.setInt(3, order.getQuantity());
            itemPs.setDouble(4, order.getWeight());
            itemPs.setString(5, order.getDescription());
            itemPs.setString(6, order.getShippingType());
            itemPs.executeUpdate();

            con.commit(); // SUCCESS
            return orderId;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (con != null)
                    con.rollback(); // FAIL SAFE
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return -1;
    }

    // ================= GET ORDERS BY CUSTOMER =================
    public List<Order> getOrdersByCustomerId(int customerId) {

        List<Order> orders = new ArrayList<>();

        String sql = "SELECT o.order_id, o.order_status, o.order_date, " +
                "pa.address_line AS pickup_address, pa.city AS pickup_city, " +
                "da.address_line AS delivery_address, da.city AS delivery_city, " +
                "i.item_name, i.quantity, i.weight, i.shipping_type " +
                "FROM orders o " +
                "JOIN addresses pa ON o.pickup_address_id = pa.address_id " +
                "JOIN addresses da ON o.delivery_address_id = da.address_id " +
                "LEFT JOIN order_items i ON o.order_id = i.order_id " +
                "WHERE o.customer_id = ? " +
                "ORDER BY o.order_date DESC";

        try (Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, customerId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setOrderStatus(rs.getString("order_status"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setPickupAddress(rs.getString("pickup_address"));
                    order.setDeliveryAddress(rs.getString("delivery_address"));
                    order.setPickupCity(rs.getString("pickup_city"));
                    order.setDeliveryCity(rs.getString("delivery_city"));
                    order.setItemName(rs.getString("item_name"));
                    order.setQuantity(rs.getInt("quantity"));
                    order.setWeight(rs.getDouble("weight"));
                    order.setShippingType(rs.getString("shipping_type"));

                    orders.add(order);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    // ================= ADMIN ORDERS =================
    public List<Order> getAllOrders() {

        List<Order> list = new ArrayList<>();

        try (Connection con = DBUtil.getConnection();
                CallableStatement cs = con.prepareCall("{CALL GetAllOrders()}")) {

            ResultSet rs = cs.executeQuery();

            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("order_id"));
                o.setCustomerName(rs.getString("customer_name"));
                o.setPickupAddress(rs.getString("pickup_address"));
                o.setDeliveryAddress(rs.getString("delivery_address"));
                o.setOrderStatus(rs.getString("order_status"));
                list.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================= DELETE ORDER =================
    public void deleteOrder(int orderId) {
        try (Connection con = DBUtil.getConnection();
                CallableStatement cs = con.prepareCall("CALL DeleteOrder(?)")) {

            cs.setInt(1, orderId);
            cs.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================= SHIPMENT SYNC =================
    public void updateOrdersByShipment(int shipmentId, String status) {
        try (Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement("UPDATE orders SET order_status=? WHERE shipment_id=?")) {

            ps.setString(1, status);
            ps.setInt(2, shipmentId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Integer findOpenShipmentByCity(String city) {
        Integer shipmentId = null;
        try (Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(
                        "SELECT shipment_id FROM shipments WHERE shipment_type=? AND current_status='CREATED' LIMIT 1")) {

            ps.setString(1, city);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                shipmentId = rs.getInt("shipment_id");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return shipmentId;
    }

    public void assignOrderToShipment(int orderId, int shipmentId) {
        try (Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement("UPDATE orders SET shipment_id=? WHERE order_id=?")) {

            ps.setInt(1, shipmentId);
            ps.setInt(2, orderId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

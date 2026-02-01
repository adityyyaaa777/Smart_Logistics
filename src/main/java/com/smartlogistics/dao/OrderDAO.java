package com.smartlogistics.dao;

import com.smartlogistics.model.Order;
import com.smartlogistics.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO{
        public boolean placeOrder(Order order){
            String orderSql = "INSERT INTO orders " + 
            "(customer_id , pickup_address_id , delivery_address_id , order_status )" +
            "VALUES(?,?,?,?)";

            String itemSql = "INSERT INTO order_items " +
                    "(order_id, item_name, quantity, weight, description, shipping_type) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";

            try(
                Connection con = DBUtil.getConnection();
                PreparedStatement orderPs =  con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            ) { 
                // ---------- INSERT ORDER ----------
                orderPs.setInt(1,order.getCustomerId());
                orderPs.setInt(2,order.getPickupAddressId());
                orderPs.setInt(3,order.getDeliveryAddressId());
                orderPs.setString(4,order.getOrderStatus());

                 orderPs.executeUpdate();


                  // ---------- GET ORDER ID ----------
                  ResultSet keys = orderPs.getGeneratedKeys();
                  if (!keys.next())
                      return false;

                  int orderId = keys.getInt(1);
                  // ---------- INSERT ORDER ITEM ----------
                  try (PreparedStatement itemPs = con.prepareStatement(itemSql)) {

                      itemPs.setInt(1, orderId);
                      itemPs.setString(2, order.getItemName());
                      itemPs.setInt(3, order.getQuantity());
                      itemPs.setDouble(4, order.getWeight());
                      itemPs.setString(5, order.getDescription());
                      itemPs.setString(6, order.getShippingType());

                      itemPs.executeUpdate();
                  }

                  return true;


            } catch (Exception e) {
                e.printStackTrace();
            }

         return false;   
        }



        public List<Order> getOrdersByCustomerId(int customerId) {

    List<Order> orders = new ArrayList<>();

        String sql =
        "SELECT o.order_id, o.order_status, o.order_date, " +
        "pa.address_line AS pickup_address, pa.city AS pickup_city, " +
        "da.address_line AS delivery_address, da.city AS delivery_city, " +
        "i.item_name, i.quantity, i.weight, i.shipping_type " +
        "FROM orders o " +
        "JOIN addresses pa ON o.pickup_address_id = pa.address_id " +
        "JOIN addresses da ON o.delivery_address_id = da.address_id " +
        "LEFT JOIN order_items i ON o.order_id = i.order_id " +
        "WHERE o.customer_id = ? " +
        "ORDER BY o.order_date DESC";



    try (
        Connection con = DBUtil.getConnection();
        PreparedStatement ps = con.prepareStatement(sql)
    ) {

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

}
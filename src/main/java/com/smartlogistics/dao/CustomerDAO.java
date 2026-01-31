package com.smartlogistics.dao;

import com.smartlogistics.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CustomerDAO {

    public int insertCustomer(String name, String email, String phone) {

        String sql =
            "INSERT INTO customers (customer_name, email, phone) " +
            "VALUES (?, ?, ?)";

        try (
            Connection con = DBUtil.getConnection();
            PreparedStatement ps =
                con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)
        ) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // generated customer_id
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }


    
}

package com.smartlogistics.dao;

import com.smartlogistics.model.Shipment;
import com.smartlogistics.util.DBUtil;

import java.sql.*;
import java.util.*;

public class ShipmentDAO {
    
    public List<Shipment> getAllShipments()
    {
        List<Shipment> list = new ArrayList<>();
        String sql = "  SELECT  *  FROM shipments ";

        try{
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Shipment s = new Shipment();
                s.setShipmentId(rs.getInt("shipment_id"));
                s.setTrackingNumber(rs.getString("tracking_id"));
                s.setShipmentType(rs.getString("shipment_type"));
                s.setShipmentStatus(rs.getString("current_status"));
            }
        }

        catch(Exception e)
        {
            e.printStackTrace();
        }


        return list;
    }

    public int createShipment(String city) {
        int id = 0;
        try {
            Connection con = DBUtil.getConnection();
            String sql = "INSERT INTO shipments(tracking_number, shipment_type, current_status) " +
                    "VALUES(?, ?, 'CREATED')";
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, "TRK" + System.currentTimeMillis());
            ps.setString(2, city);

            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next())
                id = rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }



    public void updateStatus(int shipmentId, String status) {
    Connection con = null;
    PreparedStatement ps = null;

    try {
        con = DBUtil.getConnection();

        String sql = "UPDATE shipments SET current_status = ? WHERE shipment_id = ?";
        ps = con.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, shipmentId);

        ps.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

}

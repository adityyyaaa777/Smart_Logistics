package com.smartlogistics.dao;

import com.smartlogistics.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class TrackingDAO {

    public void updateLocation(int shipmentId, String location,
            double lat, double lng) {

        String sql = "UPDATE shipment_tracking " +
                "SET current_location=?, latitude=?, longitude=? " +
                "WHERE shipment_id=?";

        try (Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, location);
            ps.setDouble(2, lat);
            ps.setDouble(3, lng);
            ps.setInt(4, shipmentId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}

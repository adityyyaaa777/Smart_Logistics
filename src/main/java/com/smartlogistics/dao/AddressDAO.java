package com.smartlogistics.dao;
import com.smartlogistics.model.Address;
import com.smartlogistics.util.DBUtil;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class AddressDAO {
    
    // ADD NEW ADDRESS
    public boolean addAddress(Address address){

        String sql = "INSERT INTO addresses (customer_id , address_line , city , state , pincode)"
                    + "VALUES (?,?,?,?,?)";


        try(
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
        ){
            ps.setInt(1,address.getCustomerId());
            ps.setString(2,address.getAddressLine());
            ps.setString(3, address.getCity());
            ps.setString(4, address.getState());
            ps.setString(5,address.getPincode());


            return ps.executeUpdate() > 0;
        }

        catch(Exception e){
            e.printStackTrace();
        }

        return false;
    }

    // GET ALL ADDRESSES OF CUSTOMER
    public List<Address> getAddressesByCustomerId(int customerId){
        List<Address> list = new ArrayList<>();

        String sql = "CALL get_addresses_by_customer(?)";

        try(
            Connection con = DBUtil.getConnection();
            CallableStatement cs = con.prepareCall(sql);
        ){
            cs.setInt(1, customerId);

            try(ResultSet rs = cs.executeQuery()){
                while(rs.next()){
                    Address a = new Address();
                    a.setAddressId(rs.getInt("address_id"));
                    a.setCustomerId(rs.getInt("customer_id"));
                    a.setAddressLine(rs.getString("address_line"));
                    a.setCity(rs.getString("city"));
                    a.setState(rs.getString("state"));
                    a.setPincode(rs.getString("pincode"));

                    list.add(a);
                }
            }
        }


        catch(Exception e){
            e.printStackTrace();
        }


        return list;
    }


    // GET SINGLE ADDRESS BY ID
    public Address getAddressById(int addressId) {

        Address address = null;

        String sql = "SELECT * FROM addresses WHERE address_id = ?";

        try (
                Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, addressId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    address = new Address();
                    address.setAddressId(rs.getInt("address_id"));
                    address.setCustomerId(rs.getInt("customer_id"));
                    address.setAddressLine(rs.getString("address_line"));
                    address.setCity(rs.getString("city"));
                    address.setState(rs.getString("state"));
                    address.setPincode(rs.getString("pincode"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return address;
    }


    
}

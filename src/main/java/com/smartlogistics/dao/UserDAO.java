package com.smartlogistics.dao;

import com.smartlogistics.model.User;
import com.smartlogistics.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // LOGIN
    public User login(String username, String password) {

        User user = null;

        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setCustomerId(rs.getInt("linked_customer_id"));
                    user.setRoleId(rs.getInt("role_id"));
                    user.setUsername(rs.getString("username"));
                    return user;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // REGISTER
    public boolean register(User user) {

        String sql =
            "INSERT INTO users (linked_customer_id, role_id, username, password) " +
            "VALUES (?, ?, ?, ?)";

        try (
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, user.getCustomerId());
            ps.setInt(2, user.getRoleId());
            ps.setString(3, user.getUsername());
            ps.setString(4, user.getPassword());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // CHECK USERNAME EXISTS
    public boolean usernameExists(String username) {

        String sql = "SELECT 1 FROM users WHERE username = ?";

        try (
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // GET ROLE ID BY NAME
    public int getRoleIdByName(String roleName) {

    String sql = "SELECT role_id FROM roles WHERE role_name = ?";

    try (
        Connection con = DBUtil.getConnection();
        PreparedStatement ps = con.prepareStatement(sql)
    ) {
        ps.setString(1, roleName);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("role_id");
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return -1;
}

    // Valid User
    public boolean isValidUser(String username, String password) {

        String sql = "SELECT 1 FROM users WHERE username = ? AND password = ?";

        try (
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // true if user exists
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // CREATE ADMIN OR AGENT (SUPER ADMIN ONLY)
    public boolean createuser(User user){
        String sql =  "INSERT INTO users (role_id, username, password) " +
        "VALUES (?, ?, ?)";

        try(
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
        ){
            ps.setInt(1, user.getRoleId());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());

            return ps.executeUpdate() > 0;
        }

        catch(Exception e){
            e.printStackTrace();
        }

        return false;
    }

    // CREATE ADMIN OR AGENT USING STORED PROCEDURE
    public boolean createAdminOrAgent(User user) {

        String sql = "{CALL create_admin_or_agent(?, ?, ?)}";

        try (
                Connection con = DBUtil.getConnection();
                CallableStatement cs = con.prepareCall(sql)) {

            cs.setString(1, user.getUsername());
            cs.setString(2, user.getPassword());
            cs.setInt(3, user.getRoleId());

            return cs.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // GET ALL ADMINS AND AGENTS USING STORED PROCEDURE
    public List<User> getAdminsAndAgents() {

        List<User> users = new ArrayList<>();

        String sql = "{CALL get_admins_and_agents()}";
        

        try (
                Connection con = DBUtil.getConnection();
                CallableStatement cs = con.prepareCall(sql);
                ResultSet rs = cs.executeQuery()) {

            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setRoleId(rs.getInt("role_id"));
                users.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    // GET ALL ADMIN ONLY FROM STORED PROCEDURES

    public List<User> getAdmins()
    {
        List<User> admins = new ArrayList<User>();

        String sql = "CALL get_admins()";

        try(
            Connection con = DBUtil.getConnection();
            CallableStatement cs = con.prepareCall(sql);
            ResultSet rs = cs.executeQuery();
        ) {
            while(rs.next()){
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setRoleId(rs.getInt("role_id"));
                admins.add(u);
            }
            
        } catch (Exception e) {
            
            e.printStackTrace();
        }

        return admins;
    }

    // GET ALL ADMIN ONLY FROM STORED PROCEDURES

    public List<User> getAgents()
    {
        List<User> admins = new ArrayList<User>();

        String sql = "CALL get_agents()";

        try(
            Connection con = DBUtil.getConnection();
            CallableStatement cs = con.prepareCall(sql);
            ResultSet rs = cs.executeQuery();
        ) {
            while(rs.next()){
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setRoleId(rs.getInt("role_id"));
                admins.add(u);
            }
            
        } catch (Exception e) {
            
            e.printStackTrace();
        }

        return admins;
    }

}

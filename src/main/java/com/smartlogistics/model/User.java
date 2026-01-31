package com.smartlogistics.model;

public class User {

    public static final int ROLE_CUSTOMER = 1;
    public static final int ROLE_ADMIN = 2;
    public static final int ROLE_SUPER_ADMIN = 0;
    public static final int ROLE_AGENT = 3;

    private int userId;
    private int customerId;
    private int roleId;
    private String username;
    private String password;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}

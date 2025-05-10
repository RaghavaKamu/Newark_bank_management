package com.newark.model;

public class Admin {
    private int adminID;
    private String adminName;
    private String username;
    private String password;

    public Admin() {
    }

    public Admin(int adminID, String adminName, String username, String password) {
        this.adminID = adminID;
        this.adminName = adminName;
        this.username = username;
        this.password = password;
    }

    public int getAdminID() {
        return adminID;
    }

    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
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
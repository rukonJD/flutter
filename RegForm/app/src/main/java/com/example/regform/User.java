package com.example.regform;

public class User {
    private String name;
    private String username;
    private String email;
    private String phone;
    private String password;

    public User(String name, String username, String email, String phone, String password) {
        this.name = name;
        this.username = username;
        this.email = email;
        this.phone = phone;
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }

    public String getPassword() {
        return password;
    }
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author anandaanugrah
 */
public class Koneksi {
    private static final String URL = "jdbc:mariadb://localhost:3306/db_smp";
    
    private static final String USER = "laravel";
    private static final String PASSWORD = "password123"; 

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Koneksi ke Database BERHASIL!");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Koneksi ke Database GAGAL: " + e.getMessage());
        }
        return conn;
    }
    
        public static void main(String[] args) {
        getConnection();
    }
}


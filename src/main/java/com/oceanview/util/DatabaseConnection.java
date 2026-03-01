package com.oceanview.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Singleton pattern implementation for Database Connection management.
 * Ensures a single, shared connection instance across the application.
 */
public class DatabaseConnection {
    
    // The single instance of the class
    private static DatabaseConnection instance;
    private Connection connection;
    
    // Database configuration
    // IMPORTANT: Update the USER and PASSWORD to match your local MySQL setup!
    private static final String URL = "jdbc:mysql://localhost:3306/ocean_view_db";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    /**
     * Private constructor to prevent instantiation from outside the class.
     */
    private DatabaseConnection() throws SQLException {
        try {
            // Load the MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException ex) {
            System.err.println("Fatal Error: MySQL JDBC Driver not found. " + ex.getMessage());
        }
    }

    /**
     * Retrieves the active database connection.
     * @return Connection object
     */
    public Connection getConnection() {
        return connection;
    }

    /**
     * Global access point for the Singleton instance.
     * Includes a check to reconnect if the existing connection was closed.
     * * @return DatabaseConnection instance
     * @throws SQLException if database access fails
     */
    public static DatabaseConnection getInstance() throws SQLException {
        if (instance == null) {
            instance = new DatabaseConnection();
        } else if (instance.getConnection().isClosed()) {
            // Re-instantiate if the connection timed out or was forcefully closed
            instance = new DatabaseConnection();
        }
        return instance;
    }
}
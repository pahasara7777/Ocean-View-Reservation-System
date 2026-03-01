package com.oceanview.dao;

import com.oceanview.model.User;
import com.oceanview.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Data Access Object implementation for the User entity.
 */
public class UserDAOImpl implements BaseDAO<User, Integer> {

    private static final String AUTHENTICATE_USER_SQL = "SELECT * FROM users WHERE username = ? AND password_hash = ?";
    private static final String INSERT_USER_SQL = "INSERT INTO users (username, password_hash, role) VALUES (?, ?, ?)";
    private static final String SELECT_USER_BY_ID = "SELECT * FROM users WHERE user_id = ?";
    private static final String SELECT_ROLE_BY_USERNAME = "SELECT role FROM users WHERE username = ?";
    
    /**
     * Authenticates a user and returns a User object if successful.
     */
    public Optional<User> authenticate(String username, String password) {
        try {
            Connection connection = DatabaseConnection.getInstance().getConnection();
            
            try (PreparedStatement preparedStatement = connection.prepareStatement(AUTHENTICATE_USER_SQL)) {
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, password);
                
                try (ResultSet rs = preparedStatement.executeQuery()) {
                    if (rs.next()) {
                        User user = new User(
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getString("password_hash"),
                            rs.getString("role"),
                            rs.getTimestamp("created_at")
                        );
                        return Optional.of(user);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Database error during authentication: " + e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }

    /**
     * New method to specifically handle adding staff members via the web form.
     */
    public boolean addMember(String username, String password, String role) {
        try {
            Connection connection = DatabaseConnection.getInstance().getConnection();
            try (PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, password);
                preparedStatement.setString(3, role);
                
                int rowsInserted = preparedStatement.executeUpdate();
                return rowsInserted > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error adding new member: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Helper method to fetch a role by username (used for session management).
     */
    public String getUserRole(String username) {
        try {
            Connection connection = DatabaseConnection.getInstance().getConnection();
            try (PreparedStatement statement = connection.prepareStatement(SELECT_ROLE_BY_USERNAME)) {
                statement.setString(1, username);
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        return resultSet.getString("role");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Deletes a user from the database by their username.
     * This is used by the Manager to remove staff accounts.
     */
    public boolean deleteUserByUsername(String username) {
        String query = "DELETE FROM users WHERE username = ?";
        
        try {
            Connection connection = DatabaseConnection.getInstance().getConnection();
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                
                statement.setString(1, username);
                int rowsDeleted = statement.executeUpdate();
                return rowsDeleted > 0; // Returns true if the delete was successful
                
            }
        } catch (SQLException e) {
            System.err.println("Error deleting user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean save(User entity) {
        // Re-uses the logic from addMember to satisfy the interface
        return addMember(entity.getUsername(), entity.getPasswordHash(), entity.getRole());
    }

    @Override
    public Optional<User> findById(Integer id) {
        try {
            Connection connection = DatabaseConnection.getInstance().getConnection();
            try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_ID)) {
                preparedStatement.setInt(1, id);
                try (ResultSet rs = preparedStatement.executeQuery()) {
                    if (rs.next()) {
                        return Optional.of(new User(
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getString("password_hash"),
                            rs.getString("role"),
                            rs.getTimestamp("created_at")
                        ));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    @Override
    public List<User> findAll() { 
        List<User> userList = new ArrayList<>();
        String query = "SELECT * FROM users ORDER BY role, username";
        
        try {
            Connection connection = DatabaseConnection.getInstance().getConnection();
            try (PreparedStatement statement = connection.prepareStatement(query);
                 ResultSet rs = statement.executeQuery()) {
                
                while (rs.next()) {
                    User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password_hash"),
                        rs.getString("role"),
                        rs.getTimestamp("created_at")
                    );
                    userList.add(user);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching all users: " + e.getMessage());
            e.printStackTrace();
        }
        return userList;
    }

    @Override
    public boolean update(User entity) { 
        return false; 
    }

    @Override
    public boolean delete(Integer id) { 
        return false; 
    }
}
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

    @Override
    public boolean save(User entity) {
        try {
            Connection connection = DatabaseConnection.getInstance().getConnection();
            try (PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {
                preparedStatement.setString(1, entity.getUsername());
                preparedStatement.setString(2, entity.getPasswordHash());
                preparedStatement.setString(3, entity.getRole());
                
                int rowsAffected = preparedStatement.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
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
        return new ArrayList<>(); 
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
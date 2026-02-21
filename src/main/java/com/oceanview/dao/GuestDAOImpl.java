package com.oceanview.dao;

import com.oceanview.model.Guest;
import com.oceanview.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Data Access Object implementation for the Guest entity.
 */
public class GuestDAOImpl implements BaseDAO<Guest, Integer> {

    private static final String INSERT_GUEST_SQL = "INSERT INTO guests (full_name, address, contact_number) VALUES (?, ?, ?)";
    private static final String SELECT_GUEST_BY_ID = "SELECT * FROM guests WHERE guest_id = ?";

    @Override
    public boolean save(Guest entity) {
        return saveAndReturnId(entity) > 0;
    }

    /**
     * Saves a guest and returns the auto-generated database ID.
     * This is critical for linking a new reservation to a newly registered guest.
     */
    public int saveAndReturnId(Guest entity) {
        int generatedId = -1;
        try {
            Connection connection = DatabaseConnection.getInstance().getConnection();
            
            // We pass Statement.RETURN_GENERATED_KEYS to tell MySQL we want the new ID back
            try (PreparedStatement preparedStatement = connection.prepareStatement(INSERT_GUEST_SQL, Statement.RETURN_GENERATED_KEYS)) {
                preparedStatement.setString(1, entity.getFullName());
                preparedStatement.setString(2, entity.getAddress());
                preparedStatement.setString(3, entity.getContactNumber());
                
                int rowsAffected = preparedStatement.executeUpdate();
                
                if (rowsAffected > 0) {
                    // Extract the generated ID
                    try (ResultSet rs = preparedStatement.getGeneratedKeys()) {
                        if (rs.next()) {
                            generatedId = rs.getInt(1);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error saving guest: " + e.getMessage());
            e.printStackTrace();
        }
        return generatedId;
    }

    @Override
    public Optional<Guest> findById(Integer id) {
        try {
            Connection connection = DatabaseConnection.getInstance().getConnection();
            try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_GUEST_BY_ID)) {
                preparedStatement.setInt(1, id);
                try (ResultSet rs = preparedStatement.executeQuery()) {
                    if (rs.next()) {
                        return Optional.of(new Guest(
                            rs.getInt("guest_id"),
                            rs.getString("full_name"),
                            rs.getString("address"),
                            rs.getString("contact_number")
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
    public List<Guest> findAll() { return new ArrayList<>(); }

    @Override
    public boolean update(Guest entity) { return false; }

    @Override
    public boolean delete(Integer id) { return false; }
}